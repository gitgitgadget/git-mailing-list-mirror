Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E0F91FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 16:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750917AbdALQ4n (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 11:56:43 -0500
Received: from mail.nottheoilrig.com ([52.27.13.164]:60170 "EHLO
        mail.nottheoilrig.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdALQzE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 11:55:04 -0500
Received: from mail.nottheoilrig.com (localhost [127.0.0.1])
        by mail.nottheoilrig.com (Postfix) with ESMTP id AF6B920293
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 16:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nottheoilrig.com;
        s=3532ada; t=1484240103;
        bh=QyZi/Bbo2deIN42Q9NgQyb6lQwVDjtKhfAgJ7IrzC4A=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=QigcNlSWUplhSvjYOyGJVVk7muZckmot9ze8c1VrsMFWjs86Kz499AVuVL3b6K3pj
         kyKs7HTC8B844uXDNwMnTRXTmXligS2iBjKuFdOtzFBrqAHO2Vut9PozxaSyrSTAfN
         tZlf3jjpKX4wXGL6lUS1hqgmjT99MXJPFMAQu0uM=
Received: from [192.168.0.11] (S0106c8fb26402908.ek.shawcable.net [24.66.132.201])
        by mail.nottheoilrig.com (Postfix) with ESMTPSA;
        Thu, 12 Jan 2017 16:55:03 +0000 (UTC)
Subject: Re: [PATCH] imap-send.c: Avoid deprecated openssl 1.1.0 API
To:     eroen <git-scm@occam.eroen.eu>, git@vger.kernel.org
References: <20170112104219.563497-1-git-scm@occam.eroen.eu>
From:   Jack Bates <bk874k@nottheoilrig.com>
Message-ID: <66967e0e-8bd9-f4b6-d2d4-ccce9004f42e@nottheoilrig.com>
Date:   Thu, 12 Jan 2017 09:55:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20170112104219.563497-1-git-scm@occam.eroen.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You might need the following, to still build with LibreSSL.
That was my experience anyway, when I recently prepared similar fixes 
for OpenSSL 1.1 and Apache Traffic Server.

#if OPENSSL_VERSION_NUMBER < 0x10100000L || defined(LIBRESSL_VERSION_NUMBER)

On 12/01/17 03:42 AM, eroen wrote:
> Library initialization functions are deprecated in openssl 1.1.0 API, as
> initialization is handled by openssl internally.
>
> Symbols for deprecated functions are not exported if openssl is built with
> `--api=1.1 disable-deprecated`, so their use will cause a build failure.
>
> Reported-by: Lars Wendler (Polynomial-C)
>
> X-Gentoo-Bug: 592466
> X-Gentoo-Bug-URL: https://bugs.gentoo.org/show_bug.cgi?id=592466
> ---
>  imap-send.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/imap-send.c b/imap-send.c
> index 5c7e27a89..98774360e 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -284,8 +284,10 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
>  	int ret;
>  	X509 *cert;
>
> +#if OPENSSL_VERSION_NUMBER < 0x10100000L
>  	SSL_library_init();
>  	SSL_load_error_strings();
> +#endif
>
>  	meth = SSLv23_method();
>  	if (!meth) {
>
