Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E53E1FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 21:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753012AbdLHVRK (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 16:17:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:52896 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752255AbdLHVRI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 16:17:08 -0500
Received: (qmail 29881 invoked by uid 109); 8 Dec 2017 21:17:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 21:17:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6210 invoked by uid 111); 8 Dec 2017 21:17:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 16:17:30 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 16:17:06 -0500
Date:   Fri, 8 Dec 2017 16:17:06 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] fmt-merge-msg: avoid leaking strbuf in shortlog()
Message-ID: <20171208211706.GB7355@sigill.intra.peff.net>
References: <b2238da3-9eba-1521-f4ca-3b805f103555@web.de>
 <xmqq4lp2cisd.fsf@gitster.mtv.corp.google.com>
 <20171208101455.GC1899@sigill.intra.peff.net>
 <1654a696-73d5-c9ef-0fc2-bd82aaf2cabb@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1654a696-73d5-c9ef-0fc2-bd82aaf2cabb@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 08, 2017 at 06:29:34PM +0100, René Scharfe wrote:

> > By the way, I think there's another quite subtle leak in this function.
> > We do this:
> > 
> >    format_commit_message(commit, "%s", &sb, &ctx);
> >    strbuf_ltrim(&sb);
> > 
> > and then only use "sb" if sb.len is non-zero. But we may have actually
> > allocated to create our zero-length string (e.g., if we had a strbuf
> > full of spaces and trimmed them all off). Since we reuse "sb" over and
> > over as we loop, this will actually only leak once for the whole loop,
> > not once per iteration. So it's probably not a big deal, but writing it
> > with the explicit reset/release pattern fixes that (and is more
> > idiomatic for our code base, I think).
> 
> It's subtle, but I think it's not leaking, at least not in your example
> case (and I can't think of another way).  IIUC format_subject(), which
> handles the "%s" part, doesn't touch sb if the subject is made up only
> of whitespace.

Yeah, I suspected that may be the case. But IMHO it is a poor use of
strbufs if you have to dig that far to see whether the code leaks or
not. The whole point of strbufs is to make string handling and memory
ownership more obviously correct.

Just skimming the history, I think it's mostly an artifact of the
function was slowly converted over the years.

-Peff
