From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/4] submodule: implement `module_list` as a builtin helper
Date: Tue,  4 Aug 2015 17:04:29 -0700
Message-ID: <1438733070-15805-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 05 02:04:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMmCP-00088R-3j
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 02:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbbHEAEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 20:04:36 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33902 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbbHEAEe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 20:04:34 -0400
Received: by pawu10 with SMTP id u10so20113622paw.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 17:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QNoaA1xQJ8fDpxUv3PgwkqkJm7XcxslIA7mYZN78FKk=;
        b=QqiBsvC28vrMCOJyM8jzfjJXnmr9KoYntENxgJG4fYXfPhXCrRWGd//Rv65uuRfzZk
         1YtI3bXxaTfaNZvTl/0/pfJhAoxhTtL0CSlzbBQYoqAHoQJgRwGTSW++NEiXHg0HGo66
         l8VljslEEX/Ad7vb4mVu5NkKqA/bVMPKw57NURa58HuyDgXTPwhvarKNYuHUSHMU3T7L
         kAqrTskWzl75olT+e3COiQuHYk+Iml3sk2dd55Og6e/URVWt6LRrwGjVZpWW8o2K+57e
         hobK1jnnFjX2/41qDTxljR3oxPMwquL0KfkrmQcuUk4lYKQduwZ8t4W36iUswn2LCEgG
         HDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QNoaA1xQJ8fDpxUv3PgwkqkJm7XcxslIA7mYZN78FKk=;
        b=QwnjC//KE6DMbu1adYWJwhESptpNrjyjUbqh8bDUBfP4u0epvrNjv2rD53QOias9QQ
         IjfgBbkPTyFyRiIPDxdHaCqSTVAsP/nkJ7vworEIE4ikKB7Vv9j1Ezeg9bI8HHHg9Tvf
         oJOMBHSUO461FW4gmSZuSaMThJt8rJlrdSBMocOB8AiVD7UF4PL9yx5bYiWgjCgxQBHB
         zCjqUfa+GLsKOYmk4MWre25GFpL/UNlZ6NlcDE6CmBnajFwxemHHVXvdmpQW2x3tsoy8
         AjnQh4MTMeSi8Sn7QL41EyI0jI26/V3XzKpj6VTc67juKdp0RV4nnJUjg53pu3eti7Hi
         HO4w==
X-Gm-Message-State: ALoCoQneO5PKUp9ngsYtv3/sVj2rjiuKx91dQnuka1qCkgRR6biEPfR67Xa0A92eIZqzjRPc3wBn
X-Received: by 10.68.215.97 with SMTP id oh1mr13238855pbc.67.1438733074083;
        Tue, 04 Aug 2015 17:04:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8a0:932b:403d:1019])
        by smtp.gmail.com with ESMTPSA id nv9sm588647pdb.20.2015.08.04.17.04.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 04 Aug 2015 17:04:33 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.2.gbb9888f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275347>

Most of the submodule operations work on a set of submodules.
Calculating and using this set is usually done via:

       module_list "$@" | {
           while read mode sha1 stage sm_path
           do
                # the actual operation
           done
       }

Currently the function `module_list` is implemented in the
git-submodule.sh as a shell script wrapping a perl script.
The rewrite is in C, such that it is faster and can later be
easily adapted when other functions are rewritten in C.

git-submodule.sh similar to the builtin commands will navigate
to the top most directory of the repository and keeping the
subdirectories as a variable. As the helper is called from
within the git-submodule.sh script, we are already navigated
to the root level, but the path arguments are stil relative
to the subdirectory we were in when calling git-submodule.sh.
That's why there is a `--prefix` option pointing to an alternative
path where to anchor relative path arguments.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

The same as yesterday evening, just an entry added to .gitignore.

So we'll have a "git submodule--helper module_list" here.

 .gitignore                  |   1 +
 Makefile                    |   1 +
 builtin.h                   |   1 +
 builtin/submodule--helper.c | 111 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  54 +++------------------
 git.c                       |   1 +
 6 files changed, 121 insertions(+), 48 deletions(-)
 create mode 100644 builtin/submodule--helper.c

diff --git a/.gitignore b/.gitignore
index a685ec1..2a69ba0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -155,6 +155,7 @@
 /git-status
 /git-stripspace
 /git-submodule
+/git-submodule--helper
 /git-svn
 /git-symbolic-ref
 /git-tag
diff --git a/Makefile b/Makefile
index 7efedbe..460d17a 100644
--- a/Makefile
+++ b/Makefile
@@ -899,6 +899,7 @@ BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-ref.o
 BUILTIN_OBJS += builtin/stripspace.o
+BUILTIN_OBJS += builtin/submodule--helper.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
 BUILTIN_OBJS += builtin/tag.o
 BUILTIN_OBJS += builtin/unpack-file.o
diff --git a/builtin.h b/builtin.h
index 839483d..924e6c4 100644
--- a/builtin.h
+++ b/builtin.h
@@ -119,6 +119,7 @@ extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
+extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tag(int argc, const char **argv, const char *prefix);
 extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
