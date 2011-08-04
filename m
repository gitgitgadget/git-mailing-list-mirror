From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v17 4/7] bisect: introduce support for --no-checkout option.
Date: Thu,  4 Aug 2011 22:01:00 +1000
Message-ID: <1312459263-16911-5-git-send-email-jon.seymour@gmail.com>
References: <1312459263-16911-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 14:02:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qowcu-00041S-Oj
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 14:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869Ab1HDMCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 08:02:07 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36181 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab1HDMB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 08:01:59 -0400
Received: by mail-gx0-f174.google.com with SMTP id 21so985599gxk.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 05:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=70KThvk8ymBkSllzm9KWHX2fFNycnMbUz/KBsueQGB8=;
        b=GSYEEkajVsah9b5yR05CY/ObIvLyKyFwnhlKH54E5LPwp4I7cncsMaDXdYsZlGsV/J
         G50kMtb0O93VQzb/gCPGoS8wversIl2cr7BllQeEU+fQh2zqx+FRceKFTphS7wQ8y2oK
         rrtSH4l6PWchjjl9PajaLEm09/tse4ZXy4zNs=
Received: by 10.142.122.27 with SMTP id u27mr742188wfc.2.1312459318905;
        Thu, 04 Aug 2011 05:01:58 -0700 (PDT)
Received: from localhost.localdomain ([120.16.214.215])
        by mx.google.com with ESMTPS id i5sm249965wff.18.2011.08.04.05.01.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 05:01:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.353.g50d6f
In-Reply-To: <1312459263-16911-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178742>

If --no-checkout is specified, then the bisection process uses:

	git update-ref --no-deref HEAD <trial>

at each trial instead of:

	git checkout <trial>

Improved-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 bisect.c                 |   33 ++++++++++++++++++++++-----------
 bisect.h                 |    2 +-
 builtin/bisect--helper.c |    7 +++++--
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/bisect.c b/bisect.c
index dd7e8ed..c7b7d79 100644
--- a/bisect.c
+++ b/bisect.c
@@ -24,6 +24,7 @@ struct argv_array {
 
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
+static const char *argv_update_ref[] = {"update-ref", "--no-deref", "BISECT_HEAD", NULL, NULL};
 
 /* bits #0-15 in revision.h */
 
@@ -707,16 +708,23 @@ static void mark_expected_rev(char *bisect_rev_hex)
 		die("closing file %s: %s", filename, strerror(errno));
 }
 
-static int bisect_checkout(char *bisect_rev_hex)
+static int bisect_checkout(char *bisect_rev_hex, int no_checkout)
 {
 	int res;
 
 	mark_expected_rev(bisect_rev_hex);
 
 	argv_checkout[2] = bisect_rev_hex;
-	res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
-	if (res)
-		exit(res);
+	if (no_checkout) {
+		argv_update_ref[3] = bisect_rev_hex;
+		if (run_command_v_opt(argv_update_ref, RUN_GIT_CMD))
+			die("update-ref --no-deref HEAD failed on %s",
+			    bisect_rev_hex);
+	} else {
+		res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
+		if (res)
+			exit(res);
+	}
 
 	argv_show_branch[1] = bisect_rev_hex;
 	return run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
@@ -788,7 +796,7 @@ static void handle_skipped_merge_base(const unsigned char *mb)
  * - If one is "skipped", we can't know but we should warn.
  * - If we don't know, we should check it out and ask the user to test.
  */
-static void check_merge_bases(void)
+static void check_merge_bases(int no_checkout)
 {
 	struct commit_list *result;
 	int rev_nr;
@@ -806,7 +814,7 @@ static void check_merge_bases(void)
 			handle_skipped_merge_base(mb);
 		} else {
 			printf("Bisecting: a merge base must be tested\n");
-			exit(bisect_checkout(sha1_to_hex(mb)));
+			exit(bisect_checkout(sha1_to_hex(mb), no_checkout));
 		}
 	}
 
@@ -849,7 +857,7 @@ static int check_ancestors(const char *prefix)
  * If a merge base must be tested by the user, its source code will be
  * checked out to be tested by the user and we will exit.
  */
-static void check_good_are_ancestors_of_bad(const char *prefix)
+static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 {
 	const char *filename = git_path("BISECT_ANCESTORS_OK");
 	struct stat st;
@@ -868,7 +876,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix)
 
 	/* Check if all good revs are ancestor of the bad rev. */
 	if (check_ancestors(prefix))
-		check_merge_bases();
+		check_merge_bases(no_checkout);
 
 	/* Create file BISECT_ANCESTORS_OK. */
 	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
@@ -908,8 +916,11 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
  * We use the convention that exiting with an exit code 10 means that
  * the bisection process finished successfully.
  * In this case the calling shell script should exit 0.
+ *
+ * If no_checkout is non-zero, the bisection process does not
+ * checkout the trial commit but instead simply updates BISECT_HEAD.
  */
-int bisect_next_all(const char *prefix)
+int bisect_next_all(const char *prefix, int no_checkout)
 {
 	struct rev_info revs;
 	struct commit_list *tried;
@@ -920,7 +931,7 @@ int bisect_next_all(const char *prefix)
 	if (read_bisect_refs())
 		die("reading bisect refs failed");
 
-	check_good_are_ancestors_of_bad(prefix);
+	check_good_are_ancestors_of_bad(prefix, no_checkout);
 
 	bisect_rev_setup(&revs, prefix, "%s", "^%s", 1);
 	revs.limited = 1;
@@ -966,6 +977,6 @@ int bisect_next_all(const char *prefix)
 	       "(roughly %d step%s)\n", nr, (nr == 1 ? "" : "s"),
 	       steps, (steps == 1 ? "" : "s"));
 
-	return bisect_checkout(bisect_rev_hex);
+	return bisect_checkout(bisect_rev_hex, no_checkout);
 }
 
diff --git a/bisect.h b/bisect.h
index 0862ce5..22f2e4d 100644
--- a/bisect.h
+++ b/bisect.h
@@ -27,7 +27,7 @@ struct rev_list_info {
 	const char *header_prefix;
 };
 
-extern int bisect_next_all(const char *prefix);
+extern int bisect_next_all(const char *prefix, int no_checkout);
 
 extern int estimate_bisect_steps(int all);
 
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 5b22639..8d325a5 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -4,16 +4,19 @@
 #include "bisect.h"
 
 static const char * const git_bisect_helper_usage[] = {
-	"git bisect--helper --next-all",
+	"git bisect--helper --next-all [--no-checkout]",
 	NULL
 };
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	int next_all = 0;
+	int no_checkout = 0;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "next-all", &next_all,
 			    "perform 'git bisect next'"),
+		OPT_BOOLEAN(0, "no-checkout", &no_checkout,
+			    "update BISECT_HEAD instead of checking out the current commit"),
 		OPT_END()
 	};
 
@@ -24,5 +27,5 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	/* next-all */
-	return bisect_next_all(prefix);
+	return bisect_next_all(prefix, no_checkout);
 }
-- 
1.7.6.353.g50d6f
