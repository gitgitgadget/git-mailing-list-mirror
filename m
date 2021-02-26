Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FA1C433E6
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 07:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 305A260231
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 07:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhBZHaz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 02:30:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:45660 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhBZHay (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 02:30:54 -0500
Received: (qmail 12340 invoked by uid 109); 26 Feb 2021 07:30:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Feb 2021 07:30:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17043 invoked by uid 111); 26 Feb 2021 07:30:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Feb 2021 02:30:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Feb 2021 02:30:13 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 08/12] unix-socket: add backlog size option to
 unix_stream_listen()
Message-ID: <YDijhRaib5It/apG@coredump.intra.peff.net>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <985b2e02b2df7725d70f1365f7cd2e525c9f3ade.1613598529.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <985b2e02b2df7725d70f1365f7cd2e525c9f3ade.1613598529.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 09:48:44PM +0000, Jeff Hostetler via GitGitGadget wrote:

> @@ -106,7 +108,10 @@ int unix_stream_listen(const char *path)
>  	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
>  		goto fail;
>  
> -	if (listen(fd, 5) < 0)
> +	backlog = opts->listen_backlog_size;
> +	if (backlog <= 0)
> +		backlog = DEFAULT_UNIX_STREAM_LISTEN_BACKLOG;
> +	if (listen(fd, backlog) < 0)
>  		goto fail;

OK, so we still have the fallback-on-zero here, which is good...

> +struct unix_stream_listen_opts {
> +	int listen_backlog_size;
> +};
> +
> +#define DEFAULT_UNIX_STREAM_LISTEN_BACKLOG (5)
> +
> +#define UNIX_STREAM_LISTEN_OPTS_INIT \
> +{ \
> +	.listen_backlog_size = DEFAULT_UNIX_STREAM_LISTEN_BACKLOG, \
> +}

...but I thought the plan was to drop this initialization in favor of a
zero-initialization. What you have certainly wouldn't do the wrong
thing, but it just seems weirdly redundant. Unless some caller really
wants to know what the default will be?

-Peff
