Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57584C352A3
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 06:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B012082F
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 06:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgBOGzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 01:55:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:44152 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725839AbgBOGzC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 01:55:02 -0500
Received: (qmail 25682 invoked by uid 109); 15 Feb 2020 06:55:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 15 Feb 2020 06:55:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26802 invoked by uid 111); 15 Feb 2020 07:03:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 15 Feb 2020 02:03:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 15 Feb 2020 01:55:00 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/15] rev-list: allow bitmaps when counting objects
Message-ID: <20200215065500.GC1633703@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182222.GG150965@coredump.intra.peff.net>
 <20200215004555.GB15192@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200215004555.GB15192@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 04:45:55PM -0800, Taylor Blau wrote:

> >  static int try_bitmap_count(struct rev_info *revs)
> >  {
> > -	uint32_t commit_count;
> > +	uint32_t commit_count = 0,
> > +		 tag_count = 0,
> > +		 tree_count = 0,
> > +		 blob_count = 0;
> 
> Hmm, I don't usually see the comma-separated declaration/initialization
> in git.git. Is there a reason you did it here? Not that I really mind
> one way or the other, just interested.

The variables are all related, and all should have the same type. I'd
complain about a patch that did:

  int ret, count;

because there's no logical reason those two variables have the same
type. They just happen to. And putting them both on the same line is
even worse, because it makes a diff changing one of them noisy.

But in the code quoted above, if one of them changes, they would all
(presumably) change. So I think it communicates something to group them
like this. That said, if we had a style guideline that strictly forbade
this (because it's often applied in _bad_ spots), I wouldn't be that
sad to convert it.

> > +	if (revs->max_count >= 0 &&
> > +	    (revs->tag_objects || revs->tree_objects || revs->blob_objects))
> 
> An aside unrelated to the patch at hand: the expression
> 
>   (revs->tag_objects || revs->tree_objects || revs->blob_objects)
> 
> does occur in an awful lot of places throughout this file. Do you
> imagine it'd be useful to pull this check out into its own function,
> perhaps as a preparatory patch in a later version of this series?
> 
> I'm also not fussed if you don't think that such a change would be
> useful, it's just an observation I had after seeing this expression a
> few times.

The most amusing part about it is that there's actually no way to
specify one type without the other. Most of the revision code tries to
be respectful of the fact that we might one day change that (though
there are some subtleties; e.g., asking for blobs but not trees would
still need to traverse the trees, but just not show them).

So this really could have been revs->objects. :) But I think given the
effort to treat them individually so far, it would be a step backwards
to switch now.

As far as whether there should be something like:

  int revs_show_objects(struct rev_info *revs)
  {
	return revs->tag_objects || revs->tree_objects || revs->blob_objects;
  }

I don't feel strongly either way. I find doing it inline perfectly
readable, but it's entirely possible my brain has been rotted by years
of looking at the revision code.

-Peff
