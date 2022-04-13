Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38716C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 16:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiDMQnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236913AbiDMQnS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 12:43:18 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A873D37AB0
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 09:40:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1627A17406B;
        Wed, 13 Apr 2022 12:40:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0YzY1oDS1ZIVfH0Wtl4GWXx0vf2OE9QpO13Az6
        LppTk=; b=lPoycsK+H18SZB51Tj14wfqtpkzYQrGwMHy1f99gS0r/52PwwJhEKO
        NHuB+jJlso9AcYlMhc04eIdUqmFShA37/cfqmxJXvq0mM1NIZ6c059W7QAFwmkDL
        /bnCOUVH7k/dYcmGUjBjUSfJpXlAkF/D33ESAWtz86DiEyqop4gD8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EC246174069;
        Wed, 13 Apr 2022 12:40:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4BC05174068;
        Wed, 13 Apr 2022 12:40:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/3] setup: opt-out of check with safe.directory=*
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
        <a5faf3a1779b51195313794fa0a48b7e2009c01b.1649863951.git.gitgitgadget@gmail.com>
Date:   Wed, 13 Apr 2022 09:40:52 -0700
In-Reply-To: <a5faf3a1779b51195313794fa0a48b7e2009c01b.1649863951.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 13 Apr 2022
        15:32:31 +0000")
Message-ID: <xmqqk0bt9bsb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7BF3D56E-BB48-11EC-B2C6-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> To simplify the reactions necessary for these users, extend the
> definition of the safe.directory config value to include a possible '*'
> value. This value implies that all directories are safe, providing a
> single setting to opt-out of this protection.

OK.  During the development of the original fix, we discussed if a
more flexible mechanism, like allowing globs, but ended up with the
simplest and easiest to explain option, with the expectation that we
may want to loosen it later as necessary.  And this is certainly
what we would have expected to add.

> Note that an empty assignment of safe.directory clears all previous
> values, and this is already the case with the "if (!value || !*value)"
> condition.

OK.

>  	if (strcmp(key, "safe.directory"))
>  		return 0;
>  
> -	if (!value || !*value)
> +	if (!value || !*value) {
>  		data->is_safe = 0;
> -	else {
> +	} else if (!strcmp(value, "*")) {
> +		data->is_safe = 1;
> +	} else {
>  		const char *interpolated = NULL;
>  
>  		if (!git_config_pathname(&interpolated, key, value) &&
> diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh

OK.

> index 6f33c0dfefa..239d93f4d21 100755
> --- a/t/t0033-safe-directory.sh
> +++ b/t/t0033-safe-directory.sh
> @@ -36,4 +36,14 @@ test_expect_success 'safe.directory matches, but is reset' '
>  	expect_rejected_dir
>  '
>  
> +test_expect_success 'safe.directory=*' '
> +	git config --global --add safe.directory "*" &&
> +	git status
> +'
> +
> +test_expect_success 'safe.directory=*, but is reset' '
> +	git config --global --add safe.directory "" &&
> +	expect_rejected_dir
> +'

Thanks.
