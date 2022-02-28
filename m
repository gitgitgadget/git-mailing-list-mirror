Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FACC433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 21:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiB1VvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 16:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiB1VvP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 16:51:15 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB56BB1520
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 13:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646085035; x=1677621035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1vSdt4npzijOq5zw8nwHgD0geQ/2AQHkQlA5CFm6wJ4=;
  b=dnASuhk+OA0l0TOp+jLhkzaI36XK1tr3DzfdBDr09ZDHTjCy4IzA8+v+
   MBDFU9i/FX8ic9fIXWB97I0Kok8tur8cdivbPpJAz+548/vZcf7lXBlbx
   P/f8FjoUCTu3QAgL7kdrtmVWG9g93VnYO1zYch0W7zT+038VpXbvrTHtd
   /IkXR4q1hKTPLlG1txCKmr4GZD7uQiXi1aXJKyrDM1xZk3BUFXHeLDpva
   ue4pO8g+CrNEuSM45R1d/nLozzW8krS8xMSeZ3m73o7SXBRh6PdepVWUY
   QQ5gkdkLx5raEXVBKZemC77ONhxFvz9HEux54Q2nva8sZPj3rrJiDHCqw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="236503912"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="236503912"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 13:50:34 -0800
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="544875865"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.10])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 13:50:34 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] name-rev: use generation numbers if available
Date:   Mon, 28 Feb 2022 13:50:25 -0800
Message-Id: <20220228215025.325904-3-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.35.1.355.ge7e302376dd6
In-Reply-To: <20220228215025.325904-1-jacob.e.keller@intel.com>
References: <20220228215025.325904-1-jacob.e.keller@intel.com>
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

Add several test cases including coverage of --all, --annotate-stdin,
and the normal case with the cutoff heuristic, both with and without
commit graphs enabled.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/name-rev.c  |  71 +++++++++++++++++++-----
 t/t6120-describe.sh | 132 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 189 insertions(+), 14 deletions(-)

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
index 9781b92aeddf..c353c21cc837 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -488,6 +488,138 @@ test_expect_success 'name-rev covers all conditions while looking at parents' '
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
+test_expect_success 'name-rev without commitGraph does not handle non-monotonic timestamps' '
+	test_config -C non-monotonic core.commitGraph false &&
+	(
+		cd non-monotonic &&
+
+		rm -rf .git/info/commit-graph* &&
+
+		echo "main~3 undefined" >expect &&
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
+test_expect_success 'name-rev with commitGraph handles non-monotonic timestamps' '
+	test_config -C non-monotonic core.commitGraph true &&
+	(
+		cd non-monotonic &&
+
+		git commit-graph write --reachable &&
+
+		echo "main~3 tags/D~2" >expect &&
+		git name-rev --tags main~3 >actual &&
+
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
-- 
2.35.1.355.ge7e302376dd6

