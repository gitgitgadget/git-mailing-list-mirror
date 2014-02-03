From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [WIP/PATCH 5/9] Teach bisect--helper the --[no-]recurse-submodules
 option
Date: Mon, 03 Feb 2014 20:51:19 +0100
Message-ID: <52EFF337.3060308@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>	<52CC3E16.4060909@web.de> <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com> <52EFF25E.6080306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 03 20:51:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAPYF-0001FP-CR
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 20:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbaBCTvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 14:51:23 -0500
Received: from mout.web.de ([212.227.17.12]:50436 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbaBCTvW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 14:51:22 -0500
Received: from [192.168.178.41] ([84.132.165.229]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0LaCbS-1VOP4g01yY-00m3zW for <git@vger.kernel.org>;
 Mon, 03 Feb 2014 20:51:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52EFF25E.6080306@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:uNTXWvSCZ+2NKNJl5R8JrcfEphb3dkDpwsp4qzxS8qIuQZ5+SyS
 3h8OUGVU+KaWOatUm/qysgDKo5NbWkA/hvV4gzKLf6pJKZc7kV/OrKAfvhtstt+L4MnUFpU
 bOgP/lWPpmMjn+hyZlprxzJnpnTbvBarM3OvRtLWee7V9xZwNwBzpDidW83/C22PL0FS6fE
 umeaBDCkqK0ETK2uZVCgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241460>

This is necessary before we can teach 'git bisect' this option, as that
calls the bisect--helper to do the actual work which then in turn calls
'git checkout'. The helper just passes the option given on the command
line on to checkout. The new recurse_submodules_enum_to_option() is added
to avoid having the helper learn the command line representation of the
different option values himself.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 bisect.c                 | 33 ++++++++++++++++++++++-----------
 bisect.h                 |  3 ++-
 builtin/bisect--helper.c |  9 ++++++++-
 submodule.c              | 21 +++++++++++++++++++++
 submodule.h              |  1 +
 5 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/bisect.c b/bisect.c
index 37200b4..b84e607 100644
--- a/bisect.c
+++ b/bisect.c
@@ -11,13 +11,13 @@
 #include "bisect.h"
 #include "sha1-array.h"
 #include "argv-array.h"
+#include "submodule.h"

 static struct sha1_array good_revs;
 static struct sha1_array skipped_revs;

 static unsigned char *current_bad_sha1;

-static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
 static const char *argv_update_ref[] = {"update-ref", "--no-deref", "BISECT_HEAD", NULL, NULL};

@@ -683,22 +683,30 @@ static void mark_expected_rev(char *bisect_rev_hex)
 		die("closing file %s: %s", filename, strerror(errno));
 }

-static int bisect_checkout(char *bisect_rev_hex, int no_checkout)
+static int bisect_checkout(char *bisect_rev_hex, int no_checkout,
+			   const char *recurse_submodules)
 {
 	int res;

 	mark_expected_rev(bisect_rev_hex);

-	argv_checkout[2] = bisect_rev_hex;
 	if (no_checkout) {
 		argv_update_ref[3] = bisect_rev_hex;
 		if (run_command_v_opt(argv_update_ref, RUN_GIT_CMD))
 			die("update-ref --no-deref HEAD failed on %s",
 			    bisect_rev_hex);
 	} else {
-		res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
+		struct argv_array argv = ARGV_ARRAY_INIT;
+		argv_array_push(&argv, "checkout");
+		argv_array_push(&argv, "-q");
+		if (recurse_submodules)
+		    argv_array_push(&argv, recurse_submodules);
+		argv_array_push(&argv, bisect_rev_hex);
+		argv_array_push(&argv, "--");
+		res = run_command_v_opt(argv.argv, RUN_GIT_CMD);
 		if (res)
 			exit(res);
+		argv_array_clear(&argv);
 	}

 	argv_show_branch[1] = bisect_rev_hex;
@@ -771,7 +779,7 @@ static void handle_skipped_merge_base(const unsigned char *mb)
  * - If one is "skipped", we can't know but we should warn.
  * - If we don't know, we should check it out and ask the user to test.
  */
-static void check_merge_bases(int no_checkout)
+static void check_merge_bases(int no_checkout, const char *recurse_submodules)
 {
 	struct commit_list *result;
 	int rev_nr;
@@ -789,7 +797,8 @@ static void check_merge_bases(int no_checkout)
 			handle_skipped_merge_base(mb);
 		} else {
 			printf("Bisecting: a merge base must be tested\n");
-			exit(bisect_checkout(sha1_to_hex(mb), no_checkout));
+			exit(bisect_checkout(sha1_to_hex(mb), no_checkout,
+					     recurse_submodules));
 		}
 	}

@@ -832,7 +841,8 @@ static int check_ancestors(const char *prefix)
  * If a merge base must be tested by the user, its source code will be
  * checked out to be tested by the user and we will exit.
  */
-static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
+static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout,
+					    const char *recurse_submodules)
 {
 	char *filename = git_pathdup("BISECT_ANCESTORS_OK");
 	struct stat st;
@@ -851,7 +861,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)

 	/* Check if all good revs are ancestor of the bad rev. */
 	if (check_ancestors(prefix))
