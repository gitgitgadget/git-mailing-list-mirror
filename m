Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6546AC19F2B
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 22:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbiHCWF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 18:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHCWFy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 18:05:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FBC11457
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 15:05:52 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0EB291AA638;
        Wed,  3 Aug 2022 18:05:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OKsH8jBJ5KPmmtS6VyDjWRRDJ73rfVaPdLKr6d
        pxIlI=; b=YACLswMwBzUsXzzdwXuPKjs/fgv0+4b3hBi9sc1RVGvBmnnZ6iTpSd
        76kzB+Jma5zIwXLyubpwUjsI4nMffLjr4l1/F2fFy7PspLQnD5/UfUg0Bm3geG07
        etvVevFYAU3Lg35wJqAoSkKCc+UGgv8K3cxsS5V+wZ0kNAQe/bSJc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 084EB1AA637;
        Wed,  3 Aug 2022 18:05:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ADEC91AA636;
        Wed,  3 Aug 2022 18:05:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: let feature.experimental imply
 gc.cruftPacks=true
References: <20220803205721.3686361-1-emilyshaffer@google.com>
        <20220803205721.3686361-3-emilyshaffer@google.com>
Date:   Wed, 03 Aug 2022 15:05:47 -0700
In-Reply-To: <20220803205721.3686361-3-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 3 Aug 2022 13:57:21 -0700")
Message-ID: <xmqqfsid7zk4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E622C10-1378-11ED-9263-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +* `gc.cruftPacks=true` reduces disk space used by unreachable objects during
> +garbage collection.

OK.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index eeff2b760e..919cc508c5 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -136,6 +136,7 @@ static int gc_config_is_timestamp_never(const char *var)
>  static void gc_config(void)
>  {
>  	const char *value;
> +	int experimental = 0;
>  
>  	if (!git_config_get_value("gc.packrefs", &value)) {
>  		if (value && !strcmp(value, "notbare"))
> @@ -148,6 +149,11 @@ static void gc_config(void)
>  	    gc_config_is_timestamp_never("gc.reflogexpireunreachable"))
>  		prune_reflogs = 0;
>  
> +	/* feature.experimental implies gc.cruftPacks=true */
> +	git_config_get_bool("feature.experimental", &experimental);
> +	if (experimental)
> +		cruft_packs = 1;
> +

I suspect the whole thing can just be:

	git_config_get_bool("feature.experimental", &cruft_packs);

If there is no feature.experimental configuration, the call returns
non-zero (we do not check, though) without touching &cruft_packs, if
there is feature.experimental configuration, the call returns zero
(we do not check, though) and cruft_packs is set to either true
(when experimental) or false (otherwise).

And this whole thing happens before we inspect what the more
specific configuration gc.cruftPacks says, so...

> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index e4c2c3583d..4ab6750111 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -238,6 +238,41 @@ test_expect_success 'gc.cruftPacks=true generates a cruft pack' '
>  	)
>  '
>  
> +test_expect_success 'feature.experimental=true generates a cruft pack' '
> +	git init crufts &&
> +	test_when_finished "rm -fr crufts" &&
> +	(
> +		cd crufts &&
> +		test_commit base &&
> +
> +		test_commit --no-tag foo &&
> +		test_commit --no-tag bar &&
> +		git reset HEAD^^ &&
> +
> +		git -c feature.experimental=true gc &&
> +
> +		cruft=$(basename $(ls .git/objects/pack/pack-*.mtimes) .mtimes) &&
> +		test_path_is_file .git/objects/pack/$cruft.pack
> +	)
> +'
> +
> +test_expect_success 'feature.experimental=false allows explicit cruft packs' '
> +	git init crufts &&
> +	test_when_finished "rm -fr crufts" &&
> +	(
> +		cd crufts &&
> +		test_commit base &&
> +
> +		test_commit --no-tag foo &&
> +		test_commit --no-tag bar &&
> +		git reset HEAD^^ &&
> +
> +		git -c gc.cruftPacks=true -c feature.experimental=false gc &&

OK.  

What is not tested is setting feature.experimental explicitly to
false without touching gc.cruftPacks does not use the cruft pack.

