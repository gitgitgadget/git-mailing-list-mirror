Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0BEC433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 19:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiB1TIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 14:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiB1TIY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 14:08:24 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAF410FC2
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 11:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646075264; x=1677611264;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HcNSPxTvr/P0WzGIv5OVbZvFlnUqiW7Z0izQCg1VEpk=;
  b=IKtiM3FrQcsr0ZM6QbFP3HiJWcOQ8j6JVAmQCCOHxctDqAM43agCibEK
   BE6A21wp+W8OCSREReclWmH9c3AsZvf/AsfRYrHxI7twLiSn8UpHzbli4
   cJbBHmGB1OnCjiWCjtEvFFS9oEzR16Lm+zibk3vVH4gsTxb/QQICV5zdf
   JYonPiKWhB7bUKQ2pM0e1Rfx8YT8e04pBR3rN/MbOpnT+fxlS7hC8sh9T
   uQ2op2Na7AJPziuVBXZqt59PCwH7bwEzhEpn+oxXH8YQnnQxAjxaePX5u
   rDE3CtDflA1fR//0XmP2xYDvbTov5H830oFn2u659enly9qq3dsXD2SWA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="316177027"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="316177027"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 11:07:43 -0800
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="510204906"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.10])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 11:07:43 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] name-rev: use generation numbers if available
Date:   Mon, 28 Feb 2022 11:07:38 -0800
Message-Id: <20220228190738.2112503-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.35.1.129.gb80121027d12
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

Further more, if --annotate-stdin is used, the heuristic is not enabled
because the full history has to be analyzed anyways. This results in
some confusion if a user sees that --annotate-stdin works but a normal
name-rev does not.

If the repository has a commit graph, we can use the generation numbers
instead of using the commit dates. This is essentially the same check
except that generation numbers make it exact, where the commit date
heuristic could be incorrect due to clock errors.

Add a test case which covers this behavior and shows how the commit
graph makes the name-rev process work.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
The initial implementation of this came from [1]. Should this have Stolee's
sign-off?

[1]: https://lore.kernel.org/git/42d2a9fe-a3f2-f841-dcd1-27a0440521b6@github.com/


 builtin/name-rev.c  | 39 +++++++++++++++++++++++++++++-------
 t/t6120-describe.sh | 48 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 138e3c30a2b9..eda06697ac9f 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -9,6 +9,7 @@
 #include "prio-queue.h"
 #include "hash-lookup.h"
 #include "commit-slab.h"
+#include "commit-graph.h"
 
 /*
  * One day.  See the 'name a rev shortly after epoch' test in t6120 when
@@ -26,9 +27,33 @@ struct rev_name {
 
 define_commit_slab(commit_rev_name, struct rev_name);
 
+static timestamp_t generation_cutoff = GENERATION_NUMBER_INFINITY;
 static timestamp_t cutoff = TIME_MAX;
 static struct commit_rev_name rev_names;
 
+static void set_commit_cutoff(struct commit *commit)
+{
+	timestamp_t generation;
+
+	if (cutoff > commit->date)
+		cutoff = commit->date;
+
+	generation = commit_graph_generation(commit);
+	if (generation_cutoff > generation)
+		generation_cutoff = generation;
+}
+
+/* Check if a commit is before the cutoff. Prioritize generation numbers
+ * first, but use the commit timestamp if we lack generation data.
+ */
+static int commit_is_before_cutoff(struct commit *commit)
+{
+	if (generation_cutoff < GENERATION_NUMBER_INFINITY)
+		return commit_graph_generation(commit) < generation_cutoff;
+
+	return commit->date < cutoff;
+}
+
 /* How many generations are maximally preferred over _one_ merge traversal? */
 #define MERGE_TRAVERSAL_WEIGHT 65535
 
@@ -151,7 +176,7 @@ static void name_rev(struct commit *start_commit,
 	struct rev_name *start_name;
 
 	parse_commit(start_commit);
-	if (start_commit->date < cutoff)
+	if (commit_is_before_cutoff(start_commit))
 		return;
 
 	start_name = create_or_update_name(start_commit, taggerdate, 0, 0,
@@ -181,7 +206,7 @@ static void name_rev(struct commit *start_commit,
 			int generation, distance;
 
 			parse_commit(parent);
-			if (parent->date < cutoff)
+			if (commit_is_before_cutoff(parent))
 				continue;
 
 			if (parent_number > 1) {
@@ -567,8 +592,10 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		error("Specify either a list, or --all, not both!");
 		usage_with_options(name_rev_usage, opts);
 	}
-	if (all || annotate_stdin)
+	if (all || annotate_stdin) {
+		generation_cutoff = 0;
 		cutoff = 0;
+	}
 
 	for (; argc; argc--, argv++) {
 		struct object_id oid;
@@ -596,10 +623,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
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
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 9781b92aeddf..1af29b6824ba 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -488,6 +488,54 @@ test_expect_success 'name-rev covers all conditions while looking at parents' '
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
+	test_config -C non-monotonic core.commitGraph true &&
+	(
+		cd non-monotonic &&
+
+		# Ensure commit graph is up to date
+		git -c gc.writeCommitGraph=true gc &&
+
+		echo "main~3 tags/D~2" >expect &&
+		git name-rev --tags main~3 >actual &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'name-rev --all works with non-monotonic' '
+	(
+		cd non-monotonic &&
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
+
+		test_cmp expect actual
+	)
+'
+
 #               B
 #               o
 #                \
-- 
2.35.1.129.gb80121027d12

