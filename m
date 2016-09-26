Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90E81207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 17:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161935AbcIZRfp (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 13:35:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:48208 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161776AbcIZRfn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 13:35:43 -0400
Received: (qmail 6104 invoked by uid 109); 26 Sep 2016 17:35:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 17:35:43 +0000
Received: (qmail 6729 invoked by uid 111); 26 Sep 2016 17:35:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 13:35:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 13:35:41 -0400
Date:   Mon, 26 Sep 2016 13:35:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
        Gustavo Grieco <gustavo.grieco@imag.fr>
Subject: Re: [PATCH] unpack_sha1_header(): detect malformed object header
Message-ID: <20160926173540.j4rxcks3pmdcyvtd@sigill.intra.peff.net>
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr>
 <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com>
 <xmqqshsnuvvz.fsf_-_@gitster.mtv.corp.google.com>
 <20160926140309.l2h4b65gpqyutepn@sigill.intra.peff.net>
 <xmqqfuomvdqe.fsf@gitster.mtv.corp.google.com>
 <xmqqshsmtvju.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshsmtvju.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 10:33:57AM -0700, Junio C Hamano wrote:

> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Mon, 26 Sep 2016 09:23:41 -0700
> Subject: [PATCH 1/2] streaming: make sure to notice corrupt object
> 
> The streaming read interface from a loose object called
> parse_sha1_header() but discarded its return value, without noticing
> a potential error.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  streaming.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/streaming.c b/streaming.c
> index 811fcc2..884a8f1 100644
> --- a/streaming.c
> +++ b/streaming.c
> @@ -347,7 +347,8 @@ static open_method_decl(loose)
>  		return -1;
>  	}
>  
> -	parse_sha1_header(st->u.loose.hdr, &st->size);
> +	if (parse_sha1_header(st->u.loose.hdr, &st->size) < 0)
> +		return -1;

Do you have to git_inflate_end() and munmap() here, as the error path
above does (this was missing from my patch, too)?

-Peff
