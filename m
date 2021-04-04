Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBEFC433B4
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 07:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 944B26135D
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 07:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhDDH6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 03:58:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64869 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhDDH60 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 03:58:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D897D10ECF7;
        Sun,  4 Apr 2021 03:58:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uZX36oHLwiWs0r+gChZI6fgSem8=; b=JYle85
        1oXTRpJimtAMDMWof36n1J0gu+3ubGoKGAG2eAhZAHHCYRdCoHdmN1wGr7ZLyyK1
        DNajaBzigGVk2wjXKwQ3oQmsHkxxSFxZ4cTzVfsrO6GQY/fKKyKGZQ9hIeWvm7A7
        U2Mva0UeKuiWLotWMjSJt28mLVaY4Sogj5CSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mh9aE2w0PikO8NIZyM/71wvV37a/zWGa
        ra20zixoat51xoOV2eQFmyzO3yaR6WxO+nY5AFktuPwCY3mg/Fi+pnldobvIRxkb
        Jln/1C6F7fkjp37nwuhtSNFh+byU6tjRKuW2pKt/oqbynBY3GuGnRq/c/AlcB9HQ
        DUfZx3azWPs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D262D10ECF5;
        Sun,  4 Apr 2021 03:58:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 17C8C10ECF4;
        Sun,  4 Apr 2021 03:58:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, d.torilov@gmail.com
Subject: Re: [PATCH v2 2/2] MacOs: Precompose startup_info->prefix
References: <xmqqtuotfre5.fsf@gitster.g>
        <20210404061754.19428-1-tboegi@web.de>
Date:   Sun, 04 Apr 2021 00:58:17 -0700
In-Reply-To: <20210404061754.19428-1-tboegi@web.de> (tboegi@web.de's message
        of "Sun, 4 Apr 2021 08:17:54 +0200")
Message-ID: <xmqqlf9y7a7a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84E3856A-951B-11EB-A31E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> diff --git a/setup.c b/setup.c
> index c04cd25a30..dcc9c41a85 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1281,10 +1281,6 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  	} else {
>  		startup_info->have_repository = 1;
>  		startup_info->prefix = prefix;

Is this assignment sensible?  As we'd defer precomposition (or not)
after we run the repository discovery, would it break if we do not
have this line here (i.e. leaving startup_info->prefix NULL), and ...

> -		if (prefix)
> -			setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
> -		else
> -			setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
>  	}
>
>  	/*
> @@ -1311,6 +1307,16 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  		if (startup_info->have_repository)
>  			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
>  	}
> +	/* Keep prefix, startup_info->prefix and GIT_PREFIX_ENVIRONMENT in sync */
> +	prefix = startup_info->prefix;

... not wipe prefix with this assignment, i.e. we learned prefix
before the previous hunk, and we would tweak it here?

> +	if (prefix) {
> +		/* This calls git_config_get_bool() under the hood (MacOs only) */

It may be more friendly to ourselves in the future if we are a bit
more explicit in what we want to convey with the comment, though.
Here is my attempt.

		/*
		 * Since precompose_string_if_needed() needs to look at
		 * the core.precomposeunicode configuration, this
		 * has to happen after the above block that finds
		 * out where the repository is, i.e. a preparation
                 * for calling git_config_get_bool().
		 */

> +		prefix = precompose_string_if_needed(prefix);
> +		startup_info->prefix = prefix;
> +		setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
> +	} else {
> +		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
> +	}
>
>  	strbuf_release(&dir);
>  	strbuf_release(&gitdir);
> --
> 2.30.0.155.g66e871b664

Other than that, both patches look sensible.

By the way, isn't the canonical way to spell the name of the
particular operating system that needs this patch "macOS"?

cf. https://support.apple.com/macos

Thanks.
