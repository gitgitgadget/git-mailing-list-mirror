From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 1/3] submodule: Reimplement `module_list` shell function in C
Date: Wed,  2 Sep 2015 14:42:24 -0700
Message-ID: <1441230146-26921-2-git-send-email-sbeller@google.com>
References: <1441230146-26921-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de, peff@peff.net
To: sbeller@google.com, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Wed Sep 02 23:42:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXFnq-0001Tq-7G
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 23:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989AbbIBVmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 17:42:42 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34933 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345AbbIBVml (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 17:42:41 -0400
Received: by pacfv12 with SMTP id fv12so24013897pac.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 14:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mQbfF5iAcMzbjrO4kagaoWGPyEYiyO5VxAPsn1cTDAo=;
        b=lgRvPhXto+WA57NzAvl3gnmX5ug38PauE9C38fuDoRai0ovj7zrcwP6vg6E6nLOPE0
         KwmQdyuvrB9pcPCl2mHa3FW47XOJoUopD8WUdz+xRkvmX1QhkJkrFD05Q9dU7t+Xsxw3
         dDXYmVrfSyUtKrKLjVrEh5Q2XLcvsRK+kE++XeNNmbF0tOf5C8tUD1aSdeLnd5eQH1uT
         jPhoH7SKWrx8BH7UtDSIvWgp3hCRSFcmDupxy+gbok9pM4WVRLg9XZmTYeDog+uoWUsv
         HpSukLK7BAUcW+59xQZ0wgxOsKi21jrDao+pV+T1KAklx+C8TIhngUlDfQFuSt1viAUD
         rqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mQbfF5iAcMzbjrO4kagaoWGPyEYiyO5VxAPsn1cTDAo=;
        b=GMECFkSrOHwsJTf20YC7tvsHh7xB8QidYkw9QbOsMAedwyaIP/i5MUV5MGfLOrEHXG
         YauzhulER38+AN1YI1DBt3TkIOdANF24bVUU936a19q3pF5irbOaHzRGpd9RQx2OyLVB
         2U0CQHPvQ6j2VDo/ymhEzxoWLfR3shb5IV68b4DOPyj4aPNaV1RmNTnwhBPzBMfF7GwS
         gNuqiYJ/eFF5Aj5pZdDMNk1o5mPuhjWbxBkXDsH1W8M0r2BkkNTxauEaBNWlszdtd2Nl
         A9AYux2Ngq4HWMihBAnUGEj2LMaoO8ILGiIMlr1yPG0Q1ANrCVA/P+dHreA49Jr0yn7R
         7zqg==
X-Gm-Message-State: ALoCoQlqsP3ActftiFJelwkOAhseeIN6Aq71/LfPz0drHuUHe5EqIBeIMclstOyQ0n8K3ty8wwuu
X-Received: by 10.68.244.137 with SMTP id xg9mr59526634pbc.27.1441230160339;
        Wed, 02 Sep 2015 14:42:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8100:e957:594c:edb9])
        by smtp.gmail.com with ESMTPSA id hk4sm17885305pdb.22.2015.09.02.14.42.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Sep 2015 14:42:39 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.256.g89f8063.dirty
In-Reply-To: <1441230146-26921-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277129>

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

