Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2757D3F5
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600461; cv=none; b=QSXrwmjuu1dctNrxztzUq1OJ4IUVFe/2kPqlcVPWQLJH16HWLzATKf0IjR1TUtaM0EBUbhO+8wDJUCel2x0CJAXwpWas2wVuJ6pEj76lDJYCW2c0AQM8UfSFhOKZCbbUjKGvT1yrdGDM3UtX7QN6847qOkVW2nBLkfpQWBmTqbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600461; c=relaxed/simple;
	bh=8VFTy6kRh5gnKTt2YR6zZHc30VWofvqdm0madhiIJt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyhfCwukRTOBO+sy63iQnwz5MmeLZAhJ9c9IKPzdzsVGn49sBO9ln1ssUaq7J3nMTOHpCqkDOKPsz53MEXZoGclparhfurZAcJsSeCaQCzPIqKfhgoDb9GPjNkpnfzxITDIRtChBDsO0Dm4BF3EvK9l01tgEy0VZ1924iGKv564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 1614 invoked by uid 109); 10 Jul 2024 08:34:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jul 2024 08:34:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10372 invoked by uid 111); 10 Jul 2024 08:34:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Jul 2024 04:34:15 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Jul 2024 04:34:16 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 0/9] here-doc test bodies (now with 100% more chainlinting)
Message-ID: <20240710083416.GA2060328@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240701220815.GA20293@coredump.intra.peff.net>

On Mon, Jul 01, 2024 at 06:08:15PM -0400, Jeff King wrote:

> This is a re-post of an idea from 2021:
> 
>   https://lore.kernel.org/git/YHDUg6ZR5vu93kGm@coredump.intra.peff.net/
> 
> that people seemed mostly positive on, and I just never got around to
> following up. Mostly because it's not life-changing, but I think it is a
> small quality of life improvement, and it came up again recently in:
> 
>   https://lore.kernel.org/git/20240701032047.GA610406@coredump.intra.peff.net/
> 
> So I thought it was worth considering again.

And here's a v2 that addresses the chainlint issue mentioned by Eric.
There were a lot of patches flying around, but this is only the second
posting of the whole topic. This can replace all of what's in
jk/test-body-in-here-doc.

I bailed on trying to notice:

  test_expect_success 'oops, forgot the dash' <<\EOT

or:

  test_expect_success 'oops, forgot the here doc' -

or:

  test_expect_success <<\EOT 'here-doc tag comes first' -

As those all require some big refactoring ScriptParser::check_test(),
etc, and this topic has already grown quite a lot.

