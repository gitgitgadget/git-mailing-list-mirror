Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 260171F404
	for <e@80x24.org>; Mon, 27 Aug 2018 23:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeH1CtZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 22:49:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:58032 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727111AbeH1CtY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 22:49:24 -0400
Received: (qmail 8009 invoked by uid 109); 27 Aug 2018 23:00:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Aug 2018 23:00:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26773 invoked by uid 111); 27 Aug 2018 23:00:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 27 Aug 2018 19:00:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2018 19:00:40 -0400
Date:   Mon, 27 Aug 2018 19:00:40 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] fsck: use strbuf_getline() to read skiplist file
Message-ID: <20180827230040.GA10402@sigill.intra.peff.net>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
 <aaf03ba2-1369-2dc3-c3ec-739a1c56606e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaf03ba2-1369-2dc3-c3ec-739a1c56606e@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 25, 2018 at 08:50:28PM +0200, René Scharfe wrote:

> buffer is unlikely to contain a NUL character, so printing its contents
> using %s in a die() format is unsafe (detected with ASan).

Having mostly forgotten about our earlier discussion, I got confused by
this, thinking the problem was that there is some issue with missing
NULs in the input.

But it is really just:

  We read() into a buffer and on error format the contents using "%s".
  But read() does not NUL-terminate, so die() might walk past the end of
  the buffer.

We _might_ be saved by a NUL in the input, but that is not the primary
concern. ;)

Not worth a re-roll on its own, but since there is some other
discussion, I thought I'd mention my confusion. :)

> Added error check.
> Hopefully fixed my MUA config..
> 
>  fsck.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)

Patch itself looks good to me.

-Peff
