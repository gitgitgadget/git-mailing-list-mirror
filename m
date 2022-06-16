Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBFBC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 07:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358639AbiFPHJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 03:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiFPHJf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 03:09:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD16619C14
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 00:09:33 -0700 (PDT)
Received: (qmail 12816 invoked by uid 109); 16 Jun 2022 07:09:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jun 2022 07:09:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Thu, 16 Jun 2022 03:09:32 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Neeraj Singh <neerajsi@microsoft.com>
Subject: [PATCH] perf-lib: fix missing test titles in output
Message-ID: <YqrXLO5oMYeOr2PB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 5dccd9155f (t/perf: add iteration setup mechanism to perf-lib,
2022-04-04) modified the parameter parsing of test_wrapper() such that
the test title was no longer in $1, and is instead in $test_title_.

We correctly pass the new variable to the code which outputs the title
to the log, but missed the spot in test_wrapper() where the title is
written to the ".descr" file which is used to produce the final output
table. As a result, all of the titles are missing from that table (or
worse, using whatever was left in $1):

  $ ./p0000-perf-lib-sanity.sh
  [...]
  Test           this tree
  ------------------------------
  0000.1:        0.01(0.01+0.00)
  0000.2:        0.01(0.00+0.01)
  0000.4:        0.00(0.00+0.00)
  0000.5: true   0.00(0.00+0.00)
  0000.7:        0.00(0.00+0.00)
  0000.8:        0.00(0.00+0.00)

After this patch, we get the pre-5dccd9155f output:

  Test                                                       this tree
  --------------------------------------------------------------------------
  0000.1: test_perf_default_repo works                       0.00(0.00+0.00)
  0000.2: test_checkout_worktree works                       0.01(0.00+0.01)
  0000.4: export a weird var                                 0.00(0.00+0.00)
  0000.5: éḿíẗ ńöń-ÁŚĆÍÍ ćḧáŕáćẗéŕś                          0.00(0.00+0.00)
  0000.7: important variables available in subshells         0.00(0.00+0.00)
  0000.8: test-lib-functions correctly loaded in subshells   0.00(0.00+0.00)

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/perf-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index ab3687c28d..27c2801792 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -219,7 +219,7 @@ test_wrapper_ () {
 	then
 		base=$(basename "$0" .sh)
 		echo "$test_count" >>"$perf_results_dir"/$base.subtests
-		echo "$1" >"$perf_results_dir"/$base.$test_count.descr
+		echo "$test_title_" >"$perf_results_dir"/$base.$test_count.descr
 		base="$perf_results_dir"/"$PERF_RESULTS_PREFIX$(basename "$0" .sh)"."$test_count"
 		"$test_wrapper_func_" "$test_title_" "$@"
 	fi
-- 
2.37.0.rc0.352.g10876ef154
