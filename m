Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA30CC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 07:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiCAHBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 02:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiCAHBp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 02:01:45 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730CA78062
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 23:01:01 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ECF1018837B;
        Tue,  1 Mar 2022 02:01:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g2wsBPGD3v2qGcrQ3lOoFgN10J3FBIif6+nFLo
        rzdZE=; b=iEZb5KtMBZvJJ0qQq8XBvhl/iQZkWYlBpIxlmpk0648W+73NBlQCuA
        ND2Opnbo2atGg8VE51QyqdKSDsXCPUhVK7Fmjzwjvn3eS1ITxHQ+haxgNJCBEVS8
        uVIA6AoWgbJbJS/JS7EdBDdO72gwpPZRCtD/iB1ZNf+hFhg9+0EQ4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E550818837A;
        Tue,  1 Mar 2022 02:01:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6A15D188375;
        Tue,  1 Mar 2022 02:00:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 2/3] introduce submodule.hasSuperproject record
References: <20220203215914.683922-1-emilyshaffer@google.com>
        <20220301002613.1459916-1-emilyshaffer@google.com>
        <20220301002613.1459916-3-emilyshaffer@google.com>
Date:   Mon, 28 Feb 2022 23:00:57 -0800
In-Reply-To: <20220301002613.1459916-3-emilyshaffer@google.com> (Emily
        Shaffer's message of "Mon, 28 Feb 2022 16:26:12 -0800")
Message-ID: <xmqqbkyqupg6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58D3D90E-992D-11EC-AAF1-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +	/*
> +	 * Note location of superproject's gitdir. Because the submodule already
> +	 * has a gitdir and local config, we can store this pointer from
> +	 * worktree config to worktree config, if the submodule has
> +	 * extensions.worktreeConfig set.
> +	 */

Probably the comment is a bit stale.  There is no longer a pointer
or location of superproject's gitdir recorded anywhere.

> +	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
> +	git_configset_init(&sub_cs);
> +	git_configset_add_file(&sub_cs, config_path.buf);
> +
> +	git_config_set_in_file(config_path.buf, "submodule.hasSuperproject",
> +			       "true");
> +
> +	git_configset_clear(&sub_cs);
> +	strbuf_release(&config_path);
> +	strbuf_release(&sb);
>  	free(old_git_dir);
>  	free(real_old_git_dir);
>  	free(real_new_git_dir);
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 40cf8d89aa..833fa01961 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -115,6 +115,10 @@ inspect() {
>  	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
>  	git -C "$sub_dir" update-index --refresh &&
>  	git -C "$sub_dir" diff-files --exit-code &&
> +
> +	# Ensure that submodule.hasSuperproject is set.
> +	git -C "$sub_dir" config "submodule.hasSuperproject"

Are we sufficiently happy to see the variable is set to anything, or
do we require it to be set to boolean true?

If the former, the above is fine, with trailing && added.

If the latter, then something like

	val=$(git config --type=bool "submodule.hasSuperproject") &&
	test "$val" = true &&

would be more appropriate, but I wonder something like

test_config_is () {
	local var expect val
	var="$1" expect="$2"
	shift 2
        val=$(git "$@" config --type=bool "$var") &&
	test "$val" = "$expect"
}

would be in order.  That would allow us to write

	test_config_is submodule.hasSuperproject true -C "$sub_dir" &&

>  	git -C "$sub_dir" clean -n -d -x >untracked
>  }
>  
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 11cccbb333..422c3cc343 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -1061,4 +1061,12 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
>  	)
>  '
>  
> +test_expect_success 'submodule update adds submodule.hasSuperproject to older repos' '
> +	(cd super &&
> +	 git -C submodule config --unset submodule.hasSuperproject &&

Are we testing that submodule.hasSuperproject is set, and that
it can successfully be unset?  "config --unset no.such.var" will
exit with non-zero status.

> +	 git submodule update &&
> +	 git -C submodule config submodule.hasSuperproject

Ditto.
