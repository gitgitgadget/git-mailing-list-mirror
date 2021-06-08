Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B146EC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 22:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 800EB61246
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 22:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhFHWJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 18:09:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:49634 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhFHWJL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 18:09:11 -0400
Received: (qmail 32455 invoked by uid 109); 8 Jun 2021 22:07:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jun 2021 22:07:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15125 invoked by uid 111); 8 Jun 2021 22:07:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Jun 2021 18:07:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Jun 2021 18:07:16 -0400
From:   Jeff King <peff@peff.net>
To:     Greg Hurrell <greg@hurrell.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] gitweb: use HEAD as primary sort key in
 git_get_heads_list()
Message-ID: <YL/qFDPoF/0+ArAV@coredump.intra.peff.net>
References: <f04ffea4-ff37-432a-a0c6-abe11721060b@www.fastmail.com>
 <20210608211440.37985-1-greg@hurrell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210608211440.37985-1-greg@hurrell.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 08, 2021 at 11:14:40PM +0200, Greg Hurrell wrote:

> Prior to this commit, the "heads" section on a gitweb summary page would
> list the heads in `-committerdate` order (ie. the most recently-modified
> ones at the top), tie-breaking equal-dated refs using the implicit
> `refname` sort fallback.
> 
> This commit adds another `--sort` parameter to the `git for-each-ref`
> invocation in `git_get_heads_list()`, ensuring that the `HEAD` ref
> always ends up getting sorted to the top, seeing as it is typically the
> "primary" line of development in some sense.
> 
> This seems to be a useful change, because I can't see anywhere else in
> the gitweb UI where we actually indicate to the user what the "default"
> branch is (ie. what they'll checkout if they run `git clone`).

Your use of "seems" in the final paragraph is a leftover from the
earlier commit message, and I think weakens your message. It's OK to
assert that it really _is_ a useful change, I would say. :)

This patch looks good to me overall. In addition to dropping the RFC
tag, you're more likely to get attention by having a subject line
without "Re:" in it (so people realize it's a patch to look at, and not
just a continuation of the discussion).

> On Tue, Jun 8, 2021, at 11:02 AM, Greg Hurrell wrote:
> > On Tue, Jun 8, 2021, at 10:34 AM, Jeff King wrote:
> > >   1. break ties by name, like:
> > > 
> > >        git for-each-ref --sort=refname --sort=-committerdate
> > > 
> > >   2. emphasize the HEAD branch, even if it isn't the newest:
> > > 
> > >        git for-each-ref --sort=refname --sort=-committerdate --sort=-HEAD
> 
> I was wracking my brains over this one trying to figure out why
> it wasn't already doing the right thing based on what I see in
> ref-filter.c.  It sure looks like the `--sort=refname` fallback should
> be automatic, but I wasn't seeing it happen in my gitweb instance.
> 
> Turns out there was a bug that you fixed in 7c5045fc180ed09ed4cb5 which
> made it in soon after v2.20.4 fixing a problem. I was seeing different
> behavior on gitweb running on Amazon Linux AMI, because that's still
> using Git v2.18.5.

Heh, OK. I almost suggested "gee, wouldn't it be nice if we used the
refname as a fallback tie-breaker by default". You'd think I would
either remember such fixes, or at least bother to look at the code. :)

> So, that means "1" isn't necessary. "2" is the only possibly interesting
> bit. I've reworded the commit text accordingly, still labeled as "RFC"
> to see if there is any consensus on this being a good idea or not.

Yep, I agree on all counts.

In my experience gitweb doesn't tend to get a lot of interest from
reviewers, and I consider it mostly in maintenance mode these days. So
be prepared for silence. In that case, I'd give it a few days and repost
the patch to see if Junio is interested in picking it up.

-Peff
