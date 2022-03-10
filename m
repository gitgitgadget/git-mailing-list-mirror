Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53880C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 00:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbiCJAG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 19:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiCJAG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 19:06:57 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D0FADD46
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 16:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646870758; x=1678406758;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wONvaYijIL8f2st1nWhJPj1QqjchDQ+GLxUYhihOWXY=;
  b=Cm87h4W8/YqkDcTj0O9K62HBh2bnEpvoAvyBGarS0j211mrsv6BFcSS7
   bXg/1yXvYHos/Y2v2UauXpDRbTK8P0ZNa3hy9AMdMZdXeLWc0gJP9TAz9
   yMXpzL2dihnPrBqz53Sk1JnmY24V0ei8bxewHyUPYMvOhvHvAUUDgILqk
   qEFtXHjBz/coP/8cdfz1r590uydaq3Ts2FHIIwpHasX+lxzr1OGNebnww
   c9Zi3d/6yKAYxdCsCXJJM0G1c0ONAG6VCpKdDySh9PDX1WVMKDxoUaoGX
   rFyVAfWBB1H+UnckzknafKmUIxMbJfEgtIyODPBO6qg1NQnykF/FtRw47
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="252689451"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="252689451"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:05:57 -0800
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="781268420"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.10])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:05:57 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v3] name-rev: use generation numbers if available
Date:   Wed,  9 Mar 2022 16:05:50 -0800
Message-Id: <20220310000550.2368737-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.35.1.355.ge7e302376dd6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

If a commit in a sequence of linear history has a non-monotonically
increasing commit timestamp, git name-rev might not properly name the
commit.

This occurs because name-rev uses a heuristic of the commit date to
avoid searching down tags which lead to commits that are older than the
named commit. This is intended to avoid work on larger repositories.

This heuristic impacts git name-rev, and by extension git describe
--contains which is built on top of name-rev.

Further more, if --all or --annotate-stdin is used, the heuristic is not
enabled because the full history has to be analyzed anyways. This
results in some confusion if a user sees that --annotate-stdin works but
a normal name-rev does not.

If the repository has a commit graph, we can use the generation numbers
instead of using the commit dates. This is essentially the same check
except that generation numbers make it exact, where the commit date
heuristic could be incorrect due to clock errors.

Since we're extending the notion of cutoff to more than one variable,
create a series of functions for setting and checking the cutoff. This
avoids duplication and moves access of the global cutoff and
generation_cutoff to as few functions as possible.

Add several test cases including a test that covers the new commitGraph
behavior, as well as tests for --all and --annotate-stdin with and
without commitGraphs.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
Changes since v2:
* Removed negative test with commit graph disabled

I wanted to add a test that counted number of revisions walked, but I
couldn't figure out if we had a method to get this data out using GIT_TRACE
or GIT_TRACE2...

 builtin/name-rev.c  |  71 +++++++++++++++++++++------
 t/t6120-describe.sh | 116 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 173 insertions(+), 14 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 929591269ddf..c59b5699fe80 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -9,6 +9,7 @@
 #include "prio-queue.h"
 #include "hash-lookup.h"
 #include "commit-slab.h"
+#include "commit-graph.h"
 
 /*
  * One day.  See the 'name a rev shortly after epoch' test in t6120 when
@@ -26,9 +27,58 @@ struct rev_name {
 
 define_commit_slab(commit_rev_name, struct rev_name);
 
+static timestamp_t generation_cutoff = GENERATION_NUMBER_INFINITY;
 static timestamp_t cutoff = TIME_MAX;
 static struct commit_rev_name rev_names;
 
+/* Disable the cutoff checks entirely */
+static void disable_cutoff(void)
+{
+	generation_cutoff = 0;
+	cutoff = 0;
+}
+
+/* Cutoff searching any commits older than this one */
+static void set_commit_cutoff(struct commit *commit)
+{
+
+	if (cutoff > commit->date)
+		cutoff = commit->date;
+
+	if (generation_cutoff) {
+		timestamp_t generation = commit_graph_generation(commit);
+
+		if (generation_cutoff > generation)
+			generation_cutoff = generation;
+	}
+}
+
+/* adjust the commit date cutoff with a slop to allow for slightly incorrect
+ * commit timestamps in case of clock skew.
+ */
+static void adjust_cutoff_timestamp_for_slop(void)
+{
+	if (cutoff) {
+		/* check for undeflow */
+		if (cutoff > TIME_MIN + CUTOFF_DATE_SLOP)
+			cutoff = cutoff - CUTOFF_DATE_SLOP;
+		else
+			cutoff = TIME_MIN;
+	}
+}
+
+/* Check if a commit is before the cutoff. Prioritize generation numbers
+ * first, but use the commit timestamp if we lack generation data.
+ */
+static int commit_is_before_cutoff(struct commit *commit)
+{
+	if (generation_cutoff < GENERATION_NUMBER_INFINITY)
+		return generation_cutoff &&
+			commit_graph_generation(commit) < generation_cutoff;
+
+	return commit->date < cutoff;
+}
+
 /* How many generations are maximally preferred over _one_ merge traversal? */
 #define MERGE_TRAVERSAL_WEIGHT 65535
 
