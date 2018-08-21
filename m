Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC1EC1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 21:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeHVAws (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 20:52:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:51040 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726628AbeHVAwr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 20:52:47 -0400
Received: (qmail 12390 invoked by uid 109); 21 Aug 2018 21:30:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Aug 2018 21:30:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27300 invoked by uid 111); 21 Aug 2018 21:31:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 Aug 2018 17:31:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2018 17:30:55 -0400
Date:   Tue, 21 Aug 2018 17:30:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 6/6] pack-objects: reuse on-disk deltas for thin "have"
 objects
Message-ID: <20180821213055.GC24431@sigill.intra.peff.net>
References: <20180821184140.GA24165@sigill.intra.peff.net>
 <20180821190705.GF30764@sigill.intra.peff.net>
 <xmqqin438pze.fsf@gitster-ct.c.googlers.com>
 <xmqqbm9v8pou.fsf@gitster-ct.c.googlers.com>
 <20180821200747.GA21955@sigill.intra.peff.net>
 <20180821201431.GA23263@sigill.intra.peff.net>
 <xmqq7ekj8msu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7ekj8msu.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 21, 2018 at 01:52:33PM -0700, Junio C Hamano wrote:

> > I think there really are two bugs here, though. The find_patch_start()
> > check is overly lax, but we also should not have to use it at all when
> > we know there is no patch.
> 
> Yes, I was grepping for callchains, and it appeared none of them
> actually expected us to feed "log plus --- plus patch" format.  The
> obvious candidate to take it is "am" but we ask mailinfo to do the
> splitting before the log message part even hits the rest of the
> system.  So my inclination right now is to see if that is truly the
> case and get rid of that bogus "patch start" thing, and if not, add
> a flag to let the caller say "I know we only have message" to the
> callchain.

I suspect this same logic is used by git-interpret-trailers, which is
taking an arbitrary message on stdin. That is probably the lone caller
that needs to retain this magic.

-Peff
