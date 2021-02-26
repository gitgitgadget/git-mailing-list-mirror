Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26BEC433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 20:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7141464F0D
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 20:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBZUof (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:44:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:46512 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhBZUoe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 15:44:34 -0500
Received: (qmail 19008 invoked by uid 109); 26 Feb 2021 20:43:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Feb 2021 20:43:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25052 invoked by uid 111); 26 Feb 2021 20:43:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Feb 2021 15:43:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Feb 2021 15:43:52 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 01/12] pkt-line: eliminate the need for static buffer
 in packet_write_gently()
Message-ID: <YDldiMC6qx0z/NBf@coredump.intra.peff.net>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <2d6858b1625aa3c96688c6c6a9157c2d2b16f43e.1613598529.git.gitgitgadget@gmail.com>
 <YDihb2Kspbh4FIlW@coredump.intra.peff.net>
 <9304ac66-f493-2150-95e3-15303c914ee3@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9304ac66-f493-2150-95e3-15303c914ee3@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 26, 2021 at 02:52:22PM -0500, Jeff Hostetler wrote:

> > > -	if (fd >= 0)
> > > -		err = write_packetized_from_fd(fd, process->in);
> > > -	else
> > > +	if (fd >= 0) {
> > > +		struct packet_scratch_space scratch;
> > > +		err = write_packetized_from_fd(fd, process->in, &scratch);
> > > +	} else
> > >   		err = write_packetized_from_buf(src, len, process->in);
> > 
> > Isn't this just putting the buffer onto the stack anyway? Your
> > scratch_space struct is really just a big array. You'd want to make
> > it static here, but then we haven't really solved anything. :)
> 
> Yeah, I was letting the caller decide how to provide the buffer.
> They could put it on the stack or allocate it once across a whole
> set of files or use a static buffer -- the caller has context for
> what works best that we don't have here.  For example, the caller
> may know that is not in threaded code at all, but we cannot assume
> that here.

Yeah, I think it's successfully pushed the problem up to the caller. But
it introduced a _new_ problem in putting the large buffer on the stack.
So if this were "static struct packet_scratch_space scratch", I think
we'd be OK.

And perhaps that would meet your needs (if you just need to call
write_packed_from_fd() in a thread, and not this other caller).

But I do think the heap approach is nice in that it keeps the interface
clean, and I think the performance should be comparable.

> Right, I think it would be fine to malloc it here, but I didn't
> want to assume that everyone would think that.
> 
> I'll change it.

Thanks. :)

-Peff
