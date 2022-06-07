Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6958AC43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 01:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiFHBUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1587768AbiFGXxk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 19:53:40 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2954324099
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 15:49:31 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4AF0619A991;
        Tue,  7 Jun 2022 18:49:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QGHTZ7aSzmx7tAJgyZTMI4W4RkMvWBHwxBbGR8
        3k97g=; b=NAvyR9P3kwNtjnK30Ds4hcVUukVom5ZiL0HszX+YPGHU5X2arGd0CC
        O6fsWjx/8mboPCJ0Oysu/G+lYdBfXwzWgWV0qzC0LBbAwG8iRl3isj2oJWqNDW2d
        lUSiFCtdYGpH4meIEwzQ50P6tURe8GkBs1ezSjcsGmKwG1g75b4kU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 43DF219A990;
        Tue,  7 Jun 2022 18:49:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E49F619A98F;
        Tue,  7 Jun 2022 18:49:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v4 3/5] config: read protected config with
 `git_protected_config()`
References: <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
        <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
        <94b40907e66b2f6e0874ab49f8b73fdd58eb06d5.1654635432.git.gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 15:49:26 -0700
In-Reply-To: <94b40907e66b2f6e0874ab49f8b73fdd58eb06d5.1654635432.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Tue, 07 Jun 2022 20:57:10
        +0000")
Message-ID: <xmqqbkv4t7gp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1604571E-E6B4-11EC-A7CD-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/upload-pack.c b/upload-pack.c
> index 3a851b36066..09f48317b02 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1321,18 +1321,27 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
>  		data->advertise_sid = git_config_bool(var, value);
>  	}
>  
> -	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
> -	    current_config_scope() != CONFIG_SCOPE_WORKTREE) {
> -		if (!strcmp("uploadpack.packobjectshook", var))
> -			return git_config_string(&data->pack_objects_hook, var, value);
> -	}
> -

The lossage of this block is because this general git_config()
callback routine that is used to read from any scope is no longer
used to pick up the sensitive variable.  Instead, we need to get it
with a different API, namely, git_protected_config().

It is probably is good that in the new code we are not encouraging
folks to write random comparisons on current_config_scope(), and
instead uniformly use a git_protected_config().  That may promote
consistency.

An obvious alternative to achieve the same consistency would be to
introduce a helper, and rewrite (instead of removing) the above part
like so:

	if (in_protected_scope()) {
		... parse sensitive variable ...
	}

We would not need any other change to this file in this patch if we
go that route, I suspect.

>  	if (parse_object_filter_config(var, value, data) < 0)
>  		return -1;
>  
>  	return parse_hide_refs_config(var, value, "uploadpack");
>  }
>  
> +static int upload_pack_protected_config(const char *var, const char *value, void *cb_data)
> +{
> +	struct upload_pack_data *data = cb_data;
> +
> +	if (!strcmp("uploadpack.packobjectshook", var))
> +		return git_config_string(&data->pack_objects_hook, var, value);
> +	return 0;
> +}
> +
> +static void get_upload_pack_config(struct upload_pack_data *data)
> +{
> +	git_config(upload_pack_config, data);
> +	git_protected_config(upload_pack_protected_config, data);
> +}

Where we used to just do git_config(upload_pack_config), we now need
to do a separate git_protected_config().  It feels a bit wasteful to
iterate over the same configset twice, but it is not like we are
doing the IO and text file parsing multiple times.  This looks quite
straight-forward.
