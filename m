From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 1/3] submodule: Reimplement `module_list` shell function in C
Date: Tue,  8 Sep 2015 11:57:43 -0700
Message-ID: <1441738665-29493-2-git-send-email-sbeller@google.com>
References: <1441738665-29493-1-git-send-email-sbeller@google.com>
Cc: sunshine@sunshineco.com, git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 08 20:58:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZO5e-0003bQ-IX
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 20:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbbIHS55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 14:57:57 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35048 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbbIHS5w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 14:57:52 -0400
Received: by pacfv12 with SMTP id fv12so134516882pac.2
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 11:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PbYQEGfCAYwHqLDfxK5cUjzL4DIqPjJAyksAiSU+NkM=;
        b=lhk1D9yMRu4S2R3HSdkMRbhzvjaolGa63sydQqhtFMwZtWXjOovI3P/Zy7Mla1x+4o
         KXRwSnAUSBRZIsQEcxjiau090AslkC5ssxrGc/LwmoQ9wi9fbs5z7ArkPDL+OyyaWx2b
         eQDY+Gj0fXLM5/azzpkGHINiNOfuh4U59q98N4ph5HVBtM+8gW2UC1hmlkNPF7DIe3RM
         ICNmhn8d6Alzn9bNCLYM6ODoXyA+n3uOw33+cYOqTBdW3pmD/956GK2WKooMIgPBqz6W
         aMTD7a32XCdOJP25ddyU4hstXtV/BFh8b/higAjLjJIMHHqOHOTGsOkynQUp/4ZA4boh
         brdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PbYQEGfCAYwHqLDfxK5cUjzL4DIqPjJAyksAiSU+NkM=;
        b=k0m3IC/CTrgbcb4CUM4xIpgCK8VpNamfEmnR5buFUBDzyl+QEee7Cw+Z2OxduJeq+M
         GYUftqKftN+g04ywKltJzv8/8Mf1Ur5jfxxCwouHJBEl+c9BjEwHz1YihgSV1q3HJPG/
         jrjUlw3qIoQVXrn1CDLNl0PT9RbmIkX6CNUNwFgGp1zMaIIYXMcoQ/u6+XOYH26snOy2
         n/ykVNf6uMuTL0zU/TKd3Gfcp6avEOw/RNiIz5yrOxImqwta+4y1b30gSdOuBqMZ8e7l
         YSTqrlq6jkIW6TUWUkWKVrWnwHROCugGdtk9UXMvW6GkhrV3ULS6oGw8pgMmSLHNx+u8
         XTuQ==
X-Gm-Message-State: ALoCoQk3fO73YDklxdkjw0jI07OviMkI6wmKPAAMNvrBCA8UbtHYYUiMVUMSNBxqmfw+fghGoD1n
X-Received: by 10.69.11.5 with SMTP id ee5mr61214211pbd.89.1441738672180;
        Tue, 08 Sep 2015 11:57:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:b8c0:c175:ec61:d891])
        by smtp.gmail.com with ESMTPSA id p3sm4293744pdf.3.2015.09.08.11.57.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 08 Sep 2015 11:57:51 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.256.g89f8063.dirty
In-Reply-To: <1441738665-29493-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277519>

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
 builtin/submodule--helper.c | 128 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  54 +++----------------
 git.c                       |   1 +
 6 files changed, 138 insertions(+), 48 deletions(-)
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
index 0000000..10db4e6
--- /dev/null
+++ b/builtin/submodule--helper.c
@@ -0,0 +1,128 @@
+#include "builtin.h"
+#include "cache.h"
+#include "parse-options.h"
+#include "quote.h"
+#include "pathspec.h"
+#include "dir.h"
+#include "utf8.h"
+
+struct module_list {
+	const struct cache_entry **entries;
+	int alloc, nr;
+};
+#define MODULE_LIST_INIT { NULL, 0, 0 }
+
+static int module_list_compute(int argc, const char **argv,
+			       const char *prefix,
+			       struct pathspec *pathspec,
+			       struct module_list *list)
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
+				    max_prefix_len, ps_matched, 1))
+			continue;
+
+		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
+		list->entries[list->nr++] = ce;
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
+	struct module_list list = MODULE_LIST_INIT;
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
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
+		printf("#unmatched\n");
+		return 1;
+	}
+
+	for (i = 0; i < list.nr; i++) {
+		const struct cache_entry *ce = list.entries[i];
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
