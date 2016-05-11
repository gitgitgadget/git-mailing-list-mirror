From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/7] submodule--helper module_list_compute: allow label or name arguments
Date: Tue, 10 May 2016 17:59:55 -0700
Message-ID: <1462928397-1708-6-git-send-email-sbeller@google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com, gitster@pobox.com, Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Wed May 11 03:00:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0IVu-00028Y-CB
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 03:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbcEKBAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 21:00:23 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36466 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbcEKBAT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 21:00:19 -0400
Received: by mail-pa0-f42.google.com with SMTP id bt5so11016285pac.3
        for <git@vger.kernel.org>; Tue, 10 May 2016 18:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ccNc8hRsiOKxjDb0BAF6g4QK/hv+glYhBFULBqNXUfI=;
        b=hm3F7NHg79Nibld10ONa19/W3pKYgRWWREElnUBLLHlyXfX08l3utYxA83sJlKgSK1
         w9i9Nlm262z2t6GNsajsMV0ijGEQw7ZWPgC9MDhmL/gOBqIRzAv+SNY2rrkl50ZU/Jk4
         6jCDin3I2mRZ1fxZEqU2nh3l3ykgkyl2h2egkODxVO1evou3/eA6hWePA+wcSV2SPZaJ
         pE2cI9XiICxOQyG4jdOiKI8DyCB+yAWEsIZIMKtW+mMuRHsR/KSD7KYAcPE+f6FVfmex
         GNp0p52fLuCg0MpZ1MnN9rdxm36UcTvbrNxoyEGlfSb4jnVmm1qXU3sELr1ds0BIwN/C
         /IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ccNc8hRsiOKxjDb0BAF6g4QK/hv+glYhBFULBqNXUfI=;
        b=AFr3DHjIxhgVHATfpgQcIKRTb/pBcX4zBeOr9JRB5Kn3+/qqJ+xSKhMuSAnDQbdGKv
         ULQzdw1xTL1/YAB/86azQZ9PQKJ8pJpPqRnJdDZzoNoAAlv27cPgXH1GBucSt/DzWaj/
         I6lVMzj5/K/QWMERuQZESqvR4EsTB589Vu+1F5IHsP75/hQ7otIGo72rW6Q/Yd03Qldz
         waWX4kBVnRXT3U51s8gEUn0gxYi9zLVXd0ykVLYtcQm37JXPVoOx9I9ldlRZvtNtiGlJ
         cY/F9sar/C8UdiA1JAkdf9eLE5lM7of+Hpd8aDxCdrH3OqD26RleALvpAR+pQ4f2nFhg
         5gJA==
X-Gm-Message-State: AOPr4FWtpeRFEVUb8zKiWD7aG4d1+gRpzG+r8bYyYwfJpfYvKgsJrdo9xFqq0CvVC12rEYKk
X-Received: by 10.66.78.73 with SMTP id z9mr789742paw.4.1462928413635;
        Tue, 10 May 2016 18:00:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:69ac:db78:a0d1:60da])
        by smtp.gmail.com with ESMTPSA id s23sm7199693pfj.86.2016.05.10.18.00.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 10 May 2016 18:00:13 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.35.g58985d9.dirty
In-Reply-To: <1462928397-1708-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294215>

Additionally to taking a pathspec, `module_list_compute` will also take
labels and submodule names, when these are prefixed by '*' and ':'
respectively.

`module_list_compute` is used by other functions in the submodule helper:
* module_list, used by `submodule {deinit, status, sync, foreach}`
* module_init, used by `submodule init`
* update_clone, used by `submodule update`

{foreach, update} do not pass on command line arguments to the listing
function such that these are not affected. The rest of them {deinit,
status, sync, init} will be exercised in additional tests.

As the labeling requires lookup of .gitmodules files, we need to make sure
the submodule config cache is initialized in all the functions, that's why
there are additional calls to gitmodules_config() and	git_config(...);

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt | 22 +++++++++--
 builtin/submodule--helper.c     | 76 +++++++++++++++++++++++++++++++-----
 git-submodule.sh                |  8 ++--
 t/t7412-submodule--helper.sh    | 86 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 175 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 9ba8895..35ca355 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -11,16 +11,16 @@ SYNOPSIS
 [verse]
 'git submodule' [--quiet] add [-b <branch>] [-f|--force] [-l|--label <label>]
 	      [--reference <repository>] [--depth <depth>] [--] <repository> [<path>]
