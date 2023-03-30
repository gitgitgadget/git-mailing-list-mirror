Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE06C7619A
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 19:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjC3T1W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 15:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjC3T1V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 15:27:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B05DBDB
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 12:27:14 -0700 (PDT)
Received: (qmail 31251 invoked by uid 109); 30 Mar 2023 19:27:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Mar 2023 19:27:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20465 invoked by uid 111); 30 Mar 2023 19:27:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Mar 2023 15:27:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Mar 2023 15:27:12 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: [PATCH v2 0/5] some chainlint fixes and performance improvements
Message-ID: <20230330192712.GA27719@coredump.intra.peff.net>
References: <20230328202043.GA1241391@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328202043.GA1241391@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 04:20:44PM -0400, Jeff King wrote:

> Here are a few fixes for chainlint.

And here's a re-roll.

As before, I think the first patch is the most important, and the rest
are optimizations. But with Eric's patch to chainlint.pl in the middle,
I think the argument for patch 4 (previously patch 3) is much stronger.

Patch 5 remains mostly a cleanup, with no performance improvement. IMHO
the result is easier to follow, but I'm open to arguments to the
contrary.

  [1/5]: tests: run internal chain-linter under "make test"
  [2/5]: tests: replace chainlint subshell with a function
  [3/5]: tests: diagnose unclosed here-doc in chainlint.pl
  [4/5]: tests: drop here-doc check from internal chain-linter
  [5/5]: tests: skip test_eval_ in internal chain-lint

 t/Makefile                                  |  4 +--
 t/chainlint.pl                              | 15 +++++++++---
 t/chainlint/unclosed-here-doc-indent.expect |  4 +++
 t/chainlint/unclosed-here-doc-indent.test   |  4 +++
 t/chainlint/unclosed-here-doc.expect        |  7 ++++++
 t/chainlint/unclosed-here-doc.test          |  7 ++++++
 t/test-lib.sh                               | 27 +++++++++++----------
 7 files changed, 50 insertions(+), 18 deletions(-)
 create mode 100644 t/chainlint/unclosed-here-doc-indent.expect
 create mode 100644 t/chainlint/unclosed-here-doc-indent.test
 create mode 100644 t/chainlint/unclosed-here-doc.expect
 create mode 100644 t/chainlint/unclosed-here-doc.test

Range-diff:

1:  19deb7195df ! 1:  d536d3b9ec0 tests: run internal chain-linter under "make test"
    @@ Commit message
     
      ## t/Makefile ##
     @@ t/Makefile: CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
    + 
      # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
      # checks all tests in all scripts via a single invocation, so tell individual
    - # scripts not to "chainlint" themselves
    +-# scripts not to "chainlint" themselves
     -CHAINLINTSUPPRESS = GIT_TEST_CHAIN_LINT=0 && export GIT_TEST_CHAIN_LINT &&
    ++# scripts not to run the external "chainlint.pl" script themselves
     +CHAINLINTSUPPRESS = GIT_TEST_EXT_CHAIN_LINT=0 && export GIT_TEST_EXT_CHAIN_LINT &&
      
      all: $(DEFAULT_TEST_TARGET)
2:  a05c440dde5 = 2:  fa29c781fca tests: replace chainlint subshell with a function
-:  ----------- > 3:  c1a3ec3619e tests: diagnose unclosed here-doc in chainlint.pl
3:  46556678938 ! 4:  b5dc3618c83 tests: drop here-doc check from internal chain-linter
    @@ Commit message
         run for many tests.
     
         The tradeoff in safety was undoubtedly worth it when 99a64e4b73c was
    -    written. But these days, the external chainlint.pl does a pretty good
    -    job of finding these (even though it's not something it specifically
    -    tries to flag). For example, if you have a test like:
    -
    -            test_expect_success 'should fail linter' '
    -                    some_command >actual &&
    -                    cat >expect <<-\EOF &&
    -                    ok
    -                    # missing EOF line here
    -                    test_cmp expect actual
    -            '
    -
    -    it will see that the here-doc isn't closed, treat it as not-a-here-doc,
    -    and complain that the "ok" line does not have an "&&". So in practice we
    -    should be catching these via that linter, although:
    -
    -      - the error message is not as good as it could be (the real problem is
    -        the unclosed here-doc)
    -
    -      - it can be fooled if there are no lines in the here-doc:
    -
    -          cat >expect <<-\EOF &&
    -          # missing EOF line here
    -
    -        or if every line in the here-doc has &&-chaining (weird, but
    -        possible)
    -
    -    Those are sufficiently unlikely that they're not worth worrying too much
    -    about. And by switching back to a simpler chain-lint, hyperfine reports
    -    a measurable speedup on t3070 (which has 1800 tests):
    +    written. But since the external chainlint.pl learned to find these
    +    recently, we can just rely on it. By switching back to a simpler
    +    chain-lint, hyperfine reports a measurable speedup on t3070 (which has
    +    1800 tests):
     
           'HEAD' ran
             1.12 ± 0.01 times faster than 'HEAD~1'
4:  f810780d326 = 5:  0ebf1da8b93 tests: skip test_eval_ in internal chain-lint

