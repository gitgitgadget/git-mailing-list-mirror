From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] parse-opt: migrate builtin-ls-files.
Date: Tue, 17 Feb 2009 15:27:11 +0100
Message-ID: <20090217142711.GT4371@genesis.frugalware.org>
References: <1234727647-18523-1-git-send-email-vmiklos@frugalware.org> <alpine.DEB.1.00.0902152108370.10279@pacific.mpi-cbg.de> <20090215220706.GB4371@genesis.frugalware.org> <alpine.DEB.1.00.0902161317570.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 15:28:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQwF-0007CO-0z
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 15:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbZBQO1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 09:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbZBQO1O
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 09:27:14 -0500
Received: from virgo.iok.hu ([212.40.97.103]:33822 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894AbZBQO1N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 09:27:13 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 4379A580D1;
	Tue, 17 Feb 2009 15:27:12 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 9438C446A6;
	Tue, 17 Feb 2009 15:27:10 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id EBC2811B877C; Tue, 17 Feb 2009 15:27:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902161317570.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110389>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-ls-files.c |  255 ++++++++++++++++++++++++---------------------------
 1 files changed, 120 insertions(+), 135 deletions(-)

On Mon, Feb 16, 2009 at 01:20:25PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 	I meant this...

And here is my patch on top of this one.
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index d36f80b..1742c0f 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -10,6 +10,7 @@
 #include "dir.h"
 #include "builtin.h"
 #include "tree.h"
+#include "parse-options.h"
 
 static int abbrev;
 static int show_deleted;
@@ -28,6 +29,7 @@ static const char **pathspec;
 static int error_unmatch;
 static char *ps_matched;
 static const char *with_tree;
+static int exc_given;
 
 static const char *tag_cached = "";
 static const char *tag_unmerged = "";
@@ -376,156 +378,139 @@ int report_path_error(const char *ps_matched, const char **pathspec, int prefix_
 	return errors;
 }
 
-static const char ls_files_usage[] =
-	"git ls-files [-z] [-t] [-v] (--[cached|deleted|others|stage|unmerged|killed|modified])* "
-	"[ --ignored ] [--exclude=<pattern>] [--exclude-from=<file>] "
-	"[ --exclude-per-directory=<filename> ] [--exclude-standard] "
-	"[--full-name] [--abbrev] [--] [<file>]*";
+static const char * const ls_files_usage[] = {
+	"git ls-files [options] [<file>]*",
+	NULL
+};
+
+static int option_parse_z(const struct option *opt,
+			  const char *arg, int unset)
+{
+	line_terminator = unset ? '\n' : '\0';
+
+	return 0;
+}
+
+static int option_parse_exclude(const struct option *opt,
+				const char *arg, int unset)
+{
+	struct exclude_list *list = opt->value;
+
+	exc_given = 1;
+	add_exclude(arg, "", 0, list);
+
+	return 0;
+}
+
+static int option_parse_exclude_from(const struct option *opt,
+				     const char *arg, int unset)
+{
+	struct dir_struct *dir = opt->value;
+
+	exc_given = 1;
+	add_excludes_from_file(dir, arg);
+
+	return 0;
+}
+
+static int option_parse_exclude_standard(const struct option *opt,
+					 const char *arg, int unset)
+{
+	struct dir_struct *dir = opt->value;
+
+	exc_given = 1;
+	setup_standard_excludes(dir);
+
+	return 0;
+}
 
 int cmd_ls_files(int argc, const char **argv, const char *prefix)
 {
-	int i;
-	int exc_given = 0, require_work_tree = 0;
+	int require_work_tree = 0, show_tag = 0;
 	struct dir_struct dir;
+	struct option builtin_ls_files_options[] = {
+		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
+			"paths are separated with NUL character",
+			PARSE_OPT_NOARG, option_parse_z },
+		OPT_BOOLEAN('t', NULL, &show_tag,
+			"identify the file status with tags"),
+		OPT_BOOLEAN('v', NULL, &show_valid_bit,
+			"use lowercase letters for 'assume unchanged' files"),
+		OPT_BOOLEAN('c', "cached", &show_cached,
+			"show cached files in the output (default)"),
+		OPT_BOOLEAN('d', "deleted", &show_deleted,
+			"show deleted files in the output"),
+		OPT_BOOLEAN('m', "modified", &show_modified,
+			"show modified files in the output"),
+		OPT_BOOLEAN('o', "others", &show_others,
+			"show other files in the output"),
+		OPT_BIT('i', "ignored", &dir.flags,
+			"show ignored files in the output",
+			DIR_SHOW_IGNORED),
+		OPT_BOOLEAN('s', "stage", &show_stage,
+			"show staged contents' object name in the output"),
+		OPT_BOOLEAN('k', "killed", &show_killed,
+			"show files on the filesystem that need to be removed"),
+		OPT_BIT(0, "directory", &dir.flags,
+			"show 'other' directories' name only",
+			DIR_SHOW_OTHER_DIRECTORIES),
+		OPT_BIT(0, "empty-directory", &dir.flags,
+			"list empty directories",
+			DIR_HIDE_EMPTY_DIRECTORIES),
+		OPT_BOOLEAN('u', "unmerged", &show_unmerged,
+			"show unmerged files in the output"),
+		{ OPTION_CALLBACK, 'x', "exclude", &dir.exclude_list[EXC_CMDL], "pattern",
+			"skip files matching pattern",
+			0, option_parse_exclude },
+		{ OPTION_CALLBACK, 'X', "exclude-from", &dir, "file",
+			"exclude patterns are read from <file>",
+			0, option_parse_exclude_from },
+		OPT_STRING(0, "exclude-per-directory", &dir.exclude_per_dir, "file",
+			"read additional per-directory exclude patterns in <file>"),
+		{ OPTION_CALLBACK, 0, "exclude-standard", &dir, NULL,
+			"add the standard git exclusions",
+			PARSE_OPT_NOARG, option_parse_exclude_standard },
+		{ OPTION_SET_INT, 0, "full-name", &prefix_offset, NULL,
+			"make the output relative to the project top directory",
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL },
+		OPT_BOOLEAN(0, "error-unmatch", &error_unmatch,
+			"if any <file> is not in the index, treat this as an error"),
+		OPT_STRING(0, "with-tree", &with_tree, "tree-ish",
+			"pretend that paths removed since <tree-ish> are still present"),
+		OPT__ABBREV(&abbrev),
+		OPT_END()
+	};
 
 	memset(&dir, 0, sizeof(dir));
 	if (prefix)
 		prefix_offset = strlen(prefix);
 	git_config(git_default_config, NULL);
 
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
-			require_work_tree = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-o") || !strcmp(arg, "--others")) {
-			show_others = 1;
-			require_work_tree = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-i") || !strcmp(arg, "--ignored")) {
-			dir.flags |= DIR_SHOW_IGNORED;
-			require_work_tree = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-s") || !strcmp(arg, "--stage")) {
-			show_stage = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-k") || !strcmp(arg, "--killed")) {
-			show_killed = 1;
-			require_work_tree = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--directory")) {
-			dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
-			continue;
-		}
-		if (!strcmp(arg, "--no-empty-directory")) {
-			dir.flags |= DIR_HIDE_EMPTY_DIRECTORIES;
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
-			add_exclude(argv[++i], "", 0, &dir.exclude_list[EXC_CMDL]);
-			continue;
-		}
-		if (!prefixcmp(arg, "--exclude=")) {
-			exc_given = 1;
-			add_exclude(arg+10, "", 0, &dir.exclude_list[EXC_CMDL]);
-			continue;
-		}
-		if (!strcmp(arg, "-X") && i+1 < argc) {
-			exc_given = 1;
-			add_excludes_from_file(&dir, argv[++i]);
-			continue;
-		}
-		if (!prefixcmp(arg, "--exclude-from=")) {
-			exc_given = 1;
-			add_excludes_from_file(&dir, arg+15);
-			continue;
-		}
-		if (!prefixcmp(arg, "--exclude-per-directory=")) {
-			exc_given = 1;
-			dir.exclude_per_dir = arg + 24;
-			continue;
-		}
-		if (!strcmp(arg, "--exclude-standard")) {
-			exc_given = 1;
-			setup_standard_excludes(&dir);
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
-		if (!prefixcmp(arg, "--with-tree=")) {
-			with_tree = arg + 12;
-			continue;
-		}
-		if (!prefixcmp(arg, "--abbrev=")) {
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
+	argc = parse_options(argc, argv, builtin_ls_files_options,
+			ls_files_usage, 0);
+	if (show_tag || show_valid_bit) {
+		tag_cached = "H ";
+		tag_unmerged = "M ";
+		tag_removed = "R ";
+		tag_modified = "C ";
+		tag_other = "? ";
+		tag_killed = "K ";
 	}
+	if (show_modified || show_others || (dir.flags & DIR_SHOW_IGNORED) || show_killed)
+		require_work_tree = 1;
+	if (show_unmerged)
+		/*
+		 * There's no point in showing unmerged unless
+		 * you also show the stage information.
+		 */
+		show_stage = 1;
+	if (dir.exclude_per_dir)
+		exc_given = 1;
 
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
 
-	pathspec = get_pathspec(prefix, argv + i);
+	pathspec = get_pathspec(prefix, argv);
 
 	/* be nice with submodule patsh ending in a slash */
 	read_cache();
-- 
1.6.1