-'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
-'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
+'git submodule' [--quiet] status [--cached] [--recursive] [--] [<submodulespec>...]
+'git submodule' [--quiet] init [--] [<submodulespec>...]
+'git submodule' [--quiet] deinit [-f|--force] [--] <submodulespec>...
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
 	      [-f|--force] [--rebase|--merge] [--reference <repository>]
 	      [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
-'git submodule' [--quiet] sync [--recursive] [--] [<path>...]
+'git submodule' [--quiet] sync [--recursive] [--] [<submodulespec>...]
 
 
 DESCRIPTION
@@ -37,6 +37,20 @@ these will not be checked out by default; the 'init' and 'update'
 subcommands will maintain submodules checked out and at
 appropriate revision in your working tree.
 
+When working on submodules you can specify the desired submodule
+group or give no specification at all to apply the command to the
+default group of submodules, which includes all submodules.
+To group submodules you can make use of
+ . a pathspec,
+ . their name,
+ . labels.
+It is undefined behavior to give a spec that is ambigious for a name,
+pathspec or label. To make the specification unambigous, you can prefix
+ . pathspecs with './',
+ . names with ':',
+ . labels with '*'.
+Labels must consist of alphanumeric characters or the dash character.
+
 Submodules are composed from a so-called `gitlink` tree entry
 in the main repository that refers to a particular commit object
 within the inner repository that is completely separate.
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6ffd1c1..ba43c80 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -12,6 +12,7 @@
 #include "remote.h"
 #include "refs.h"
 #include "connect.h"
+#include "argv-array.h"
 
 static char *get_default_remote(void)
 {
@@ -215,6 +216,36 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
+static void split_argv_pathspec_groups(int argc, const char **argv,
+				       const char ***pathspec_argv,
+				       struct string_list *group)
+{
+	int i;
+	struct argv_array ps = ARGV_ARRAY_INIT;
+	for (i = 0; i < argc; i++) {
+		if (starts_with(argv[i], "*")
+		    || starts_with(argv[i], ":")) {
+			string_list_insert(group, argv[i]);
+		} else if (starts_with(argv[i], "./")) {
+			argv_array_push(&ps, argv[i]);
+		} else {
+			/*
+			* NEEDSWORK:
+			* Improve autodetection of items with no prefixes,
+			* roughly like
+			* if (label_or_name_exists(argv[i]))
+			*	string_list_insert(group, argv[i]);
+			* else
+			*	argv_array_push(&ps, argv[i]);
+			*/
+			argv_array_push(&ps, argv[i]);
+		}
+	}
+
+	*pathspec_argv = argv_array_detach(&ps);
+	argv_array_clear(&ps);
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -228,10 +259,15 @@ static int module_list_compute(int argc, const char **argv,
 {
 	int i, result = 0;
 	char *ps_matched = NULL;
+	const char **pathspec_argv;
+	struct string_list group = STRING_LIST_INIT_DUP;
+
+	split_argv_pathspec_groups(argc, argv, &pathspec_argv, &group);
+
 	parse_pathspec(pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
-		       prefix, argv);
+		       prefix, pathspec_argv);
 
 	if (pathspec->nr)
 		ps_matched = xcalloc(pathspec->nr, 1);
@@ -242,10 +278,27 @@ static int module_list_compute(int argc, const char **argv,
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 
-		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
-				    0, ps_matched, 1) ||
-		    !S_ISGITLINK(ce->ce_mode))
-			continue;
+		if (!group.nr) {
+			if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
+					    0, ps_matched, 1) ||
+			    !S_ISGITLINK(ce->ce_mode))
+				continue;
+		} else {
+			const struct submodule *sub;
+			int ps = 0, gr = 0;
+			if (!S_ISGITLINK(ce->ce_mode))
+				continue;
+			sub = submodule_from_path(null_sha1, ce->name);
+
+			ps = match_pathspec(pathspec, ce->name, ce_namelen(ce),
+					    0, ps_matched, 1);
+			gr = submodule_in_group(&group, sub);
+
+			if (!pathspec->nr && !gr)
+				continue;
+			if (!ps && !gr)
+				continue;
+		}
 
 		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
 		list->entries[list->nr++] = ce;
@@ -287,6 +340,9 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_list_options,
 			     git_submodule_helper_usage, 0);
 
+	gitmodules_config();
+	git_config(submodule_config, NULL);
+
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
 		printf("#unmatched\n");
 		return 1;
@@ -415,6 +471,9 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_init_options,
 			     git_submodule_helper_usage, 0);
 
+	gitmodules_config();
+	git_config(submodule_config, NULL);
+
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
 		return 1;
 
@@ -795,16 +854,15 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		if (parse_submodule_update_strategy(update, &suc.update) < 0)
 			die(_("bad value for update parameter"));
 
