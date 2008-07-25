From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5/6] archive: allow --exec and --remote without equal sign
Date: Fri, 25 Jul 2008 12:41:26 +0200
Message-ID: <1216982486-5887-6-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1216982486-5887-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <1216982486-5887-2-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <1216982486-5887-3-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <1216982486-5887-4-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <1216982486-5887-5-git-send-email-rene.scharfe@lsrfire.ath.cx>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 12:50:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMKsi-0001aq-64
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 12:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348AbYGYKtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 06:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754283AbYGYKtk
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 06:49:40 -0400
Received: from india601.server4you.de ([85.25.151.105]:55541 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884AbYGYKtd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 06:49:33 -0400
Received: by india601.server4you.de (Postfix, from userid 1000)
	id 6A7CC2F81B4; Fri, 25 Jul 2008 12:41:26 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2
In-Reply-To: <1216982486-5887-5-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90028>

Convert git archive to parse_options().  The parameters --remote and --exec
are still handled by their special parser.  Define them anyway in order for
them to show up in the usage notice.

Note: in a command like "git archive --prefix --remote=a/ HEAD", the string
"--remote=a/" will be interpreted as a remote option, not a prefix, because
that special parser sees it first.  If one needs such a strange prefix, it
needs to be specified like this: "git archive --prefix=--remote=a/ HEAD"
(with an equal sign).

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive.c |  110 +++++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 68 insertions(+), 42 deletions(-)

diff --git a/archive.c b/archive.c
index f834b5f..5b40e26 100644
--- a/archive.c
+++ b/archive.c
@@ -3,9 +3,15 @@
 #include "tree-walk.h"
 #include "attr.h"
 #include "archive.h"
-
-static const char archive_usage[] = \
-"git archive --format=<fmt> [--prefix=<prefix>/] [--verbose] [<extra>] <tree-ish> [path...]";
+#include "parse-options.h"
+
+static char const * const archive_usage[] = {
+	"git archive [options] <tree-ish> [path...]",
+	"git archive --list",
+	"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [path...]",
+	"git archive --remote <repo> [--exec <cmd>] --list",
+	NULL
+};
 
 #define USES_ZLIB_COMPRESSION 1
 
@@ -175,6 +181,9 @@ static const struct archiver *lookup_archiver(const char *name)
 {
 	int i;
 
+	if (!name)
+		return NULL;
+
 	for (i = 0; i < ARRAY_SIZE(archivers); i++) {
 		if (!strcmp(name, archivers[i].name))
 			return &archivers[i];
@@ -232,51 +241,70 @@ static void parse_treeish_arg(const char **argv,
 	ar_args->time = archive_time;
 }
 
+#define OPT__COMPR(s, v, h, p) \
+	{ OPTION_SET_INT, (s), NULL, (v), NULL, (h), \
+	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, (p) }
+#define OPT__COMPR_HIDDEN(s, v, p) \
+	{ OPTION_SET_INT, (s), NULL, (v), NULL, "", \
+	  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN, NULL, (p) }
+
 static int parse_archive_args(int argc, const char **argv,
 		const struct archiver **ar, struct archiver_args *args)
 {
 	const char *format = "tar";
-	const char *base = "";
+	const char *base = NULL;
+	const char *remote = NULL;
+	const char *exec = NULL;
 	int compression_level = -1;
 	int verbose = 0;
 	int i;
-
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-
-		if (!strcmp(arg, "--list") || !strcmp(arg, "-l")) {
-			for (i = 0; i < ARRAY_SIZE(archivers); i++)
-				printf("%s\n", archivers[i].name);
-			exit(0);
-		}
-		if (!strcmp(arg, "--verbose") || !strcmp(arg, "-v")) {
-			verbose = 1;
-			continue;
-		}
-		if (!prefixcmp(arg, "--format=")) {
-			format = arg + 9;
-			continue;
-		}
-		if (!prefixcmp(arg, "--prefix=")) {
-			base = arg + 9;
-			continue;
-		}
-		if (!strcmp(arg, "--")) {
-			i++;
-			break;
-		}
-		if (arg[0] == '-' && isdigit(arg[1]) && arg[2] == '\0') {
-			compression_level = arg[1] - '0';
-			continue;
-		}
-		if (arg[0] == '-')
-			die("Unknown argument: %s", arg);
-		break;
+	int list = 0;
+	struct option opts[] = {
+		OPT_GROUP(""),
+		OPT_STRING(0, "format", &format, "fmt", "archive format"),
+		OPT_STRING(0, "prefix", &base, "prefix",
+			"prepend prefix to each pathname in the archive"),
+		OPT__VERBOSE(&verbose),
+		OPT__COMPR('0', &compression_level, "store only", 0),
+		OPT__COMPR('1', &compression_level, "compress faster", 1),
+		OPT__COMPR_HIDDEN('2', &compression_level, 2),
+		OPT__COMPR_HIDDEN('3', &compression_level, 3),
+		OPT__COMPR_HIDDEN('4', &compression_level, 4),
+		OPT__COMPR_HIDDEN('5', &compression_level, 5),
+		OPT__COMPR_HIDDEN('6', &compression_level, 6),
+		OPT__COMPR_HIDDEN('7', &compression_level, 7),
+		OPT__COMPR_HIDDEN('8', &compression_level, 8),
+		OPT__COMPR('9', &compression_level, "compress better", 9),
+		OPT_GROUP(""),
+		OPT_BOOLEAN('l', "list", &list,
+			"list supported archive formats"),
+		OPT_GROUP(""),
+		OPT_STRING(0, "remote", &remote, "repo",
+			"retrieve the archive from remote repository <repo>"),
+		OPT_STRING(0, "exec", &exec, "cmd",
+			"path to the remote git-upload-archive command"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, opts, archive_usage, 0);
+
+	if (remote)
+		die("Unexpected option --remote");
+	if (exec)
+		die("Option --exec can only be used together with --remote");
+
+	if (!base)
+		base = "";
+
+	if (list) {
+		for (i = 0; i < ARRAY_SIZE(archivers); i++)
+			printf("%s\n", archivers[i].name);
+		exit(0);
 	}
 
 	/* We need at least one parameter -- tree-ish */
-	if (argc - 1 < i)
-		usage(archive_usage);
+	if (argc < 1)
+		usage_with_options(archive_usage, opts);
 	*ar = lookup_archiver(format);
 	if (!*ar)
 		die("Unknown archive format '%s'", format);
@@ -294,7 +322,7 @@ static int parse_archive_args(int argc, const char **argv,
 	args->base = base;
 	args->baselen = strlen(base);
 
-	return i;
+	return argc;
 }
 
 int write_archive(int argc, const char **argv, const char *prefix,
@@ -302,13 +330,11 @@ int write_archive(int argc, const char **argv, const char *prefix,
 {
 	const struct archiver *ar = NULL;
 	struct archiver_args args;
-	int tree_idx;
 
-	tree_idx = parse_archive_args(argc, argv, &ar, &args);
+	argc = parse_archive_args(argc, argv, &ar, &args);
 	if (setup_prefix && prefix == NULL)
 		prefix = setup_git_directory();
 
-	argv += tree_idx;
 	parse_treeish_arg(argv, &args, prefix);
 	parse_pathspec_arg(argv + 1, &args);
 
-- 
1.6.0.rc0.42.g186458
