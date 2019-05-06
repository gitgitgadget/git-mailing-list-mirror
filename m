Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1DF71F45F
	for <e@80x24.org>; Mon,  6 May 2019 05:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfEFFH2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 01:07:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:48880 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725710AbfEFFH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 01:07:28 -0400
Received: (qmail 27528 invoked by uid 109); 6 May 2019 05:07:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 May 2019 05:07:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30157 invoked by uid 111); 6 May 2019 05:08:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 06 May 2019 01:08:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2019 01:07:26 -0400
Date:   Mon, 6 May 2019 01:07:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 1/2] archive: replace write_or_die() calls with
 write_block_or_die()
Message-ID: <20190506050726.GA30003@sigill.intra.peff.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <7a9525a78a7b7b237150b9264cf675a4a0b37267.1555110278.git.gitgitgadget@gmail.com>
 <20190413013451.GB2040@sigill.intra.peff.net>
 <xmqqzhouwizg.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1904261028220.45@tvgsbejvaqbjf.bet>
 <xmqqd0l8tjph.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1904291732370.45@tvgsbejvaqbjf.bet>
 <20190501180936.GB4109@sigill.intra.peff.net>
 <xmqqsgttsc9k.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgttsc9k.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 05, 2019 at 02:25:59PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > FWIW, I agree with you here. These patches are not making anything worse
> > (and may even make them better, since we'd probably need to swap out the
> > BLOCKSIZE constant for a run-time "blocksize" variable in fewer places).
> 
> It's just that leaving the interface uneven is an easy way to
> introduce an unnecessary bug, e.g.
> 
> 	-type function(args) {
> 	+type function(args, size_t blocksize) {
> 		decls;
> 	-	helper_one(BLOCKSIZE, other, args);
> 	+	helper_one(blocksize, other, args);
> 		helper_two(its, args);
> 	-	helper_three(BLOCKSIZE, even, more, args);
> 	+	helper_three(blocksize, even, more, args);
> 	 }
> 
> when this caller is away from the implementation of helper_two()
> that hardcodes the assumption that this callchain only uses
> BLOCKSIZE and in an implicit way.
> 
> And that can easily be avoided by defensively making helper_two() to
> take BLOCKSIZE as an argument as everybody else in the caller does.
> 
> I do not actually care too deeply, though.  Hopefully whoever adds
> "-b" would be careful enough to follow all callchain, and at least
> look at all the callees that are file-scope static, and the one I
> have trouble with _is_ a file-scope static.

Right, my assumption was that the first step in the conversion would be
somebody doing s/BLOCKSIZE/global_blocksize_variable/. But that is just
a guess.

> Or maybe nobody does "-b", in which case this ticking time bomb will
> not trigger, so we'd be OK.

Yes. I suspect we're probably going down an unproductive tangent. :)

-Peff
