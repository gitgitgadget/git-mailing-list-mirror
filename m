Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2492C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15F220657
	for <git@archiver.kernel.org>; Mon, 18 May 2020 15:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgERPtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 11:49:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:49666 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728210AbgERPti (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 11:49:38 -0400
Received: (qmail 20263 invoked by uid 109); 18 May 2020 15:49:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 May 2020 15:49:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3331 invoked by uid 111); 18 May 2020 15:49:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2020 11:49:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 May 2020 11:49:37 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 5/6] remote-curl: error on incomplete packet
Message-ID: <20200518154937.GB41356@coredump.intra.peff.net>
References: <cover.1589393036.git.liu.denton@gmail.com>
 <3ed7cf87aaa40ee66b20aa929d89d28fefcec312.1589393036.git.liu.denton@gmail.com>
 <20200515213844.GD115445@coredump.intra.peff.net>
 <20200518090857.GA24557@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200518090857.GA24557@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 05:08:57AM -0400, Denton Liu wrote:

> > Hmm. Right now there's no assumption in rpc_in that we're writing
> > pktlines. Will this always be the case?
> > 
> > I think the answer is probably yes. If there's a case where it isn't, it
> > might be something like v0 git-over-http against a server which doesn't
> > have the sideband capability.
> 
> As far as I can tell from skimming the code, v0 uses always pktlines
> although I'm far from being an expert on Git's networking stuff. Perhaps
> we could implement this such that the line-length checking only happens
> for stateless_connect()?

Yeah, that would certainly limit the possibility of unintended side
effects (and I don't think there's any benefit to this patch for the
non-stateless-connect cases).

We'd still be locking stateless-connect into always using pktlines, but
I think that's probably OK in practice. AFAICT it's the case now, and I
doubt we'd have any desire to change it in the future (and if we do,
this is all local-ish code that we could modify).

One unfortunate thing about the protocol (but not new to your patch) is
that this will be a problem for _any_ remote-helper which claims to
support stateless-connect. So they'd all need to carry similar code to
deal with this issue. Right now remote-curl is the only one, but
probably git-remote-ext and git-remote-fd could support this, too. Those
are pretty exotic, though (I don't think anyone has even bothered to
make them support v2 yet).

-Peff
