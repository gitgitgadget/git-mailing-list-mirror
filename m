From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/6] update-index: convert to using gitopt
Date: Mon, 08 May 2006 22:06:45 -0700
Message-ID: <11471512101532-git-send-email-normalperson@yhbt.net>
References: <11471512103526-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 09 08:22:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdLcN-00087J-LE
	for gcvg-git@gmane.org; Tue, 09 May 2006 08:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWEIGWn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 02:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWEIGWn
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 02:22:43 -0400
Received: from hand.yhbt.net ([66.150.188.102]:7903 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751414AbWEIGWm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 02:22:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id CB4E77DC005;
	Mon,  8 May 2006 23:22:41 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.2.ge3d7
In-Reply-To: <11471512103526-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19820>

This is an example how how to override gitopt_non_option_cb, as
well as disabling permuting of options to the front of the
command list.  This way, commands like:

	git-update-index --add new_file --remove old_file

will continue to work.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 update-index.c |  261 ++++++++++++++++++++++++++++----------------------------
 1 files changed, 130 insertions(+), 131 deletions(-)

50f33d232367e8d7a46bd014f5a5da4d0ad370b3
diff --git a/update-index.c b/update-index.c
index 00cde70..6205f85 100644
--- a/update-index.c
+++ b/update-index.c
@@ -7,6 +7,7 @@ #include "cache.h"
 #include "strbuf.h"
 #include "quote.h"
 #include "tree-walk.h"
+#include "gitopt.h"
 
 /*
  * Default to not allowing changes to the list of files. The
@@ -25,6 +26,14 @@ static int info_only;
 static int force_remove;
 static int verbose;
 static int mark_valid_only = 0;
+static int prefix_length = 0;
+static int line_termination = '\n';
+static const char *prefix = NULL;
+static char set_executable_bit = 0;
+static int read_from_stdin = 0;
+static int newfd = 0;
+static int has_errors = 0;
+
 #define MARK_VALID 1
 #define UNMARK_VALID 2
 
@@ -189,10 +198,9 @@ static struct cache_entry *refresh_entry
 	return updated;
 }
 
-static int refresh_cache(int really)
+static void refresh_cache(int really)
 {
 	int i;
-	int has_errors = 0;
 
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce, *new;
@@ -205,7 +213,7 @@ static int refresh_cache(int really)
 			if (allow_unmerged)
 				continue;
 			printf("%s: needs merge\n", ce->name);
-			has_errors = 1;
+			has_errors |= 1;
 			continue;
 		}
 
@@ -225,7 +233,7 @@ static int refresh_cache(int really)
 			if (quiet)
 				continue;
 			printf("%s: needs update\n", ce->name);
-			has_errors = 1;
+			has_errors |= 1;
 			continue;
 		}
 		active_cache_changed = 1;
@@ -234,7 +242,7 @@ static int refresh_cache(int really)
 		 * from mmap(). */
 		active_cache[i] = new;
 	}
