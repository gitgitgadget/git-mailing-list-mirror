Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B30081FADF
	for <e@80x24.org>; Sat, 13 Jan 2018 07:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750951AbeAMHOx (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 02:14:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:42928 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750732AbeAMHOw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 02:14:52 -0500
Received: (qmail 20924 invoked by uid 109); 13 Jan 2018 07:14:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Jan 2018 07:14:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5288 invoked by uid 111); 13 Jan 2018 07:15:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 13 Jan 2018 02:15:26 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Jan 2018 02:14:50 -0500
Date:   Sat, 13 Jan 2018 02:14:50 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 3/7] trace.c: move strbuf_release() out of
 print_trace_line()
Message-ID: <20180113071450.GA27251@sigill.intra.peff.net>
References: <20180112095607.18293-1-pclouds@gmail.com>
 <20180113064949.6043-1-pclouds@gmail.com>
 <20180113064949.6043-4-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180113064949.6043-4-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 13, 2018 at 01:49:45PM +0700, Nguyễn Thái Ngọc Duy wrote:

> The function is about printing a trace line, not releasing the buffer it
> receives too. Move strbuf_release() back outside. This makes it easier
> to see how strbuf is managed.

This is kind of a funny refactor, in that it makes the code longer. :)
I think it does make things a bit more obvious, though.

> diff --git a/trace.c b/trace.c
> index 9784915be1..7f3b08e148 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -131,7 +131,6 @@ static void print_trace_line(struct trace_key *key, struct strbuf *buf)
>  {
>  	strbuf_complete_line(buf);
>  	trace_write(key, buf->buf, buf->len);
> -	strbuf_release(buf);
>  }

One mental note: any print_trace_line() calls for topics in flight need
to be adjusted, or they will leak. Probably OK for a static function
(and I don't see any in pu, nor git-for-windows, nor do I have any in my
private stash of patches).

-Peff
