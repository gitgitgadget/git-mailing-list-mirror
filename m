From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 4/6] ls-files: convert to using gitopt
Date: Mon, 08 May 2006 22:06:47 -0700
Message-ID: <11471512121152-git-send-email-normalperson@yhbt.net>
References: <1147151211399-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 09 08:22:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdLcQ-00087J-Kb
	for gcvg-git@gmane.org; Tue, 09 May 2006 08:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWEIGWs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 02:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWEIGWs
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 02:22:48 -0400
Received: from hand.yhbt.net ([66.150.188.102]:8415 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751424AbWEIGWn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 02:22:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 0CDAE2DC035;
	Mon,  8 May 2006 23:22:43 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.2.ge3d7
In-Reply-To: <1147151211399-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19821>

Another simple and straight forward conversion, imho.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 ls-files.c |  187 ++++++++++++++++++++++--------------------------------------
 1 files changed, 69 insertions(+), 118 deletions(-)

6a65d6f1e59638185c846920d8c6f0dbd82f1bf7
diff --git a/ls-files.c b/ls-files.c
index 4a4af1c..62f9e10 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -10,6 +10,8 @@ #include <fnmatch.h>
 
 #include "cache.h"
 #include "quote.h"
+#include "gitopt.h"
+#include "gitopt/abbrev.h"
 
 static int abbrev = 0;
 static int show_deleted = 0;
@@ -648,133 +650,82 @@ static const char ls_files_usage[] =
 	"[ --exclude-per-directory=<filename> ] [--full-name] [--abbrev] "
 	"[--] [<file>]*";
 
+static void tag_pfx()
+{
+	tag_cached = "H ";
+	tag_unmerged = "M ";
+	tag_removed = "R ";
+	tag_modified = "C ";
+	tag_other = "? ";
+	tag_killed = "K ";
+}
+
+static int exc_given = 0;
+
+gitopt_eat(opt_z, line_terminator = 0;)
+gitopt_eat(opt_t, tag_pfx();)
+gitopt_eat(opt_v, tag_pfx(); show_valid_bit = 1;)
+gitopt_eat(opt_c, show_cached = 1;)
+gitopt_eat(opt_d, show_deleted = 1;)
+gitopt_eat(opt_m, show_modified = 1;)
+gitopt_eat(opt_o, show_others = 1;)
+gitopt_eat(opt_i, show_ignored = 1;)
+gitopt_eat(opt_s, show_stage = 1;)
+gitopt_eat(opt_k, show_killed = 1;)
+gitopt_eat(opt_directory, show_other_directories = 1;)
+gitopt_eat(opt_no_empty_directory, hide_empty_directories = 1;)
+gitopt_eat(opt_u, show_stage = 1; show_unmerged = 1;)
+gitopt_eat_one_arg(opt_x,
+		exc_given = 1;
+		add_exclude(ea->argv[0], "", 0, &exclude_list[EXC_CMDL]);)
+gitopt_eat_one_arg(opt_X,
+		exc_given = 1;
+		add_excludes_from_file(ea->argv[0]);)
+gitopt_eat_one_arg(opt_exclude_per_dir,
+		exc_given = 1;
+		exclude_per_dir = ea->argv[0];)
+gitopt_eat(opt_full_name, prefix_offset = 0;)
+gitopt_eat(opt_error_unmatch, error_unmatch = 1;)
+gitopt_opt_abbrev(abbrev)
+
+static const struct opt_spec ls_files_ost[] = {
+	{ 0,			'z',	0,	0,	opt_z },
+	{ 0,			'v',	0,	0,	opt_v },
+	{ 0,			't',	0,	0,	opt_t },
+	{ "cached",		'c',	0,	0,	opt_c },
+	{ "deleted",		'd',	0,	0,	opt_d },
+	{ "modified",		'm',	0,	0,	opt_m },
+	{ "others",		'o',	0,	0,	opt_o },
+	{ "ignored",		'i',	0,	0,	opt_i },
+	{ "stage",		's',	0,	0,	opt_s },
+	{ "killed",		'k',	0,	0,	opt_k },
+	{ "directory",		0,	0,	0,	opt_directory },
+	{ "no-empty-directory",	0,	0,	0,	opt_no_empty_directory},
+	{ "unmerged",		'u',	0,	0,	opt_u },
+	{ "exclude",		'x',	"%s",	ARG_ONE,	opt_x },
+	{ "exclude-from",	'X',	"%s",	ARG_ONE,	opt_X },
+	{ "exclude-per-directory",0,	"%s",	ARG_ONE, opt_exclude_per_dir },
+	{ "full-name",		0,	0,	0,	opt_full_name },
+	{ "error-unmatch",	0,	0,	0,	opt_error_unmatch },
+	abbrev_ost_row,
+	{ 0, 0 }
+};
+
 int main(int argc, const char **argv)
 {
-	int i;
-	int exc_given = 0;
+	struct exec_args *a = new_exec_args(argc); /* argv[0] and options: */
+	struct exec_args *b = new_exec_args(argc); /* non-option args */
 
 	prefix = setup_git_directory();
 	if (prefix)
 		prefix_offset = strlen(prefix);
 	git_config(git_default_config);
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-
-		if (!strcmp(arg, "--")) {
-			i++;
-			break;
-		}
-		if (!strcmp(arg, "-z")) {
-			line_terminator = 0;
-			continue;
-		}
-		if (!strcmp(arg, "-t") || !strcmp(arg, "-v")) {
-			tag_cached = "H ";
-			tag_unmerged = "M ";
-			tag_removed = "R ";
-			tag_modified = "C ";
-			tag_other = "? ";
-			tag_killed = "K ";
-			if (arg[1] == 'v')
-				show_valid_bit = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-c") || !strcmp(arg, "--cached")) {
-			show_cached = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-d") || !strcmp(arg, "--deleted")) {
-			show_deleted = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-m") || !strcmp(arg, "--modified")) {
-			show_modified = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-o") || !strcmp(arg, "--others")) {
-			show_others = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-i") || !strcmp(arg, "--ignored")) {
-			show_ignored = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-s") || !strcmp(arg, "--stage")) {
-			show_stage = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-k") || !strcmp(arg, "--killed")) {
-			show_killed = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--directory")) {
-			show_other_directories = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--no-empty-directory")) {
-			hide_empty_directories = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-u") || !strcmp(arg, "--unmerged")) {
-			/* There's no point in showing unmerged unless
-			 * you also show the stage information.
-			 */
-			show_stage = 1;
-			show_unmerged = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-x") && i+1 < argc) {
-			exc_given = 1;
-			add_exclude(argv[++i], "", 0, &exclude_list[EXC_CMDL]);
-			continue;
-		}
-		if (!strncmp(arg, "--exclude=", 10)) {
-			exc_given = 1;
-			add_exclude(arg+10, "", 0, &exclude_list[EXC_CMDL]);
-			continue;
-		}
-		if (!strcmp(arg, "-X") && i+1 < argc) {
-			exc_given = 1;
-			add_excludes_from_file(argv[++i]);
-			continue;
-		}
-		if (!strncmp(arg, "--exclude-from=", 15)) {
-			exc_given = 1;
-			add_excludes_from_file(arg+15);
-			continue;
-		}
-		if (!strncmp(arg, "--exclude-per-directory=", 24)) {
-			exc_given = 1;
-			exclude_per_dir = arg + 24;
-			continue;
-		}
-		if (!strcmp(arg, "--full-name")) {
-			prefix_offset = 0;
-			continue;
-		}
-		if (!strcmp(arg, "--error-unmatch")) {
-			error_unmatch = 1;
-			continue;
-		}
-		if (!strncmp(arg, "--abbrev=", 9)) {
-			abbrev = strtoul(arg+9, NULL, 10);
-			if (abbrev && abbrev < MINIMUM_ABBREV)
-				abbrev = MINIMUM_ABBREV;
-			else if (abbrev > 40)
-				abbrev = 40;
-			continue;
-		}
-		if (!strcmp(arg, "--abbrev")) {
-			abbrev = DEFAULT_ABBREV;
-			continue;
-		}
-		if (*arg == '-')
-			usage(ls_files_usage);
-		break;
-	}
+	if (gitopt_parse_ost_split(a, b, ls_files_ost, argc, argv) < 0)
+		usage(ls_files_usage);
+	free_exec_args(a);
 
-	pathspec = get_pathspec(prefix, argv + i);
+	pathspec = get_pathspec(prefix,b->argv);
 
 	/* Verify that the pathspec matches the prefix */
 	if (pathspec)
-- 
1.3.2.g0a3ae
