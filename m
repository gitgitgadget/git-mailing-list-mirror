Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E39C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 21:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiB1VvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 16:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiB1VvO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 16:51:14 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAEDB1520
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 13:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646085034; x=1677621034;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zl/ahhYygUKbz2e4KmhuJ94+2rFotRuEtxa3MeAlHFc=;
  b=ByUQitFndsuRw86vgg82GwkIMIe0hhY6ya43mGm4/KzBXTFtRmQ96lxT
   po7DfpfS4z+JSchEYZnsmlLN7ZYaUXZLSYKL/4yNJ/cVciByDQ6VSaObK
   YWKfszjjxEpzJWA6/X69hYDOXttylGx5/NC/zDF+hTrdAqSOCCeoGOtNs
   OAimrPNyM0LPPGvtoE+x9XjMWXdM9vir0Xy6vBmDZctJkk0tGTdZTWudA
   mSTyrExJSfordbGkqz2+EEP2h5/zYvPFP7IazUIraFDkzTZ/haHvggeve
   W0MdRynvBNcB25mLImlTN82MjezMpHfuM1CMFkFCRxYkzEFossi1WOKOP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="236503909"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="236503909"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 13:50:34 -0800
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="544875863"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.10])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 13:50:33 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 0/1] name-rev: use generation numbers if available
Date:   Mon, 28 Feb 2022 13:50:23 -0800
Message-Id: <20220228215025.325904-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.35.1.355.ge7e302376dd6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Thanks for the review, Stolee!

Here's the range-diff since v1:

