Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E59971F404
	for <e@80x24.org>; Wed,  4 Apr 2018 19:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeDDTmv (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 15:42:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:53586 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751510AbeDDTmv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 15:42:51 -0400
Received: (qmail 19558 invoked by uid 109); 4 Apr 2018 19:42:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Apr 2018 19:42:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7435 invoked by uid 111); 4 Apr 2018 19:43:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 04 Apr 2018 15:43:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Apr 2018 15:42:49 -0400
Date:   Wed, 4 Apr 2018 15:42:49 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        avarab@gmail.com, sbeller@gmail.com, larsxschneider@gmail.com,
        bmwill@google.com
Subject: Re: [PATCH 7/6] ref-filter: use generation number for --contains
Message-ID: <20180404194248.GA14055@sigill.intra.peff.net>
References: <20180403190500.GA10930@sigill.intra.peff.net>
 <20180404154554.140716-1-dstolee@microsoft.com>
 <20180404182242.GA9055@sigill.intra.peff.net>
 <1cc07683-8d2e-e9fa-ffee-2663057704be@gmail.com>
 <20180404191657.GA13543@sigill.intra.peff.net>
 <fcded90f-cb12-dafd-f21a-18ea67e99406@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fcded90f-cb12-dafd-f21a-18ea67e99406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 04, 2018 at 03:22:01PM -0400, Derrick Stolee wrote:

> > I don't know that the reachability property is explicitly promised by
> > your work, but it seems like it would be a natural fallout (after all,
> > you have to know the generation of each ancestor in order to compute the
> > later ones, so you're really just promising that you've actually stored
> > all the ones you've computed).
> 
> The commit-graph is closed under reachability, so if a commit has a
> generation number then it is in the graph and so are all its ancestors.

OK, if we assume that it's closed, then I think we can effectively
ignore the UNDEF cases. They'll just work out. And then yes I'd agree
that the:

  if (cutoff == UNDEF)
    cutoff = NONE;

code is wrong. We'd want to keep it at UNDEF so we stop traversing at
any generation number.

> The reason for GENERATION_NUMBER_NONE is that the commit-graph file stores
> "0" for generation number until this patch. It still satisfies the condition
> that gen(A) < gen(B) if B can reach A, but also gives us a condition for
> "this commit still needs its generation number computed".

OK. I thought at first that would yield wrong results when comparing
UNDEF to NONE, but I think for this kind of --contains traversal, it's
still OK (NONE is less than UNDEF, but we know that the UNDEF thing
cannot be found by traversing from a NONE).

> > If you could make the reachability assumption, I think this question
> > just goes away. As soon as you hit a commit with _any_ generation
> > number, you could quit traversing down that path.
> That is the idea. I should make this clearer in all of my commit messages.

Yes, please. :) And maybe in the documentation of the file format, if
it's not there (I didn't check). It's a very useful property, and we
want to make sure people making use of the graph know they can depend on
it.

-Peff
