From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/5] gitopt: convert ls-files, ls-tree, update-index
Date: Sun, 14 May 2006 08:19:19 -0700
Message-ID: <11476199623781-git-send-email-normalperson@yhbt.net>
References: <11476199622462-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun May 14 17:19:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfINi-0004pX-Cp
	for gcvg-git@gmane.org; Sun, 14 May 2006 17:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWENPT1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 11:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWENPT1
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 11:19:27 -0400
Received: from hand.yhbt.net ([66.150.188.102]:65180 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751450AbWENPTX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 11:19:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 2DD8E7DC021;
	Sun, 14 May 2006 08:19:23 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.2.ge3d7
In-Reply-To: <11476199622462-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19965>

All of these are pretty straighforward conversions

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 ls-files.c     |  184 +++++++++++++++++++++-------------------
 ls-tree.c      |   82 ++++++++++++------
 update-index.c |  257 ++++++++++++++++++++++++++++++--------------------------
 3 files changed, 287 insertions(+), 236 deletions(-)

962175b2be70eab14997a10ebb9c7cd719d72c1b
diff --git a/ls-files.c b/ls-files.c
index 4a4af1c..9f4d328 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -10,6 +10,7 @@ #include <fnmatch.h>
 
 #include "cache.h"
 #include "quote.h"
+#include "gitopt.h"
 
 static int abbrev = 0;
 static int show_deleted = 0;
@@ -648,133 +649,140 @@ static const char ls_files_usage[] =
 	"[ --exclude-per-directory=<filename> ] [--full-name] [--abbrev] "
 	"[--] [<file>]*";
 
+enum ls_files_ids {
+	opt_z = 1, opt_v, opt_t, opt_c, opt_d, opt_m, opt_o, opt_i, opt_s,
+	opt_k, opt_directory, opt_no_empty_directory,
+	opt_u, opt_x, opt_X, opt_exclude_per_dir,
+	opt_abbrev, opt_full_name, opt_error_unmatch
+};
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
+	{ "exclude",		'x',	0,	ARG_ONE,	opt_x },
+	{ "exclude-from",	'X',	0,	ARG_ONE,	opt_X },
+	{ "exclude-per-directory",0,	0,	ARG_ONE, opt_exclude_per_dir },
+	{ "full-name",		0,	0,	0,	opt_full_name },
+	{ "error-unmatch",	0,	0,	0,	opt_error_unmatch },
+	{ "abbrev",		0,	0,	ARG_OPTINT, opt_abbrev },
+	{ 0, 0 }
+};
+
 int main(int argc, const char **argv)
 {
 	int i;
 	int exc_given = 0;
+	struct gitopt_iterator gi;
+	struct exec_args *ea, *b;
 
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
+	gitopt_iter_setup(&gi, argc, argv);
+	ea = gi.ea;
+	b = gi.b;
+	for (; (i = gitopt_iter_parse(&gi, ls_files_ost));
+				gitopt_iter_next(&gi)) {
+		switch (i) {
+		case opt_z:
 			line_terminator = 0;
-			continue;
-		}
-		if (!strcmp(arg, "-t") || !strcmp(arg, "-v")) {
+			break;
+		case opt_v:
+			show_valid_bit = 1; /* fall through */
+		case opt_t:
 			tag_cached = "H ";
 			tag_unmerged = "M ";
 			tag_removed = "R ";
 			tag_modified = "C ";
 			tag_other = "? ";
 			tag_killed = "K ";
-			if (arg[1] == 'v')
-				show_valid_bit = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-c") || !strcmp(arg, "--cached")) {
+			break;
+		case opt_c:
 			show_cached = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-d") || !strcmp(arg, "--deleted")) {
+			break;
+		case opt_d:
 			show_deleted = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-m") || !strcmp(arg, "--modified")) {
+			break;
+		case opt_m:
 			show_modified = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-o") || !strcmp(arg, "--others")) {
+			break;
+		case opt_o:
 			show_others = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-i") || !strcmp(arg, "--ignored")) {
+			break;
+		case opt_i:
 			show_ignored = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-s") || !strcmp(arg, "--stage")) {
+			break;
+		case opt_s:
 			show_stage = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-k") || !strcmp(arg, "--killed")) {
+			break;
+		case opt_k:
 			show_killed = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--directory")) {
+			break;
+		case opt_directory:
 			show_other_directories = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--no-empty-directory")) {
+			break;
+		case opt_no_empty_directory:
 			hide_empty_directories = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-u") || !strcmp(arg, "--unmerged")) {
+			break;
+		case opt_u:
 			/* There's no point in showing unmerged unless
 			 * you also show the stage information.
 			 */
 			show_stage = 1;
 			show_unmerged = 1;
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
+			break;
+		case opt_x:
 			exc_given = 1;
-			add_excludes_from_file(argv[++i]);
-			continue;
-		}
-		if (!strncmp(arg, "--exclude-from=", 15)) {
+			add_exclude(ea->argv[0], "", 0, &exclude_list[EXC_CMDL]);
+			break;
+		case opt_X:
 			exc_given = 1;
-			add_excludes_from_file(arg+15);
-			continue;
-		}
-		if (!strncmp(arg, "--exclude-per-directory=", 24)) {
+			add_excludes_from_file(ea->argv[0]);
+			break;
+		case opt_exclude_per_dir:
 			exc_given = 1;
-			exclude_per_dir = arg + 24;
-			continue;
-		}
-		if (!strcmp(arg, "--full-name")) {
+			exclude_per_dir = ea->argv[0];
+			break;
+		case opt_full_name:
 			prefix_offset = 0;
-			continue;
-		}
-		if (!strcmp(arg, "--error-unmatch")) {
+			break;
+		case opt_error_unmatch:
 			error_unmatch = 1;
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
+			break;
+		case opt_abbrev:
+			if (ea->argc == 1)
+				abbrev = DEFAULT_ABBREV;
+			else {
+				if (abbrev && abbrev < MINIMUM_ABBREV)
+					abbrev = MINIMUM_ABBREV;
+				else if (abbrev > 40)
+					abbrev = 40;
+			}
+			break;
+		case GITOPT_DD:
+			break;
+		case GITOPT_NON_OPTION:
+			b->argv[b->argc++] = argv[gi.pos];
+			break;
+		case GITOPT_ERROR:
 			usage(ls_files_usage);
-		break;
+		}
 	}
 
-	pathspec = get_pathspec(prefix, argv + i);
+	pathspec = get_pathspec(prefix, b->argv);
 
 	/* Verify that the pathspec matches the prefix */
 	if (pathspec)
diff --git a/ls-tree.c b/ls-tree.c
index f2b3bc1..3de85bc 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -7,6 +7,7 @@ #include "cache.h"
 #include "blob.h"
 #include "tree.h"
 #include "quote.h"
+#include "gitopt.h"
 
 static int line_termination = '\n';
 #define LS_RECURSIVE 1
@@ -84,56 +85,79 @@ static int show_tree(unsigned char *sha1
 	return retval;
 }
 
+enum ls_tree_ids {
+	opt_z = 1, opt_r, opt_d, opt_t,
+	opt_name_only_status, opt_full_name, opt_abbrev
+};
+
+static const struct opt_spec ls_tree_ost[] = {
+	{ 0,			'z',	0,	0,	opt_z },
+	{ 0,			'r',	0,	0,	opt_r },
+	{ 0,			'd',	0,	0,	opt_d },
+	{ 0,			't',	0,	0,	opt_t },
+	{ "name-only",		0,	0,	0,	opt_name_only_status },
+	{ "name-status",	0,	0,	0,	opt_name_only_status },
+	{ "full-name",		0,	0,	0,	opt_full_name },
+	{ "abbrev",		0,	0,	ARG_OPTINT,	opt_abbrev },
+	{ 0, 0 }
+};
+
 int main(int argc, const char **argv)
 {
 	unsigned char sha1[20];
 	struct tree *tree;
+	struct exec_args *b, *ea;
+	struct gitopt_iterator gi;
+	int i;
 
 	prefix = setup_git_directory();
 	git_config(git_default_config);
 	if (prefix && *prefix)
 		chomp_prefix = strlen(prefix);
-	while (1 < argc && argv[1][0] == '-') {
-		switch (argv[1][1]) {
-		case 'z':
+
+	gitopt_iter_setup(&gi, argc, argv);
+	ea = gi.ea;
+	b = gi.b;
+	for (; (i = gitopt_iter_parse(&gi, ls_tree_ost));
+				gitopt_iter_next(&gi)) {
+		switch (i) {
+		case opt_z:
 			line_termination = 0;
 			break;
-		case 'r':
+		case opt_r:
 			ls_options |= LS_RECURSIVE;
 			break;
-		case 'd':
+		case opt_d:
 			ls_options |= LS_TREE_ONLY;
 			break;
-		case 't':
+		case opt_t:
 			ls_options |= LS_SHOW_TREES;
 			break;
-		case '-':
-			if (!strcmp(argv[1]+2, "name-only") ||
-			    !strcmp(argv[1]+2, "name-status")) {
-				ls_options |= LS_NAME_ONLY;
-				break;
-			}
-			if (!strcmp(argv[1]+2, "full-name")) {
-				chomp_prefix = 0;
-				break;
-			}
-			if (!strncmp(argv[1]+2, "abbrev=",7)) {
-				abbrev = strtoul(argv[1]+9, NULL, 10);
+		case opt_name_only_status:
+			ls_options |= LS_NAME_ONLY;
+			break;
+		case opt_full_name:
+			chomp_prefix = 0;
+			break;
+		case opt_abbrev:
+			if (ea->argc == 1)
+				abbrev = DEFAULT_ABBREV;
+			else {
+				abbrev = strtoul(ea->argv[1], NULL, 10);
 				if (abbrev && abbrev < MINIMUM_ABBREV)
 					abbrev = MINIMUM_ABBREV;
 				else if (abbrev > 40)
 					abbrev = 40;
-				break;
-			}
-			if (!strcmp(argv[1]+2, "abbrev")) {
-				abbrev = DEFAULT_ABBREV;
-				break;
 			}
-			/* otherwise fallthru */
-		default:
+			break;
+		case GITOPT_DD:
+			break;
+		case GITOPT_NON_OPTION:
+			b->argv[b->argc++] = argv[gi.pos];
+			break;
+		case GITOPT_ERROR:
 			usage(ls_tree_usage);
 		}
-		argc--; argv++;
 	}
 	/* -d -r should imply -t, but -d by itself should not have to. */
 	if ( (LS_TREE_ONLY|LS_RECURSIVE) ==
@@ -142,10 +166,10 @@ int main(int argc, const char **argv)
 
 	if (argc < 2)
 		usage(ls_tree_usage);
-	if (get_sha1(argv[1], sha1))
-		die("Not a valid object name %s", argv[1]);
+	if (get_sha1(b->argv[0], sha1))
+		die("Not a valid object name %s", b->argv[0]);
 
-	pathspec = get_pathspec(prefix, argv + 2);
+	pathspec = get_pathspec(prefix, b->argv + 1);
 	tree = parse_tree_indirect(sha1);
 	if (!tree)
 		die("not a tree object");
diff --git a/update-index.c b/update-index.c
index 3d7e02d..f4e15d7 100644
--- a/update-index.c
+++ b/update-index.c
@@ -7,6 +7,7 @@ #include "cache.h"
 #include "strbuf.h"
 #include "quote.h"
 #include "tree-walk.h"
+#include "gitopt.h"
 
 /*
  * Default to not allowing changes to the list of files. The
@@ -645,6 +646,39 @@ static int do_reupdate(int ac, const cha
 	return 0;
 }
 
+enum update_index_ids {
+	opt_q = 1, opt_add, opt_replace, opt_remove, opt_unmerged,
+	opt_refresh, opt_really_refresh, opt_cacheinfo, opt_chmod,
+	opt_assume_unchanged, opt_no_assume_unchanged, opt_info_only,
+	opt_force_remove, opt_z, opt_stdin, opt_index_info, opt_unresolve,
+	opt_again, opt_ignore_missing, opt_verbose, opt_h
+};
+
+static const struct opt_spec update_index_ost[] = {
+	{ 0,			'q',	0,	0,	opt_q },
+	{ "add",		0,	0,	0,	opt_add },
+	{ "replace",		0,	0,	0,	opt_replace },
+	{ "remove",		0,	0,	0,	opt_remove },
+	{ "unmerged",		0,	0,	0,	opt_unmerged },
+	{ "refresh",		0,	0,	0,	opt_refresh },
+	{ "really-refresh",	0,	0,	0,	opt_really_refresh },
+	{ "cacheinfo",		0,	0,	ARG_TRE, opt_cacheinfo},
+	{ "chmod",		0,	"%s",	ARG_ONE, opt_chmod },
+	{ "assume-unchanged",	0,	0,	0,	opt_assume_unchanged },
+	{ "no-assume-unchanged",0,	0,	0,	opt_no_assume_unchanged},
+	{ "info-only",		0,	0,	0,	opt_info_only },
+	{ "force-remove",	0,	0,	0,	opt_force_remove },
+	{ 0,			'z',	0,	0,	opt_z },
+	{ "stdin",		0,	0,	0,	opt_stdin },
+	{ "index-info",		0,	0,	0,	opt_index_info },
+	{ "unresolve",		0,	0,	0,	opt_unresolve },
+	{ "again",		0,	0,	0,	opt_again },
+	{ "ignore-missing",	0,	0,	0,	opt_ignore_missing },
+	{ "verbose",		0,	0,	0,	opt_verbose },
+	{ "help",		'h',	0,	0,	opt_h },
+	{ 0, 0 }
+};
+
 int main(int argc, const char **argv)
 {
 	int i, newfd, entries, has_errors = 0, line_termination = '\n';
@@ -653,6 +687,10 @@ int main(int argc, const char **argv)
 	const char *prefix = setup_git_directory();
 	int prefix_length = prefix ? strlen(prefix) : 0;
 	char set_executable_bit = 0;
+	struct exec_args *ea;
+	struct gitopt_iterator gi;
+	unsigned char sha1[20];
+	unsigned int mode;
 
 	git_config(git_default_config);
 
@@ -664,126 +702,107 @@ int main(int argc, const char **argv)
 	if (entries < 0)
 		die("cache corrupted");
 
-	for (i = 1 ; i < argc; i++) {
-		const char *path = argv[i];
-
-		if (allow_options && *path == '-') {
-			if (!strcmp(path, "--")) {
-				allow_options = 0;
-				continue;
-			}
-			if (!strcmp(path, "-q")) {
-				quiet = 1;
-				continue;
-			}
-			if (!strcmp(path, "--add")) {
-				allow_add = 1;
-				continue;
-			}
-			if (!strcmp(path, "--replace")) {
-				allow_replace = 1;
-				continue;
-			}
-			if (!strcmp(path, "--remove")) {
-				allow_remove = 1;
-				continue;
-			}
-			if (!strcmp(path, "--unmerged")) {
-				allow_unmerged = 1;
-				continue;
-			}
-			if (!strcmp(path, "--refresh")) {
-				has_errors |= refresh_cache(0);
-				continue;
-			}
-			if (!strcmp(path, "--really-refresh")) {
-				has_errors |= refresh_cache(1);
-				continue;
-			}
-			if (!strcmp(path, "--cacheinfo")) {
-				unsigned char sha1[20];
-				unsigned int mode;
-
-				if (i+3 >= argc)
-					die("git-update-index: --cacheinfo <mode> <sha1> <path>");
-
-				if ((sscanf(argv[i+1], "%o", &mode) != 1) ||
-				    get_sha1_hex(argv[i+2], sha1) ||
-				    add_cacheinfo(mode, sha1, argv[i+3], 0))
-					die("git-update-index: --cacheinfo"
-					    " cannot add %s", argv[i+3]);
-				i += 3;
-				continue;
-			}
-			if (!strcmp(path, "--chmod=-x") ||
-			    !strcmp(path, "--chmod=+x")) {
-				if (argc <= i+1)
-					die("git-update-index: %s <path>", path);
-				set_executable_bit = path[8];
-				continue;
-			}
-			if (!strcmp(path, "--assume-unchanged")) {
-				mark_valid_only = MARK_VALID;
-				continue;
-			}
-			if (!strcmp(path, "--no-assume-unchanged")) {
-				mark_valid_only = UNMARK_VALID;
-				continue;
-			}
-			if (!strcmp(path, "--info-only")) {
-				info_only = 1;
-				continue;
-			}
-			if (!strcmp(path, "--force-remove")) {
-				force_remove = 1;
-				continue;
-			}
-			if (!strcmp(path, "-z")) {
-				line_termination = 0;
-				continue;
-			}
-			if (!strcmp(path, "--stdin")) {
-				if (i != argc - 1)
-					die("--stdin must be at the end");
-				read_from_stdin = 1;
-				break;
-			}
-			if (!strcmp(path, "--index-info")) {
-				if (i != argc - 1)
-					die("--index-info must be at the end");
-				allow_add = allow_replace = allow_remove = 1;
-				read_index_info(line_termination);
-				break;
-			}
-			if (!strcmp(path, "--unresolve")) {
-				has_errors = do_unresolve(argc - i, argv + i,
-							  prefix, prefix_length);
-				if (has_errors)
-					active_cache_changed = 0;
-				goto finish;
-			}
-			if (!strcmp(path, "--again")) {
-				has_errors = do_reupdate(argc - i, argv + i,
-							 prefix, prefix_length);
-				if (has_errors)
-					active_cache_changed = 0;
-				goto finish;
-			}
-			if (!strcmp(path, "--ignore-missing")) {
-				not_new = 1;
-				continue;
-			}
-			if (!strcmp(path, "--verbose")) {
-				verbose = 1;
-				continue;
-			}
-			if (!strcmp(path, "-h") || !strcmp(path, "--help"))
-				usage(update_index_usage);
-			die("unknown option %s", path);
+	gitopt_iter_setup(&gi, argc, argv);
+	ea = gi.ea;
+	for (; (i = gitopt_iter_parse(&gi, update_index_ost));
+				gitopt_iter_next(&gi)) {
+		switch (i) {
+		case opt_q:
+			quiet = 1;
+			break;
+		case opt_add:
+			allow_add = 1;
+			break;
+		case opt_replace:
+			allow_replace = 1;
+			break;
+		case opt_remove:
+			allow_remove = 1;
+			break;
+		case opt_unmerged:
+			allow_unmerged = 1;
+			break;
+		case opt_refresh:
+			has_errors |= refresh_cache(0);
+			break;
+		case opt_really_refresh:
+			has_errors |= refresh_cache(1);
+			break;
+		case opt_cacheinfo:
+			if (ea->argc != 4)
+				die("git-update-index: --cacheinfo "
+				    "<mode> <sha1> <path>");
+			if ((sscanf(ea->argv[1], "%o", &mode) != 1) ||
+			    get_sha1_hex(ea->argv[2], sha1) ||
+			    add_cacheinfo(mode, sha1, ea->argv[3], 0))
+				die("git-update-index: --cacheinfo"
+				    " cannot add %s", ea->argv[3]);
+			break;
+		case opt_chmod:
+			if (i+1 >= argc)
+				die("git-update-index: --chmod=%s <path>",
+								ea->argv[0]);
+			set_executable_bit = ea->argv[0][0];
+			break;
+		case opt_assume_unchanged:
+			mark_valid_only = MARK_VALID;
+			break;
+		case opt_no_assume_unchanged:
+			mark_valid_only = UNMARK_VALID;
+			break;
+		case opt_info_only:
+			info_only = 1;
+			break;
+		case opt_force_remove:
+			force_remove = 1;
+			break;
+		case opt_z:
+			line_termination = 0;
+			break;
+		case opt_stdin:
+			if (gi.pos != argc - 1)
+				die("--stdin must be at the end");
+			read_from_stdin = 1;
+			break;
+		case opt_index_info:
+			if (gi.pos != argc - 1)
+				die("--index-info must be at the end");
+			allow_add = allow_replace = allow_remove = 1;
+			read_index_info(line_termination);
+			break;
+		case opt_unresolve:
+			has_errors = do_unresolve(argc - gi.pos, argv + gi.pos,
+						  prefix, prefix_length);
+			if (has_errors)
+				active_cache_changed = 0;
+			goto finish;
+		case opt_again:
+			has_errors = do_reupdate(argc - gi.pos, argv + gi.pos,
+						 prefix, prefix_length);
+			if (has_errors)
+				active_cache_changed = 0;
+			goto finish;
+		case opt_ignore_missing:
+			not_new = 1;
+			break;
+		case opt_verbose:
+			verbose = 1;
+			break;
+		case opt_h:
+			usage(update_index_usage);
+			break;
+		case GITOPT_DD:
+			allow_options = 0;
+			break;
+		case GITOPT_NON_OPTION:
+			update_one(argv[gi.pos], prefix, prefix_length);
+			if (set_executable_bit)
+				chmod_path(set_executable_bit, argv[gi.pos]);
+			break;
+		case GITOPT_ERROR:
+			die("unknown option %s", argv[gi.pos]);
+			break;
 		}
-		update_one(path, prefix, prefix_length);
-		if (set_executable_bit)
-			chmod_path(set_executable_bit, path);
 	}
 	if (read_from_stdin) {
 		struct strbuf buf;
-- 
1.3.2.g102e322
