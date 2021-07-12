Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D781C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 18:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E4A6120A
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 18:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbhGLSQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 14:16:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:46762 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhGLSQo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 14:16:44 -0400
Received: (qmail 19779 invoked by uid 109); 12 Jul 2021 18:13:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jul 2021 18:13:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8450 invoked by uid 111); 12 Jul 2021 18:13:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Jul 2021 14:13:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Jul 2021 14:13:54 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] rev-list: add option for --pretty=format without
 header
Message-ID: <YOyGYs+uDr7tYxON@coredump.intra.peff.net>
References: <20210706224321.14371-1-sandals@crustytoothpaste.net>
 <20210711215510.191626-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210711215510.191626-1-sandals@crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 11, 2021 at 09:55:10PM +0000, brian m. carlson wrote:

> In general, we encourage users to use plumbing commands, like git
> rev-list, over porcelain commands, like git log, when scripting.
> However, git rev-list has one glaring problem that prevents it from
> being used in certain cases: when --pretty is used with a custom format,
> it always prints out a line containing "commit" and the object ID.  This
> makes it unsuitable for many scripting needs, and forces users to use
> git log instead.
> 
> While we can't change this behavior for backwards compatibility, we can
> add an option to suppress this behavior, so let's do so, and call it
> "--no-commit-header".  Additionally, add the corresponding positive
> option to switch it back on.
> 
> Note that this option doesn't affect the built-in formats, only custom
> formats.  This is exactly the same behavior as users already have from
> git log and is what most users will be used to.

Thanks for working on this. It has bugged me for at least a decade. :)

I do wish this had been made the default when we introduced
--pretty=format, but I agree we can't just change it now. This could be
something to keep in mind for future deprecation (or a large breaking
version). People would have to start saying --commit-header now to
future-proof themselves if they really want the current behavior. I'm OK
to leave any plans / warnings like that for future work.

The patch looks correct to me. I did have one small nit:

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 5bf2a85f69..23388f36c3 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -1064,6 +1064,14 @@ ifdef::git-rev-list[]
>  --header::
>  	Print the contents of the commit in raw-format; each record is
>  	separated with a NUL character.
> +
> +--no-commit-header::
> +	Suppress the header line containing "commit" and the object ID printed before
> +	the specified format.  This has no effect on the built-in formats; only custom
> +	formats are affected.

It wasn't immediately obvious to me what "custom formats" meant here. I
don't think we use that term elsewhere, nor do we seem to have a
succinct phrase for the concept. Maybe something like:

  only custom formats (i.e., `--pretty=format:`) are affected.

helps without making it too clunky?

-Peff
