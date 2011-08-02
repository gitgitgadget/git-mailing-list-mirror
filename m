From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v13 4/8] bisect: introduce support for --no-checkout option.
Date: Tue,  2 Aug 2011 21:29:01 +1000
Message-ID: <1312284545-2426-5-git-send-email-jon.seymour@gmail.com>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 02 13:30:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoDB8-0004bt-PA
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 13:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006Ab1HBLaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 07:30:13 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51756 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab1HBLaK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 07:30:10 -0400
Received: by mail-yx0-f174.google.com with SMTP id 11so3685327yxi.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 04:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=00RV+AAkQozWnGMgbWocWDWWhCW4ZUxVl0dkqFISLpM=;
        b=uKTTJnoqnNZ+tGgj1FzB95yHXxqry1O/g/OXgbAvzJYVfJJq+Vo886fLpxEly8fmGQ
         nlI2itgafvF8TLV2dver3AZ2HAqIZfcNpT+vtMATBVGFFM/UYCkakfPvu0zEQz1UQckV
         9It7DWyobpA0oh7lPa8RRjr1pH01rw+FhJwro=
Received: by 10.143.59.19 with SMTP id m19mr3561324wfk.50.1312284609444;
        Tue, 02 Aug 2011 04:30:09 -0700 (PDT)
Received: from localhost.localdomain ([120.16.93.94])
        by mx.google.com with ESMTPS id t20sm3715018wfe.12.2011.08.02.04.30.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Aug 2011 04:30:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.353.g3461
In-Reply-To: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178457>

If --no-checkout is specified, then the bisection process uses:

	git update-ref --no-deref HEAD <trial>

at each trial instead of:

	git checkout <trial>

Improved-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 bisect.c                 |   33 ++++++++++++++++++++++-----------
 bisect.h                 |    2 +-
 builtin/bisect--helper.c |    9 +++++++--
 3 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/bisect.c b/bisect.c
index dd7e8ed..0427117 100644
--- a/bisect.c
+++ b/bisect.c
@@ -24,6 +24,7 @@ struct argv_array {
 
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
+static const char *argv_update_ref[] = {"update-ref", "--no-deref", "HEAD", NULL, NULL};
 
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
+ * checkout the trial commit but instead simply updates HEAD.
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
index 5b22639..5cfac13 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -4,16 +4,20 @@
 #include "bisect.h"
 
 static const char * const git_bisect_helper_usage[] = {
-	"git bisect--helper --next-all",
+	"git bisect--helper --next-all [--bisect-mode=checkout|update-ref]",
 	NULL
 };
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	int next_all = 0;
+	int no_checkout = 0;
+	char *bisect_mode=NULL;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "next-all", &next_all,
 			    "perform 'git bisect next'"),
+		OPT_STRING(0, "bisect-mode", &bisect_mode, "mode",
+			    "the bisection mode either checkout or update-ref. defaults to checkout."),
 		OPT_END()
 	};
 
@@ -23,6 +27,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	if (!next_all)
 		usage_with_options(git_bisect_helper_usage, options);
 
+	no_checkout = bisect_mode && !strcmp(bisect_mode, "update-ref");
 	/* next-all */
-	return bisect_next_all(prefix);
+	return bisect_next_all(prefix, no_checkout);
 }
-- 
1.7.6.353.g3461
