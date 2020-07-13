Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EA7C433E2
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CFC220720
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 20:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgGMUWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:22:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:56472 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbgGMUWM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 16:22:12 -0400
Received: (qmail 1066 invoked by uid 109); 13 Jul 2020 20:22:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Jul 2020 20:22:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26150 invoked by uid 111); 13 Jul 2020 20:22:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Jul 2020 16:22:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Jul 2020 16:22:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: FETCH_HEAD files and mirrored repos
Message-ID: <20200713202211.GA2355588@coredump.intra.peff.net>
References: <20200711204849.khfbyundun7ujqzw@chatter.i7.local>
 <xmqqimetrcay.fsf@gitster.c.googlers.com>
 <20200711211915.h5bdgmbkisyc23m3@chatter.i7.local>
 <xmqqblkkr63u.fsf@gitster.c.googlers.com>
 <20200712202502.x4p2c7rf6ctflt5g@chatter.i7.local>
 <xmqqr1tgpibi.fsf@gitster.c.googlers.com>
 <79a56e7b-3c31-80c0-6a8b-807dcb4d5af3@kdbg.org>
 <xmqqk0z7nxs7.fsf@gitster.c.googlers.com>
 <20200713200049.6a22nek4xckwtpt6@chatter.i7.local>
 <xmqqtuybmba1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuybmba1.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 13, 2020 at 01:04:54PM -0700, Junio C Hamano wrote:

> Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:
> 
> > Does it make sense to add logic for whether this is done in a bare repo?  
> > I can't imagine common cases where a FETCH_HEAD would be useful outside 
> > of a checkout where a merge is likely to happen.
> 
> It is entirely valid to respond to a one-shot "My work is published
> there; could you see if I am doing anything obviously wrong?" with
> 
>     git fetch git://k.org/somebody/linux.git check-me-please
>     git log ..FETCH_HEAD
>     git diff ...FETCH_HEAD
> 
> i.e. without touching any of our refs, and possibly in a bare
> repository, no?

I occasionally use FETCH_HEAD for such things. If we were to stop
writing it automatically, I think the key thing to notice is whether the
result was actually stored anywhere else. Or more accurately, whether
the user asked for any refspecs on the command line (since we'd still
update tracking refs in some cases).

If I do:

  git fetch

or:

  git fetch origin refs/heads/foo:refs/heads/foo

then I probably don't care about FETCH_HEAD. But if I do:

  git fetch origin refs/heads/foo

then I'm probably interested in picking the result out of FETCH_HEAD.

-Peff
