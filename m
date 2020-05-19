Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE146C433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 02:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4695206D4
	for <git@archiver.kernel.org>; Tue, 19 May 2020 02:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgESCiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 22:38:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:50490 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726302AbgESCiU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 22:38:20 -0400
Received: (qmail 22731 invoked by uid 109); 19 May 2020 02:38:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 May 2020 02:38:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8556 invoked by uid 111); 19 May 2020 02:38:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2020 22:38:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 May 2020 22:38:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/7] remote-curl: fix deadlocks when remote server
 disconnects
Message-ID: <20200519023819.GA70483@coredump.intra.peff.net>
References: <cover.1589393036.git.liu.denton@gmail.com>
 <cover.1589816718.git.liu.denton@gmail.com>
 <20200518165056.GD42240@coredump.intra.peff.net>
 <20200518173652.GB2462058@generichostname>
 <20200518205854.GB63978@coredump.intra.peff.net>
 <xmqqh7wc26v9.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7wc26v9.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 03:52:42PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So I think our options are probably:
> >
> >   1. detect flush packets in remote-curl, and either:
> >
> >      a. don't print an error, just hang up. That prevents a hang in the
> > 	caller and produces no extra message on a real error. It may be
> > 	less informative than it could be if the connection hangs up
> > 	(though we may print a curl error message, and the caller will
> > 	at least say "the helper hung up")
> >
> >      b. like (a), but always print an error; this is your original
> > 	patch, but I _suspect_ (but didn't test) that it would produce
> > 	extra useless messages for errors the server reports
> >
> >      c. between the two: inspect the final packet data for evidence of
> >         ERR/sideband 3 and suppress any message if found
> >
> >   2. helper signals end-of-response to caller (then it never produces a
> >      message itself; only the caller does, and it would abort on an ERR
> >      packet before then)
> >
> >      a. using a special pktline (your "0002" patch)
> >
> >      b. some other out-of-band mechanism (e.g., could be another fd)
> >
> > I think this is pushing me towards 2a, your "0002" patch. It sidesteps
> > the error-message questions entirely (and I think 2b is too convoluted
> > to be worth pursuing, especially on Windows where setting up extra pipes
> > is tricky). But I'd also be OK with 1a or 1c.
> 
> Thanks for a detailed analysis.  I guess we'd take 0002, then?

Yeah, that's how I lean. I think I did have a few comments on the patch
that I'd like Denton to consider, so hopefully we'll see a re-roll.

-Peff
