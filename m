Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EEDC432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 23:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2E220684
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 23:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfLCXUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:20:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:37884 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727576AbfLCXUI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 18:20:08 -0500
Received: (qmail 18012 invoked by uid 109); 3 Dec 2019 23:20:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Dec 2019 23:20:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20432 invoked by uid 111); 3 Dec 2019 23:24:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Dec 2019 18:24:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Dec 2019 18:20:07 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Patrick Marlier (pamarlie)" <pamarlie@cisco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] send-pack: use OBJECT_INFO_QUICK to check negative
 objects
Message-ID: <20191203232007.GA30535@sigill.intra.peff.net>
References: <CH2PR11MB429411CA1288526D21C7AF26CF4C0@CH2PR11MB4294.namprd11.prod.outlook.com>
 <20191127123211.GG22221@sigill.intra.peff.net>
 <xmqqr21p2sxb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr21p2sxb.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 30, 2019 at 09:08:32AM -0800, Junio C Hamano wrote:

> > Interestingly, upload-pack does not use OBJECT_INFO_QUICK when it's
> > getting oids from the other side. But I think it could possibly benefit
> > in the same way. Nobody seems to have noticed. Perhaps it simply comes
> > up less, as servers would tend to have more objects than their clients?
> 
> Makes me wonder how many times we wre bitten by the fact that
> INFO_SKIP_FETCH_OBJECT does not imply INFO_QUICK.  Perhaps most of
> the users of INFO_SKIP_FETCH_OBJECT wants to use INFO_FOR_PREFETCH?

We seem to be discussing this about once a month lately. :)

There's some good digging by Jonathan in:

  https://public-inbox.org/git/20191011220822.154063-1-jonathantanmy@google.com/

That thread is also about this exact same spot, which is why I cc'd him
originally.

I do tend to think that QUICK ought to imply SKIP_FETCH. I'm slightly
negative on sprinkling FOR_PREFETCH everywhere, because the name implies
to me that we are telling object_info() that we are pre-fetching. Which
yes, has the effect we want, but I think is misleading. So we'd want to
change the name of the combined flag, I think, or just let QUICK imply
SKIP_FETCH and use that more thoroughly.

-Peff
