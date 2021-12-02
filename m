Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2A2C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 06:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350286AbhLBHAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 02:00:35 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58555 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhLBHAd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 02:00:33 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A2AA15B4DC;
        Thu,  2 Dec 2021 01:57:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TnU2ymMTqmKfFhUbNn3YA9Igoi6+2BUTHxCO2V
        7aEew=; b=x/9IW6+RukfRSbKJhPFjsisc9qwWx/FDqeH6dKg3hu8cZ/2jIj7aqY
        J6jKpc93DlVkzR6/LKUMWdDnACLAp+o7VXQhK0ZNckqqLTQt/d2r17AmEb/mbl87
        S+meiDAvGrCzzs7dcIKm+3JcjTT0I/AxxDeW1MF7h/+6DzEsPa1vg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 831CC15B4DB;
        Thu,  2 Dec 2021 01:57:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3B6A215B4DA;
        Thu,  2 Dec 2021 01:57:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, avarab@gmail.com
Subject: Re: [PATCH v4 2/2] config: include file if remote URL matches a glob
References: <cover.1634077795.git.jonathantanmy@google.com>
        <cover.1638217387.git.jonathantanmy@google.com>
        <3b3af0da983c65ac8282b14141495f6859cd575a.1638217387.git.jonathantanmy@google.com>
Date:   Wed, 01 Dec 2021 22:57:05 -0800
In-Reply-To: <3b3af0da983c65ac8282b14141495f6859cd575a.1638217387.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 29 Nov 2021 12:23:42 -0800")
Message-ID: <xmqqpmqfwl32.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10431384-533D-11EC-8BDB-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +static int add_remote_url(const char *var, const char *value, void *data)
> +{
> +...
> +}
> +
> +static void populate_remote_urls(struct config_include_data *inc)
> +{
> +...
> +}
> +
> +static int forbid_remote_url(const char *var, const char *value, void *data)
> +{
> +...
> +}
> +
> +static int at_least_one_url_matches_glob(const char *glob, int glob_len,
> +					 struct string_list *remote_urls)
> +{
> +...
> +}

All of the above makes sense; you prepare the remote URLs defined in
a string list, and have these helper functions that can determine if
the value given to hasremoteurl:* condition satisfies the condition.

>  static int git_config_include(const char *var, const char *value, void *data)
>  {
>  	struct config_include_data *inc = data;
>  	const char *cond, *key;
>  	size_t cond_len;
> -	int ret;
> +	int ret = 0;
>  
>  	/*
>  	 * Pass along all values, including "include" directives; this makes it
> @@ -335,9 +412,29 @@ static int git_config_include(const char *var, const char *value, void *data)
>  		ret = handle_path_include(value, inc);
>  
>  	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
> -	    (cond && include_condition_is_true(inc->opts, cond, cond_len)) &&
> -	    !strcmp(key, "path"))
> -		ret = handle_path_include(value, inc);
> +	    cond && !strcmp(key, "path")) {
> +		const char *url;
> +		size_t url_len;
> +
> +		if (skip_prefix_mem(cond, cond_len, "hasremoteurl:", &url,
> +				    &url_len)) {
> +			if (inc->opts->unconditional_remote_url) {
> +				config_fn_t old_fn = inc->fn;
> +
> +				inc->fn = forbid_remote_url;
> +				ret = handle_path_include(value, inc);
> +				inc->fn = old_fn;
> +			} else {
> +				if (!inc->remote_urls)
> +					populate_remote_urls(inc);
> +				if (at_least_one_url_matches_glob(
> +						url, url_len, inc->remote_urls))
> +					ret = handle_path_include(value, inc);
> +			}
> +		} else if (include_condition_is_true(inc->opts, cond, cond_len)) {
> +			ret = handle_path_include(value, inc);
> +		}

This looks iffy, especialy in a patch that is not marked as [RFC].

I can see that include_condition_is_true() only passes inc->opts and
you need some other parts of inc for your purpose, and it may be the
primary reason why you munge this caller instead of adding function
include_by_remoteurl() and making include_condition_is_true() call
it.  But wouldn't it be sufficient to pass inc (not inc->opts) to
include_condition_is_true(), and have it dereference inc->opts when
calling include_by_gitdir() and friends that want opts, while
passing inc to include_by_remoteurl()?
