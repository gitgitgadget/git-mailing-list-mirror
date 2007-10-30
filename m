From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/4] Build-in peek-remote, using transport infrastructure.
Date: Mon, 29 Oct 2007 21:05:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710292049310.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 02:06:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImfYo-0002uH-IE
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 02:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbXJ3BFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 21:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752236AbXJ3BFr
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 21:05:47 -0400
Received: from iabervon.org ([66.92.72.58]:39156 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbXJ3BFo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 21:05:44 -0400
Received: (qmail 32662 invoked by uid 1000); 30 Oct 2007 01:05:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Oct 2007 01:05:43 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62641>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Makefile                               |    3 +-
 peek-remote.c => builtin-peek-remote.c |   55 ++++++++++++++-----------------
 builtin.h                              |    1 +
 git.c                                  |    1 +
 4 files changed, 29 insertions(+), 31 deletions(-)
 rename peek-remote.c => builtin-peek-remote.c (59%)

diff --git a/Makefile b/Makefile
index 72f5ef4..64ad297 100644
--- a/Makefile
+++ b/Makefile
@@ -240,7 +240,7 @@ PROGRAMS = \
 	git-fast-import$X \
 	git-daemon$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-patch-id$X \
-	git-peek-remote$X git-receive-pack$X \
+	git-receive-pack$X \
 	git-send-pack$X git-shell$X \
 	git-show-index$X \
 	git-unpack-file$X \
@@ -353,6 +353,7 @@ BUILTIN_OBJS = \
 	builtin-mv.o \
 	builtin-name-rev.o \
 	builtin-pack-objects.o \
+	builtin-peek-remote.o \
 	builtin-prune.o \
 	builtin-prune-packed.o \
 	builtin-push.o \
diff --git a/peek-remote.c b/builtin-peek-remote.c
similarity index 59%
rename from peek-remote.c
rename to builtin-peek-remote.c
index ceb7871..b4106f5 100644
--- a/peek-remote.c
+++ b/builtin-peek-remote.c
@@ -1,38 +1,26 @@
+#include "builtin.h"
 #include "cache.h"
-#include "refs.h"
-#include "pkt-line.h"
+#include "transport.h"
+#include "remote.h"
 
 static const char peek_remote_usage[] =
 "git-peek-remote [--upload-pack=<git-upload-pack>] [<host>:]<directory>";
-static const char *uploadpack = "git-upload-pack";
 
-static int peek_remote(int fd[2], unsigned flags)
+int cmd_peek_remote(int argc, const char **argv, const char *prefix)
 {
-	struct ref *ref;
-
-	get_remote_heads(fd[0], &ref, 0, NULL, flags);
-	packet_flush(fd[1]);
-
-	while (ref) {
-		printf("%s	%s\n", sha1_to_hex(ref->old_sha1), ref->name);
-		ref = ref->next;
-	}
-	return 0;
-}
-
-int main(int argc, char **argv)
-{
-	int i, ret;
-	char *dest = NULL;
-	int fd[2];
-	pid_t pid;
+	int i;
+	const char *dest = NULL;
 	int nongit = 0;
 	unsigned flags = 0;
+	const char *uploadpack = NULL;
+
+	struct transport *transport;
+	const struct ref *ref;
 
 	setup_git_directory_gently(&nongit);
 
 	for (i = 1; i < argc; i++) {
-		char *arg = argv[i];
+		const char *arg = argv[i];
 
 		if (*arg == '-') {
 			if (!prefixcmp(arg, "--upload-pack=")) {
@@ -64,12 +52,19 @@ int main(int argc, char **argv)
 	if (!dest || i != argc - 1)
 		usage(peek_remote_usage);
 
-	pid = git_connect(fd, dest, uploadpack, 0);
-	if (pid < 0)
+	transport = transport_get(NULL, dest);
+	if (uploadpack != NULL)
+		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
+
+	ref = transport_get_remote_refs(transport);
+
+	if (!ref)
 		return 1;
-	ret = peek_remote(fd, flags);
-	close(fd[0]);
-	close(fd[1]);
-	ret |= finish_connect(pid);
-	return !!ret;
+
+	while (ref) {
+		if (check_ref_type(ref, flags))
+			printf("%s	%s\n", sha1_to_hex(ref->old_sha1), ref->name);
+		ref = ref->next;
+	}
+	return 0;
 }
diff --git a/builtin.h b/builtin.h
index 65cc0fb..ff84835 100644
--- a/builtin.h
+++ b/builtin.h
@@ -54,6 +54,7 @@ extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
+extern int cmd_peek_remote(int argc, const char **argv, const char *prefix);
 extern int cmd_pickaxe(int argc, const char **argv, const char *prefix);
 extern int cmd_prune(int argc, const char **argv, const char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 23a430c..1b182e2 100644
--- a/git.c
+++ b/git.c
@@ -355,6 +355,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
+		{ "peek-remote", cmd_peek_remote },
 		{ "pickaxe", cmd_blame, RUN_SETUP },
 		{ "prune", cmd_prune, RUN_SETUP },
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
-- 
1.5.3.4.1206.g5f96
