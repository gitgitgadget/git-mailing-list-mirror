From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 3/4 v2] Build-in send-pack, with an API for other programs
 to call.
Date: Mon, 29 Oct 2007 22:03:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710292202530.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 03:03:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImgSS-0005X9-Ts
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 03:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbXJ3CDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 22:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752744AbXJ3CDl
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 22:03:41 -0400
Received: from iabervon.org ([66.92.72.58]:54105 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525AbXJ3CDl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 22:03:41 -0400
Received: (qmail 1720 invoked by uid 1000); 30 Oct 2007 02:03:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Oct 2007 02:03:39 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62646>

Also marks some more things as const, as needed.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Makefile                           |    1 +
 send-pack.c => builtin-send-pack.c |   81 +++++++++++++++++++----------------
 builtin.h                          |    1 +
 git.c                              |    1 +
 send-pack.h                        |   17 ++++++++
 5 files changed, 64 insertions(+), 37 deletions(-)
 rename send-pack.c => builtin-send-pack.c (88%)
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
similarity index 88%
rename from send-pack.c
rename to builtin-send-pack.c
index fe56617..60a12f7 100644
--- a/send-pack.c
+++ b/builtin-send-pack.c
@@ -5,16 +5,15 @@
 #include "pkt-line.h"
 #include "run-command.h"
 #include "remote.h"
+#include "send-pack.h"
 
 static const char send_pack_usage[] =
 "git-send-pack [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
 "  --all and explicit <ref> specification are mutually exclusive.";
-static const char *receivepack = "git-receive-pack";
-static int verbose;
-static int send_all;
-static int force_update;
-static int use_thin_pack;
-static int dry_run;
+
+static struct send_pack_args args = {
+	/* .receivepack = */ "git-receive-pack",
+};
 
 /*
  * Make a pack stream and spit it out into file descriptor fd
@@ -26,7 +25,7 @@ static int pack_objects(int fd, struct ref *refs)
 	 * the revision parameters to it via its stdin and
 	 * let its stdout go back to the other end.
 	 */
-	const char *args[] = {
+	const char *argv[] = {
 		"pack-objects",
 		"--all-progress",
 		"--revs",
@@ -36,10 +35,10 @@ static int pack_objects(int fd, struct ref *refs)
 	};
 	struct child_process po;
 
-	if (use_thin_pack)
-		args[4] = "--thin";
+	if (args.use_thin_pack)
+		argv[4] = "--thin";
 	memset(&po, 0, sizeof(po));
-	po.argv = args;
+	po.argv = argv;
 	po.in = -1;
 	po.out = fd;
 	po.git_cmd = 1;
@@ -178,7 +177,7 @@ static int receive_status(int in)
 	return ret;
 }
 
-static int send_pack(int in, int out, struct remote *remote, int nr_refspec, const char **refspec)
+static int do_send_pack(int in, int out, struct remote *remote, int nr_refspec, const char **refspec)
 {
 	struct ref *ref;
 	int new_refs;
@@ -201,7 +200,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, con
 	if (!remote_tail)
 		remote_tail = &remote_refs;
 	if (match_refs(local_refs, remote_refs, &remote_tail,
-		       nr_refspec, refspec, send_all))
+		       nr_refspec, refspec, args.send_all))
 		return -1;
 
 	if (!remote_refs) {
@@ -230,7 +229,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, con
 		}
 		if (!will_delete_ref &&
 		    !hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
-			if (verbose)
+			if (args.verbose)
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
 			continue;
 		}
@@ -254,7 +253,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, con
 		 *     always allowed.
 		 */
 
-		if (!force_update &&
+		if (!args.force_update &&
 		    !will_delete_ref &&
 		    !is_null_sha1(ref->old_sha1) &&
 		    !ref->force) {
@@ -284,7 +283,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, con
 		strcpy(old_hex, sha1_to_hex(ref->old_sha1));
 		new_hex = sha1_to_hex(ref->new_sha1);
 
-		if (!dry_run) {
+		if (!args.dry_run) {
 			if (ask_for_status_report) {
 				packet_write(out, "%s %s %s%c%s",
 					old_hex, new_hex, ref->name, 0,
@@ -306,7 +305,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, con
 			fprintf(stderr, "\n  from %s\n  to   %s\n",
 				old_hex, new_hex);
 		}
-		if (remote && !dry_run) {
+		if (remote && !args.dry_run) {
 			struct refspec rs;
 			rs.src = ref->name;
 			rs.dst = NULL;
@@ -325,7 +324,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, con
 	}
 
 	packet_flush(out);
-	if (new_refs && !dry_run)
+	if (new_refs && !args.dry_run)
 		ret = pack_objects(out, remote_refs);
 	close(out);
 
@@ -360,30 +359,25 @@ static void verify_remote_names(int nr_heads, const char **heads)
 	}
 }
 
-int main(int argc, char **argv)
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
-				receivepack = arg + 15;
+				args.receivepack = arg + 15;
 				continue;
 			}
 			if (!prefixcmp(arg, "--exec=")) {
-				receivepack = arg + 7;
+				args.receivepack = arg + 7;
 				continue;
 			}
 			if (!prefixcmp(arg, "--remote=")) {
@@ -391,23 +385,23 @@ int main(int argc, char **argv)
 				continue;
 			}
 			if (!strcmp(arg, "--all")) {
-				send_all = 1;
+				args.send_all = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--dry-run")) {
-				dry_run = 1;
+				args.dry_run = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--force")) {
-				force_update = 1;
+				args.force_update = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--verbose")) {
-				verbose = 1;
+				args.verbose = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--thin")) {
-				use_thin_pack = 1;
+				args.use_thin_pack = 1;
 				continue;
 			}
 			usage(send_pack_usage);
@@ -422,9 +416,8 @@ int main(int argc, char **argv)
 	}
 	if (!dest)
 		usage(send_pack_usage);
-	if (heads && send_all)
+	if (heads && args.send_all)
 		usage(send_pack_usage);
-	verify_remote_names(nr_heads, heads);
 
 	if (remote_name) {
 		remote = remote_get(remote_name);
@@ -434,10 +427,24 @@ int main(int argc, char **argv)
 		}
 	}
 
-	pid = git_connect(fd, dest, receivepack, verbose ? CONNECT_VERBOSE : 0);
+	return send_pack(&args, dest, remote, nr_heads, heads);
+}
+
+int send_pack(struct send_pack_args *my_args,
+	      const char *dest, struct remote *remote,
+	      int nr_heads, const char **heads)
+{
+	int fd[2], ret;
+	pid_t pid;
+
+	memcpy(&args, my_args, sizeof(args));
+
+	verify_remote_names(nr_heads, heads);
+
+	pid = git_connect(fd, dest, args.receivepack, args.verbose ? CONNECT_VERBOSE : 0);
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
index 0000000..7a24f71
--- /dev/null
+++ b/send-pack.h
@@ -0,0 +1,17 @@
+#ifndef SEND_PACK_H
+#define SEND_PACK_H
+
+struct send_pack_args {
+	const char *receivepack;
+	unsigned verbose:1,
+		send_all:1,
+		force_update:1,
+		use_thin_pack:1,
+		dry_run:1;
+};
+
+int send_pack(struct send_pack_args *args,
+	      const char *dest, struct remote *remote,
+	      int nr_heads, const char **heads);
+
+#endif
-- 
1.5.3.4.1206.g5f96
