Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45485C352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 22:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AD621734
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 22:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgBMWeJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:34:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:42894 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726780AbgBMWeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 17:34:09 -0500
Received: (qmail 17608 invoked by uid 109); 13 Feb 2020 22:34:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Feb 2020 22:34:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17309 invoked by uid 111); 13 Feb 2020 22:43:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Feb 2020 17:43:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Feb 2020 17:34:07 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 09/13] rev-list: use bitmap filters for traversal
Message-ID: <20200213223407.GB25317@coredump.intra.peff.net>
References: <20200213021506.GA1124607@coredump.intra.peff.net>
 <20200213022125.GI1126038@coredump.intra.peff.net>
 <xmqqblq2qga8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblq2qga8.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 13, 2020 at 02:22:07PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This just passes the filter-options struct to prepare_bitmap_walk().
> > Since the bitmap code doesn't actually support any filters yet, it will
> > fallback to the non-bitmap code if any --filter is specified. But this
> > lets us exercise that rejection code path, as well as getting us ready
> > to test filters via rev-list when we _do_ support them.
> 
> So we used to look at filter_options.choice and declared any filter
> is incompatible with use_bitmap_index quite early, but now we let
> each of the try_bitmap_*() helpers check what is in the filter and
> make their own decisions.
> 
> Of course, the prepare_bitmap_walk() call at the beginning of these
> helpers does not know how to work with any filter at this point in
> the series, so all of the above cancel out :-).
> 
> Makes sense.
> 
> I wonder if the "revs.prune" thing that forces use_bitmap_index off
> should also move to prepare_bitmap_walk() at some point in the
> series (or after the current series is done).  After all, the point
> of introducing try_bitmap_*() helpers was to let these bitmap
> specific logic to know what is and is not compatible with the bitmap
> routines.

Ah, interesting thought. Yeah, we could push it down to that level to
avoid rev-list having to know details about how the bitmap code works.
That could replace the earlier patch to consolidate the filter/prune
logic. And then in this patch, this hunk:

> > @@ -612,7 +614,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
> >  	    (revs.left_right || revs.cherry_mark))
> >  		die(_("marked counting is incompatible with --objects"));
> >  
> > -	if (filter_options.choice || revs.prune)
> > +	if (revs.prune)
> >  		use_bitmap_index = 0;

would just drop this conditional entirely. I like it.

-Peff
