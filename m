From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH RFC 6/8] clone: use setup_remote_config
Date: Mon, 20 Jul 2009 19:49:53 +0200
Message-ID: <1248112195-3761-7-git-send-email-bonzini@gnu.org>
References: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 19:51:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSx0y-0005yL-Po
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 19:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432AbZGTRuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 13:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753340AbZGTRuT
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 13:50:19 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:56555 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415AbZGTRuP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 13:50:15 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MSx0B-00033W-IW
	for git@vger.kernel.org; Mon, 20 Jul 2009 13:50:15 -0400
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123630>

We can now use setup_remote_config in builtin-clone.c and remove
duplicated computation of remote.*.fetch contents.

The three cases to consider are:

1) !option_bare.  This is the easy case when setup_remote_config just
works and a normal refs/heads/*:refs/remotes/origin/* refspec is created.
This only requires a small new feature in setup_remote_config to pass
the refspec back to builtin-clone.c; setup_remote_config will simply store
it in the util field of the stringlist items.

2) option_bare && option_mirror.  Again, setup_remote_config is used.
Passing PUSH_DEFAULT_MIRROR to option_mirror will use +refs/*:refs/*
for the refspec.  There is a change from before, in that a remote.*.push
refspec will be setup as well.

3) option_bare && !option_mirror.  In this case, no fetch refspec will
be configured (just as before), and setup_remote_config is not used.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 builtin-clone.c  |   46 ++++++++++++++--------------------------------
 builtin-remote.c |    5 +++--
 remote.h         |    3 +++
 3 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 345101a..68d8a68 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -19,6 +19,7 @@
 #include "strbuf.h"
 #include "dir.h"
 #include "pack-refs.h"
+#include "string-list.h"
 #include "sigchain.h"
 #include "branch.h"
 #include "remote.h"
@@ -348,7 +349,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	char *path, *dir;
 	int dest_exists;
 	const struct ref *refs, *head_points_at, *remote_head, *mapped_refs;
-	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
 	struct strbuf reflog_msg = STRBUF_INIT;
 	struct transport *transport = NULL;
 	int err = 0;
@@ -449,40 +449,24 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	if (option_bare) {
-		if (option_mirror)
-			fetch_pattern = "+refs/*:refs/*";
-		else
-			fetch_pattern = "+refs/heads/*:refs/heads/*";
-
+	if (option_bare)
 		git_config_set("core.bare", "true");
-	} else {
-		strbuf_addf(&value, "+refs/heads/*:refs/remotes/%s/*:*",
-			    option_origin);
-		fetch_pattern = value.buf;
-	}
 
 	if (option_mirror || !option_bare) {
-		/* Configure the remote */
-		strbuf_addf(&key, "remote.%s.fetch", option_origin);
-		git_config_set_multivar(key.buf, fetch_pattern, "^$", 0);
-		strbuf_reset(&key);
-
-		if (option_mirror) {
-			strbuf_addf(&key, "remote.%s.mirror", option_origin);
-			git_config_set(key.buf, "true");
-			strbuf_reset(&key);
-		}
-
-		strbuf_addf(&key, "remote.%s.url", option_origin);
-		git_config_set(key.buf, repo);
-		strbuf_reset(&key);
+		struct string_list track = { NULL, 0, 0 };
+		setup_remote_config (option_origin, repo,
+				     option_mirror
+				     ? PUSH_DEFAULT_MIRROR
+				     : PUSH_DEFAULT_NOTHING,
+				     &track);
+		fetch_pattern = track.items[0].util;
+		refspec = parse_fetch_refspec(1, &fetch_pattern);
+		string_list_clear(&track, 1);
+	} else {
+		fetch_pattern = "+refs/heads/*:refs/heads/*";
+		refspec = parse_fetch_refspec(1, &fetch_pattern);
 	}
 
-	refspec = parse_fetch_refspec(1, &fetch_pattern);
-
-	strbuf_reset(&value);
-
 	if (path && !is_bundle)
 		refs = clone_local(path, git_dir);
 	else {
@@ -611,8 +595,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	strbuf_release(&reflog_msg);
-	strbuf_release(&key);
-	strbuf_release(&value);
 	junk_pid = 0;
 	return err;
 }
diff --git a/builtin-remote.c b/builtin-remote.c
index 23ab24b..99c06bc 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -59,7 +59,7 @@ static void warn_unconfigured_push()
 }
 
 
-static int setup_default_remote_config(const char *name, const char *url, int push, struct string_list *track)
+int setup_remote_config(const char *name, const char *url, int push, struct string_list *track)
 {
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT;
 	const char *refspec = NULL;
@@ -154,6 +154,7 @@ static int setup_default_remote_config(const char *name, const char *url, int pu
 		else
 			strbuf_addf(&buf2, "+refs/heads/%s:refs/remotes/%s/%s",
 					item->string, name, item->string);
+		item->util = xstrdup (buf2.buf);
 		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
 			return 1;
 	}
@@ -265,7 +266,7 @@ static int add(int argc, const char **argv)
 
 	strbuf_release(&buf);
 	strbuf_release(&buf2);
-	string_list_clear(&track, 0);
+	string_list_clear(&track, 1);
 
 	return 0;
 }
diff --git a/remote.h b/remote.h
index 86b18dc..64f4d58 100644
--- a/remote.h
+++ b/remote.h
@@ -115,6 +115,9 @@ struct ref *get_remote_ref(const struct ref *remote_refs, const char *name);
  */
 int remote_find_tracking(struct remote *remote, struct refspec *refspec);
 
+struct string_list;
+int setup_remote_config(const char *name, const char *url, int push, struct string_list *track);
+
 struct branch {
 	const char *name;
 	const char *refname;
-- 
1.6.2.5
