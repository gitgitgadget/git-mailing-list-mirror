Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A26AC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 07:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiCAHGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 02:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiCAHGy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 02:06:54 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330386A075
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 23:06:13 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 82BE3168560;
        Tue,  1 Mar 2022 02:06:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aGCB/lmGdWEJmKA4EMdIGXDTqgjp2AY46PWYTC
        iLs1Q=; b=d7a+6cM9Xha40FbaFI2/EaLW9gOnGRfi6fHmQX9EVPsVOS3FYFIPxn
        iUHdX2t7q4QmoDZXw1qJTqnKNTzvE4XZ0XigFV38xTLhZEg8erQlHbRd4Un5FIh0
        UVEvZik/iEoTYPpCcxuGgLF53IM8bd+EHcAhS6uJr9aHbi0dnAP1w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B54516855F;
        Tue,  1 Mar 2022 02:06:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D82B916855E;
        Tue,  1 Mar 2022 02:06:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 3/3] rev-parse: short-circuit superproject worktree
 when config unset
References: <20220203215914.683922-1-emilyshaffer@google.com>
        <20220301002613.1459916-1-emilyshaffer@google.com>
        <20220301002613.1459916-4-emilyshaffer@google.com>
Date:   Mon, 28 Feb 2022 23:06:07 -0800
In-Reply-To: <20220301002613.1459916-4-emilyshaffer@google.com> (Emily
        Shaffer's message of "Mon, 28 Feb 2022 16:26:13 -0800")
Message-ID: <xmqq7d9eup7k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 127785CC-992E-11EC-AAD1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> diff --git a/submodule.c b/submodule.c
> index 741104af8a..463e7f0c48 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2237,6 +2237,7 @@ int get_superproject_working_tree(struct strbuf *buf)
>  	struct strbuf sb = STRBUF_INIT;
>  	struct strbuf one_up = STRBUF_INIT;
>  	const char *cwd = xgetcwd();
> +	int has_superproject_cfg = 0;
>  	int ret = 0;
>  	const char *subpath;
>  	int code;
> @@ -2250,6 +2251,17 @@ int get_superproject_working_tree(struct strbuf *buf)
>  		 */
>  		return 0;
>  
> +	if (git_config_get_bool("submodule.hassuperproject", &has_superproject_cfg)
> +	    || !has_superproject_cfg) {

git_config_get_bool() returns 0 when it successfully finds the
variable, so the above says "If submodule.hasSuperproject is not set
at all, or if it is set to false, then..."

> +		/*
> +		 * If we don't have a superproject, then we're probably not a
> +		 * submodule. If this is failing and shouldn't be, investigate
> +		 * why the config was never set.
> +		 */
> +		error(_("Asked to find a superproject, but submodule.hasSuperproject != true"));
> +		return 0;

But given that this thing is new, I am not sure if that is a
sensible guard to use here.  Shouldn't we say 

 - If submodule.hasSuperproject is EXPLICITLY set to false then ...

instead?  I.e.

	if (!git_config_get_bool("submodule.hassuperproject", &value) &&
	    !value) {
		error(_("asked to ..."));
		return 0;
	}

