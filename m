Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57136C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjC1U2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjC1U2W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:28:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE6A4222
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:28:21 -0700 (PDT)
Received: (qmail 1984 invoked by uid 109); 28 Mar 2023 20:28:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 20:28:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1844 invoked by uid 111); 28 Mar 2023 20:28:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 16:28:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 16:28:19 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: [PATCH 3/4] tests: drop here-doc check from internal chain-linter
Message-ID: <20230328202819.GC1241631@coredump.intra.peff.net>
References: <20230328202043.GA1241391@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328202043.GA1241391@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 99a64e4b73c (tests: lint for run-away here-doc, 2017-03-22)
tweaked the chain-lint test to catch unclosed here-docs. It works by
adding an extra "echo" command after the test snippet, and checking that
it is run (if it gets swallowed by a here-doc, naturally it is not run).

The downside here is that we introduced an extra $() substitution, which
happens in a subshell. This has a measurable performance impact when
run for many tests.

The tradeoff in safety was undoubtedly worth it when 99a64e4b73c was
written. But these days, the external chainlint.pl does a pretty good
job of finding these (even though it's not something it specifically
tries to flag). For example, if you have a test like:

	test_expect_success 'should fail linter' '
	        some_command >actual &&
	        cat >expect <<-\EOF &&
		ok
		# missing EOF line here
	        test_cmp expect actual
	'

it will see that the here-doc isn't closed, treat it as not-a-here-doc,
and complain that the "ok" line does not have an "&&". So in practice we
should be catching these via that linter, although:

  - the error message is not as good as it could be (the real problem is
    the unclosed here-doc)

  - it can be fooled if there are no lines in the here-doc:

      cat >expect <<-\EOF &&
      # missing EOF line here

    or if every line in the here-doc has &&-chaining (weird, but
    possible)

Those are sufficiently unlikely that they're not worth worrying too much
about. And by switching back to a simpler chain-lint, hyperfine reports
a measurable speedup on t3070 (which has 1800 tests):

  'HEAD' ran
    1.12 ± 0.01 times faster than 'HEAD~1'

Signed-off-by: Jeff King <peff@peff.net>
---
I didn't look at how hard it would be to teach chainlint.pl to complain
about the unclosed here-doc. I think it _might_ actually not be that
bad, just because it does already understand here-docs in general. If it
handled that, then all of the hand-waving in the second half of the
commit message could go away. ;)

I'd also be OK dropping this. 12% is nice, but this one test is an
outlier. Picking t4202 somewhat at random as a more realistic test, any
improvement seems to be mostly lost in the noise.

 t/test-lib.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index cfcbd899c5a..0048ec7b6f6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1101,9 +1101,10 @@ test_run_ () {
 		trace=
 		# 117 is magic because it is unlikely to match the exit
 		# code of other programs
-		if test "OK-117" != "$(test_eval_ "fail_117 && $1${LF}${LF}echo OK-\$?" 3>&1)"
+		test_eval_ "fail_117 && $1"
+		if test $? != 117
 		then
-			BUG "broken &&-chain or run-away HERE-DOC: $1"
+			BUG "broken &&-chain: $1"
 		fi
 		trace=$trace_tmp
 	fi
-- 
2.40.0.616.gf524ec75088

