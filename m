Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE1EC83F2F
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 21:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347522AbjHaVU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 17:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347500AbjHaVUz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 17:20:55 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67A511B
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 14:20:52 -0700 (PDT)
Received: (qmail 25982 invoked by uid 109); 31 Aug 2023 21:20:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 21:20:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11582 invoked by uid 111); 31 Aug 2023 21:20:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 17:20:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 17:20:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 04/10] checkout-index: delay automatic setting of
 to_tempfile
Message-ID: <20230831212051.GD949469@coredump.intra.peff.net>
References: <20230831211637.GA949188@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831211637.GA949188@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using --stage=all requires writing to tempfiles, since we cannot put
multiple stages into a single file. So --stage=all implies --temp.

But we do this by setting to_tempfile in the options callback for
--stage, rather than after all options have been parsed. This leads to
two bugs:

  1. If you run "checkout-index --stage=all --stage=2", this should not
     imply --temp, but it currently does. The callback cannot just unset
     to_tempfile when it sees the "2" value, because it no longer knows
     if its value was from the earlier --stage call, or if the user
     specified --temp explicitly.

  2. If you run "checkout-index --stage=all --no-temp", the --no-temp
     will overwrite the earlier implied --temp. But this mode of
     operation cannot work, and the command will fail with "<path>
     already exists" when trying to write the higher stages.

We can fix both by lazily setting to_tempfile. We'll make it a tristate,
with -1 as "not yet given", and have --stage=all enable it only after
all options are parsed. Likewise, after all options are parsed we can
detect and reject the bogus "--no-temp" case.

Note that this does technically change the behavior for "--stage=all
--no-temp" for paths which have only one stage present (which
accidentally worked before, but is now forbidden). But this behavior was
never intended, and you'd have to go out of your way to try to trigger
it.

The new tests cover both cases, as well the general "--stage=all implies
--temp", as most of the other tests explicitly say "--temp". Ironically,
the test "checkout --temp within subdir" is the only one that _doesn't_
use "--temp", and so was implicitly covering this case. But it seems
reasonable to have a more explicit test alongside the other related
ones.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
---
One other bug-let I noticed in this function: it only looks at the first
byte of the stage argument, so "--stage=13" is the same as "--stage=1".
We could tighten this, but I wonder if anybody does something weird like
"--stage=2ours" or something. That seems pretty unlikely, but I'd still
prefer to do it as a separate patch (if at all).

 builtin/checkout-index.c       |  8 ++++++--
 t/t2004-checkout-cache-temp.sh | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index f62f13f2b5..6687a495ff 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -24,7 +24,7 @@
 static int nul_term_line;
 static int checkout_stage; /* default to checkout stage0 */
 static int ignore_skip_worktree; /* default to 0 */
-static int to_tempfile;
+static int to_tempfile = -1;
 static char topath[4][TEMPORARY_FILENAME_LENGTH + 1];
 
 static struct checkout state = CHECKOUT_INIT;
@@ -196,7 +196,6 @@ static int option_parse_stage(const struct option *opt,
 	BUG_ON_OPT_NEG(unset);
 
 	if (!strcmp(arg, "all")) {
-		to_tempfile = 1;
 		checkout_stage = CHECKOUT_ALL;
 	} else {
 		int ch = arg[0];
@@ -269,6 +268,11 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		state.base_dir = "";
 	state.base_dir_len = strlen(state.base_dir);
 
+	if (to_tempfile < 0)
+		to_tempfile = (checkout_stage == CHECKOUT_ALL);
+	if (!to_tempfile && checkout_stage == CHECKOUT_ALL)
+		die("--stage=all and --no-temp are incompatible");
+
 	/*
 	 * when --prefix is specified we do not want to update cache.
 	 */
diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
index b16d69ca4a..8eb2ef44eb 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -117,6 +117,26 @@ test_expect_success 'checkout all stages/one file to temporary files' '
 	test $(cat $s3) = tree3path1)
 '
 
+test_expect_success '--stage=all implies --temp' '
+	rm -f path* .merge_* actual &&
+	git checkout-index --stage=all -- path1 &&
+	test_path_is_missing path1
+'
+
+test_expect_success 'overriding --stage=all resets implied --temp' '
+	rm -f path* .merge_* actual &&
+	git checkout-index --stage=all --stage=2 -- path1 &&
+	echo tree2path1 >expect &&
+	test_cmp expect path1
+'
+
+test_expect_success '--stage=all --no-temp is rejected' '
+	rm -f path* .merge_* actual &&
+	test_must_fail git checkout-index --stage=all --no-temp -- path1 2>err &&
+	grep -v "already exists" err &&
+	grep "stage=all and --no-temp are incompatible" err
+'
+
 test_expect_success 'checkout some stages/one file to temporary files' '
 	rm -f path* .merge_* actual &&
 	git checkout-index --stage=all --temp -- path2 >actual &&
-- 
2.42.0.561.gaa987ecc69

