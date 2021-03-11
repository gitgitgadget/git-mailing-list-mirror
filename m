Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EADC433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 20:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEAA364F8C
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 20:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhCKUyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 15:54:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:32774 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhCKUx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 15:53:57 -0500
Received: (qmail 17622 invoked by uid 109); 11 Mar 2021 20:53:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Mar 2021 20:53:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13823 invoked by uid 111); 11 Mar 2021 20:53:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Mar 2021 15:53:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Mar 2021 15:53:56 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 01/12] pkt-line: eliminate the need for static buffer
 in packet_write_gently()
Message-ID: <YEqDZP/Ea+qf0Qrp@coredump.intra.peff.net>
References: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
 <311ea4a5cd71c5dd2407348ad4608d2f7dd77ce5.1615302157.git.gitgitgadget@gmail.com>
 <xmqqblbrzy5j.fsf@gitster.c.googlers.com>
 <YEpvfztZWhAvSDTL@coredump.intra.peff.net>
 <xmqq4khhctya.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4khhctya.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 12:32:29PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Mar 09, 2021 at 03:48:40PM -0800, Junio C Hamano wrote:
> >
> >> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >> 
> >> > +	/*
> >> > +	 * Write the header and the buffer in 2 parts so that we do not need
> >> > +	 * to allocate a buffer or rely on a static buffer.  This avoids perf
> >> > +	 * and multi-threading issues.
> >> > +	 */
> >> 
> >> I understand "multi-threading issues" (i.e. let's not have too much
> >> stuff on the stack), but what issue around "perf" are we worried
> >> about?
> >>  ...
> > Yeah, this came from my suggestion. My gut feeling is that it isn't
> > likely to matter, but I'd much rather solve any performance problem we
> > find using writev(), which would be pretty easy to emulate with a
> > wrapper for systems that lack it.
> 
> I too had writev() in mind when I said "can fix it locally", so we
> are on the same page, which is good.
> 
> So "this avoid multi-threading issues" without mentioning "perf and"
> would be more appropriate?

IMHO yes. I think "avoid perf issues" is probably answering the "why not
just heap-allocate the buffer" question. But that makes sense in the
commit message, not in a comment.

-Peff