git-submodule.sh, similar to the builtin commands, will navigate
to the top-most directory of the repository and keep the
subdirectory as a variable. As the helper is called from
within the git-submodule.sh script, we are already navigated
to the root level, but the path arguments are still relative
to the subdirectory we were in when calling git-submodule.sh.
That's why there is a `--prefix` option pointing to an alternative
path which to anchor relative path arguments.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 .gitignore                  |   1 +
 Makefile                    |   1 +
 builtin.h                   |   1 +
 builtin/submodule--helper.c | 124 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  54 +++----------------
 git.c                       |   1 +
 6 files changed, 134 insertions(+), 48 deletions(-)
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
index 0000000..e97403e
--- /dev/null
+++ b/builtin/submodule--helper.c
@@ -0,0 +1,124 @@
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
+
+static int module_list_compute(int argc, const char **argv,
+				const char *prefix,
+				struct pathspec *pathspec)
+{
+	int i, result = 0;
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
+		ps_matched = xcalloc(pathspec->nr, 1);
+
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
+
+	for (i = 0; i < active_nr; i++) {
+		const struct cache_entry *ce = active_cache[i];
+
+		if (!S_ISGITLINK(ce->ce_mode) ||
+		    !match_pathspec(pathspec, ce->name, ce_namelen(ce),
+				    max_prefix_len, ps_matched,
+				    S_ISGITLINK(ce->ce_mode) | S_ISDIR(ce->ce_mode)))
+			continue;
+
+		ALLOC_GROW(ce_entries, ce_used + 1, ce_alloc);
+		ce_entries[ce_used++] = ce;
+		while (i + 1 < active_nr &&
+		       !strcmp(ce->name, active_cache[i + 1]->name))
+			/*
+			 * Skip entries with the same name in different stages
+			 * to make sure an entry is returned only once.
+			 */
+			i++;
+	}
+	free(max_prefix);
+
+	if (ps_matched && report_path_error(ps_matched, pathspec, prefix))
+		result = -1;
+
+	free(ps_matched);
+
+	return result;
+}
+
+static int module_list(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	struct pathspec pathspec;
+
+	struct option module_list_options[] = {
+		OPT_STRING(0, "prefix", &prefix,
+			   N_("path"),
+			   N_("alternative anchor for relative paths")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper list [--prefix=<path>] [<path>...]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_list_options,
+			     git_submodule_helper_usage, 0);
+
+	if (module_list_compute(argc, argv, prefix, &pathspec) < 0) {
+		printf("#unmatched\n");
+		return 1;
+	}
+
+	for (i = 0; i < ce_used; i++) {
+		const struct cache_entry *ce = ce_entries[i];
+
+		if (ce_stage(ce))
+			printf("%06o %s U\t", ce->ce_mode, sha1_to_hex(null_sha1));
+		else
+			printf("%06o %s %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
+
+		utf8_fprintf(stdout, "%s\n", ce->name);
+	}
+	return 0;
+}
+
+
+struct cmd_struct {
+	const char *cmd;
+	int (*fn)(int, const char **, const char *);
+};
+
+static struct cmd_struct commands[] = {
+	{"list", module_list},
+};
+
+int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	if (argc < 2)
+		die(_("fatal: submodule--helper subcommand must be "
+		      "called with a subcommand"));
+
+	for (i = 0; i < ARRAY_SIZE(commands); i++)
+		if (!strcmp(argv[1], commands[i].cmd))
+			return commands[i].fn(argc - 1, argv + 1, prefix);
+
+	die(_("fatal: '%s' is not a valid submodule--helper "
+	      "subcommand"), argv[1]);
+}
diff --git a/git-submodule.sh b/git-submodule.sh
index 36797c3..95c04fc 100755
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
+	git submodule--helper list --prefix "$wt_prefix"|
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -592,7 +550,7 @@ cmd_init()
 		shift
 	done
 
-	module_list "$@" |
+	git submodule--helper list --prefix "$wt_prefix" "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -674,7 +632,7 @@ cmd_deinit()
 		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
 	fi
 
-	module_list "$@" |
+	git submodule--helper list --prefix "$wt_prefix" "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -790,7 +748,7 @@ cmd_update()
 	fi
 
 	cloned_modules=
-	module_list "$@" | {
+	git submodule--helper list --prefix "$wt_prefix" "$@" | {
 	err=
 	while read mode sha1 stage sm_path
 	do
@@ -1222,7 +1180,7 @@ cmd_status()
 		shift
 	done
 
-	module_list "$@" |
+	git submodule--helper list --prefix "$wt_prefix" "$@" |
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
@@ -1299,7 +1257,7 @@ cmd_sync()
 		esac
 	done
 	cd_to_toplevel
-	module_list "$@" |
+	git submodule--helper list --prefix "$wt_prefix" "$@" |
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
2.5.0.256.g89f8063.dirty
