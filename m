Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B561C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 01:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiCJBs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 20:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiCJBsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 20:48:25 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA660FDFB8
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 17:47:24 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C20D182D07;
        Wed,  9 Mar 2022 20:47:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yHYnbJopaSOWvSTCQJHNcI0LCn8QmAy5EWEG1F
        uDD3c=; b=fNTkn1M+m6uXrUO3Sp2pgzRutiVTaqW9sD2B1msgnLHi9gHpwDs7oF
        EG+pp4za1gKZ/QXkdp5c6R20pOuKbYyzAzjfjrV3e19k0HVrwDPA9lDSNOV9l2wg
        DiiXU4+cJ/+BOP82LtU3W4Z5h237Xnvgod68hD0Z8ifZHXzVaXTL8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 47618182D06;
        Wed,  9 Mar 2022 20:47:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B02FA182D05;
        Wed,  9 Mar 2022 20:47:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 3/3] rev-parse: short-circuit superproject worktree
 when config unset
References: <20220310004423.2627181-1-emilyshaffer@google.com>
        <20220310004423.2627181-4-emilyshaffer@google.com>
Date:   Wed, 09 Mar 2022 17:47:20 -0800
In-Reply-To: <20220310004423.2627181-4-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 9 Mar 2022 16:44:23 -0800")
Message-ID: <xmqq35jqino7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06E8F26C-A014-11EC-940B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +	/*
> +	 * Because get_superproject_working_tree() is older than
> +	 * submodule.hasSuperproject, don't rely on the default "unset = false"
> +	 * - instead, only rely on if submodule.hasSuperproject was explicitly
> +	 * set to false.
> +	 */

That's a round-about way to say that submodule.hassuperproject
defaults to true, isn't it ;-)?

> +	if (! git_config_get_bool("submodule.hassuperproject", &has_superproject_cfg)
> +	    && !has_superproject_cfg) {
> +		/*
> +		 * If we don't have a superproject, then we're probably not a
> +		 * submodule. If this is failing and shouldn't be, investigate
> +		 * why the config was set to false.
> +		 */
> +		error(_("Asked to find a superproject, but submodule.hasSuperproject == false"));

s/Asked to/asked to/, probably.

> +		return 0;
> +	}
> +
>  	if (!strbuf_realpath(&one_up, "../", 0))
>  		return 0;
>  
> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> index 1c2df08333..dd35036bd6 100755
> --- a/t/t1500-rev-parse.sh
> +++ b/t/t1500-rev-parse.sh
> @@ -244,7 +244,15 @@ test_expect_success 'showing the superproject correctly' '
>  	test_must_fail git -C super merge branch1 &&
>  
>  	git -C super/dir/sub rev-parse --show-superproject-working-tree >out &&
> -	test_cmp expect out
> +	test_cmp expect out &&
> +
> +	# When submodule.hasSuperproject=false, --show-superproject-working-tree
> +	# should fail instead of checking the filesystem.
> +	test_config -C super/dir/sub submodule.hasSuperproject false &&
> +	git -C super/dir/sub rev-parse --show-superproject-working-tree >out &&
> +	# --show-superproject-working-tree should print an error about the
> +	# broken config
> +	! grep "error:.*hasSuperproject" out
>  '
>  
>  # at least one external project depends on this behavior:
