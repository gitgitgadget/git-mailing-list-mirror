Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 078D61F731
	for <e@80x24.org>; Tue,  6 Aug 2019 12:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfHFM5B (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 08:57:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:35220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728560AbfHFM5B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 08:57:01 -0400
Received: (qmail 16742 invoked by uid 109); 6 Aug 2019 12:57:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Aug 2019 12:57:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1508 invoked by uid 111); 6 Aug 2019 12:59:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Aug 2019 08:59:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Aug 2019 08:56:59 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] config: work around bug with includeif:onbranch
 and early config
Message-ID: <20190806125659.GA18442@sigill.intra.peff.net>
References: <pull.300.git.gitgitgadget@gmail.com>
 <pull.300.v2.git.gitgitgadget@gmail.com>
 <ea1a746113b85bde5319c410f68fe3dc75f8a328.1564603600.git.gitgitgadget@gmail.com>
 <20190731220204.GA1933@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1908010004130.21907@tvgsbejvaqbjf.bet>
 <20190731231257.GB1933@sigill.intra.peff.net>
 <20190801004928.GA6351@sigill.intra.peff.net>
 <7f4257d3-5ae0-3a83-84f1-bee83682fa36@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f4257d3-5ae0-3a83-84f1-bee83682fa36@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 01, 2019 at 01:24:17PM -0400, Jeff Hostetler wrote:

> > By the way, I wondered why trace2's existing config reading did not
> > cause us to segfault because of this. It is because it invented the
> > "very early config" function which always ignores some config sources
> > (working around this problem, but also making it weirdly unlike most
> > other config).
> 
> Yes, I added the "very early config" to try to work around some of
> the chicken-n-egg problems.  I can't say that I was completely happy
> with having to do that.

I meant to comment a little further on this earlier. While I do think
it's unfortunate to have yet another set of special rules, I think what
you ended up with is probably the least-bad thing.  This trace2 config
read is happening so early (even after my movement patch) that it makes
me nervous to do anything at all complicated.

Not just for performance reasons, which you cited in the original
commit, but also for correctness and even security reasons.  This is
code we're running for every single binary before we even hit main(),
and it's probably a good thing that we are not loading .git/config
values from a potentially untrusted repository (e.g., upload-pack is
supposed to be safe to run in an untrusted repo).

-Peff