+	gitmodules_config();
+	git_config(submodule_config, NULL);
+
 	if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0)
 		return 1;
 
 	if (pathspec.nr)
 		suc.warn_if_uninitialized = 1;
 
-	/* Overlay the parsed .gitmodules file with .git/config */
-	gitmodules_config();
-	git_config(submodule_config, NULL);
-
 	if (max_jobs < 0)
 		max_jobs = parallel_submodules();
 
diff --git a/git-submodule.sh b/git-submodule.sh
index c1213d8..c8e36c5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -6,13 +6,13 @@
 
 dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [-l|--label <label>][--] <repository> [<path>]
-   or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
-   or: $dashless [--quiet] init [--] [<path>...]
-   or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
+   or: $dashless [--quiet] status [--cached] [--recursive] [--] [<submodulespec>...]
+   or: $dashless [--quiet] init [--] [<submodulespec>...]
+   or: $dashless [--quiet] deinit [-f|--force] [--] <submodulespec>...
    or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
-   or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
+   or: $dashless [--quiet] sync [--recursive] [--] [<submodulespec>...]"
 OPTIONS_SPEC=
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
diff --git a/t/t7412-submodule--helper.sh b/t/t7412-submodule--helper.sh
index 042f3f5..0f2e5c6 100755
--- a/t/t7412-submodule--helper.sh
+++ b/t/t7412-submodule--helper.sh
@@ -104,4 +104,90 @@ test_expect_success 'in-group' '
 	)
 '
 
+test_expect_success 'submodule init respects label' '
+	test_when_finished "rm -rf super_clone" &&
+	suburl=$(pwd)/sub &&
+	git clone super super_clone &&
+	(
+		cd super_clone &&
+		git submodule init \*bit1 &&
+		test_must_fail git config submodule.sub0.url &&
+		test        "$(git config submodule.sub1.url)" = "$suburl" &&
+		test_must_fail git config submodule.sub2.url &&
+		test        "$(git config submodule.sub3.url)" = "$suburl"
+	)
+'
+
+test_expect_success 'submodule init respects name' '
+	test_when_finished "rm -rf super_clone" &&
+	suburl=$(pwd)/sub &&
+	git clone super super_clone &&
+	(
+		cd super_clone &&
+		git submodule init :sub_name &&
+		test_must_fail git config submodule.sub0.url &&
+		test "$(git config submodule.sub_name.url)" = "$suburl"
+	)
+'
+
+test_expect_success 'submodule deinit respects label' '
+	suburl=$(pwd)/sub &&
+	(
+		cd super &&
+		git submodule init &&
+		git submodule deinit \*bit2 &&
+		test        "$(git config submodule.sub0.url)" = "$suburl" &&
+		test        "$(git config submodule.sub1.url)" = "$suburl" &&
+		test_must_fail git config submodule.sub2.url &&
+		test_must_fail git config submodule.sub3.url
+	)
+'
+
+test_expect_success 'submodule deinit respects label and path' '
+	suburl=$(pwd)/sub &&
+	(
+		cd super &&
+		git submodule init &&
+		git submodule deinit \*bit2 ./sub1 &&
+		test        "$(git config submodule.sub0.url)" = "$suburl" &&
+		test_must_fail git config submodule.sub1.url &&
+		test_must_fail git config submodule.sub2.url &&
+		test_must_fail git config submodule.sub3.url
+	)
+'
+
+cat >expect <<-EOF
+-sub1
+-sub3
+EOF
+
+test_expect_success 'submodule status respects label and path' '
+	suburl=$(pwd)/sub &&
+	(
+		cd super &&
+		git submodule deinit .
+		git submodule init &&
+		git submodule status \*bit1 ./sub1 | cut -c 1,43- >../actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success 'submodule sync respects name and path' '
+	suburl=$(pwd)/sub &&
+	(
+		cd super &&
+		git submodule init &&
+		git config submodule."sub0".url "wrong" &&
+		git config submodule."sub1".url "wrong" &&
+		git config submodule."sub2".url "wrong" &&
+		git config submodule."sub3".url "wrong" &&
+		git submodule sync :sub_name ./sub1 | cut -c 1,43- >../actual &&
+		test "$(git config submodule.sub0.url)" = "wrong" &&
+		test "$(git config submodule.sub1.url)" = "$suburl" &&
+		test "$(git config submodule.sub2.url)" = "wrong" &&
+		test "$(git config submodule.sub3.url)" = "wrong" &&
+		test "$(git config submodule.sub_name.url)" = "$suburl"
+	)
+'
+
 test_done
-- 
2.8.0.35.g58985d9.dirty
