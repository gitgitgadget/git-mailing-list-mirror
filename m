Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C5772035F
	for <e@80x24.org>; Wed, 26 Oct 2016 04:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751029AbcJZEZ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 00:25:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:34177 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbcJZEZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 00:25:59 -0400
Received: (qmail 11388 invoked by uid 109); 26 Oct 2016 04:25:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Oct 2016 04:25:58 +0000
Received: (qmail 7048 invoked by uid 111); 26 Oct 2016 04:26:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Oct 2016 00:26:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Oct 2016 00:25:55 -0400
Date:   Wed, 26 Oct 2016 00:25:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with
 O_CLOEXEC
Message-ID: <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
 <20161025181621.4201-1-gitster@pobox.com>
 <20161025181621.4201-3-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161025181621.4201-3-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 11:16:20AM -0700, Junio C Hamano wrote:

> diff --git a/sha1_file.c b/sha1_file.c
> index 5d2bcd3ed1..09045df1dc 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1571,12 +1571,17 @@ int git_open(const char *name)
>  		if (fd >= 0)
>  			return fd;
>  
> -		/* Might the failure be due to O_NOATIME? */
> -		if (errno != ENOENT && sha1_file_open_flag) {
> -			sha1_file_open_flag = 0;
> +		/* Try again w/o O_CLOEXEC: the kernel might not support it */
> +		if ((sha1_file_open_flag & O_CLOEXEC) && errno == EINVAL) {
> +			sha1_file_open_flag &= ~O_CLOEXEC;
>  			continue;
>  		}

So if we start with O_CLOEXEC|O_NOATIME, we drop CLOEXEC here and try
again with just O_NOATIME. And then if _that_ fails...

> +		/* Might the failure be due to O_NOATIME? */
> +		if (errno != ENOENT && (sha1_file_open_flag & O_NOATIME)) {
> +			sha1_file_open_flag &= ~O_NOATIME;
> +			continue;
> +		}

We drop O_NOATIME, and end up with an empty flag field.

But we will never have tried just O_CLOEXEC, which might have worked.

Because of the order here, this would not be a regression (i.e., any
system that used to work will still eventually find a working comb), but
it does mean that systems without O_NOATIME do not get the benefit of
the new O_CLOEXEC protection.

Unfortunately, I think covering all of the cases would be 2^nr_flags.
That's only 4 right now, but it does not bode well as a pattern.

I'm not sure it's worth worrying about or not; I don't know which
systems are actually lacking either of the flags, or if they tend to
have both.

-Peff
