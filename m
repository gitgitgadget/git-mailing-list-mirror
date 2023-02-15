Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798C0C636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 19:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBOT7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 14:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBOT7w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 14:59:52 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9FE86B5
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 11:59:50 -0800 (PST)
Received: (qmail 14807 invoked by uid 109); 15 Feb 2023 19:59:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Feb 2023 19:59:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17625 invoked by uid 111); 15 Feb 2023 19:59:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Feb 2023 14:59:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Feb 2023 14:59:49 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     rsbecker@nexbridge.com, 'Git List' <git@vger.kernel.org>
Subject: Re: [Bug] Test 1450.91 Fails on NonStop
Message-ID: <Y+05tTHdj2Jzenge@coredump.intra.peff.net>
References: <000001d94165$3d1cf2f0$b756d8d0$@nexbridge.com>
 <Y+0eIlsIxRr+1RYp@coredump.intra.peff.net>
 <000801d9416e$4bf844b0$e3e8ce10$@nexbridge.com>
 <xmqqwn4iycbt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwn4iycbt.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2023 at 11:10:14AM -0800, Junio C Hamano wrote:

> > + test-tool genzeros 104857601
> > fatal: write(): Invalid function argument
> >
> > That explains it. We had to push the use of xwrite() because of
> > issues associated with writing large buffers exceeding through
> > write(). We could use MAX_IO_SIZE to limit the write size (at
> > least on NonStop) into acceptable chunks.
> 
> True.
> 
> Curious that this use of write(2) is from late 2021 and its uses in
> tests came from the same era (e.g. t1051 has two calls added in the
> same timeperiod).  So it is nothing new even to your platform, I
> suspect.

I think the latent problem was always there, but almost every call to
"test-tool genzeros" is gated on the EXPENSIVE prerequisite, and the
remainder are quite small. This is the first one that is always run, and
is bigger than the 256k buffer.

(This test actually _is_ kind of slow, so one might argue it should be
marked as EXPENSIVE, too, but obviously that is orthogonal).

> diff --git c/t/helper/test-genzeros.c w/t/helper/test-genzeros.c
> index 8ca988d621..9a1d3ee221 100644
> --- c/t/helper/test-genzeros.c
> +++ w/t/helper/test-genzeros.c
> @@ -17,12 +17,12 @@ int cmd__genzeros(int argc, const char **argv)
>  
>  	/* Writing out individual NUL bytes is slow... */
>  	while (count < 0)
> -		if (write(1, zeros, ARRAY_SIZE(zeros)) < 0)
> +		if (xwrite(1, zeros, ARRAY_SIZE(zeros)) < 0)
>  			return -1;

Sheesh. It even occurred to me with the big buffer that write limits
could be the problem, but I thought to myself, "no, we have MAX_IO_SIZE"
for that. The fact that this was write() and not xwrite() totally
escaped my notice. :)

So yeah, this seems like an obvious good fix. Using write_or_die() might
be even better, as it would report errors rather than quietly returning
non-zero.

We could also move test-tool away from the left-hand side of the pipe in
the test, which might have made this easier to diagnose. But not
significantly so, and it makes the test even less efficient than it
already is.

-Peff
