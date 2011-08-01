From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v11 4/7] bisect: introduce support for --no-checkout option.
Date: Mon,  1 Aug 2011 21:56:14 +1000
Message-ID: <1312199777-10144-5-git-send-email-jon.seymour@gmail.com>
References: <1312199777-10144-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 13:57:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnr7Z-00062W-Ht
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 13:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab1HAL5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 07:57:14 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60595 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252Ab1HAL5M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 07:57:12 -0400
Received: by yxi11 with SMTP id 11so3066694yxi.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 04:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5TLLPIzzEcPxmly7d5Zclm4Br9gl5+oFzilMOFUPBMg=;
        b=lvPUF4vrjS/Y0em/EumuxuBEXN4s6I8URwMGIHpKCT7bGAT4JpMu+pisDF7TSJKGED
         PpuzMEcjKduyifHZEu7aa3LEV/FHACTLb+wcrmHGpdMNFvcoPBiC0pQF6JWL2giRY4Z1
         sDsWpP4GC6tLOKzdG51WDMW/r0BPmy9UjGRdM=
Received: by 10.142.110.12 with SMTP id i12mr2772521wfc.161.1312199830478;
        Mon, 01 Aug 2011 04:57:10 -0700 (PDT)
Received: from localhost.localdomain ([120.16.6.238])
        by mx.google.com with ESMTPS id a4sm3060009wfm.4.2011.08.01.04.57.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 04:57:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.g0c69b
In-Reply-To: <1312199777-10144-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178339>

If --no-checkout is specified, then the bisection process uses:

	git update-ref --no-deref HEAD <trial>

at each trial instead of:

	git checkout <trial>

Improved-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 bisect.c                 |   32 +++++++++++++++++++++-----------
 bisect.h                 |    2 +-
 builtin/bisect--helper.c |    7 +++++--
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/bisect.c b/bisect.c
index dd7e8ed..534da2c 100644
--- a/bisect.c
+++ b/bisect.c
@@ -24,6 +24,7 @@ struct argv_array {
 
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
+static const char *argv_update_ref[] = {"update-ref", "--no-deref", "HEAD", NULL, NULL};
 
 /* bits #0-15 in revision.h */
 
@@ -707,16 +708,22 @@ static void mark_expected_rev(char *bisect_rev_hex)
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
+	  argv_update_ref[3] = bisect_rev_hex;
+	  if (run_command_v_opt(argv_update_ref, RUN_GIT_CMD))
+	    die("update-ref --no-deref HEAD failed on %s", bisect_rev_hex);
+	} else {
+	  res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
+	  if (res)
+	    exit(res);
+	}
 
 	argv_show_branch[1] = bisect_rev_hex;
 	return run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
@@ -788,7 +795,7 @@ static void handle_skipped_merge_base(const unsigned char *mb)
  * - If one is "skipped", we can't know but we should warn.
  * - If we don't know, we should check it out and ask the user to test.
  */
-static void check_merge_bases(void)
+static void check_merge_bases(int no_checkout)
 {
 	struct commit_list *result;
 	int rev_nr;
@@ -806,7 +813,7 @@ static void check_merge_bases(void)
 			handle_skipped_merge_base(mb);
 		} else {
 			printf("Bisecting: a merge base must be tested\n");
-			exit(bisect_checkout(sha1_to_hex(mb)));
+			exit(bisect_checkout(sha1_to_hex(mb), no_checkout));
 		}
 	}
 
@@ -849,7 +856,7 @@ static int check_ancestors(const char *prefix)
  * If a merge base must be tested by the user, its source code will be
  * checked out to be tested by the user and we will exit.
  */
-static void check_good_are_ancestors_of_bad(const char *prefix)
+static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 {
 	const char *filename = git_path("BISECT_ANCESTORS_OK");
 	struct stat st;
@@ -868,7 +875,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix)
 
 	/* Check if all good revs are ancestor of the bad rev. */
 	if (check_ancestors(prefix))
-		check_merge_bases();
+		check_merge_bases(no_checkout);
 
 	/* Create file BISECT_ANCESTORS_OK. */
 	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
@@ -908,8 +915,11 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
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
@@ -920,7 +930,7 @@ int bisect_next_all(const char *prefix)
 	if (read_bisect_refs())
 		die("reading bisect refs failed");
 
-	check_good_are_ancestors_of_bad(prefix);
+	check_good_are_ancestors_of_bad(prefix, no_checkout);
 
 	bisect_rev_setup(&revs, prefix, "%s", "^%s", 1);
 	revs.limited = 1;
@@ -966,6 +976,6 @@ int bisect_next_all(const char *prefix)
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
index 5b22639..d96a193 100644
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
+			    "update HEAD instead of checking out the current commit"),
 		OPT_END()
 	};
 
@@ -24,5 +27,5 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	/* next-all */
-	return bisect_next_all(prefix);
+	return bisect_next_all(prefix, no_checkout);
 }
-- 
1.7.6.352.g0c69b
