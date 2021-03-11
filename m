Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BBCC433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 19:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C51064F1A
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 19:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCKT3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 14:29:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:60860 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhCKT3E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 14:29:04 -0500
Received: (qmail 16964 invoked by uid 109); 11 Mar 2021 19:29:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Mar 2021 19:29:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13061 invoked by uid 111); 11 Mar 2021 19:29:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Mar 2021 14:29:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Mar 2021 14:29:03 -0500
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
Message-ID: <YEpvfztZWhAvSDTL@coredump.intra.peff.net>
References: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
 <311ea4a5cd71c5dd2407348ad4608d2f7dd77ce5.1615302157.git.gitgitgadget@gmail.com>
 <xmqqblbrzy5j.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblbrzy5j.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 09, 2021 at 03:48:40PM -0800, Junio C Hamano wrote:

> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > +	/*
> > +	 * Write the header and the buffer in 2 parts so that we do not need
> > +	 * to allocate a buffer or rely on a static buffer.  This avoids perf
> > +	 * and multi-threading issues.
> > +	 */
> 
> I understand "multi-threading issues" (i.e. let's not have too much
> stuff on the stack), but what issue around "perf" are we worried
> about?
> 
> Even though we eliminate memcpy() from the original buffer to our
> temporary, this doubles the number of write(2) system calls used to
> write out packetised data, by the way.  I do not know if this results
> in measurable performance degradation, but hopefully we can fix it
> locally if it turns out to be a real problem later.

Yeah, this came from my suggestion. My gut feeling is that it isn't
likely to matter, but I'd much rather solve any performance problem we
find using writev(), which would be pretty easy to emulate with a
wrapper for systems that lack it.

-Peff