1:  e7e302376dd6 ! 1:  8ab5d987bf93 name-rev: use generation numbers if available
    @@ Commit message
         This heuristic impacts git name-rev, and by extension git describe
         --contains which is built on top of name-rev.
     
    -    Further more, if --annotate-stdin is used, the heuristic is not enabled
    -    because the full history has to be analyzed anyways. This results in
    -    some confusion if a user sees that --annotate-stdin works but a normal
    -    name-rev does not.
    +    Further more, if --all or --annotate-stdin is used, the heuristic is not
    +    enabled because the full history has to be analyzed anyways. This
    +    results in some confusion if a user sees that --annotate-stdin works but
    +    a normal name-rev does not.
     
         If the repository has a commit graph, we can use the generation numbers
         instead of using the commit dates. This is essentially the same check
         except that generation numbers make it exact, where the commit date
         heuristic could be incorrect due to clock errors.
     
    -    Add a test case which covers this behavior and shows how the commit
    -    graph makes the name-rev process work.
    +    Since we're extending the notion of cutoff to more than one variable,
    +    create a series of functions for setting and checking the cutoff. This
    +    avoids duplication and moves access of the global cutoff and
    +    generation_cutoff to as few functions as possible.
    +
    +    Add several test cases including coverage of --all, --annotate-stdin,
    +    and the normal case with the cutoff heuristic, both with and without
    +    commit graphs enabled.
     
         Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
     
    @@ builtin/name-rev.c: struct rev_name {
      static timestamp_t cutoff = TIME_MAX;
      static struct commit_rev_name rev_names;
      
    ++/* Disable the cutoff checks entirely */
    ++static void disable_cutoff(void)
    ++{
    ++	generation_cutoff = 0;
    ++	cutoff = 0;
    ++}
    ++
    ++/* Cutoff searching any commits older than this one */
     +static void set_commit_cutoff(struct commit *commit)
     +{
    -+	timestamp_t generation;
     +
     +	if (cutoff > commit->date)
     +		cutoff = commit->date;
     +
    -+	generation = commit_graph_generation(commit);
    -+	if (generation_cutoff > generation)
    -+		generation_cutoff = generation;
    ++	if (generation_cutoff) {
    ++		timestamp_t generation = commit_graph_generation(commit);
    ++
    ++		if (generation_cutoff > generation)
    ++			generation_cutoff = generation;
    ++	}
    ++}
    ++
    ++/* adjust the commit date cutoff with a slop to allow for slightly incorrect
    ++ * commit timestamps in case of clock skew.
    ++ */
    ++static void adjust_cutoff_timestamp_for_slop(void)
    ++{
    ++	if (cutoff) {
    ++		/* check for undeflow */
    ++		if (cutoff > TIME_MIN + CUTOFF_DATE_SLOP)
    ++			cutoff = cutoff - CUTOFF_DATE_SLOP;
    ++		else
    ++			cutoff = TIME_MIN;
    ++	}
     +}
     +
     +/* Check if a commit is before the cutoff. Prioritize generation numbers
    @@ builtin/name-rev.c: struct rev_name {
     +static int commit_is_before_cutoff(struct commit *commit)
     +{
     +	if (generation_cutoff < GENERATION_NUMBER_INFINITY)
    -+		return commit_graph_generation(commit) < generation_cutoff;
    ++		return generation_cutoff &&
    ++			commit_graph_generation(commit) < generation_cutoff;
     +
     +	return commit->date < cutoff;
     +}
    @@ builtin/name-rev.c: static void name_rev(struct commit *start_commit,
      
      			if (parent_number > 1) {
     @@ builtin/name-rev.c: int cmd_name_rev(int argc, const char **argv, const char *prefix)
    - 		error("Specify either a list, or --all, not both!");
      		usage_with_options(name_rev_usage, opts);
      	}
    --	if (all || annotate_stdin)
    -+	if (all || annotate_stdin) {
    -+		generation_cutoff = 0;
    - 		cutoff = 0;
    -+	}
    + 	if (all || annotate_stdin)
    +-		cutoff = 0;
    ++		disable_cutoff();
      
      	for (; argc; argc--, argv++) {
      		struct object_id oid;
    @@ builtin/name-rev.c: int cmd_name_rev(int argc, const char **argv, const char *pr
      
      		if (peel_tag) {
      			if (!commit) {
    +@@ builtin/name-rev.c: int cmd_name_rev(int argc, const char **argv, const char *prefix)
    + 		add_object_array(object, *argv, &revs);
    + 	}
    + 
    +-	if (cutoff) {
    +-		/* check for undeflow */
    +-		if (cutoff > TIME_MIN + CUTOFF_DATE_SLOP)
    +-			cutoff = cutoff - CUTOFF_DATE_SLOP;
    +-		else
    +-			cutoff = TIME_MIN;
    +-	}
    ++	adjust_cutoff_timestamp_for_slop();
    ++
    + 	for_each_ref(name_ref, &data);
    + 	name_tips();
    + 
     
      ## t/t6120-describe.sh ##
     @@ t/t6120-describe.sh: test_expect_success 'name-rev covers all conditions while looking at parents' '
    @@ t/t6120-describe.sh: test_expect_success 'name-rev covers all conditions while l
     +	test_commit -C non-monotonic E
     +'
     +
    -+test_expect_success 'name-rev with commitGraph handles non-monotonic timestamps' '
    -+	test_config -C non-monotonic core.commitGraph true &&
    ++test_expect_success 'name-rev without commitGraph does not handle non-monotonic timestamps' '
    ++	test_config -C non-monotonic core.commitGraph false &&
     +	(
     +		cd non-monotonic &&
     +
    -+		# Ensure commit graph is up to date
    -+		git -c gc.writeCommitGraph=true gc &&
    ++		rm -rf .git/info/commit-graph* &&
     +
    -+		echo "main~3 tags/D~2" >expect &&
    ++		echo "main~3 undefined" >expect &&
     +		git name-rev --tags main~3 >actual &&
     +
     +		test_cmp expect actual
     +	)
     +'
     +
    -+test_expect_success 'name-rev --all works with non-monotonic' '
    ++test_expect_success 'name-rev --all works with non-monotonic timestamps' '
    ++	test_config -C non-monotonic core.commitGraph false &&
     +	(
     +		cd non-monotonic &&
     +
    ++		rm -rf .git/info/commit-graph* &&
    ++
    ++		cat >tags <<-\EOF &&
    ++		tags/E
    ++		tags/D
    ++		tags/D~1
    ++		tags/D~2
    ++		tags/A
    ++		EOF
    ++
    ++		git log --pretty=%H >revs &&
    ++
    ++		paste -d" " revs tags | sort >expect &&
    ++
    ++		git name-rev --tags --all | sort >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    ++test_expect_success 'name-rev --annotate-stdin works with non-monotonic timestamps' '
    ++	test_config -C non-monotonic core.commitGraph false &&
    ++	(
    ++		cd non-monotonic &&
    ++
    ++		rm -rf .git/info/commit-graph* &&
    ++
     +		cat >expect <<-\EOF &&
     +		E
     +		D
    @@ t/t6120-describe.sh: test_expect_success 'name-rev covers all conditions while l
     +
     +		git log --pretty=%H >revs &&
     +		git name-rev --tags --annotate-stdin --name-only <revs >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
     +
    ++test_expect_success 'name-rev with commitGraph handles non-monotonic timestamps' '
    ++	test_config -C non-monotonic core.commitGraph true &&
    ++	(
    ++		cd non-monotonic &&
    ++
    ++		git commit-graph write --reachable &&
    ++
    ++		echo "main~3 tags/D~2" >expect &&
    ++		git name-rev --tags main~3 >actual &&
    ++
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    ++test_expect_success 'name-rev --all works with commitGraph' '
    ++	test_config -C non-monotonic core.commitGraph true &&
    ++	(
    ++		cd non-monotonic &&
    ++
    ++		git commit-graph write --reachable &&
    ++
    ++		cat >tags <<-\EOF &&
    ++		tags/E
    ++		tags/D
    ++		tags/D~1
    ++		tags/D~2
    ++		tags/A
    ++		EOF
    ++
    ++		git log --pretty=%H >revs &&
    ++
    ++		paste -d" " revs tags | sort >expect &&
    ++
    ++		git name-rev --tags --all | sort >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    ++test_expect_success 'name-rev --annotate-stdin works with commitGraph' '
    ++	test_config -C non-monotonic core.commitGraph true &&
    ++	(
    ++		cd non-monotonic &&
    ++
    ++		git commit-graph write --reachable &&
    ++
    ++		cat >expect <<-\EOF &&
    ++		E
    ++		D
    ++		D~1
    ++		D~2
    ++		A
    ++		EOF
    ++
    ++		git log --pretty=%H >revs &&
    ++		git name-rev --tags --annotate-stdin --name-only <revs >actual &&
     +		test_cmp expect actual
     +	)
     +'

Jacob Keller (1):
  name-rev: use generation numbers if available

 builtin/name-rev.c  |  71 +++++++++++++++++++-----
 t/t6120-describe.sh | 132 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 189 insertions(+), 14 deletions(-)

-- 
2.35.1.355.ge7e302376dd6

