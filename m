Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CFBC433DB
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 10:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAC9664E77
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 10:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhBLKkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 05:40:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:58560 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230348AbhBLKjT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 05:39:19 -0500
Received: (qmail 11387 invoked by uid 109); 12 Feb 2021 10:38:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Feb 2021 10:38:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11115 invoked by uid 111); 12 Feb 2021 10:38:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 Feb 2021 05:38:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 12 Feb 2021 05:38:36 -0500
From:   Jeff King <peff@peff.net>
To:     Andrew Klotz via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Andrew Klotz <agc.klotz@gmail.com>
Subject: Re: [PATCH v3] config: improve error message for boolean config
Message-ID: <YCZarBDX2E3U0OXU@coredump.intra.peff.net>
References: <pull.841.v2.git.git.1612833909210.gitgitgadget@gmail.com>
 <pull.841.v3.git.git.1613075454274.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.841.v3.git.git.1613075454274.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 11, 2021 at 08:30:53PM +0000, Andrew Klotz via GitGitGadget wrote:

> From: Andrew Klotz <agc.klotz@gmail.com>
> 
> Currently invalid boolean config values return messages about 'bad
> numeric', which is slightly misleading when the error was due to a
> boolean value. We can improve the developer experience by returning a
> boolean error message when we know the value is neither a bool text or
> int.
> 
> before with an invalid boolean value of `non-boolean`, its unclear what
> numeric is referring to:
>   fatal: bad numeric config value 'non-boolean' for 'commit.gpgsign': invalid unit
> 
> now the error message mentions `non-boolean` is a bad boolean value:
>   fatal: bad boolean config value 'non-boolean' for 'commit.gpgsign'
> 
> Signed-off-by: Andrew Klotz <agc.klotz@gmail.com>

Thanks, all the changes here look good to me except for one curiosity:

> diff --git a/config.c b/config.c
> index b922b4f28572..f90b633dba21 100644
> --- a/config.c
> +++ b/config.c
> @@ -1180,6 +1180,20 @@ static void die_bad_number(const char *name, const char *value)
>  	}
>  }
>  
> +NORETURN
> +static void die_bad_bool(const char *name, const char *value)
> +{
> +	if (!strcmp(name, "GIT_TEST_GETTEXT_POISON"))
> +		/*
> +		 * We explicitly *don't* use _() here since it would
> +		 * cause an infinite loop with _() needing to call
> +		 * use_gettext_poison().
> +		 */
> +		die("bad boolean config value '%s' for '%s'", value, name);
> +	else
> +		die(_("bad boolean config value '%s' for '%s'"), value, name);
> +}

...if this is rebased on the current master that does not have
GIT_TEST_GETTEXT_POISON anymore, then I think this whole function can be
simplified down to the final line.

Since it looks like Junio applied this on top of v2.30.1, which still
has GETTEXT_POISON, we need it here. But we should remember to remove it
with the rest of the GETTEXT_POISON once it's all merged together.

-Peff
