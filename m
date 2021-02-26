Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A4EC433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 07:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0590F64EC8
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 07:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhBZHWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 02:22:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:45630 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhBZHWD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 02:22:03 -0500
Received: (qmail 12289 invoked by uid 109); 26 Feb 2021 07:21:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Feb 2021 07:21:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16913 invoked by uid 111); 26 Feb 2021 07:21:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Feb 2021 02:21:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Feb 2021 02:21:19 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 01/12] pkt-line: eliminate the need for static buffer
 in packet_write_gently()
Message-ID: <YDihb2Kspbh4FIlW@coredump.intra.peff.net>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <2d6858b1625aa3c96688c6c6a9157c2d2b16f43e.1613598529.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d6858b1625aa3c96688c6c6a9157c2d2b16f43e.1613598529.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 09:48:37PM +0000, Jeff Hostetler via GitGitGadget wrote:

> Change the API of `write_packetized_from_fd()` to accept a scratch space
> argument from its caller to avoid similar issues here.

OK, but...

> diff --git a/convert.c b/convert.c
> index ee360c2f07ce..41012c2d301c 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -883,9 +883,10 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
>  	if (err)
>  		goto done;
>  
> -	if (fd >= 0)
> -		err = write_packetized_from_fd(fd, process->in);
> -	else
> +	if (fd >= 0) {
> +		struct packet_scratch_space scratch;
> +		err = write_packetized_from_fd(fd, process->in, &scratch);
> +	} else
>  		err = write_packetized_from_buf(src, len, process->in);

Isn't this just putting the buffer onto the stack anyway? Your
scratch_space struct is really just a big array. You'd want to make
it static here, but then we haven't really solved anything. :)

I think instead that:

> -int write_packetized_from_fd(int fd_in, int fd_out)
> +int write_packetized_from_fd(int fd_in, int fd_out,
> +			     struct packet_scratch_space *scratch)
>  {
> -	static char buf[LARGE_PACKET_DATA_MAX];
>  	int err = 0;
>  	ssize_t bytes_to_write;
>  
>  	while (!err) {
> -		bytes_to_write = xread(fd_in, buf, sizeof(buf));
> +		bytes_to_write = xread(fd_in, scratch->buffer,
> +				       sizeof(scratch->buffer));
>  		if (bytes_to_write < 0)
>  			return COPY_READ_ERROR;
>  		if (bytes_to_write == 0)
>  			break;
> -		err = packet_write_gently(fd_out, buf, bytes_to_write);
> +		err = packet_write_gently(fd_out, scratch->buffer,
> +					  bytes_to_write);
>  	}

...just heap-allocating the buffer in this function would be fine. It's
one malloc for the whole sequence of pktlines, which is unlikely to be a
problem.

-Peff
