Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2597A1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 15:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbeKMBkG (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 20:40:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:35910 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729925AbeKMBkG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 20:40:06 -0500
Received: (qmail 31626 invoked by uid 109); 12 Nov 2018 15:46:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 15:46:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12211 invoked by uid 111); 12 Nov 2018 15:45:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 10:45:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 10:46:17 -0500
Date:   Mon, 12 Nov 2018 10:46:17 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Geert Jansen <gerardu@amazon.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: Re: [PATCH 5/9] handle alternates paths the same as the main object
 dir
Message-ID: <20181112154617.GA6577@sigill.intra.peff.net>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112144935.GE7400@sigill.intra.peff.net>
 <56c50f51-5d9c-1166-75b9-418e384fc672@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56c50f51-5d9c-1166-75b9-418e384fc672@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 10:38:28AM -0500, Derrick Stolee wrote:

> > We could go either direction here, but this patch moves the alternates
> > struct over to the main directory style (rather than vice-versa).
> > Technically the alternates style is more efficient, as it avoids
> > rewriting the object directory name on each call. But this is unlikely
> > to matter in practice, as we avoid reallocations either way (and nobody
> > has ever noticed or complained that the main object directory is copying
> > a few extra bytes before making a much more expensive system call).
> 
> Hm. I've complained in the past [1] about a simple method like strbuf_addf()
> over loose objects, but that was during abbreviation checks so we were
> adding the string for every loose object but not actually reading the
> objects.
> 
> [1]
> https://public-inbox.org/git/20171201174956.143245-1-dstolee@microsoft.com/

I suspect that had more to do with the cost of snprintf() than the extra
bytes being copied. And here we'd still be using addstr and addch
exclusively. I'm open to numeric arguments to the contrary, though. :)

There's actually a lot of low-hanging fruit there for pre-sizing, too.
E.g., fill_sha1_path() calls strbuf_addch() in a loop, but it could
quite easily grow the 41 bytes it needs ahead of time. I wouldn't want
to change that without finding a measurable improvement, though. It
might not be a big deal due to fec501dae8 (strbuf_addch: avoid calling
strbuf_grow, 2015-04-16).

-Peff
