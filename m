From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule: implement `module_list` as a builtin helper
Date: Mon,  3 Aug 2015 15:58:08 -0700
Message-ID: <1438642688-9660-1-git-send-email-sbeller@google.com>
References: <xmqqbneo6nas.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 04 00:58:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMOgT-0002H0-7T
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 00:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778AbbHCW6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 18:58:12 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36317 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755582AbbHCW6K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 18:58:10 -0400
Received: by pdco4 with SMTP id o4so13793345pdc.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 15:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KaKxEGZdlGI5MUWfeY8dZA2lRkmI+J6ciwRZM9Z2vHc=;
        b=XfRvpfkNpFBQEDajrikUK/nj/jfYAfChHRbGUy9CsQ3arJ/Y5w1LBgWmJR7a+9LQHW
         s254TthQ46X15XXwvAxmgFjSl2a0+54FpzmCPrGJH7JNvkc9/KLfo0EG5cP2a+h1XDdL
         NqQDVE1BQV4YFzGzGDcnrAwywRA/XBqSzdOlKq4QjWmMg01UHg4RgS3k0qW0l6OGGogg
         8nbK8A0Mol3vt7iPwb7z6SD0xPUXyF2dlBHIoc6XKr8DjTcBxV8uHATVpEw18MeADMqP
         mIC0FcFmiypkY9sm+hoOemTzmqy2y//EJybFnBwKJn9lpGW74XIJaY8A3bDcnWEP0Eur
         Mspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KaKxEGZdlGI5MUWfeY8dZA2lRkmI+J6ciwRZM9Z2vHc=;
        b=Z7K75B+OIsfIa+fnQU+w/joF7B39k87fO6xn4xAiz2NNXQqHquMV8pjGpyBsL8U7W8
         ZSLsi68R99C1f1V9aSiYa9LoE0tp5J6HQHNqcCSa+HjDe4zoxrvkDmp/Hq+yvhtu9iHA
         uvXrZPs+EjeUXk69ai3hGe66H8Ne++6MhlQp3HbxC4bKw3zcPbPvAQNV1Rd9UXdAlzzZ
         Sb4aCUNvdm3MEmJc7OZOXCsgBClfLvj+M5frIJugiamf/Pbw7yrNVljiWk5rgrf6rQfe
         n8XxNwoq0l3P6FYTrjnOjXE7SbP5RL+ASTtS8VM9bUAWApBZgcO/BN9Y+af3bJMDZv7+
         P9NA==
X-Gm-Message-State: ALoCoQkohp+HGL5uz5CxMScY36feJvtzcJNhj4m7wCCAGpzkgFFDYiguuHa5LxeEdA/0wJdeqvaG
X-Received: by 10.70.44.133 with SMTP id e5mr988344pdm.24.1438642690372;
        Mon, 03 Aug 2015 15:58:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:db:6b60:15e0:f3aa])
        by smtp.gmail.com with ESMTPSA id k5sm18638443pdo.48.2015.08.03.15.58.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 15:58:09 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.1.gc648038.dirty
In-Reply-To: <xmqqbneo6nas.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275225>

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
 Makefile                    |   1 +
 builtin.h                   |   1 +
 builtin/submodule--helper.c | 110 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  54 +++-------------------
 git.c                       |   1 +
 5 files changed, 119 insertions(+), 48 deletions(-)
 create mode 100644 builtin/submodule--helper.c

diff --git a/Makefile b/Makefile
index 8c3c724..6fb7484 100644
--- a/Makefile
+++ b/Makefile
@@ -898,6 +898,7 @@ BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-ref.o
 BUILTIN_OBJS += builtin/stripspace.o
+BUILTIN_OBJS += builtin/submodule--helper.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
 BUILTIN_OBJS += builtin/tag.o
 BUILTIN_OBJS += builtin/unpack-file.o
diff --git a/builtin.h b/builtin.h
index 9e04f97..7bf9597 100644
--- a/builtin.h
+++ b/builtin.h
@@ -118,6 +118,7 @@ extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
+extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tag(int argc, const char **argv, const char *prefix);
 extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
new file mode 100644
index 0000000..fbd9568
--- /dev/null
+++ b/builtin/submodule--helper.c
@@ -0,0 +1,110 @@
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
+		return module_list(--argc, ++argv, prefix);
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
index fe94066..721995e 100644
--- a/git.c
+++ b/git.c
@@ -468,6 +468,7 @@ static struct cmd_struct commands[] = {
 	{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
+	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP },
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 	{ "tag", cmd_tag, RUN_SETUP },
 	{ "unpack-file", cmd_unpack_file, RUN_SETUP },
-- 
2.5.0.1.gc648038.dirty
