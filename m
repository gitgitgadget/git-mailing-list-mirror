Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB3631F954
	for <e@80x24.org>; Sat, 18 Aug 2018 23:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbeHSCbo (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 22:31:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:60070 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726506AbeHSCbn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 22:31:43 -0400
Received: (qmail 32515 invoked by uid 109); 18 Aug 2018 23:22:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 18 Aug 2018 23:22:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3934 invoked by uid 111); 18 Aug 2018 23:22:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 18 Aug 2018 19:22:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Aug 2018 19:22:21 -0400
Date:   Sat, 18 Aug 2018 19:22:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>, sunshine@sunshineco.com,
        git@vger.kernel.org
Subject: Re: Re* [PATCH v7 1/1] sideband: highlight keywords in remote
 sideband output
Message-ID: <20180818232220.GA24533@sigill.intra.peff.net>
References: <20180807125108.104293-1-hanwen@google.com>
 <20180807125108.104293-2-hanwen@google.com>
 <xmqqd0ugc07x.fsf@gitster-ct.c.googlers.com>
 <xmqq8t54bzo4.fsf_-_@gitster-ct.c.googlers.com>
 <20180818060911.GC241538@aiede.svl.corp.google.com>
 <xmqqmutjagc7.fsf@gitster-ct.c.googlers.com>
 <xmqqin47acir.fsf@gitster-ct.c.googlers.com>
 <xmqqa7pjabvn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7pjabvn.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 18, 2018 at 09:16:28AM -0700, Junio C Hamano wrote:

> -- >8 --
> Subject: [PATCH] sideband: do not read beyond the end of input
> 
> The caller of maybe_colorize_sideband() gives a counted buffer
> <src, n>, but the callee checked src[] as if it were a NUL terminated
> buffer.  If src[] had all isspace() bytes in it, we would have made
> n negative, and then
> 
>  (1) made number of strncasecmp() calls to see if the remaining
>      bytes in src[] matched keywords, reading beyond the end of the
>      array (this actually happens even if n does not go negative),
>      and/or
> 
>  (2) called strbuf_add() with negative count, most likely triggering
>      the "you want to use way too much memory" error due to unsigned
>      integer overflow.
> 
> Fix both issues by making sure we do not go beyond &src[n].

Thanks. I've been sporadically seeing "fatal: you want to use way too
much memory" the last few days while running 'next', and finally managed
to catch a reproducible case. This patch definitely fixes it.

> In the longer term we may want to accept size_t as parameter for
> clarity (even though we know that a sideband message we are painting
> typically would fit on a line on a terminal and int is sufficient).
> Write it down as a NEEDSWORK comment.

This "typically" made me nervous about what happens in the non-typical
case, but I think we can say something even stronger: the length comes
from a pktline, so the maximum is less than 16 bits. I wondered if we
might ever call this on the accumulated string from multiple sidebands,
but it doesn't look like it.

-Peff
