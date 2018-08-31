Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CB971F404
	for <e@80x24.org>; Fri, 31 Aug 2018 22:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeIADFj (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 23:05:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:35978 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727637AbeIADFj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 23:05:39 -0400
Received: (qmail 4720 invoked by uid 109); 31 Aug 2018 22:56:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 31 Aug 2018 22:56:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10138 invoked by uid 111); 31 Aug 2018 22:56:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 31 Aug 2018 18:56:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 31 Aug 2018 18:55:58 -0400
Date:   Fri, 31 Aug 2018 18:55:58 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] pack-bitmap: save "have" bitmap from walk
Message-ID: <20180831225558.GA22917@sigill.intra.peff.net>
References: <20180821184140.GA24165@sigill.intra.peff.net>
 <20180821190701.GE30764@sigill.intra.peff.net>
 <8736uud0gq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736uud0gq.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 05:23:17PM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Tue, Aug 21 2018, Jeff King wrote:
> 
> > +int bitmap_has_sha1_in_uninteresting(struct bitmap_index *bitmap_git,
> > +				     const unsigned char *sha1)
> > +{
> > +	int pos;
> > +
> > +	if (!bitmap_git)
> > +		return 0; /* no bitmap loaded */
> > +	if (!bitmap_git->result)
> > +		BUG("failed to perform bitmap walk before querying");
> 
> Some part of what calls this completely breaks pushing from the "next"
> branch when you have local bitmaps (we *really* should have some tests
> for this...).

Yikes, thanks for reporting. I agree we need better tests here.

This assertion is totally bogus, as traverse_bitmap_commit_list() will
actually free (and NULL) the result field! This is a holdover from the
original bitmap code, where bitmap_git was a static, and this is how you
might prepare a second walk (though AFAIK only ever do one walk per
process). These days prepare_bitmap_walk() actually returns a fresh
bitmap_index struct.

So there's no way to know if traverse_bitmap_commit_list() was called.
But as it turns out, we don't care. We want to know if
"bitmap_git->have" was set up, which is done in prepare_bitmap_walk().
So there's no way[1] to get a bitmap_git that hasn't been properly set
up. This BUG() check can just go away.

I'll prepare a patch and some tests later tonight.

-Peff

[1] Actually, there is also prepare_bitmap_git(), but it is not really
    for general use by callers. It should be made static, or better yet,
    I suspect it can be folded into its callers.
