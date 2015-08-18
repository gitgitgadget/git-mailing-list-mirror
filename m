From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/7] submodule: implement `module_list` as a builtin helper
Date: Mon, 17 Aug 2015 17:22:01 -0700
Message-ID: <1439857323-21048-6-git-send-email-sbeller@google.com>
References: <1439857323-21048-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, hvoigt@hvoigt.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 02:22:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRUg0-00085k-8i
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 02:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbbHRAWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 20:22:44 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33718 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbbHRAWX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 20:22:23 -0400
Received: by pabyb7 with SMTP id yb7so119043507pab.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 17:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XC8SDYEzOBymEYQE5xXWIub18gor2y2Mp/bHuS/EHaw=;
        b=ib8ZsYNks9RGmHlDJKwZadopT7d4iof+D2LtMLxwbI1+uV0EKJalq3PD/UD9CPEZyl
         IXWDrX+rnoTHBYkGz3yumtvmOr8kUQGE/M1PYXQIUPuCBVeSo92dkM6I9I9uoXWJ+mZP
         FkgxzNkUGdREccMpzhcSbJ2scizXPXl4oLjmWl3RDqdnvT4ZABeoDqSk6sIbVyMIE3dM
         xIcj3JySwlSqZkU5bRDk+vEFoUXl3MzeMDoXMhJJAMgSGlsH4RgCvR6CVB+UNz4se6GZ
         EZvmJ+lxQWRkhMNxcWsyy7KBC51Y/MwogO56k6/B6sdm+qBiW9zdMWl2N0sS/AoV1E5y
         wOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XC8SDYEzOBymEYQE5xXWIub18gor2y2Mp/bHuS/EHaw=;
        b=knBQC3RsX7Plwpv3G60KCSpKUp+qEiKGbqvkhVveJIOKv6Qh/rjk6STibux0JVHRAI
         nbP5wrzOjc+C3ZwSKAK6My0CRZyu03t4RzIT6a1u7UZZs9WH+rdb9IZZFOo0bLtDfPO5
         lqwZoKpsU1BtCswJX2I208R/FZCE2lWbZLvjNWlqZ+OZEh9KUssGH/nfz1skA27UuFLc
         iq7G8QAZGHV3eGoBEb/7UBqMYWMdNUIhn0x33IaSYiT6odl6B9wLxdM8JfllvVZ6sYyd
         pgAS8wMjndPRvZ9GRTiYC36CDjmvRtvniM0W8Glwx0xuBXc/Z1TnqjTS6pySp9qplyAI
         zZ6w==
X-Gm-Message-State: ALoCoQmKa9g6tvjat6g1p45FnBpjMHSgbhJMgYZ3KaAb+FX57gRnwrGt5Zx3+zLUEa0lg1u2coXN
X-Received: by 10.68.250.98 with SMTP id zb2mr7558645pbc.40.1439857342950;
        Mon, 17 Aug 2015 17:22:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bca6:6b6f:4dbb:30a3])
        by smtp.gmail.com with ESMTPSA id jv5sm979998pbc.47.2015.08.17.17.22.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 17:22:17 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.330.g130be8e.dirty
In-Reply-To: <1439857323-21048-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276117>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitignore                  |   1 +
 Makefile                    |   1 +
 builtin.h                   |   1 +
 builtin/submodule--helper.c | 114 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  54 +++------------------
 git.c                       |   1 +
 6 files changed, 124 insertions(+), 48 deletions(-)
 create mode 100644 builtin/submodule--helper.c

diff --git a/.gitignore b/.gitignore
index 4fd81ba..1c2f832 100644
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
index 24b636d..d434e73 100644
--- a/Makefile
+++ b/Makefile
@@ -901,6 +901,7 @@ BUILTIN_OBJS += builtin/shortlog.o
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
index 0000000..610ec51
--- /dev/null
+++ b/builtin/submodule--helper.c
@@ -0,0 +1,114 @@
+#include "builtin.h"
+#include "cache.h"
+#include "parse-options.h"
+#include "quote.h"
+#include "pathspec.h"
+#include "dir.h"
+#include "utf8.h"
+
+static const struct cache_entry **ce_entries;
+static int ce_alloc, ce_used;
+static const char *alternative_path;
+
+static int module_list_compute(int argc, const char **argv,
+				const char *prefix,
+				struct pathspec *pathspec)
+{
+	int i;
+	char *max_prefix, *ps_matched = NULL;
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
+
+		while (i + 1 < active_nr && !strcmp(ce->name, active_cache[i + 1]->name))
+			/*
+			 * Skip entries with the same name in different stages
+			 * to make sure an entry is returned only once.
+			 */
+			i++;
+	}
+	free(max_prefix);
+
+	if (ps_matched && report_path_error(ps_matched, pathspec, prefix))
+		return -1;
+
+	return 0;
+}
+
+static int module_list(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	static struct pathspec pathspec;
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
+	if (module_list_compute(argc, argv, alternative_path
+					    ? alternative_path
+					    : prefix, &pathspec) < 0) {
+		printf("#unmatched\n");
+		return 1;
+	}
+
+	for (i = 0; i < ce_used; i++) {
+		const struct cache_entry *ce = ce_entries[i];
+
+		if (ce_stage(ce)) {
+			printf("%06o %s U\t", ce->ce_mode, sha1_to_hex(null_sha1));
+		} else {
+			printf("%06o %s %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
+		}
+
+		utf8_fprintf(stdout, "%s\n", ce->name);
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
2.5.0.330.g130be8e.dirty