-	return has_errors;
+	return;
 }
 
 /*
@@ -600,15 +608,123 @@ static int do_unresolve(int ac, const ch
 	return err;
 }
 
+static void write_cache_if_changed ()
+{
+	if (active_cache_changed) {
+		if (write_cache(newfd, active_cache, active_nr) ||
+		    commit_index_file(&cache_file))
+			die("Unable to write new cachefile");
+	}
+}
+
+gitopt_eat(opt_q, quiet = 1;)
+gitopt_eat(opt_add, allow_add = 1;)
+gitopt_eat(opt_replace, allow_replace = 1;)
+gitopt_eat(opt_remove, allow_remove = 1;)
+gitopt_eat(opt_unmerged, allow_unmerged = 1;)
+gitopt_eat(opt_refresh, refresh_cache(0);)
+gitopt_eat(opt_really_refresh, refresh_cache(1);)
+
+static struct exec_args *opt_cacheinfo(const struct opt_spec *s,
+			const int argc, const char **argv, int *argc_pos)
+{
+	struct exec_args *ea = new_exec_args(4);
+	unsigned char sha1[20];
+	unsigned int mode;
+
+	ea->argc = 1;
+	ea->argv[0] = argv[*argc_pos];
+	while (*argc_pos < (argc-1) && ea->argc < 4)
+		ea->argv[ea->argc++] = argv[++(*argc_pos)];
+	if (ea->argc != 4)
+		die("git-update-index: --cacheinfo <mode> <sha1> <path>");
+
+	if ((sscanf(ea->argv[1], "%o", &mode) != 1) ||
+				get_sha1_hex(ea->argv[2], sha1) ||
+				add_cacheinfo(mode, sha1, ea->argv[3], 0))
+		die("git-update-index: --cacheinfo cannot add %s",ea->argv[3]);
+
+	return nil_exec_args(ea);
+}
+
+gitopt_eat_one_arg(opt_chmod,
+		if (*argc_pos + 1 >= argc)
+			die("git-update-index: --chmod=%s <path>",ea->argv[0]);
+		set_executable_bit = ea->argv[0][0];)
+
+gitopt_eat(opt_assume_unchanged, mark_valid_only = MARK_VALID;)
+gitopt_eat(opt_no_assume_unchanged, mark_valid_only = UNMARK_VALID;)
+gitopt_eat(opt_info_only, info_only = 1;)
+gitopt_eat(opt_force_remove, force_remove = 1;)
+gitopt_eat(opt_z, line_termination = 0;)
+gitopt_eat(opt_stdin,
+		if (*argc_pos != argc - 1)
+			die("--stdin must be at the end");
+		read_from_stdin = 1;)
+
+gitopt_eat(opt_index_info,
+		if (*argc_pos != argc - 1)
+			die("--index-info must be at the end");
+		allow_add = allow_replace = allow_remove = 1;
+		read_index_info(line_termination);)
+
+gitopt_eat(opt_unresolve,
+		has_errors = do_unresolve(argc - *argc_pos, argv + *argc_pos,
+					prefix, prefix_length);
+		if (has_errors)
+			active_cache_changed = 0;
+		write_cache_if_changed();
+		exit(has_errors ? 1 : 0);)
+
+gitopt_eat(opt_ignore_missing, not_new = 1;)
+gitopt_eat(opt_verbose, verbose = 1;)
+gitopt_eat(opt_h, usage(update_index_usage);)
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
+	{ "ignore-missing",	0,	0,	0,	opt_ignore_missing },
+	{ "verbose",		0,	0,	0,	opt_verbose },
+	{ "help",		'h',	0,	0,	opt_h },
+	{ 0, 0 }
+};
+
+/* call this for every non-option (and everything after "--") we have */
+static void update_index_non_option_cb(struct exec_args *b, const int argc,
+					const char **argv, int *argc_pos)
+{
+	const char *arg = argv[*argc_pos];
+	update_one(arg, prefix, prefix_length);
+	if (set_executable_bit)
+		chmod_path(set_executable_bit, arg);
+}
+
 int main(int argc, const char **argv)
 {
-	int i, newfd, entries, has_errors = 0, line_termination = '\n';
-	int allow_options = 1;
-	int read_from_stdin = 0;
-	const char *prefix = setup_git_directory();
-	int prefix_length = prefix ? strlen(prefix) : 0;
-	char set_executable_bit = 0;
+	int entries;
+	struct exec_args *a;
+
+	prefix = setup_git_directory();
+	if (prefix)
+		prefix_length = strlen(prefix);
 
+	a = new_exec_args(argc);	/* argv[0] and options: */
+	gitopt_non_option_cb = update_index_non_option_cb;
 	git_config(git_default_config);
 
 	newfd = hold_index_file_for_update(&cache_file, get_index_file());
@@ -619,120 +735,9 @@ int main(int argc, const char **argv)
 	if (entries < 0)
 		die("cache corrupted");
 
-	for (i = 1 ; i < argc; i++) {
-		const char *path = argv[i];
+	if (gitopt_parse_ost_split(a, a, update_index_ost, argc, argv) < 0)
+		usage(update_index_usage);
 
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
-		}
-		update_one(path, prefix, prefix_length);
-		if (set_executable_bit)
-			chmod_path(set_executable_bit, path);
-	}
 	if (read_from_stdin) {
 		struct strbuf buf;
 		strbuf_init(&buf);
@@ -757,12 +762,6 @@ int main(int argc, const char **argv)
 		}
 	}
 
- finish:
-	if (active_cache_changed) {
-		if (write_cache(newfd, active_cache, active_nr) ||
-		    commit_index_file(&cache_file))
-			die("Unable to write new cachefile");
-	}
-
+	write_cache_if_changed();
 	return has_errors ? 1 : 0;
 }
-- 
1.3.2.g0a3ae
