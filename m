Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136A6C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 23:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8FCD23B52
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 23:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbhAVX7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 18:59:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:36022 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbhAVX6S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 18:58:18 -0500
Received: (qmail 15703 invoked by uid 109); 22 Jan 2021 23:57:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Jan 2021 23:57:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20353 invoked by uid 111); 22 Jan 2021 23:57:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Jan 2021 18:57:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 Jan 2021 18:57:35 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 4/8] builtin/pack-objects.c: respect
 'pack.writeReverseIndex'
Message-ID: <YAtmb7wXQse76kJi@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
 <68bde3ea972f5b3753d7e9063d0490c67c74709b.1610576805.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68bde3ea972f5b3753d7e9063d0490c67c74709b.1610576805.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 05:28:19PM -0500, Taylor Blau wrote:

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 5b0c4489e2..d784569200 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2955,6 +2955,13 @@ static int git_pack_config(const char *k, const char *v, void *cb)
>  			    pack_idx_opts.version);
>  		return 0;
>  	}
> +	if (!strcmp(k, "pack.writereverseindex")) {
> +		if (git_config_bool(k, v))
> +			pack_idx_opts.flags |= WRITE_REV;
> +		else
> +			pack_idx_opts.flags &= ~WRITE_REV;
> +		return 0;
> +	}

This turned out delightfully simple. And I guess this is the "why is
WRITE_REV" caller I asked about from patch 2. It is
finish_tmp_packfile() where the magic happens. That unconditionally
calls write_rev_file(), but it's a noop if WRITE_REV isn't specified.

Makes sense.

-Peff
