Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D4591F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 20:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfJ2UdB (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 16:33:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:33306 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725840AbfJ2UdA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 16:33:00 -0400
Received: (qmail 2642 invoked by uid 109); 29 Oct 2019 20:33:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Oct 2019 20:33:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12803 invoked by uid 111); 29 Oct 2019 20:36:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Oct 2019 16:36:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Oct 2019 16:32:59 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] vreportf(): avoid relying on stdio buffering
Message-ID: <20191029203259.GB12337@sigill.intra.peff.net>
References: <pull.428.v2.git.1572356272.gitgitgadget@gmail.com>
 <pull.428.v3.git.1572379280.gitgitgadget@gmail.com>
 <fce0894ee46f737322551b51edf5cd2a53413a50.1572379280.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fce0894ee46f737322551b51edf5cd2a53413a50.1572379280.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 29, 2019 at 08:01:20PM +0000, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/usage.c b/usage.c
> index 2fdb20086b..471efb2de9 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -9,14 +9,21 @@
>  void vreportf(const char *prefix, const char *err, va_list params)
>  {
>  	char msg[4096];
> -	char *p;
> +	size_t off = strlcpy(msg, prefix, sizeof(msg));
> +	char *p, *pend = msg + sizeof(msg);
>  
> -	vsnprintf(msg, sizeof(msg), err, params);
> -	for (p = msg; *p; p++) {
> +	p = off < pend - msg ? msg + off : pend - 1;
> +	if (vsnprintf(p, pend - p, err, params) < 0)
> +		*p = '\0'; /* vsnprintf() failed, clip at prefix */
> +
> +	for (; p != pend - 1 && *p; p++) {
>  		if (iscntrl(*p) && *p != '\t' && *p != '\n')
>  			*p = '?';
>  	}

This version looks OK to me. Some bikeshedding:

  - I suspect it may be more readable to just stick to offsets instead
    of pointers, since that's what strlcpy() and vsnprintf() give us.

  - I don't think "p == pend - 1" can ever trigger, since either
    vsnprintf() or we will have just written a NUL.

  - Do we need to contend with vsnprintf() return a negative value in
    general in our codebase? We already BUG() on it elsewhere. Yes, that
    BUG() would try to write via this code path, but it implies to me
    that we've already dealt with any such broken vsnprintf()
    implementations (via compat/snprintf.c).

If you're sick of bikeshedding, though, I can live without any of those
being addressed.

> +	*(p++) = '\n'; /* we no longer need a NUL */
> +	fflush(stderr);
> +	write_in_full(2, msg, p - msg);

One non-bikeshed question: would fprintf() on some platforms have sent
"\r\n", which is no longer happening with our write()? Do we need to
care about that?

-Peff
