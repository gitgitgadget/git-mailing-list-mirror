Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BC0B1F453
	for <e@80x24.org>; Thu,  2 May 2019 16:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEBQ6F (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 12:58:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:47184 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726120AbfEBQ6F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 12:58:05 -0400
Received: (qmail 19640 invoked by uid 109); 2 May 2019 16:58:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 May 2019 16:58:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1200 invoked by uid 111); 2 May 2019 16:58:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 May 2019 12:58:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 May 2019 12:58:03 -0400
Date:   Thu, 2 May 2019 12:58:03 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Aleksey Midenkov <midenok@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug: fatal: Unable to create '.../.git/index.lock': File exists.
Message-ID: <20190502165802.GA19341@sigill.intra.peff.net>
References: <CAF8BazDu_GqoCPBQ-gEJ+q8n1aWSjf_TOV7bDE5VCQkDgBjyfQ@mail.gmail.com>
 <CAF8BazA-VYFns7o9F7gXfFZCspbM0yQKi+LQ+BnkpGH+EjPC9A@mail.gmail.com>
 <CACsJy8DSW2f3v1KpU-QrAz-EeLwG4mVm9ToDdA2=kXSmtsEAYw@mail.gmail.com>
 <CAF8BazBShg9F2uCuVQ_PM6196kOUNWOA1T9APkCXCoey7as2mQ@mail.gmail.com>
 <20190430174110.GA16729@sigill.intra.peff.net>
 <CAF8BazBBP53uhh+oOroFuVCEL-FaqJheSYX5Q5_NQxGRt=g_xA@mail.gmail.com>
 <20190501183638.GF4109@sigill.intra.peff.net>
 <CAF8BazAK_s89XY8-AAsSSbgOFgP03CLRZ50bLGPsc89bfnN7kQ@mail.gmail.com>
 <20190502150701.GA14906@sigill.intra.peff.net>
 <CACsJy8Dimn9+ogDNEgy3xmLunyX_pStBq=g-1jrf74LsOW1xrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Dimn9+ogDNEgy3xmLunyX_pStBq=g-1jrf74LsOW1xrA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 02, 2019 at 11:38:51PM +0700, Duy Nguyen wrote:

> > Since the decision of whether to use the locks is dependent on the
> > operation being performed, it's an environment variable and not a config
> > option.
> 
> And there's also tradeoff for doing it. If git-status will not take
> locks, it cannot update the index to save refresh information and
> reuse the next time. git-status may become more and more expensive
> over time (*). Setting a config variable for this does not sound like
> a good idea at all. The same for setting GIT_OPTIONAL_LOCKS=0 in
> ~/.bashrc to "fix" the problem once and for all.

Right. I suspect in the long run it might not be _too_ bad to run with
such a setting, because any non-read operations would eventually refresh
the index (and as you note even many read-only operations like porcelain
git-diff unconditionally refresh for now).

But I agree it's not really the direction we want to go.

> I might take a stab at the "wait and try to hold the lock again, doing
> necessary verification after if needed" idea. It sounds like the right
> way to go and we haven't had problems with refs doing the same thing
> (have we?).

No, but it's a bit easier with refs because the locking is just
atomically checking the lease. I.e., after taking the lock we still say
"we expected the ref to be at oid XYZ, is it still there?". What's the
equivalent for an index operation?

I think it is more common with the index to take the lock, then while
holding it read it in fresh (possibly dumping old results), manipulate
the result, and then write it out. For callers which make sure to
get a fresh view _after_ taking the lock, they should be OK if taking
the lock is delayed.

I guess arguably any callers that aren't that careful are already
broken, since it is a race; any delay-and-retry _could_ have happened as
"we were too slow to see the initial lock".

-Peff
