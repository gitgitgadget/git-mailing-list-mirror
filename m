From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/4] archive: use parseopt for local-only options
Date: Sun, 08 Mar 2009 19:21:53 +0100
Message-ID: <49B40CC1.2090906@lsrfire.ath.cx>
References: <7vfxhs2shk.fsf@gitster.siamese.dyndns.org> <49B2C784.90800@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, carlos.duclos@nokia.com,
	Pierre Habouzit <madcoder@madism.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 19:23:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgNen-0005gS-HX
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 19:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbZCHSV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 14:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753373AbZCHSV5
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 14:21:57 -0400
Received: from india601.server4you.de ([85.25.151.105]:46152 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245AbZCHSV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 14:21:56 -0400
Received: from [10.0.1.101] (p57B7C244.dip.t-dialin.net [87.183.194.68])
	by india601.server4you.de (Postfix) with ESMTPSA id B63E92F8063;
	Sun,  8 Mar 2009 19:21:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <49B2C784.90800@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112628>

Replace the hand-rolled parsers that find and remove --remote and --exec
by a parseopt parser that also handles --output.

All three options only have a meaning if no remote server is used or on
the local side.  They must be rejected by upload-archive and should not
be sent to the server by archive.

We can't use a single parser for both remote and local side because the
remote end possibly understands a different set of options than the
local side.  A local parser would then wrongly accuse options valid on
the other side as being incorrect.

This patch implements a very forgiving parser that understands only the
three options mentioned above.  All others are passed to the normal,
complete parser in archive.c (running either locally in archive, or
remotely in upload-archive).  This normal parser definition contains
dummy entries for the three options, in order for them to appear in the
help screen.

The parseopt parser allows multiple occurrences of --remote and --exec
unlike the previous one; the one specified last wins.  This looseness
is acceptable, I think.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive.c         |   18 +--------
 builtin-archive.c |  103 +++++++++++++++++++---------------------------------
 2 files changed, 40 insertions(+), 81 deletions(-)

diff --git a/archive.c b/archive.c
index c6aea83..96b62d4 100644
--- a/archive.c
+++ b/archive.c
@@ -239,19 +239,6 @@ static void parse_treeish_arg(const char **argv,
 	ar_args->time = archive_time;
 }
 
-static void create_output_file(const char *output_file)
-{
-	int output_fd = open(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
-	if (output_fd < 0)
-		die("could not create archive file: %s ", output_file);
-	if (output_fd != 1) {
-		if (dup2(output_fd, 1) < 0)
-			die("could not redirect output");
-		else
-			close(output_fd);
-	}
-}
-
 #define OPT__COMPR(s, v, h, p) \
 	{ OPTION_SET_INT, (s), NULL, (v), NULL, (h), \
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, (p) }
@@ -306,13 +293,12 @@ static int parse_archive_args(int argc, const char **argv,
 		die("Unexpected option --remote");
 	if (exec)
 		die("Option --exec can only be used together with --remote");
+	if (output)
+		die("Unexpected option --output");
 
 	if (!base)
 		base = "";
 
-	if (output)
-		create_output_file(output);
-
 	if (list) {
 		for (i = 0; i < ARRAY_SIZE(archivers); i++)
 			printf("%s\n", archivers[i].name);
diff --git a/builtin-archive.c b/builtin-archive.c
index 5ceec43..60adef9 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -5,44 +5,35 @@
 #include "cache.h"
 #include "builtin.h"
 #include "archive.h"
+#include "parse-options.h"
 #include "pkt-line.h"
 #include "sideband.h"
 
-static int run_remote_archiver(const char *remote, int argc,
-			       const char **argv)
+static void create_output_file(const char *output_file)
+{
+	int output_fd = open(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
+	if (output_fd < 0)
+		die("could not create archive file: %s ", output_file);
+	if (output_fd != 1) {
+		if (dup2(output_fd, 1) < 0)
+			die("could not redirect output");
+		else
+			close(output_fd);
+	}
+}
+
+static int run_remote_archiver(int argc, const char **argv,
+			       const char *remote, const char *exec)
 {
 	char *url, buf[LARGE_PACKET_MAX];
 	int fd[2], i, len, rv;
 	struct child_process *conn;
-	const char *exec = "git-upload-archive";
-	int exec_at = 0, exec_value_at = 0;
-
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (!prefixcmp(arg, "--exec=")) {
-			if (exec_at)
-				die("multiple --exec specified");
-			exec = arg + 7;
-			exec_at = i;
-		} else if (!strcmp(arg, "--exec")) {
-			if (exec_at)
-				die("multiple --exec specified");
-			if (i + 1 >= argc)
-				die("option --exec requires a value");
-			exec = argv[i + 1];
-			exec_at = i;
-			exec_value_at = ++i;
-		}
-	}
 
 	url = xstrdup(remote);
 	conn = git_connect(fd, url, exec, 0);
 
-	for (i = 1; i < argc; i++) {
-		if (i == exec_at || i == exec_value_at)
-			continue;
+	for (i = 1; i < argc; i++)
 		packet_write(fd[1], "argument %s\n", argv[i]);
-	}
 	packet_flush(fd[1]);
 
 	len = packet_read_line(fd[0], buf, sizeof(buf));
@@ -69,51 +60,33 @@ static int run_remote_archiver(const char *remote, int argc,
 	return !!rv;
 }
 
-static const char *extract_remote_arg(int *ac, const char **av)
-{
-	int ix, iy, cnt = *ac;
-	int no_more_options = 0;
-	const char *remote = NULL;
-
-	for (ix = iy = 1; ix < cnt; ix++) {
-		const char *arg = av[ix];
-		if (!strcmp(arg, "--"))
-			no_more_options = 1;
-		if (!no_more_options) {
-			if (!prefixcmp(arg, "--remote=")) {
-				if (remote)
-					die("Multiple --remote specified");
-				remote = arg + 9;
-				continue;
-			} else if (!strcmp(arg, "--remote")) {
-				if (remote)
-					die("Multiple --remote specified");
-				if (++ix >= cnt)
-					die("option --remote requires a value");
-				remote = av[ix];
-				continue;
-			}
-			if (arg[0] != '-')
-				no_more_options = 1;
-		}
-		if (ix != iy)
-			av[iy] = arg;
-		iy++;
-	}
-	if (remote) {
-		av[--cnt] = NULL;
-		*ac = cnt;
-	}
-	return remote;
-}
+#define PARSE_OPT_KEEP_ALL ( PARSE_OPT_KEEP_DASHDASH | 	\
+			     PARSE_OPT_KEEP_ARGV0 | 	\
+			     PARSE_OPT_KEEP_UNKNOWN |	\
+			     PARSE_OPT_NO_INTERNAL_HELP	)
 
 int cmd_archive(int argc, const char **argv, const char *prefix)
 {
+	const char *exec = "git-upload-archive";
+	const char *output = NULL;
 	const char *remote = NULL;
+	struct option local_opts[] = {
+		OPT_STRING(0, "output", &output, "file",
+			"write the archive to this file"),
+		OPT_STRING(0, "remote", &remote, "repo",
+			"retrieve the archive from remote repository <repo>"),
+		OPT_STRING(0, "exec", &exec, "cmd",
+			"path to the remote git-upload-archive command"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, local_opts, NULL, PARSE_OPT_KEEP_ALL);
+
+	if (output)
+		create_output_file(output);
 
-	remote = extract_remote_arg(&argc, argv);
 	if (remote)
-		return run_remote_archiver(remote, argc, argv);
+		return run_remote_archiver(argc, argv, remote, exec);
 
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
 
-- 
1.6.2
