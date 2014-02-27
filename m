From: Jeff King <peff@peff.net>
Subject: [PATCH] shallow: automatically clean up shallow tempfiles
Date: Thu, 27 Feb 2014 06:25:20 -0500
Message-ID: <20140227112519.GB29668@sigill.intra.peff.net>
References: <1393485183-20100-1-git-send-email-pclouds@gmail.com>
 <20140227090426.GA21892@sigill.intra.peff.net>
 <CACsJy8Di7vVhZzzHhavTPupbgeiKr70psq_U33C8i4c+auJxUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 12:25:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIz65-0000le-CU
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 12:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbaB0LZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 06:25:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:57965 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752389AbaB0LZY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 06:25:24 -0500
Received: (qmail 18398 invoked by uid 102); 27 Feb 2014 11:25:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Feb 2014 05:25:24 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Feb 2014 06:25:20 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8Di7vVhZzzHhavTPupbgeiKr70psq_U33C8i4c+auJxUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242806>

On Thu, Feb 27, 2014 at 05:11:41PM +0700, Duy Nguyen wrote:

> We only update shallow file in these cases: clone --depth, fetch
> --update-shallow, fetch --depth, and push when receive.shallowupdate
> is set. All of them may end up not updating shallow file though.

OK, that last sentence is what I wasn't sure of. If they might sometimes
not update the shallow file, then I think locking early is wrong. It
means we create lock contention where it might not exist.

> For read-only case in upload-file, locking only reduces the
> availability of clone/fetch.

Right, those should never lock. So even if we did want to tweak the
locking, we would still need a separate tempfile cleanup for those.

Here it is as a completed patch. It conflicts textually but not
semantically with the patch that started this thread (I think one of my
earlier patches has a minor textual conflict, too). Should we roll them
into a single series to help Junio? If so, do you want to do it, or
should I?

-- >8 --
Subject: shallow: automatically clean up shallow tempfiles

We sometimes write tempfiles of the form "shallow_XXXXXX"
during fetch/push operations with shallow repositories.
Under normal circumstances, we clean up the result when we
are done. However, we do no take steps to clean up after
ourselves when we exit due to die() or signal death.

This patch teaches the tempfile creation code to register
handlers to clean up after ourselves. To handle this, we
change the ownership semantics of the filename returned by
setup_temporary_shallow. It now keeps a copy of the filename
itself, and returns only a const pointer to it.

We can also do away with explicit tempfile removal in the
callers. They all exit not long after finishing with the
file, so they can rely on the auto-cleanup, simplifying the
code.

Note that we keep things simple and maintain only a single
filename to be cleaned. This is sufficient for the current
caller, but we future-proof it with a die("BUG").

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 16 ++++------------
 commit.h               |  2 +-
 fetch-pack.c           | 11 -----------
 shallow.c              | 41 ++++++++++++++++++++++++++++++++++-------
 upload-pack.c          |  7 +------
 5 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 85bba35..c323081 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -828,14 +828,10 @@ static void execute_commands(struct command *commands,
 		}
 	}
 
-	if (shallow_update) {
-		if (!checked_connectivity)
-			error("BUG: run 'git fsck' for safety.\n"
-			      "If there are errors, try to remove "
-			      "the reported refs above");
-		if (alt_shallow_file && *alt_shallow_file)
-			unlink(alt_shallow_file);
-	}
+	if (shallow_update && !checked_connectivity)
+		error("BUG: run 'git fsck' for safety.\n"
+		      "If there are errors, try to remove "
+		      "the reported refs above");
 }
 
 static struct command *read_head_info(struct sha1_array *shallow)
@@ -1087,10 +1083,6 @@ static void update_shallow_info(struct command *commands,
 			cmd->skip_update = 1;
 		}
 	}
-	if (alt_shallow_file && *alt_shallow_file) {
-		unlink(alt_shallow_file);
-		alt_shallow_file = NULL;
-	}
 	free(ref_status);
 }
 
diff --git a/commit.h b/commit.h
index 16d9c43..55631f1 100644
--- a/commit.h
+++ b/commit.h
@@ -209,7 +209,7 @@ extern int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
 extern void setup_alternate_shallow(struct lock_file *shallow_lock,
 				    const char **alternate_shallow_file,
 				    const struct sha1_array *extra);
