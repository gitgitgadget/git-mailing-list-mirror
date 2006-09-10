From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] archive: allow remote to have more formats than we understand.
Date: Sun, 10 Sep 2006 00:09:31 -0700
Message-ID: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Sep 10 09:09:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMJRm-0004zb-BP
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 09:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWIJHIy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 03:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWIJHIy
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 03:08:54 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:39830 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750708AbWIJHIx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 03:08:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060910070853.LOBC3535.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Sep 2006 03:08:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LX8t1V00T1kojtg0000000
	Sun, 10 Sep 2006 03:08:54 -0400
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26786>

This fixes git-archive --remote not to parse archiver arguments;
otherwise if the remote end implements formats other than the
one known locally we will not be able to access that format.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * At first sight, this should not matter that much, but (1) we
   do not really parse and validate the arguments when dealing
   with remote site, and (2) we have no way validating them if
   we wanted to, given that the remote end might be running
   different version of git.

   Having said that, you would realize that once we start
   refactoring things this way, "git archive --remote=foo" is
   not archive driver anymore.  There is nothing that prevents
   us saying "git archive --remote=foo --command=rev-list HEAD",
   other than that the remote archive protocol insists the
   command invoked at the remote end to be "git archive" itself.

 archive.h         |    1 -
 builtin-archive.c |   79 ++++++++++++++++++++++++++++++++---------------------
 2 files changed, 47 insertions(+), 33 deletions(-)

diff --git a/archive.h b/archive.h
index d8cca73..e0782b9 100644
--- a/archive.h
+++ b/archive.h
@@ -19,7 +19,6 @@ typedef void *(*parse_extra_args_fn_t)(i
 
 struct archiver {
 	const char *name;
-	const char *remote;
 	struct archiver_args args;
 	write_archive_fn_t write_archive;
 	parse_extra_args_fn_t parse_extra;
diff --git a/builtin-archive.c b/builtin-archive.c
index b944737..c70488c 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -26,7 +26,7 @@ struct archiver archivers[] = {
 	},
 };
 
-static int run_remote_archiver(struct archiver *ar, int argc,
+static int run_remote_archiver(const char *remote, int argc,
 			       const char **argv)
 {
 	char *url, buf[1024];
@@ -35,16 +35,13 @@ static int run_remote_archiver(struct ar
 
 	sprintf(buf, "git-upload-archive");
 
-	url = xstrdup(ar->remote);
+	url = xstrdup(remote);
 	pid = git_connect(fd, url, buf);
 	if (pid < 0)
 		return pid;
 
-	for (i = 1; i < argc; i++) {
-		if (!strncmp(argv[i], "--remote=", 9))
-			continue;
+	for (i = 1; i < argc; i++)
 		packet_write(fd[1], "argument %s\n", argv[i]);
-	}
 	packet_flush(fd[1]);
 
 	len = packet_read_line(fd[0], buf, sizeof(buf));
@@ -150,17 +147,16 @@ int parse_archive_args(int argc, const c
 	const char *extra_argv[MAX_EXTRA_ARGS];
 	int extra_argc = 0;
 	const char *format = NULL; /* might want to default to "tar" */
-	const char *remote = NULL;
 	const char *base = "";
-	int list = 0;
 	int i;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
 		if (!strcmp(arg, "--list") || !strcmp(arg, "-l")) {
-			list = 1;
-			continue;
+			for (i = 0; i < ARRAY_SIZE(archivers); i++)
+				printf("%s\n", archivers[i].name);
+			exit(0);
 		}
 		if (!strncmp(arg, "--format=", 9)) {
 			format = arg + 9;
@@ -170,10 +166,6 @@ int parse_archive_args(int argc, const c
 			base = arg + 9;
 			continue;
 		}
-		if (!strncmp(arg, "--remote=", 9)) {
-			remote = arg + 9;
-			continue;
-		}
 		if (!strcmp(arg, "--")) {
 			i++;
 			break;
@@ -187,44 +179,67 @@ int parse_archive_args(int argc, const c
 		break;
 	}
 
-	if (list) {
-		if (!remote) {
-			for (i = 0; i < ARRAY_SIZE(archivers); i++)
-				printf("%s\n", archivers[i].name);
-			exit(0);
-		}
-		die("--list and --remote are mutually exclusive");
-	}
-
-	if (argc - i < 1)
+	/* We need at least one parameter -- tree-ish */
+	if (argc - 1 < i)
 		usage(archive_usage);
 	if (!format)
 		die("You must specify an archive format");
 	if (init_archiver(format, ar) < 0)
 		die("Unknown archive format '%s'", format);
 
-	if (extra_argc && !remote) {
-		if (!ar->parse_extra) {
+	if (extra_argc) {
+		if (!ar->parse_extra)
 			die("%s", default_parse_extra(ar, extra_argv));
-		}
 		ar->args.extra = ar->parse_extra(extra_argc, extra_argv);
 	}
-	ar->remote = remote;
 	ar->args.base = base;
 
 	return i;
 }
 
+static const char *remote_request(int *ac, const char **av)
+{
+	int ix, iy, cnt = *ac;
+	int no_more_options = 0;
+	const char *remote = NULL;
+
+	for (ix = iy = 1; ix < cnt; ix++) {
+		const char *arg = av[ix];
+		if (!strcmp(arg, "--"))
+			no_more_options = 1;
+		if (!no_more_options) {
+			if (!strncmp(arg, "--remote=", 9)) {
+				if (remote)
+					die("Multiple --remote specified");
+				remote = arg + 9;
+				continue;
+			}
+			if (arg[0] != '-')
+				no_more_options = 1;
+		}
+		if (ix != iy)
+			av[iy] = arg;
+		iy++;
+	}
+	if (remote) {
+		av[--cnt] = NULL;
+		*ac = cnt;
+	}
+	return remote;
+}
+
 int cmd_archive(int argc, const char **argv, const char *prefix)
 {
 	struct archiver ar;
 	int tree_idx;
+	const char *remote = NULL;
 
-	tree_idx = parse_archive_args(argc, argv, &ar);
-
-	if (ar.remote)
-		return run_remote_archiver(&ar, argc, argv);
+	remote = remote_request(&argc, argv);
+	if (remote)
+		return run_remote_archiver(remote, argc, argv);
 
+	memset(&ar, 0, sizeof(ar));
+	tree_idx = parse_archive_args(argc, argv, &ar);
 	if (prefix == NULL)
 		prefix = setup_git_directory();
 
-- 
1.4.2.gc52f
