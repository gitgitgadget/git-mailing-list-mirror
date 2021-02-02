Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A44C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17F2764F55
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhBBJ7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:59:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:44282 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhBBJ7B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 04:59:01 -0500
Received: (qmail 12784 invoked by uid 109); 2 Feb 2021 09:58:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Feb 2021 09:58:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 703 invoked by uid 111); 2 Feb 2021 09:58:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Feb 2021 04:58:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Feb 2021 04:58:19 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 10/14] unix-socket: elimiate static
 unix_stream_socket() helper function
Message-ID: <YBkiO7hl71YwrifV@coredump.intra.peff.net>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
 <f5d5445cf42e2f107c5f137922e9887ea46d730d.1612208747.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5d5445cf42e2f107c5f137922e9887ea46d730d.1612208747.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 07:45:43PM +0000, Jeff Hostetler via GitGitGadget wrote:

>  static int chdir_len(const char *orig, int len)
>  {
>  	char *path = xmemdupz(orig, len);
> @@ -79,7 +71,10 @@ int unix_stream_connect(const char *path)
>  
>  	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
>  		return -1;
> -	fd = unix_stream_socket();
> +	fd = socket(AF_UNIX, SOCK_STREAM, 0);
> +	if (fd < 0)
> +		die_errno("unable to create socket");
> +

Reading the next patch, I suddenly realized that these are die calls,
and not just passing along the error (which you then fix in the next
patch). It seems like that should be happening here in this patch.
Callers must already be ready to handle an error (we return -1 in the
context above).

> @@ -103,7 +98,9 @@ int unix_stream_listen(const char *path)
>  
>  	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
>  		return -1;
> -	fd = unix_stream_socket();
> +	fd = socket(AF_UNIX, SOCK_STREAM, 0);
> +	if (fd < 0)
> +		die_errno("unable to create socket");

Ditto here.

-Peff