new file mode 100644
index 0000000..cb18ddf
--- /dev/null
+++ b/builtin/submodule--helper.c
@@ -0,0 +1,111 @@
+#include "builtin.h"
+#include "cache.h"
+#include "parse-options.h"
+#include "quote.h"
+#include "pathspec.h"
+#include "dir.h"
+#include "utf8.h"
+
+static char *ps_matched;
+static const struct cache_entry **ce_entries;
+static int ce_alloc, ce_used;
+static struct pathspec pathspec;
+static const char *alternative_path;
+
+static void module_list_compute(int argc, const char **argv,
+				const char *prefix,
+				struct pathspec *pathspec)
+{
+	int i;
+	char *max_prefix;
+	int max_prefix_len;
+	parse_pathspec(pathspec, 0,
+		       PATHSPEC_PREFER_FULL |
+		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
+		       prefix, argv);
+
+	/* Find common prefix for all pathspec's */
+	max_prefix = common_prefix(pathspec);
+	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
+
+	if (pathspec->nr)
+		ps_matched = xcalloc(1, pathspec->nr);
+
+
+	if (read_cache() < 0)
+		die("index file corrupt");
+
+	for (i = 0; i < active_nr; i++) {
+		const struct cache_entry *ce = active_cache[i];
+
+		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
+				    max_prefix_len, ps_matched,
+				    S_ISGITLINK(ce->ce_mode) | S_ISDIR(ce->ce_mode)))
+			continue;
+
+		if (S_ISGITLINK(ce->ce_mode)) {
+			ALLOC_GROW(ce_entries, ce_used + 1, ce_alloc);
+			ce_entries[ce_used++] = ce;
+		}
+	}
+}
+
+static int module_list(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	struct string_list already_printed = STRING_LIST_INIT_NODUP;
+
+	struct option module_list_options[] = {
+		OPT_STRING(0, "prefix", &alternative_path,
+			   N_("path"),
+			   N_("alternative anchor for relative paths")),
+		OPT_END()
+	};
+
+	static const char * const git_submodule_helper_usage[] = {
+		N_("git submodule--helper module_list [--prefix=<path>] [<path>...]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_list_options,
+			     git_submodule_helper_usage, 0);
+
+	module_list_compute(argc, argv, alternative_path
+					? alternative_path
+					: prefix, &pathspec);
+
+	if (ps_matched && report_path_error(ps_matched, &pathspec, prefix)) {
+		printf("#unmatched\n");
+		return 1;
+	}
+
+	for (i = 0; i < ce_used; i++) {
+		const struct cache_entry *ce = ce_entries[i];
+
+		if (string_list_has_string(&already_printed, ce->name))
+			continue;
+
+		if (ce_stage(ce)) {
+			printf("%06o %s U\t", ce->ce_mode, sha1_to_hex(null_sha1));
+		} else {
+			printf("%06o %s %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
+		}
+
+		utf8_fprintf(stdout, "%s\n", ce->name);
+
+		string_list_insert(&already_printed, ce->name);
+	}
+	return 0;
+}
+
+int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
+{
+	if (argc < 2)
+		goto usage;
+
+	if (!strcmp(argv[1], "module_list"))
+		return module_list(argc - 1, argv + 1, prefix);
+
+usage:
+	usage("git submodule--helper module_list\n");
+}
diff --git a/git-submodule.sh b/git-submodule.sh
index 36797c3..af9ecef 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -145,48 +145,6 @@ relative_path ()
 	echo "$result$target"
 }
 
-#
-# Get submodule info for registered submodules
-# $@ = path to limit submodule list
-#
-module_list()
-{
-	eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
-	(
-		git ls-files -z --error-unmatch --stage -- "$@" ||
-		echo "unmatched pathspec exists"
-	) |
-	@@PERL@@ -e '
-	my %unmerged = ();
-	my ($null_sha1) = ("0" x 40);
-	my @out = ();
-	my $unmatched = 0;
-	$/ = "\0";
-	while (<STDIN>) {
-		if (/^unmatched pathspec/) {
-			$unmatched = 1;
-			next;
-		}
-		chomp;
-		my ($mode, $sha1, $stage, $path) =
-			/^([0-7]+) ([0-9a-f]{40}) ([0-3])\t(.*)$/;
-		next unless $mode eq "160000";
-		if ($stage ne "0") {
-			if (!$unmerged{$path}++) {
-				push @out, "$mode $null_sha1 U\t$path\n";
-			}
-			next;
-		}
-		push @out, "$_\n";
-	}
-	if ($unmatched) {
-		print "#unmatched\n";
-	} else {
-		print for (@out);
-	}
-	'
-}
-
 die_if_unmatched ()
 {
 	if test "$1" = "#unmatched"
@@ -532,7 +490,7 @@ cmd_foreach()
 	# command in the subshell (and a recursive call to this function)
 	exec 3<&0
 
-	module_list |
+	git submodule--helper module_list --prefix "$wt_prefix"|
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -592,7 +550,7 @@ cmd_init()
 		shift
 	done
 
-	module_list "$@" |
+	git submodule--helper module_list --prefix "$wt_prefix" "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -674,7 +632,7 @@ cmd_deinit()
 		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
 	fi
 
-	module_list "$@" |
+	git submodule--helper module_list --prefix "$wt_prefix" "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -790,7 +748,7 @@ cmd_update()
 	fi
 
 	cloned_modules=
-	module_list "$@" | {
+	git submodule--helper module_list --prefix "$wt_prefix" "$@" | {
 	err=
 	while read mode sha1 stage sm_path
 	do
@@ -1222,7 +1180,7 @@ cmd_status()
 		shift
 	done
 
-	module_list "$@" |
+	git submodule--helper module_list --prefix "$wt_prefix" "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -1299,7 +1257,7 @@ cmd_sync()
 		esac
 	done
 	cd_to_toplevel
-	module_list "$@" |
+	git submodule--helper module_list --prefix "$wt_prefix" "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
diff --git a/git.c b/git.c
index 55c327c..deecba0 100644
--- a/git.c
+++ b/git.c
@@ -469,6 +469,7 @@ static struct cmd_struct commands[] = {
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
+	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP },
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 	{ "tag", cmd_tag, RUN_SETUP },
 	{ "unpack-file", cmd_unpack_file, RUN_SETUP },
-- 
2.5.0.2.gbb9888f.dirty
