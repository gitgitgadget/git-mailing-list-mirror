Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679BAC04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 15:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbiG0PA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 11:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiG0PA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 11:00:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490E9639E
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 08:00:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC8341B2FDC;
        Wed, 27 Jul 2022 11:00:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=UBSFNGD4yxFdF8ofpeXjmmaIGW30mVhBGAqPvSmYPg0=; b=C9q8
        XUNbE76aaSkB84wUzJ571478gFHOzTPdhvV4GHh9yLfg/M+81deyQFkD2dTwHl8j
        gCtXVGP3UGB6A019Xu9iYmoUFq5a4DNpqaF4Z+3eXkAjzWNWufsOfT5o1vX/56k/
        1/qEMzK0pdCl+v6UBZi0iF47sWccFXXBsCpwcaI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D5A861B2FDB;
        Wed, 27 Jul 2022 11:00:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1DE8D1B2FD6;
        Wed, 27 Jul 2022 11:00:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2] config.c: NULL check when reading protected config
References: <pull.1299.git.git.1658855372189.gitgitgadget@gmail.com>
        <pull.1299.v2.git.git.1658874067077.gitgitgadget@gmail.com>
Date:   Wed, 27 Jul 2022 08:00:51 -0700
Message-ID: <xmqq1qu6txb0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8EFA280-0DBC-11ED-8AC3-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/config.c b/config.c
> index 015bec360f5..e8ebef77d5c 100644
> --- a/config.c
> +++ b/config.c
> @@ -2645,9 +2647,12 @@ static void read_protected_config(void)
>  	system_config = git_system_config();
>  	git_global_config(&user_config, &xdg_config);
>  
> -	git_configset_add_file(&protected_config, system_config);
> -	git_configset_add_file(&protected_config, xdg_config);
> -	git_configset_add_file(&protected_config, user_config);
> +	if (system_config)
> +		git_configset_add_file(&protected_config, system_config);
> +	if (xdg_config)
> +		git_configset_add_file(&protected_config, xdg_config);
> +	if (user_config)
> +		git_configset_add_file(&protected_config, user_config);
>  	git_configset_add_parameters(&protected_config);

This does make it similar to the way how the primary "config
sequence" reader calls git_config_from_file(), so I do prefer the
patch as posted as a short-term "oops, we merged a buggy code that
segfaults and here is a fix" patch.

It however makes me wonder if it is simpler to allow passing NULL to
git_config_from_file_with_options() and make it silently turn into a
no-op.  I.e. instead of ...

> @@ -1979,6 +1979,8 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
>  	int ret = -1;
>  	FILE *f;
>  
> +	if (!filename)
> +		BUG("filename cannot be NULL");

... we could do

	if (!filename)
		return 0; /* successful no-op */

Even if there are codepaths that feed arbitrary pathnames given by
the end user, they wouldn't be passing NULL (they may pass an empty
string, or a filename that causes fopen() to fail), would they?

But that is something we should leave to a follow-up series, not
"oops, we need to fix it now" fix.

Thanks, will queue.

>  	f = fopen_or_warn(filename, "r");
>  	if (f) {
>  		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename,
