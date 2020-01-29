Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E573C33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 10:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337D720708
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 10:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgA2KDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:03:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:47324 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726067AbgA2KDK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 05:03:10 -0500
Received: (qmail 16019 invoked by uid 109); 29 Jan 2020 10:03:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Jan 2020 10:03:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15402 invoked by uid 111); 29 Jan 2020 10:10:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jan 2020 05:10:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jan 2020 05:03:09 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 09/12] sparse-checkout: properly match escaped
 characters
Message-ID: <20200129100309.GA4218@coredump.intra.peff.net>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
 <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
 <9ea69e90694e53842acd68d3ac85c9a00c4bd343.1580236003.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ea69e90694e53842acd68d3ac85c9a00c4bd343.1580236003.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 06:26:40PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> In cone mode, the sparse-checkout feature uses hashset containment
> queries to match paths. Make this algorithm respect escaped asterisk
> (*) and backslash (\) characters.

Do we also need to worry about other glob metacharacters? E.g., "?" or
ranges like "[A-Z]"?

> +static char *dup_and_filter_pattern(const char *pattern)
> +{
> +	char *set, *read;
> +	char *result = xstrdup(pattern);
> +
> +	set = result;
> +	read = result;
> +
> +	while (*read) {
> +		/* skip escape characters (once) */
> +		if (*read == '\\')
> +			read++;
> +
> +		*set = *read;
> +
> +		set++;
> +		read++;
> +	}
> +	*set = 0;
> +
> +	if (*(read - 2) == '/' && *(read - 1) == '*')
> +		*(read - 2) = 0;
> +
> +	return result;
> +}

Do we need to check that the pattern is longer than 1 character here? If
it's a single character, it seems like this "*(read - 2)" will
dereference the byte before the string.

-Peff