-extern char *setup_temporary_shallow(const struct sha1_array *extra);
+extern const char *setup_temporary_shallow(const struct sha1_array *extra);
 extern void advertise_shallow_grafts(int);
 
 struct shallow_info {
diff --git a/fetch-pack.c b/fetch-pack.c
index 90fdd49..ae8550e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -947,17 +947,6 @@ static void update_shallow(struct fetch_pack_args *args,
 	if (!si->shallow || !si->shallow->nr)
 		return;
 
-	if (alternate_shallow_file) {
-		/*
-		 * The temporary shallow file is only useful for
-		 * index-pack and unpack-objects because it may
-		 * contain more roots than we want. Delete it.
-		 */
-		if (*alternate_shallow_file)
-			unlink(alternate_shallow_file);
-		free((char *)alternate_shallow_file);
-	}
-
 	if (args->cloning) {
 		/*
 		 * remote is shallow, but this is a clone, there are
diff --git a/shallow.c b/shallow.c
index 9668b39..0b267b6 100644
--- a/shallow.c
+++ b/shallow.c
@@ -8,6 +8,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "commit-slab.h"
+#include "sigchain.h"
 
 static int is_shallow = -1;
 static struct stat_validity shallow_stat;
@@ -206,27 +207,53 @@ int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
 	return write_shallow_commits_1(out, use_pack_protocol, extra, 0);
 }
 
-char *setup_temporary_shallow(const struct sha1_array *extra)
+static struct strbuf temporary_shallow = STRBUF_INIT;
+
+static void remove_temporary_shallow(void)
+{
+	if (temporary_shallow.len) {
+		unlink_or_warn(temporary_shallow.buf);
+		strbuf_reset(&temporary_shallow);
+	}
+}
+
+static void remove_temporary_shallow_on_signal(int signo)
+{
+	remove_temporary_shallow();
+	sigchain_pop(signo);
+	raise(signo);
+}
+
+const char *setup_temporary_shallow(const struct sha1_array *extra)
 {
+	static int installed_handler;
 	struct strbuf sb = STRBUF_INIT;
 	int fd;
 
+	if (temporary_shallow.len)
+		die("BUG: attempt to create two temporary shallow files");
+
 	if (write_shallow_commits(&sb, 0, extra)) {
-		struct strbuf path = STRBUF_INIT;
-		strbuf_addstr(&path, git_path("shallow_XXXXXX"));
-		fd = xmkstemp(path.buf);
+		strbuf_addstr(&temporary_shallow, git_path("shallow_XXXXXX"));
+		fd = xmkstemp(temporary_shallow.buf);
+
+		if (!installed_handler) {
+			atexit(remove_temporary_shallow);
+			sigchain_push_common(remove_temporary_shallow_on_signal);
+		}
+
 		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
 			die_errno("failed to write to %s",
-				  path.buf);
+				  temporary_shallow.buf);
 		close(fd);
 		strbuf_release(&sb);
-		return strbuf_detach(&path, NULL);
+		return temporary_shallow.buf;
 	}
 	/*
 	 * is_repository_shallow() sees empty string as "no shallow
 	 * file".
 	 */
-	return xstrdup("");
+	return temporary_shallow.buf;
 }
 
 void setup_alternate_shallow(struct lock_file *shallow_lock,
diff --git a/upload-pack.c b/upload-pack.c
index 0c44f6b..a3c52f6 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -81,7 +81,7 @@ static void create_pack_file(void)
 	const char *argv[12];
 	int i, arg = 0;
 	FILE *pipe_fd;
-	char *shallow_file = NULL;
+	const char *shallow_file = NULL;
 
 	if (shallow_nr) {
 		shallow_file = setup_temporary_shallow(NULL);
@@ -242,11 +242,6 @@ static void create_pack_file(void)
 		error("git upload-pack: git-pack-objects died with error.");
 		goto fail;
 	}
-	if (shallow_file) {
-		if (*shallow_file)
-			unlink(shallow_file);
-		free(shallow_file);
-	}
 
 	/* flush the data */
 	if (0 <= buffered) {
-- 
1.8.5.2.500.g8060133
