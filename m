Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69E732022D
	for <e@80x24.org>; Sun, 26 Feb 2017 18:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbdBZS5Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 13:57:24 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:41188 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751214AbdBZS5X (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Feb 2017 13:57:23 -0500
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ci40W-0004xC-Ba; Sun, 26 Feb 2017 19:57:20 +0100
Subject: Re: SHA1 collisions found
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <9cedbfa5-4095-15d8-639c-0e3b9b98d6b9@gmail.com>
 <20170224230604.nt37uw5y3uehukfd@sigill.intra.peff.net>
Cc:     Joey Hess <id@joeyh.name>, git@vger.kernel.org
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <8e98a9f9-a431-9170-df9d-24ad8ec59ed7@virtuell-zuhause.de>
Date:   Sun, 26 Feb 2017 19:57:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170224230604.nt37uw5y3uehukfd@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1488135443;9f845b72;
X-HE-SMSGID: 1ci40W-0004xC-Ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.02.2017 um 00:06 schrieb Jeff King:
> So we don't actually know how Git would behave in the face of a SHA-1
> collision. It would be pretty easy to simulate it with something like:
>
> ---
> diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
> index 22b125cf8..1be5b5ba3 100644
> --- a/block-sha1/sha1.c
> +++ b/block-sha1/sha1.c
> @@ -231,6 +231,16 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
>  		memcpy(ctx->W, data, len);
>  }
>  
> +/* sha1 of blobs containing "foo\n" and "bar\n" */
> +static const unsigned char foo_sha1[] = {
> +	0x25, 0x7c, 0xc5, 0x64, 0x2c, 0xb1, 0xa0, 0x54, 0xf0, 0x8c,
> +	0xc8, 0x3f, 0x2d, 0x94, 0x3e, 0x56, 0xfd, 0x3e, 0xbe, 0x99
> +};
> +static const unsigned char bar_sha1[] = {
> +	0x57, 0x16, 0xca, 0x59, 0x87, 0xcb, 0xf9, 0x7d, 0x6b, 0xb5,
> +	0x49, 0x20, 0xbe, 0xa6, 0xad, 0xde, 0x24, 0x2d, 0x87, 0xe6
> +};
> +
>  void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
>  {
>  	static const unsigned char pad[64] = { 0x80 };
> @@ -248,4 +258,8 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
>  	/* Output hash */
>  	for (i = 0; i < 5; i++)
>  		put_be32(hashout + i * 4, ctx->H[i]);
> +
> +	/* pretend "foo" and "bar" collide */
> +	if (!memcmp(hashout, bar_sha1, 20))
> +		memcpy(hashout, foo_sha1, 20);
>  }

While reading about the subject I came across [1]. The author reduced
the hash size to 4bits and then played around with git.

Diff taken from the posting (not my code)
--- git-2.7.0~rc0+next.20151210.orig/block-sha1/sha1.c
+++ git-2.7.0~rc0+next.20151210/block-sha1/sha1.c
@@ -246,6 +246,8 @@ void blk_SHA1_Final(unsigned char hashou
    blk_SHA1_Update(ctx, padlen, 8);

    /* Output hash */
-   for (i = 0; i < 5; i++)
-       put_be32(hashout + i * 4, ctx->H[i]);
+   for (i = 0; i < 1; i++)
+       put_be32(hashout + i * 4, (ctx->H[i] & 0xf000000));
+   for (i = 1; i < 5; i++)
+       put_be32(hashout + i * 4, 0);
 }

From a noob git-dev perspective this sounds more flexibel.

[1]: http://stackoverflow.com/a/34599081
