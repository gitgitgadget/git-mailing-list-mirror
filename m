From: Jeff King <peff@peff.net>
Subject: [PATCH v2 4/5] refactor signal handling for cleanup functions
Date: Thu, 22 Jan 2009 01:03:08 -0500
Message-ID: <20090122060307.GD30133@coredump.intra.peff.net>
References: <20090122042643.GB31427@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 07:04:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPsg9-0006mS-NU
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 07:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587AbZAVGDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 01:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754609AbZAVGDL
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 01:03:11 -0500
Received: from peff.net ([208.65.91.99]:46676 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754587AbZAVGDK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 01:03:10 -0500
Received: (qmail 24472 invoked by uid 107); 22 Jan 2009 06:03:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 22 Jan 2009 01:03:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jan 2009 01:03:08 -0500
Content-Disposition: inline
In-Reply-To: <20090122042643.GB31427@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106727>

The current code is very inconsistent about which signals
are caught for doing cleanup of temporary files and lock
files. Some callsites checked only SIGINT, while others
checked a variety of death-dealing signals.

This patch factors out those signals to a single function,
and then calls it everywhere. For some sites, that means
this is a simple clean up. For others, it is an improvement
in that they will now properly clean themselves up after a
larger variety of signals.

Signed-off-by: Jeff King <peff@peff.net>
---
Same as before, but needed rebasing due to previous diff.c changes.

 builtin-clone.c       |    2 +-
 builtin-fetch--tool.c |    2 +-
 builtin-fetch.c       |    2 +-
 diff.c                |    2 +-
 http-push.c           |    5 +----
 lockfile.c            |    6 +-----
 sigchain.c            |    9 +++++++++
 sigchain.h            |    2 ++
 8 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 849cefc..313df6a 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -442,7 +442,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 	junk_git_dir = git_dir;
 	atexit(remove_junk);
-	sigchain_push(SIGINT, remove_junk_on_signal);
+	sigchain_push_common(remove_junk_on_signal);
 
 	setenv(CONFIG_ENVIRONMENT, xstrdup(mkpath("%s/config", git_dir)), 1);
 
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index b1d7f8f..29356d2 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -246,7 +246,7 @@ static int fetch_native_store(FILE *fp,
 	char buffer[1024];
 	int err = 0;
 
-	sigchain_push(SIGINT, remove_keep_on_signal);
+	sigchain_push_common(remove_keep_on_signal);
 	atexit(remove_keep);
 
 	while (fgets(buffer, sizeof(buffer), stdin)) {
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 8c86974..1e4a3d9 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -673,7 +673,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		ref_nr = j;
 	}
 
-	sigchain_push(SIGINT, unlock_pack_on_signal);
+	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack);
 	exit_code = do_fetch(transport,
 			parse_fetch_refspec(ref_nr, refs), ref_nr);
diff --git a/diff.c b/diff.c
index dacd5d2..715709b 100644
--- a/diff.c
+++ b/diff.c
@@ -1905,7 +1905,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 
 	if (!remove_tempfile_installed) {
 		atexit(remove_tempfile);
-		sigchain_push(SIGINT, remove_tempfile_on_signal);
+		sigchain_push_common(remove_tempfile_on_signal);
 		remove_tempfile_installed = 1;
 	}
 
diff --git a/http-push.c b/http-push.c
index 4c92f80..178af75 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2267,10 +2267,7 @@ int main(int argc, char **argv)
 		goto cleanup;
 	}
 
-	sigchain_push(SIGINT, remove_locks_on_signal);
-	sigchain_push(SIGHUP, remove_locks_on_signal);
-	sigchain_push(SIGQUIT, remove_locks_on_signal);
-	sigchain_push(SIGTERM, remove_locks_on_signal);
+	sigchain_push_common(remove_locks_on_signal);
 
 	/* Check whether the remote has server info files */
 	remote->can_update_info_refs = 0;
diff --git a/lockfile.c b/lockfile.c
index 3cd57dc..021c337 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -137,11 +137,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= lk->fd) {
 		if (!lock_file_list) {
-			sigchain_push(SIGINT, remove_lock_file_on_signal);
-			sigchain_push(SIGHUP, remove_lock_file_on_signal);
-			sigchain_push(SIGTERM, remove_lock_file_on_signal);
-			sigchain_push(SIGQUIT, remove_lock_file_on_signal);
-			sigchain_push(SIGPIPE, remove_lock_file_on_signal);
+			sigchain_push_common(remove_lock_file_on_signal);
 			atexit(remove_lock_file);
 		}
 		lk->owner = getpid();
diff --git a/sigchain.c b/sigchain.c
index a18d505..1118b99 100644
--- a/sigchain.c
+++ b/sigchain.c
@@ -41,3 +41,12 @@ int sigchain_pop(int sig)
 	s->n--;
 	return 0;
 }
+
+void sigchain_push_common(sigchain_fun f)
+{
+	sigchain_push(SIGINT, f);
+	sigchain_push(SIGHUP, f);
+	sigchain_push(SIGTERM, f);
+	sigchain_push(SIGQUIT, f);
+	sigchain_push(SIGPIPE, f);
+}
diff --git a/sigchain.h b/sigchain.h
index 254ebb0..618083b 100644
--- a/sigchain.h
+++ b/sigchain.h
@@ -6,4 +6,6 @@ typedef void (*sigchain_fun)(int);
 int sigchain_push(int sig, sigchain_fun f);
 int sigchain_pop(int sig);
 
+void sigchain_push_common(sigchain_fun f);
+
 #endif /* SIGCHAIN_H */
-- 
1.6.1.403.g6c435
