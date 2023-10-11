Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AF4CDB465
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 23:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjJKXbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 19:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJKXbY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 19:31:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222569E
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 16:31:23 -0700 (PDT)
Received: (qmail 20728 invoked by uid 109); 11 Oct 2023 23:31:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Oct 2023 23:31:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11362 invoked by uid 111); 11 Oct 2023 23:31:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Oct 2023 19:31:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Oct 2023 19:31:21 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/20] bounds-checks for chunk-based files
Message-ID: <20231011233121.GN518221@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <ZSb1QAaLX+xcZK4a@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZSb1QAaLX+xcZK4a@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2023 at 03:19:28PM -0400, Taylor Blau wrote:

> I reviewed this carefully (well, except for the new Perl script, for
> obvious[^1] reasons ;-)).
> 
> Everything mostly looks good to me, though I
> had a handful of review comments throughout. Many of them are trivial
> (e.g. a number of warning() and error() strings should be marked for
> translation, etc.), but a couple of them I think are worth looking at.

Thanks for taking a look. I think it may make sense to come back on top
and adjust a few of the commit messages, along with adding a few
st_mult() overflow checks that you suggest.

> Most notably, I think that by the end of the series, I was convinced
> that having some kind of 'pair_chunk_expectsz()' or similar would be
> useful and eliminate a good chunk of the boilerplate you have to write
> to check the chunk size against an expected value when using
> read_chunk().

This I'm less convinced by. In fact, I _almost_ just dropped
pair_chunk() entirely. Adding an out-parameter for the size at least
forces the caller to consider what to do with the size. But really, I
think the right mindset is "we should be sanity-checking this chunk as
we load it". And having a callback, even if it is a little bit of
boilerplate, helps set that frame of mind.

I dunno. Maybe that is all just programmer pseudo-psychology. But I also
don't like that about half the calls to pair_chunk() can't do a size
check (so we need two functions, or to make the "expect" parameter
optional).

-Peff
