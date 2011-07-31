From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v8 3/7] bisect: introduce support for --update-ref=<ref> option.
Date: Sun, 31 Jul 2011 21:55:17 +1000
Message-ID: <1312113321-28760-4-git-send-email-jon.seymour@gmail.com>
References: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 13:56:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnUdM-0002mJ-L6
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 13:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337Ab1GaL4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 07:56:31 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:33709 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab1GaL4b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 07:56:31 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so9556049pzk.1
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 04:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=liDQ0M0Q1uH6c6XSDNcn7TUon0CJeD1UdytuuErkHCA=;
        b=vPyntiiAexzdH2UDzuvLlWMvlrbVxkugpGPCe8S6FHrL3WKY2Z0d6HXYo9mt7xRkzH
         p/8nbOe/uGK8H0WdWciz4s5ifGdGNZSxeRekqoHMALWi8QTH8qKlv2hRq7yjCEhmMHpu
         KxyNq9BuhIx5OiBfuftSuPr07XakH+NBx3Nqo=
Received: by 10.68.2.1 with SMTP id 1mr3726917pbq.274.1312113389665;
        Sun, 31 Jul 2011 04:56:29 -0700 (PDT)
Received: from localhost.localdomain ([120.16.239.154])
        by mx.google.com with ESMTPS id g4sm4306620pbj.41.2011.07.31.04.56.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 04:56:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.352.g62761
In-Reply-To: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178240>

If --update-ref=<ref> is specified, then the bisection process uses:

	git update-ref --no-deref <ref> <trial>

at each trial instead of:

	git checkout <trial>

Improved-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 bisect.c                 |   34 +++++++++++++++++++++++-----------
 bisect.h                 |    2 +-
 builtin/bisect--helper.c |    7 +++++--
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/bisect.c b/bisect.c
index dd7e8ed..4291935 100644
--- a/bisect.c
+++ b/bisect.c
@@ -24,6 +24,7 @@ struct argv_array {
 
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
+static const char *argv_update_ref[] = {"update-ref", "--no-deref", NULL, NULL, NULL};
 
 /* bits #0-15 in revision.h */
 
@@ -707,16 +708,23 @@ static void mark_expected_rev(char *bisect_rev_hex)
 		die("closing file %s: %s", filename, strerror(errno));
 }
 
-static int bisect_checkout(char *bisect_rev_hex)
+static int bisect_checkout(char *bisect_rev_hex, const char *update_ref)
 {
 	int res;
 
 	mark_expected_rev(bisect_rev_hex);
 
 	argv_checkout[2] = bisect_rev_hex;
-	res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
-	if (res)
-		exit(res);
+	if (!update_ref) {
+	  res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
+	  if (res)
+	    exit(res);
+	} else {
+	    argv_update_ref[2] = update_ref;
+	    argv_update_ref[3] = bisect_rev_hex;
+	    if (run_command_v_opt(argv_update_ref, RUN_GIT_CMD))
+	      die("update-ref --no-deref %s failed on %s", update_ref, bisect_rev_hex);
+	}
 
 	argv_show_branch[1] = bisect_rev_hex;
 	return run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
@@ -788,7 +796,7 @@ static void handle_skipped_merge_base(const unsigned char *mb)
  * - If one is "skipped", we can't know but we should warn.
  * - If we don't know, we should check it out and ask the user to test.
  */
-static void check_merge_bases(void)
+static void check_merge_bases(const char *update_ref)
 {
 	struct commit_list *result;
 	int rev_nr;
@@ -806,7 +814,7 @@ static void check_merge_bases(void)
 			handle_skipped_merge_base(mb);
 		} else {
 			printf("Bisecting: a merge base must be tested\n");
-			exit(bisect_checkout(sha1_to_hex(mb)));
+			exit(bisect_checkout(sha1_to_hex(mb), update_ref));
 		}
 	}
 
@@ -849,7 +857,7 @@ static int check_ancestors(const char *prefix)
  * If a merge base must be tested by the user, its source code will be
  * checked out to be tested by the user and we will exit.
  */
-static void check_good_are_ancestors_of_bad(const char *prefix)
+static void check_good_are_ancestors_of_bad(const char *prefix, const char *update_ref)
 {
 	const char *filename = git_path("BISECT_ANCESTORS_OK");
 	struct stat st;
@@ -868,7 +876,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix)
 
 	/* Check if all good revs are ancestor of the bad rev. */
 	if (check_ancestors(prefix))
-		check_merge_bases();
+		check_merge_bases(update_ref);
 
 	/* Create file BISECT_ANCESTORS_OK. */
 	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
@@ -908,8 +916,12 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
  * We use the convention that exiting with an exit code 10 means that
  * the bisection process finished successfully.
  * In this case the calling shell script should exit 0.
+ *
+ * If update_ref is not null, the bisection process does not
+ * checkout the trial commit but instead simply updates the
+ * specified reference.
  */
-int bisect_next_all(const char *prefix)
+int bisect_next_all(const char *prefix, const char *update_ref)
 {
 	struct rev_info revs;
 	struct commit_list *tried;
@@ -920,7 +932,7 @@ int bisect_next_all(const char *prefix)
 	if (read_bisect_refs())
 		die("reading bisect refs failed");
 
-	check_good_are_ancestors_of_bad(prefix);
+	check_good_are_ancestors_of_bad(prefix, update_ref);
 
 	bisect_rev_setup(&revs, prefix, "%s", "^%s", 1);
 	revs.limited = 1;
@@ -966,6 +978,6 @@ int bisect_next_all(const char *prefix)
 	       "(roughly %d step%s)\n", nr, (nr == 1 ? "" : "s"),
 	       steps, (steps == 1 ? "" : "s"));
 
-	return bisect_checkout(bisect_rev_hex);
+	return bisect_checkout(bisect_rev_hex, update_ref);
 }
 
diff --git a/bisect.h b/bisect.h
index 0862ce5..63f0ca5 100644
--- a/bisect.h
+++ b/bisect.h
@@ -27,7 +27,7 @@ struct rev_list_info {
 	const char *header_prefix;
 };
 
-extern int bisect_next_all(const char *prefix);
+extern int bisect_next_all(const char *prefix, const char *update_ref);
 
 extern int estimate_bisect_steps(int all);
 
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 5b22639..cb13cb2 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -4,16 +4,19 @@
 #include "bisect.h"
 
 static const char * const git_bisect_helper_usage[] = {
-	"git bisect--helper --next-all",
+	"git bisect--helper --next-all [--update-ref=<ref>]",
 	NULL
 };
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	int next_all = 0;
+	char *update_ref = NULL;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "next-all", &next_all,
 			    "perform 'git bisect next'"),
+		OPT_STRING(0, "update-ref", &update_ref, "ref",
+			    "update <ref> instead of checking out the current commit"),
 		OPT_END()
 	};
 
@@ -24,5 +27,5 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	/* next-all */
-	return bisect_next_all(prefix);
+	return bisect_next_all(prefix, update_ref);
 }
-- 
1.7.6.391.g168d0.dirty
