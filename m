From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH v2] parse-opt: migrate builtin-ls-files.
Date: Wed,  7 Jan 2009 04:11:34 +0100
Message-ID: <1231297894-31809-1-git-send-email-vmiklos@frugalware.org>
References: <20090106102202.GA30766@artemis.corp>
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 04:13:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKOqt-00065J-Lp
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 04:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbZAGDLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 22:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbZAGDLk
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 22:11:40 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:53266 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbZAGDLj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 22:11:39 -0500
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id 783D2446CE2;
	Wed,  7 Jan 2009 04:11:36 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 3938819DFC4; Wed,  7 Jan 2009 04:11:34 +0100 (CET)
X-Mailer: git-send-email 1.6.1
In-Reply-To: <20090106102202.GA30766@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104748>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Tue, Jan 06, 2009 at 11:22:02AM +0100, Pierre Habouzit <madcoder@debian.org> wrote:
> > +static int option_parse_no_empty(const struct option *opt,
> > +                            const char *arg, int unset)
> > +{
> > +   struct dir_struct *dir = opt->value;
> > +
> > +   dir->hide_empty_directories = 1;
> > +
> > +   return 0;
> > +}
>
> Should be option_parse_empty and deal with "unset" to know if `no-`
> was
> prefixed to it or not.
>
>
> > +           { OPTION_CALLBACK, 0, "no-empty-directory", &dir, NULL,
> > +                   "do not list empty directories",
>
> This should be "empty-directory" and "list empty directories as well"

Ah, sure.

> I've not checked if you could also check more of the "unsets" things
> in
> your callbacks as well btw, but it looks like it could.

Right, added to option_parse_ignored() and option_parse_directory() as
well.

Interdiff: b3b6ad0..a44941c in git://repo.or.cz/git/vmiklos.git.

 builtin-ls-files.c |  303 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 168 insertions(+), 135 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index f72eb85..8a946ef 100644
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
@@ -395,156 +397,187 @@ int report_path_error(const char *ps_matched, const char **pathspec, int prefix_
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
+	if (unset)
+		line_terminator = '\n';
+	else
+		line_terminator = 0;
+	return 0;
+}
+
+static int option_parse_exclude(const struct option *opt,
+				const char *arg, int unset)
+{
+	struct dir_struct *dir = opt->value;
+
+	exc_given = 1;
+	add_exclude(arg, "", 0, &dir->exclude_list[EXC_CMDL]);
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
+
+static int option_parse_ignored(const struct option *opt,
+				const char *arg, int unset)
+{
+	struct dir_struct *dir = opt->value;
+
+	if (unset)
+		dir->show_ignored = 0;
+	else
+		dir->show_ignored = 1;
+
+	return 0;
+}
+
+static int option_parse_directory(const struct option *opt,
+				  const char *arg, int unset)
+{
+	struct dir_struct *dir = opt->value;
+
+	if (unset)
+		dir->show_other_directories = 0;
+	else
+		dir->show_other_directories = 1;
+
+	return 0;
+}
+
+static int option_parse_empty(const struct option *opt,
+				 const char *arg, int unset)
+{
+	struct dir_struct *dir = opt->value;
+
+	if (unset)
+		dir->hide_empty_directories = 1;
+	else
+		dir->hide_empty_directories = 0;
+
+	return 0;
+}
+
+static int option_parse_full_name(const struct option *opt,
+				  const char *arg, int unset)
+{
+	prefix_offset = 0;
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
+				"show cached files in the output (default)"),
+		OPT_BOOLEAN('d', "deleted", &show_deleted,
+				"show deleted files in the output"),
+		OPT_BOOLEAN('m', "modified", &show_modified,
+				"show modified files in the output"),
+		OPT_BOOLEAN('o', "others", &show_others,
+				"show other files in the output"),
+		{ OPTION_CALLBACK, 'i', "ignored", &dir, NULL,
+			"show ignored files in the output",
+			PARSE_OPT_NOARG, option_parse_ignored },
+		OPT_BOOLEAN('s', "stage", &show_stage,
+			"show staged contents' object name in the output"),
+		OPT_BOOLEAN('k', "killed", &show_killed,
+			"show files on the filesystem that need to be removed"),
+		{ OPTION_CALLBACK, 0, "directory", &dir, NULL,
+			"show 'other' directories' name only",
+			PARSE_OPT_NOARG, option_parse_directory },
+		{ OPTION_CALLBACK, 0, "empty-directory", &dir, NULL,
+			"list empty directories",
+			PARSE_OPT_NOARG, option_parse_empty },
+		OPT_BOOLEAN('u', "unmerged", &show_unmerged,
+			"show unmerged files in the output"),
+		{ OPTION_CALLBACK, 'x', "exclude", &dir, "pattern",
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
+		{ OPTION_CALLBACK, 0, "full-name", NULL, NULL,
+			"make the output relative to the project top directory",
+			PARSE_OPT_NOARG, option_parse_full_name },
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
-			dir.show_ignored = 1;
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
-			dir.show_other_directories = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--no-empty-directory")) {
-			dir.hide_empty_directories = 1;
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
+	if (show_modified || show_others || dir.show_ignored || show_killed)
+		require_work_tree = 1;
+	if (show_unmerged)
+		/* There's no point in showing unmerged unless
+		 * you also show the stage information.
+		 */
+		show_stage = 1;
+	if (dir.exclude_per_dir)
+		exc_given = 1;
 
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
 
-	pathspec = get_pathspec(prefix, argv + i);
+	pathspec = get_pathspec(prefix, argv);
 
 	/* Verify that the pathspec matches the prefix */
 	if (pathspec)
-- 
1.6.1