-		check_merge_bases(no_checkout);
+		check_merge_bases(no_checkout, recurse_submodules);

 	/* Create file BISECT_ANCESTORS_OK. */
 	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
@@ -897,7 +907,8 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
  * If no_checkout is non-zero, the bisection process does not
  * checkout the trial commit but instead simply updates BISECT_HEAD.
  */
-int bisect_next_all(const char *prefix, int no_checkout)
+int bisect_next_all(const char *prefix, int no_checkout,
+		    const char *recurse_submodules)
 {
 	struct rev_info revs;
 	struct commit_list *tried;
@@ -908,7 +919,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	if (read_bisect_refs())
 		die("reading bisect refs failed");

-	check_good_are_ancestors_of_bad(prefix, no_checkout);
+	check_good_are_ancestors_of_bad(prefix, no_checkout, recurse_submodules);

 	bisect_rev_setup(&revs, prefix, "%s", "^%s", 1);
 	revs.limited = 1;
@@ -954,7 +965,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	       "(roughly %d step%s)\n", nr, (nr == 1 ? "" : "s"),
 	       steps, (steps == 1 ? "" : "s"));

-	return bisect_checkout(bisect_rev_hex, no_checkout);
+	return bisect_checkout(bisect_rev_hex, no_checkout, recurse_submodules);
 }

 static inline int log2i(int n)
diff --git a/bisect.h b/bisect.h
index 2a6c831..5c1ea9c 100644
--- a/bisect.h
+++ b/bisect.h
@@ -22,7 +22,8 @@ struct rev_list_info {
 	const char *header_prefix;
 };

-extern int bisect_next_all(const char *prefix, int no_checkout);
+extern int bisect_next_all(const char *prefix, int no_checkout,
+			   const char *recurse_submodules);

 extern int estimate_bisect_steps(int all);

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3324229..b30087a 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "bisect.h"
+#include "submodule.h"

 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
@@ -12,11 +13,16 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	int next_all = 0;
 	int no_checkout = 0;
+	int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+
 	struct option options[] = {
 		OPT_BOOL(0, "next-all", &next_all,
 			 N_("perform 'git bisect next'")),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules,
+			"checkout", "control recursive updating of submodules",
+			PARSE_OPT_OPTARG, option_parse_update_submodules },
 		OPT_END()
 	};

@@ -27,5 +33,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);

 	/* next-all */
-	return bisect_next_all(prefix, no_checkout);
+	return bisect_next_all(prefix, no_checkout,
+			       recurse_submodules_enum_to_option(recurse_submodules));
 }
diff --git a/submodule.c b/submodule.c
index b3eb28d..448b645 100644
--- a/submodule.c
+++ b/submodule.c
@@ -44,6 +44,27 @@ static int gitmodules_is_unmerged;
 static int gitmodules_is_modified;


+/*
+ * Convert values defined in the RECURSE_SUBMODULES_* enum to the string
+ * representation usable as command parameter. Returns NULL if no parameter
+ * is necessary.
+ */
+const char *recurse_submodules_enum_to_option(int recurse_submodules)
+{
+	switch(recurse_submodules) {
+	case RECURSE_SUBMODULES_ON_DEMAND:
+		return "--recurse-submodules=on-demand";
+	case RECURSE_SUBMODULES_OFF:
+		return "--no-recurse-submodules";
+	case RECURSE_SUBMODULES_ON:
+		return "--recurse-submodules";
+	case RECURSE_SUBMODULES_DEFAULT:
+		return NULL;
+	default:
+		die("Invalid recurse submodule value: %d", recurse_submodules);
+	}
+}
+
 int is_staging_gitmodules_ok(void)
 {
 	return !gitmodules_is_modified;
diff --git a/submodule.h b/submodule.h
index 79b336b..5958010 100644
--- a/submodule.h
+++ b/submodule.h
@@ -11,6 +11,7 @@ enum {
 	RECURSE_SUBMODULES_DEFAULT = 1,
 	RECURSE_SUBMODULES_ON = 2
 };
+const char *recurse_submodules_enum_to_option(int recurse_submodules);

 int is_staging_gitmodules_ok(void);
 int update_path_in_gitmodules(const char *oldpath, const char *newpath);
-- 
1.9.rc0.28.ge3363ff
