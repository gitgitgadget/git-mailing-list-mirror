Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ACCC2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 22:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F7A2084D
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 22:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDJWPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 18:15:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:40364 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726582AbgDJWPt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 18:15:49 -0400
Received: (qmail 8613 invoked by uid 109); 10 Apr 2020 22:15:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Apr 2020 22:15:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3774 invoked by uid 111); 10 Apr 2020 22:26:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Apr 2020 18:26:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Apr 2020 18:15:49 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] config: reject parsing of files over INT_MAX
Message-ID: <20200410221549.GA2078378@coredump.intra.peff.net>
References: <20200410194211.GA1363484@coredump.intra.peff.net>
 <20200410195007.GF1363756@coredump.intra.peff.net>
 <xmqqzhbjgfps.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhbjgfps.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 10, 2020 at 03:04:31PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So given the fact that these are insane cases which we have no need to
> > support, the weird behavior from feeding the results to printf even if
> > the code is careful, and the possibility of uncareful code introducing
> > its own integer truncation issues, let's just declare INT_MAX as a limit
> > for parsing config files.
> 
> Makes sense.
> 
> > +	if (c != EOF && ++cf->total_len > INT_MAX) {
> 
> Would this work correctly if size_t is uint?  Sure, as int-max would
> fit within it.  And of course if size_t is wider than uint, there is
> no problem in this comparison.

Good question, but yeah, I think it's right.

Another method would be to do:

  if (cf->total_len >= INT_MAX)

_before_ reading any character. We'd have to remember to increment
total_len then (I suppose we could do it preemptively; as long as people
don't try to read EOF from us over and over again it would never move
again).

I also considered making the limit much lower than INT_MAX because
really, who needs even a 1GB config file? :)

-Peff
