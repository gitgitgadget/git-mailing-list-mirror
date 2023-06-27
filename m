Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3849BC001B3
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 07:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjF0Hae (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 03:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjF0HaK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 03:30:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F3D10DA
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 00:30:08 -0700 (PDT)
Received: (qmail 30415 invoked by uid 109); 27 Jun 2023 07:30:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jun 2023 07:30:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14652 invoked by uid 111); 27 Jun 2023 07:30:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jun 2023 03:30:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jun 2023 03:30:07 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        vdye@github.com, me@ttaylorr.com, mjcheetham@outlook.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/2] for-each-ref: add --count-matches option
Message-ID: <20230627073007.GD1226768@coredump.intra.peff.net>
References: <pull.1548.git.1687792197.gitgitgadget@gmail.com>
 <9121e027fb9f157878a9624ce6c834b69cd38472.1687792197.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9121e027fb9f157878a9624ce6c834b69cd38472.1687792197.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 26, 2023 at 03:09:57PM +0000, Derrick Stolee via GitGitGadget wrote:

> +for pattern in "refs/heads/" "refs/tags/" "refs/remotes"
> +do
> +	test_perf "count $pattern: git for-each-ref | wc -l" "
> +		git for-each-ref $pattern | wc -l
> +	"
> +
> +	test_perf "count $pattern: git for-each-ref --count-match" "
> +		git for-each-ref --count-matches $pattern
> +	"
> +done

I don't think this is a very realistic perf test, because for-each-ref
is doing a bunch of work to generate its default format, only to have
"wc" throw most of it away. Doing:

  git for-each-ref --format='%(refname)' | wc -l

is much better (obviously you have to remember to do that if you care
about optimizing your command, but that's true of --count-matches, too).

Running hyperfine with three variants shows that the command above is
competitive with --count-matches, though slightly slower (hyperfine
complains about short commands and outliers because these runtimes are
so tiny in the first place; I omitted those warnings from the output
below for readability):

  Benchmark 1: ./git-for-each-ref refs/remotes/ | wc -l
    Time (mean ± σ):       6.1 ms ±   0.2 ms    [User: 3.0 ms, System: 3.6 ms]
    Range (min … max):     5.6 ms …   7.1 ms    397 runs
  
  Benchmark 2: ./git-for-each-ref --format="%(refname)" refs/remotes/ | wc -l
    Time (mean ± σ):       3.3 ms ±   0.2 ms    [User: 2.2 ms, System: 1.5 ms]
    Range (min … max):     3.0 ms …   4.0 ms    774 runs
  
  Benchmark 3: ./git-for-each-ref --count-matches refs/remotes/
    Time (mean ± σ):       2.4 ms ±   0.1 ms    [User: 1.5 ms, System: 0.9 ms]
    Range (min … max):     2.2 ms …   3.4 ms    1018 runs
  
  Summary
    './git-for-each-ref --count-matches refs/remotes/' ran
      1.33 ± 0.10 times faster than './git-for-each-ref --format="%(refname)" refs/remotes/ | wc -l'
      2.48 ± 0.17 times faster than './git-for-each-ref refs/remotes/ | wc -l'

I will note this is an unloaded multi-core system, which gives the piped
version a slight edge. Total CPU is probably more interesting than
wall-clock time, but all of these are so short that I think the results
should be taken with a pretty big grain of salt (I had to switch from
the "powersave" to "performance" CPU governor just to get more
consistent results).

-Peff
