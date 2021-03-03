Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5464C433E6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FBDC64F1D
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378493AbhCDAYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:24:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59226 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388054AbhCCUmH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 15:42:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C9EFBD944;
        Wed,  3 Mar 2021 15:41:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K/I+C3cyzRBx09mgUPEjiGMUrVk=; b=hxDzFx
        zGy66zUvYAlzBp8Qr5NB8JNmdOhg/W9QN6pznHScq2bUtJuHSb6ePjMNJ27BQDfs
        G8g5HOOXs5D194MNgd8waHFOn2Xzcot7MEMKu+Q08Sb8GTk3dadJF7jejjhyyA2E
        9UpnmIFina+RkRSIA74ai/+9W5mRCRYb5zguM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nUcO3IWkI1jpr9ret/wAnSoBFunjlBVq
        /F2CNc+3tSRMVcKY6Zn1fpJ95lNxKnZ9nOccX7riw0ivpNPVV4SD2qeDErnjTH4y
        f//sm8srIcU2S43cJSH4MEUBY7kiyCzsKauGQeDNaMUujxonAug6pR3Am4A2v9q9
        jPXveFQP1/g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 547F6BD943;
        Wed,  3 Mar 2021 15:41:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4189BD942;
        Wed,  3 Mar 2021 15:41:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 07/12] unix-socket: elimiate static
 unix_stream_socket() helper function
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
        <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
        <b368318e6a23f8c4e60f77a8b81b558c523d5b03.1613598529.git.gitgitgadget@gmail.com>
Date:   Wed, 03 Mar 2021 12:41:22 -0800
In-Reply-To: <b368318e6a23f8c4e60f77a8b81b558c523d5b03.1613598529.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Wed, 17 Feb 2021
        21:48:43 +0000")
Message-ID: <xmqqmtvkhswd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D17259A2-7C60-11EB-9754-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  int unix_stream_connect(const char *path)
>  {
> -	int fd, saved_errno;
> +	int fd = -1, saved_errno;
>  	struct sockaddr_un sa;
>  	struct unix_sockaddr_context ctx;
>  
>  	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
>  		return -1;
> -	fd = unix_stream_socket();
> +	fd = socket(AF_UNIX, SOCK_STREAM, 0);
> +	if (fd < 0)
> +		goto fail;
> +
>  	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
>  		goto fail;
>  	unix_sockaddr_cleanup(&ctx);
> @@ -87,15 +82,16 @@ int unix_stream_connect(const char *path)
>  
>  fail:
>  	saved_errno = errno;
> +	if (fd != -1)
> +		close(fd);
>  	unix_sockaddr_cleanup(&ctx);
> -	close(fd);
>  	errno = saved_errno;
>  	return -1;
>  }

So, the difference is that the caller must be prepared to see and
handle error return from this function when creating socket fails,
but existing callers must be prepared to handle error returns from
this function for different reasons (e.g. we may successfully make a
socket, but connect may fail) already anyway, so this should be a
fairly safe thing to do.  The sole caller send_request() in
credential-cache.c will relay the error return back to do_cache()
which cares what errno it got, and that code does seem to care what
kind of error caused unix_stream_connect() to fail.  And the new
error case introduced by this patch won't result in ENOENT or
ECONNREFUSED to cause the code to fall back to "if the thing is not
running, let's try starting it and try again".

OK.


>  int unix_stream_listen(const char *path)
>  {

This one is simpler to vet its caller.  It immediately dies upon any
error return.

Thanks.
