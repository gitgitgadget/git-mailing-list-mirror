Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20B9A20958
	for <e@80x24.org>; Tue, 28 Mar 2017 06:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754537AbdC1Gvv (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 02:51:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:52765 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754462AbdC1Gvu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 02:51:50 -0400
Received: (qmail 24074 invoked by uid 109); 28 Mar 2017 06:51:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 06:51:25 +0000
Received: (qmail 13800 invoked by uid 111); 28 Mar 2017 06:51:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 02:51:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 02:51:23 -0400
Date:   Tue, 28 Mar 2017 02:51:23 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/21] builtin/receive-pack: fix incorrect pointer
 arithmetic
Message-ID: <20170328065123.f4uswxxznv3wyqaz@sigill.intra.peff.net>
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
 <20170326160143.769630-7-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170326160143.769630-7-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 26, 2017 at 04:01:28PM +0000, brian m. carlson wrote:

> If we had already processed the last newline in a push certificate, we
> would end up subtracting NULL from the end-of-certificate pointer when
> computing the length of the line.  This would have resulted in an
> absurdly large length, and possibly a buffer overflow.  Instead,
> subtract the beginning-of-certificate pointer from the
> end-of-certificate pointer, which is what's expected.
> 
> Note that this situation should never occur, since not only do we
> require the certificate to be newline terminated, but the signature will
> only be read from the beginning of a line.  Nevertheless, it seems
> prudent to correct it.

I think you can trigger it with carefully-crafted input. Try this on the
client side:

diff --git a/send-pack.c b/send-pack.c
index 66e652f7e..dd18c9a33 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -311,8 +311,7 @@ static int generate_push_cert(struct strbuf *req_buf,
 	if (!update_seen)
 		goto free_return;
 
-	if (sign_buffer(&cert, &cert, signing_key))
-		die(_("failed to sign the push certificate"));
+	strbuf_rtrim(&cert);
 
 	packet_buf_write(req_buf, "push-cert%c%s", 0, cap_string);
 	for (cp = cert.buf; cp < cert.buf + cert.len; cp = np) {

We omit the signature entirely, which causes the parser to treat the
end of the string as the end-of-cert (we still find the end because the
push-cert-end is in its own pkt-line; you could also just issue a flush,
which has the same effect).

And then the rtrim means that the cert doesn't actually end in a
newline. Running t5534 with this patch causes receive-pack to segfault.
It's not an overflow on writing the buffer, though; the nonsense size is
passed into a FLEX_ALLOC_MEM(). In my test case, I ended up allocating a
1.4GB buffer (which just happened to be the mod-2^32 residue of my "eoc"
pointer), and the segfault comes from trying to read an unallocated
page.

So I don't think it's exploitable in any interesting way.

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index feafb076a4..116f3177a1 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1524,7 +1524,7 @@ static void queue_commands_from_cert(struct command **tail,
>  
>  	while (boc < eoc) {
>  		const char *eol = memchr(boc, '\n', eoc - boc);
> -		tail = queue_command(tail, boc, eol ? eol - boc : eoc - eol);
> +		tail = queue_command(tail, boc, eol ? eol - boc : eoc - boc);
>  		boc = eol ? eol + 1 : eoc;
>  	}
>  }

The patch itself is obviously an improvement. It may be worth graduating
separately from the rest of the series.

-Peff
