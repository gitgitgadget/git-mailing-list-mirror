Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48E7B2035F
	for <e@80x24.org>; Tue, 25 Oct 2016 18:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753501AbcJYSeN (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 14:34:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:34055 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbcJYSeM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 14:34:12 -0400
Received: (qmail 11437 invoked by uid 109); 25 Oct 2016 18:33:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Oct 2016 18:33:50 +0000
Received: (qmail 3833 invoked by uid 111); 25 Oct 2016 18:34:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Oct 2016 14:34:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Oct 2016 14:33:48 -0400
Date:   Tue, 25 Oct 2016 14:33:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] hex: use unsigned index for ring buffer
Message-ID: <20161025183347.u3cvowf2h6tabtuw@sigill.intra.peff.net>
References: <ebf769d4-771f-499e-c7fc-f0377d8df18e@web.de>
 <20161023091146.p2kmqvgwxdf77dnn@sigill.intra.peff.net>
 <fb816dd5-8fb9-c6a6-2ec2-9ea4dddfdb26@web.de>
 <20161024130015.awlmgpfzixiy6wkb@sigill.intra.peff.net>
 <xmqqwpgx7jn6.fsf@gitster.mtv.corp.google.com>
 <xmqqshrl7j42.fsf@gitster.mtv.corp.google.com>
 <b1f9054e-fadb-c2d3-bf95-00e88e1fb85b@web.de>
 <xmqq60ohtib5.fsf@gitster.mtv.corp.google.com>
 <20161025003023.6vaqofsixana3zno@sigill.intra.peff.net>
 <xmqqd1ios2p3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqd1ios2p3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 11:28:40AM -0700, Junio C Hamano wrote:

> OK, here is what I'll queue then.
> I assumed that René wants to sign it off ;-).
> 
> -- >8 --
> From: René Scharfe <l.s.r@web.de>
> Date: Sun, 23 Oct 2016 19:57:30 +0200
> Subject: [PATCH] hex: make wraparound of the index into ring-buffer explicit
> 
> Overflow is defined for unsigned integers, but not for signed ones.
> 
> We could make the ring-buffer index in sha1_to_hex() and
> get_pathname() unsigned to be on the safe side to resolve this, but
> let's make it explicit that we are wrapping around at whatever the
> number of elements the ring-buffer has.  The compiler is smart enough
> to turn modulus into bitmask for these codepaths that use
> ring-buffers of a size that is a power of 2.

Looks good to me.

> diff --git a/path.c b/path.c
> index fe3c4d96c6..9bfaeda207 100644
> --- a/path.c
> +++ b/path.c
> @@ -24,7 +24,8 @@ static struct strbuf *get_pathname(void)
>  		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
>  	};
>  	static int index;
> -	struct strbuf *sb = &pathname_array[3 & ++index];
> +	struct strbuf *sb = &pathname_array[index];
> +	index = (index + 1) % ARRAY_SIZE(pathname_array);
>  	strbuf_reset(sb);
>  	return sb;

This converts the pre-increment to a post-increment, but I don't think
it matters.

-Peff
