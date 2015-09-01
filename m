From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 1/3] submodule: implement `list` as a builtin helper
Date: Tue,  1 Sep 2015 11:24:27 -0700
Message-ID: <1441131869-29474-2-git-send-email-sbeller@google.com>
References: <1441131869-29474-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de, peff@peff.net
To: sbeller@google.com, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Tue Sep 01 20:25:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWqEq-0005wb-7P
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 20:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684AbbIASYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 14:24:47 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33324 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbbIASYp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 14:24:45 -0400
Received: by padan5 with SMTP id an5so3783432pad.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b6QMG3J4WTmoRCpsVNQECK0f+hTF8CgMOzCbakJ4OHs=;
        b=Ai+cQWPcDuMG8qSazV+gtGBHkwJEIjQX9WJGZWYRyygodFi+IHFs8p2tWPH2pf/u5M
         4+YiUntSaFp4frGShkPFd8ThXa4/vhoQMoPRwlfuBx2GDfWFVWQFGWv+YEITQwTpbXDK
         FNdsha3DiMsEM7GdlEI1KiErwDg1O5ZeoYYXJQNlNOZXovBAv3s9CaNAxm+HihyfboGm
         AilPChtzFBkSWk86SNNFKByb/90g3wDr0uS19cgdsVREMmry+oGbdibV0vyZU1OyMB9/
         HJExNOO+HcPGlffwfG3NA3zshSkWL0ouctI3z2UJORdEMS4wodI+l9K//6IqEBdVkRL3
         EJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b6QMG3J4WTmoRCpsVNQECK0f+hTF8CgMOzCbakJ4OHs=;
        b=itATEn55tQc76B9/Ydvp/zFFYrEiVAnnP7vKJOWJtPTb/13wJd70I6nuB7yh4tREN5
         7jPnB+blInri7hvSwnH3H4MG5x82O2S82SnVbDmxRjQsHhNXW2n25BL6GbgbgrzAkO4D
         Rg9OzqzYeHLk2PqgBI1RG91nIDOvmbHLCmFAL4KWiT7Fzgjh2MbIhr3L8700sIGz0I2u
         s6HANExpPc2r4rAt0XaOk5XbiUKrO/LU5fCBENCL2pFx4N7prXjxYipaTi2xltG9T93K
         Fukj1pp5Dm431fH50um/eEGVqG/BMqHxFAHlQt3yB9MmPA33ANs8uPWpkCXvcQ1TNJIW
         XuHg==
X-Gm-Message-State: ALoCoQme9lzc/XPLyDvjIbVlQvD0dmUMv4yxJmj+AWnBiccQCP1CbHYSsaf9X5kzB4CLqRWAzbH9
X-Received: by 10.68.68.233 with SMTP id z9mr48365344pbt.140.1441131884716;
        Tue, 01 Sep 2015 11:24:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3828:a7a8:276e:e72a])
        by smtp.gmail.com with ESMTPSA id fs13sm18956680pdb.29.2015.09.01.11.24.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 11:24:44 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.256.g89f8063.dirty
In-Reply-To: <1441131869-29474-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277010>

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
 builtin/submodule--helper.c | 137 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  54 ++---------------
 git.c                       |   1 +
 6 files changed, 147 insertions(+), 48 deletions(-)
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
index 0000000..16d9abe
--- /dev/null
+++ b/builtin/submodule--helper.c
@@ -0,0 +1,137 @@
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
+	const char *alternative_path;
+
+	struct option module_list_options[] = {
+		OPT_STRING(0, "prefix", &alternative_path,
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
+	int (*fct)(int, const char **, const char *);
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
+		goto out;
+
+	for (i = 0; i < ARRAY_SIZE(commands); i++)
+		if (!strcmp(argv[1], commands[i].cmd))
+			return commands[i].fct(argc - 1, argv + 1, prefix);
+
+out:
+	if (argc > 1)
+		fprintf(stderr, _("fatal: '%s' is not a valid submodule--helper "
+				  "subcommand, which are:\n"), argv[1]);
+	else
+		fprintf(stderr, _("fatal: submodule--helper subcommand must be "
+				  "called with a subcommand, which are:\n"));
+
+	for (i = 0; i < ARRAY_SIZE(commands); i++)
+		fprintf(stderr, "\t%s\n", commands[i].cmd);
+
+	exit(129);
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
