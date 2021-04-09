Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62171C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D9146101D
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbhDIPxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:53:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:46338 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233577AbhDIPxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 11:53:25 -0400
Received: (qmail 31835 invoked by uid 109); 9 Apr 2021 15:53:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 15:53:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12559 invoked by uid 111); 9 Apr 2021 15:53:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 11:53:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 11:53:11 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 7/8] pack-bitmap: implement combined filter
Message-ID: <YHB4ZytlI8XI+4N1@coredump.intra.peff.net>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
 <fac3477d979058da0430b974a34f7c7f866bf456.1615813673.git.ps@pks.im>
 <YGygV1mesbJzdPr5@coredump.intra.peff.net>
 <YHAtDp11xFzdUSQl@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHAtDp11xFzdUSQl@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 12:31:42PM +0200, Patrick Steinhardt wrote:

> > Hmm. This is essentially reproducing the list in filter_bitmap() of
> > what's OK for bitmaps. So when adding a new filter, it would have to be
> > added in both places.
> > 
> > Can we preserve that property of the original code? I'd think that just
> > adding LOFC_COMBINE to filter_bitmap() would be sufficient. I.e., this
> > hunk:
> > 
> > > +	if (filter->choice == LOFC_COMBINE) {
> > > +		int i;
> > > +		for (i = 0; i < filter->sub_nr; i++) {
> > > +			filter_bitmap(bitmap_git, tip_objects, to_filter,
> > > +				      &filter->sub[i]);
> > > +		}
> > > +		return 0;
> > > +	}
> > 
> > ...except that we need to see if filter_bitmap() returns "-1" for any of
> > the recursive calls. Which we probably should be doing anyway to
> > propagate any errors (though I think the only "errors" we'd return are
> > "not supported", at least for now).
> > 
> > -Peff
> 
> But wouldn't that mean that we're now needlessly filtering via bitmaps
> all the way down the combined filters only to realize at the end that it
> cannot work because we've got a tree filter with non-zero tree depth?
> Granted, this will not be the common case. But it still feels like we're
> doing needless work for cases where we know that bitmaps cannot answer
> the query.

I don't think so. We first call can_filter_bitmap(filter), which passes
NULL for bitmap_git. And then in filter_bitmap(), we only do actual work
if bitmap_git is non-NULL.

This is the same thing that saves us from even loading the bitmaps
(which is itself a non-trivial amount of work) if the filter cannot be
satisfied by bitmaps.

-Peff
