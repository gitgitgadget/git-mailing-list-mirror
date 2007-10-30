From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 3/4] Build-in send-pack, with an API for other programs to
 call.
Date: Mon, 29 Oct 2007 21:05:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710292049350.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 02:06:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImfYp-0002uH-6V
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 02:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbXJ3BFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 21:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbXJ3BFt
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 21:05:49 -0400
Received: from iabervon.org ([66.92.72.58]:39158 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752255AbXJ3BFr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 21:05:47 -0400
Received: (qmail 32666 invoked by uid 1000); 30 Oct 2007 01:05:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Oct 2007 01:05:46 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62639>

Also marks some more things as const, as needed.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Makefile                           |    1 +
 send-pack.c => builtin-send-pack.c |   40 +++++++++++++++++++++++++----------
 builtin.h                          |    1 +
 git.c                              |    1 +
 send-pack.h                        |   18 ++++++++++++++++
 5 files changed, 49 insertions(+), 12 deletions(-)
 rename send-pack.c => builtin-send-pack.c (93%)
 create mode 100644 send-pack.h

diff --git a/Makefile b/Makefile
index 64ad297..8b0c8cd 100644
--- a/Makefile
+++ b/Makefile
@@ -359,6 +359,7 @@ BUILTIN_OBJS = \
 	builtin-push.o \
 	builtin-read-tree.o \
 	builtin-reflog.o \
+	builtin-send-pack.o \
 	builtin-config.o \
 	builtin-rerere.o \
 	builtin-reset.o \
diff --git a/send-pack.c b/builtin-send-pack.c
similarity index 93%
rename from send-pack.c
rename to builtin-send-pack.c
index fe56617..931f994 100644
--- a/send-pack.c
+++ b/builtin-send-pack.c
@@ -5,6 +5,7 @@
 #include "pkt-line.h"
 #include "run-command.h"
 #include "remote.h"
+#include "send-pack.h"
 
 static const char send_pack_usage[] =
 "git-send-pack [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
@@ -178,7 +179,7 @@ static int receive_status(int in)
 	return ret;
 }
 
-static int send_pack(int in, int out, struct remote *remote, int nr_refspec, const char **refspec)
+static int do_send_pack(int in, int out, struct remote *remote, int nr_refspec, const char **refspec)
 {
 	struct ref *ref;
 	int new_refs;
@@ -360,22 +361,27 @@ static void verify_remote_names(int nr_heads, const char **heads)
 	}
 }
 
-int main(int argc, char **argv)
+void setup_send_pack(struct send_pack_args *args)
+{
+	receivepack = args->receivepack;
+	verbose = args->verbose;
+	send_all = args->send_all;
+	force_update = args->force_update;
+	use_thin_pack = args->use_thin_pack;
+	dry_run = args->dry_run;
+}
+
+int cmd_send_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, nr_heads = 0;
-	char *dest = NULL;
 	const char **heads = NULL;
-	int fd[2], ret;
-	pid_t pid;
-	char *remote_name = NULL;
+	const char *remote_name = NULL;
 	struct remote *remote = NULL;
-
-	setup_git_directory();
-	git_config(git_default_config);
+	const char *dest = NULL;
 
 	argv++;
 	for (i = 1; i < argc; i++, argv++) {
-		char *arg = *argv;
+		const char *arg = *argv;
 
 		if (*arg == '-') {
 			if (!prefixcmp(arg, "--receive-pack=")) {
@@ -424,7 +430,6 @@ int main(int argc, char **argv)
 		usage(send_pack_usage);
 	if (heads && send_all)
 		usage(send_pack_usage);
-	verify_remote_names(nr_heads, heads);
 
 	if (remote_name) {
 		remote = remote_get(remote_name);
@@ -434,10 +439,21 @@ int main(int argc, char **argv)
 		}
 	}
 
+	return send_pack(dest, remote, nr_heads, heads);
+}
+
+int send_pack(const char *dest, struct remote *remote,
+	      int nr_heads, const char **heads)
+{
+	int fd[2], ret;
+	pid_t pid;
+
+	verify_remote_names(nr_heads, heads);
+
 	pid = git_connect(fd, dest, receivepack, verbose ? CONNECT_VERBOSE : 0);
 	if (pid < 0)
 		return 1;
-	ret = send_pack(fd[0], fd[1], remote, nr_heads, heads);
+	ret = do_send_pack(fd[0], fd[1], remote, nr_heads, heads);
 	close(fd[0]);
 	close(fd[1]);
 	ret |= finish_connect(pid);
diff --git a/builtin.h b/builtin.h
index ff84835..51747c7 100644
--- a/builtin.h
+++ b/builtin.h
@@ -69,6 +69,7 @@ extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 extern int cmd_revert(int argc, const char **argv, const char *prefix);
 extern int cmd_rm(int argc, const char **argv, const char *prefix);
 extern int cmd_runstatus(int argc, const char **argv, const char *prefix);
+extern int cmd_send_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 1b182e2..4893a85 100644
--- a/git.c
+++ b/git.c
@@ -370,6 +370,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
 		{ "rm", cmd_rm, RUN_SETUP | NEED_WORK_TREE },
 		{ "runstatus", cmd_runstatus, RUN_SETUP | NEED_WORK_TREE },
+		{ "send-pack", cmd_send_pack, RUN_SETUP },
 		{ "shortlog", cmd_shortlog, RUN_SETUP | USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
diff --git a/send-pack.h b/send-pack.h
new file mode 100644
index 0000000..22b0624
--- /dev/null
+++ b/send-pack.h
@@ -0,0 +1,18 @@
+#ifndef SEND_PACK_H
+#define SEND_PACK_H
+
+struct send_pack_args {
+	const char *receivepack;
+	int verbose;
+	int send_all;
+	int force_update;
+	int use_thin_pack;
+	int dry_run;
+};
+
+void setup_send_pack(struct send_pack_args *args);
+
+int send_pack(const char *dest, struct remote *remote,
+	      int nr_heads, const char **heads);
+
+#endif
-- 
1.5.3.4.1206.g5f96