@@ -151,7 +201,7 @@ static void name_rev(struct commit *start_commit,
 	struct rev_name *start_name;
 
 	parse_commit(start_commit);
-	if (start_commit->date < cutoff)
+	if (commit_is_before_cutoff(start_commit))
 		return;
 
 	start_name = create_or_update_name(start_commit, taggerdate, 0, 0,
@@ -181,7 +231,7 @@ static void name_rev(struct commit *start_commit,
 			int generation, distance;
 
 			parse_commit(parent);
-			if (parent->date < cutoff)
+			if (commit_is_before_cutoff(parent))
 				continue;
 
 			if (parent_number > 1) {
@@ -568,7 +618,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		usage_with_options(name_rev_usage, opts);
 	}
 	if (all || annotate_stdin)
-		cutoff = 0;
+		disable_cutoff();
 
 	for (; argc; argc--, argv++) {
 		struct object_id oid;
@@ -596,10 +646,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (commit) {
-			if (cutoff > commit->date)
-				cutoff = commit->date;
-		}
+		if (commit)
+			set_commit_cutoff(commit);
 
 		if (peel_tag) {
 			if (!commit) {
@@ -612,13 +660,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		add_object_array(object, *argv, &revs);
 	}
 
-	if (cutoff) {
-		/* check for undeflow */
-		if (cutoff > TIME_MIN + CUTOFF_DATE_SLOP)
-			cutoff = cutoff - CUTOFF_DATE_SLOP;
-		else
-			cutoff = TIME_MIN;
-	}
+	adjust_cutoff_timestamp_for_slop();
+
 	for_each_ref(name_ref, &data);
 	name_tips();
 
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 9781b92aeddf..0b18f737794b 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -488,6 +488,122 @@ test_expect_success 'name-rev covers all conditions while looking at parents' '
 	)
 '
 
+# A-B-C-D-E-main
+#
+# Where C has a non-monotonically increasing commit timestamp w.r.t. other
+# commits
+test_expect_success 'non-monotonic commit dates setup' '
+	UNIX_EPOCH_ZERO="@0 +0000" &&
+	git init non-monotonic &&
+	test_commit -C non-monotonic A &&
+	test_commit -C non-monotonic --no-tag B &&
+	test_commit -C non-monotonic --no-tag --date "$UNIX_EPOCH_ZERO" C &&
+	test_commit -C non-monotonic D &&
+	test_commit -C non-monotonic E
+'
+
+test_expect_success 'name-rev with commitGraph handles non-monotonic timestamps' '
+	test_config -C non-monotonic core.commitGraph false &&
+	(
+		cd non-monotonic &&
+
+		echo "main~3 tags/D~2" >expect &&
+		git name-rev --tags main~3 >actual &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'name-rev --all works with non-monotonic timestamps' '
+	test_config -C non-monotonic core.commitGraph false &&
+	(
+		cd non-monotonic &&
+
+		rm -rf .git/info/commit-graph* &&
+
+		cat >tags <<-\EOF &&
+		tags/E
+		tags/D
+		tags/D~1
+		tags/D~2
+		tags/A
+		EOF
+
+		git log --pretty=%H >revs &&
+
+		paste -d" " revs tags | sort >expect &&
+
+		git name-rev --tags --all | sort >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'name-rev --annotate-stdin works with non-monotonic timestamps' '
+	test_config -C non-monotonic core.commitGraph false &&
+	(
+		cd non-monotonic &&
+
+		rm -rf .git/info/commit-graph* &&
+
+		cat >expect <<-\EOF &&
+		E
+		D
+		D~1
+		D~2
+		A
+		EOF
+
+		git log --pretty=%H >revs &&
+		git name-rev --tags --annotate-stdin --name-only <revs >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'name-rev --all works with commitGraph' '
+	test_config -C non-monotonic core.commitGraph true &&
+	(
+		cd non-monotonic &&
+
+		git commit-graph write --reachable &&
+
+		cat >tags <<-\EOF &&
+		tags/E
+		tags/D
+		tags/D~1
+		tags/D~2
+		tags/A
+		EOF
+
+		git log --pretty=%H >revs &&
+
+		paste -d" " revs tags | sort >expect &&
+
+		git name-rev --tags --all | sort >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'name-rev --annotate-stdin works with commitGraph' '
+	test_config -C non-monotonic core.commitGraph true &&
+	(
+		cd non-monotonic &&
+
+		git commit-graph write --reachable &&
+
+		cat >expect <<-\EOF &&
+		E
+		D
+		D~1
+		D~2
+		A
+		EOF
+
+		git log --pretty=%H >revs &&
+		git name-rev --tags --annotate-stdin --name-only <revs >actual &&
+		test_cmp expect actual
+	)
+'
+
 #               B
 #               o
 #                \

base-commit: c2162907e9aa884bdb70208389cb99b181620d51
-- 
2.35.1.355.ge7e302376dd6

