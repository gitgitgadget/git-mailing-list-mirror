Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3EBC4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 21:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C2661038
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 21:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbhHLVKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 17:10:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:46032 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231270AbhHLVKW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 17:10:22 -0400
Received: (qmail 25066 invoked by uid 109); 12 Aug 2021 21:09:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Aug 2021 21:09:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25577 invoked by uid 111); 12 Aug 2021 21:09:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Aug 2021 17:09:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Aug 2021 17:09:55 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 23/25] midx: respect
 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
Message-ID: <YRWOI8nmhPuCp2TU@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
 <50865e52a37590d0bef541fd96c95a0416d7d585.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50865e52a37590d0bef541fd96c95a0416d7d585.1627420428.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 05:20:23PM -0400, Taylor Blau wrote:

> diff --git a/builtin/repack.c b/builtin/repack.c
> index 5f9bc74adc..82ab668272 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -515,6 +515,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		if (!(pack_everything & ALL_INTO_ONE) ||
>  		    !is_bare_repository())
>  			write_bitmaps = 0;
> +	} else if (write_bitmaps &&
> +		   git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0) &&
> +		   git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP, 0)) {
> +		write_bitmaps = 0;
>  	}

This hunk confused me for a minute, since we are turning write_bitmaps
_off_ if we see a positive "write midx bitmap". But I guess the point is
to turn off the pack bitmap, and then in the later hunk:

> @@ -725,8 +729,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		update_server_info(0);
>  	remove_temporary_files();
>  
> -	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
> -		write_midx_file(get_object_directory(), NULL, 0);
> +	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0)) {
> +		unsigned flags = 0;
> +		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP, 0))
> +			flags |= MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX;
> +		write_midx_file(get_object_directory(), NULL, flags);
> +	}

...we'd turn on the midx one. Makes sense.

-Peff
