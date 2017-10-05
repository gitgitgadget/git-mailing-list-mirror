Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56C432036D
	for <e@80x24.org>; Thu,  5 Oct 2017 08:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbdJEIz5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 04:55:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:33206 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751315AbdJEIzz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 04:55:55 -0400
Received: (qmail 13837 invoked by uid 109); 5 Oct 2017 08:55:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 08:55:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25488 invoked by uid 111); 5 Oct 2017 08:55:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 04:55:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Oct 2017 04:55:53 -0400
Date:   Thu, 5 Oct 2017 04:55:53 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, git@jeffhostetler.com
Subject: Re: [PATCH v2 2/5] p0008-abbrev.sh: Test find_unique_abbrev() perf
Message-ID: <20171005085553.v3eqk73aaknt5fem@sigill.intra.peff.net>
References: <20170925095452.66833-1-dstolee@microsoft.com>
 <20170925095452.66833-3-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170925095452.66833-3-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 05:54:49AM -0400, Derrick Stolee wrote:

> Create helper program test-abbrev to compute the minimum length of a
> disambiguating short-sha for an input list of object ids.

This seems like something that Git ought to be able to do via real
commands.

Using "log --stdin --no-walk --format=%h" doesn't quite work, since it
only handles commits. We ought to be able to ask "cat-file" for this,
though. E.g., with the patch below you can do:

  git cat-file --batch-check='%(objectsize:short)' <input

Or even just dispense with your earlier randomization helper and do:

  git cat-file --batch-all-objects --batch-check='%(objectsize:short)'

to compute the abbreviation for every object.

> Perf test p0008-abbrev.sh runs test-abbrev for 100,000 object ids. For
> test 0008.1, these objects exist. For test 0008.2 these objects do not
> exist in the repo (with high probability). For each test, use `sort -R`
> to (deterministically) shuffle the sample of object ids to not check
> abbreviations in lexicographic order.

I know you're not the first to add a test like this, but I'm somewhat
negative on these sorts of micro-benchmark perf tests. They're nice for
showing off an improvement, but there's little indication of how they
impact things that users actually do.

We know that this series makes finding abbreviations cheaper. But how
much does it speed up "git log --oneline" on a real repository
(including absurdly-sized ones)?

-Peff