I won't bother with a range diff; patches 8 and 9 are just the original
v1 patches verbatim, and everything else is new.

  [1/9]: chainlint.pl: add test_expect_success call to test snippets

    Test refactoring for chainlint before we change it.

  [2/9]: chainlint.pl: only start threads if jobs > 1
  [3/9]: chainlint.pl: do not spawn more threads than we have scripts

    These two aren't strictly necessary, but some easy speedups I hit
    along the way (they depend on patch 1 for showing the speedup).

  [4/9]: chainlint.pl: force CRLF conversion when opening input files
  [5/9]: chainlint.pl: check line numbers in expected output

    These two make the chainlint tests more robust against the
    line-number bugs we hit while developing patch 6.

  [6/9]: chainlint.pl: recognize test bodies defined via heredoc

    This is Eric's fix (thanks!) for chainlint to recognize the new
    format, including the line-number fixes that we discussed.

  [7/9]: chainlint.pl: add tests for test body in heredoc

    And then I kept my tests of the new feature split into their own
    commit.

  [8/9]: test-lib: allow test snippets as here-docs
  [9/9]: t: convert some here-doc test bodies

    And then this is the actual purpose of the series. ;)

 t/Makefile                                    |  16 +-
 t/README                                      |   8 +
 t/chainlint-cat.pl                            |  29 +++
 t/chainlint.pl                                |  33 ++-
 t/chainlint/arithmetic-expansion.expect       |  18 +-
 t/chainlint/arithmetic-expansion.test         |   2 +
 t/chainlint/bash-array.expect                 |  20 +-
 t/chainlint/bash-array.test                   |   2 +
 t/chainlint/blank-line-before-esac.expect     |  36 ++--
 t/chainlint/blank-line-before-esac.test       |   2 +
 t/chainlint/blank-line.expect                 |  16 +-
 t/chainlint/blank-line.test                   |   2 +
 t/chainlint/block-comment.expect              |  16 +-
 t/chainlint/block-comment.test                |   2 +
 t/chainlint/block.expect                      |  46 ++--
 t/chainlint/block.test                        |   2 +
 t/chainlint/broken-chain.expect               |  12 +-
 t/chainlint/broken-chain.test                 |   2 +
 t/chainlint/case-comment.expect               |  22 +-
 t/chainlint/case-comment.test                 |   2 +
 t/chainlint/case.expect                       |  38 ++--
 t/chainlint/case.test                         |   2 +
 t/chainlint/chain-break-background.expect     |  18 +-
 t/chainlint/chain-break-background.test       |   2 +
 t/chainlint/chain-break-continue.expect       |  24 +--
 t/chainlint/chain-break-continue.test         |   2 +
 t/chainlint/chain-break-false.expect          |  18 +-
 t/chainlint/chain-break-false.test            |   2 +
 t/chainlint/chain-break-return-exit.expect    |  38 ++--
 t/chainlint/chain-break-return-exit.test      |   2 +
 t/chainlint/chain-break-status.expect         |  18 +-
 t/chainlint/chain-break-status.test           |   2 +
 t/chainlint/chained-block.expect              |  18 +-
 t/chainlint/chained-block.test                |   2 +
 t/chainlint/chained-subshell.expect           |  20 +-
 t/chainlint/chained-subshell.test             |   2 +
 .../close-nested-and-parent-together.expect   |   6 +-
 .../close-nested-and-parent-together.test     |   2 +
 t/chainlint/close-subshell.expect             |  52 ++---
 t/chainlint/close-subshell.test               |   2 +
 .../command-substitution-subsubshell.expect   |   4 +-
 .../command-substitution-subsubshell.test     |   2 +
 t/chainlint/command-substitution.expect       |  18 +-
 t/chainlint/command-substitution.test         |   2 +
 t/chainlint/comment.expect                    |  16 +-
 t/chainlint/comment.test                      |   2 +
 t/chainlint/complex-if-in-cuddled-loop.expect |  18 +-
 t/chainlint/complex-if-in-cuddled-loop.test   |   2 +
 t/chainlint/cuddled-if-then-else.expect       |  12 +-
 t/chainlint/cuddled-if-then-else.test         |   2 +
 t/chainlint/cuddled-loop.expect               |   8 +-
 t/chainlint/cuddled-loop.test                 |   2 +
 t/chainlint/cuddled.expect                    |  34 +--
 t/chainlint/cuddled.test                      |   2 +
 t/chainlint/double-here-doc.expect            |  24 +--
 t/chainlint/double-here-doc.test              |   2 +
 t/chainlint/dqstring-line-splice.expect       |  10 +-
 t/chainlint/dqstring-line-splice.test         |   2 +
 t/chainlint/dqstring-no-interpolate.expect    |  24 +--
 t/chainlint/dqstring-no-interpolate.test      |   2 +
 t/chainlint/empty-here-doc.expect             |   8 +-
 t/chainlint/empty-here-doc.test               |   2 +
 t/chainlint/exclamation.expect                |   8 +-
 t/chainlint/exclamation.test                  |   2 +
 t/chainlint/exit-loop.expect                  |  48 ++---
 t/chainlint/exit-loop.test                    |   2 +
 t/chainlint/exit-subshell.expect              |  10 +-
 t/chainlint/exit-subshell.test                |   2 +
 t/chainlint/for-loop-abbreviated.expect       |  10 +-
 t/chainlint/for-loop-abbreviated.test         |   2 +
 t/chainlint/for-loop.expect                   |  28 +--
 t/chainlint/for-loop.test                     |   2 +
 t/chainlint/function.expect                   |  22 +-
 t/chainlint/function.test                     |   2 +
 t/chainlint/here-doc-body-indent.expect       |   2 +
 t/chainlint/here-doc-body-indent.test         |   4 +
 t/chainlint/here-doc-body-pathological.expect |   7 +
 t/chainlint/here-doc-body-pathological.test   |   9 +
 t/chainlint/here-doc-body.expect              |   7 +
 t/chainlint/here-doc-body.test                |   9 +
 t/chainlint/here-doc-close-subshell.expect    |   8 +-
 t/chainlint/here-doc-close-subshell.test      |   2 +
 t/chainlint/here-doc-double.expect            |   2 +
 t/chainlint/here-doc-double.test              |  10 +
 t/chainlint/here-doc-indent-operator.expect   |  22 +-
 t/chainlint/here-doc-indent-operator.test     |   2 +
 .../here-doc-multi-line-command-subst.expect  |  16 +-
 .../here-doc-multi-line-command-subst.test    |   2 +
 t/chainlint/here-doc-multi-line-string.expect |  14 +-
 t/chainlint/here-doc-multi-line-string.test   |   2 +
 t/chainlint/here-doc.expect                   |  50 ++---
 t/chainlint/here-doc.test                     |   2 +
 t/chainlint/if-condition-split.expect         |  14 +-
 t/chainlint/if-condition-split.test           |   2 +
 t/chainlint/if-in-loop.expect                 |  24 +--
 t/chainlint/if-in-loop.test                   |   2 +
 t/chainlint/if-then-else.expect               |  44 ++--
 t/chainlint/if-then-else.test                 |   2 +
 t/chainlint/incomplete-line.expect            |  20 +-
 t/chainlint/incomplete-line.test              |   2 +
 t/chainlint/inline-comment.expect             |  16 +-
 t/chainlint/inline-comment.test               |   2 +
 t/chainlint/loop-detect-failure.expect        |  30 +--
 t/chainlint/loop-detect-failure.test          |   2 +
 t/chainlint/loop-detect-status.expect         |  36 ++--
 t/chainlint/loop-detect-status.test           |   2 +
 t/chainlint/loop-in-if.expect                 |  24 +--
 t/chainlint/loop-in-if.test                   |   2 +
 t/chainlint/loop-upstream-pipe.expect         |  20 +-
 t/chainlint/loop-upstream-pipe.test           |   2 +
 ...ti-line-nested-command-substitution.expect |  36 ++--
 ...ulti-line-nested-command-substitution.test |   2 +
 t/chainlint/multi-line-string.expect          |  28 +--
 t/chainlint/multi-line-string.test            |   2 +
 t/chainlint/negated-one-liner.expect          |  10 +-
 t/chainlint/negated-one-liner.test            |   2 +
 t/chainlint/nested-cuddled-subshell.expect    |  50 ++---
 t/chainlint/nested-cuddled-subshell.test      |   2 +
 t/chainlint/nested-here-doc.expect            |  60 +++---
 t/chainlint/nested-here-doc.test              |   2 +
 t/chainlint/nested-loop-detect-failure.expect |  62 +++---
 t/chainlint/nested-loop-detect-failure.test   |   2 +
 t/chainlint/nested-subshell-comment.expect    |  22 +-
 t/chainlint/nested-subshell-comment.test      |   2 +
 t/chainlint/nested-subshell.expect            |  26 +--
 t/chainlint/nested-subshell.test              |   2 +
 t/chainlint/not-heredoc.expect                |  28 +--
 t/chainlint/not-heredoc.test                  |   2 +
 t/chainlint/one-liner-for-loop.expect         |  18 +-
 t/chainlint/one-liner-for-loop.test           |   2 +
 t/chainlint/one-liner.expect                  |  18 +-
 t/chainlint/one-liner.test                    |   2 +
 t/chainlint/p4-filespec.expect                |   8 +-
 t/chainlint/p4-filespec.test                  |   2 +
 t/chainlint/pipe.expect                       |  20 +-
 t/chainlint/pipe.test                         |   2 +
 t/chainlint/return-loop.expect                |  10 +-
 t/chainlint/return-loop.test                  |   2 +
 t/chainlint/semicolon.expect                  |  38 ++--
 t/chainlint/semicolon.test                    |   2 +
 t/chainlint/sqstring-in-sqstring.expect       |   8 +-
 t/chainlint/sqstring-in-sqstring.test         |   2 +
 t/chainlint/subshell-here-doc.expect          |  60 +++---
 t/chainlint/subshell-here-doc.test            |   2 +
 t/chainlint/subshell-one-liner.expect         |  38 ++--
 t/chainlint/subshell-one-liner.test           |   2 +
 t/chainlint/t7900-subtree.expect              |  44 ++--
 t/chainlint/t7900-subtree.test                |   2 +
 t/chainlint/token-pasting.expect              |  54 ++---
 t/chainlint/token-pasting.test                |   2 +
 t/chainlint/unclosed-here-doc-indent.expect   |   8 +-
 t/chainlint/unclosed-here-doc-indent.test     |   2 +
 t/chainlint/unclosed-here-doc.expect          |  14 +-
 t/chainlint/unclosed-here-doc.test            |   2 +
 t/chainlint/while-loop.expect                 |  28 +--
 t/chainlint/while-loop.test                   |   2 +
 t/t0600-reffiles-backend.sh                   |  38 ++--
 t/t1404-update-ref-errors.sh                  | 196 +++++++++---------
 t/test-lib-functions.sh                       |  32 ++-
 159 files changed, 1285 insertions(+), 1025 deletions(-)
 create mode 100644 t/chainlint-cat.pl
 create mode 100644 t/chainlint/here-doc-body-indent.expect
 create mode 100644 t/chainlint/here-doc-body-indent.test
 create mode 100644 t/chainlint/here-doc-body-pathological.expect
 create mode 100644 t/chainlint/here-doc-body-pathological.test
 create mode 100644 t/chainlint/here-doc-body.expect
 create mode 100644 t/chainlint/here-doc-body.test
 create mode 100644 t/chainlint/here-doc-double.expect
 create mode 100644 t/chainlint/here-doc-double.test

