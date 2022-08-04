Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0923AC19F2D
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 16:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbiHDQ5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiHDQ5n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 12:57:43 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4F326119
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 09:57:41 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F01F113DF0D;
        Thu,  4 Aug 2022 12:57:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qi34AqjkwghyTuviIs9xxdOOrFQQezvJRU2PyQ
        QLsUw=; b=xEL60QLrlwU2UApB20ZGC3hWiLdaLa8IFd0dDNVbrruNLwRI8sh5Ky
        6BSUihlXczivQRdlKt8/2G8v2W37ww+UWDMoQPf7icEBozRa9OH1o0a34JSV3nLE
        Ofjb1/umMc+y8MrFQdXgXY2XPhc4agW387Ub2UTQtqJEnzlCE5w+k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E56C213DF0C;
        Thu,  4 Aug 2022 12:57:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B8A113DF0B;
        Thu,  4 Aug 2022 12:57:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 07/10] log: add --decorate-all option
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <64ee889369dd4044a4acd967876476ea6cfff1c3.1659122979.git.gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 09:57:37 -0700
In-Reply-To: <64ee889369dd4044a4acd967876476ea6cfff1c3.1659122979.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 29 Jul 2022
        19:29:36 +0000")
Message-ID: <xmqqczdg6j5q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BA93900-1416-11ED-A7EB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int decorate_all;
> +static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
> +static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
> +static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
> +
> +static int decorate_all_callback(const struct option *opt,
> +				 const char *arg, int unset)
> +{
> +	if (unset) {
> +		decorate_all = 0;
> +		return 0;
> +	}
> +
> +	string_list_clear(&decorate_refs_include, 0);
> +	string_list_clear(&decorate_refs_exclude, 0);
> +	decorate_all = 1;

Here, we clear include and exclude list, and set the flag.

> +	return 0;
> +}
> +
>  static int decorate_callback(const struct option *opt, const char *arg, int unset)
>  {
>  	if (unset)
> @@ -176,7 +195,8 @@ static void set_default_d
>  					   item->string);
>  	}
>  
> -	if (decoration_filter->exclude_ref_pattern->nr ||
> +	if (decorate_all ||
> +	    decoration_filter->exclude_ref_pattern->nr ||
>  	    decoration_filter->include_ref_pattern->nr ||
>  	    decoration_filter->exclude_ref_config_pattern->nr)
>  		return;

In the pre-context of this hunk, we still pay attention to the
configuration variable log.excludedDecoration and stuff them in
exclude_ref_config_pattern.  Presense of decorate_all option makes
us leave early from this function, skipping the addition of
hardcoded default patterns from the ref_namespace[] array.

Most notably, clearing of exclude_ref_pattern and
include_ref_pattern is done when "--decorate-all" was parsed, and
not here.  So we may have patterns there if 

	git log --decorate-all \
		--decorate-refs=<pattern> \
		--decorate-refs-exclude=<pattern>

Later, log-tree.c::load_ref_decoration() uses these patterns to
decide what to exclude and to include.

So to me, this command option does not look like "all" at all.  It
is more like "clear", with a side effect visible and noticeable only
to implementors.

If we explain the decoration feature to end users in such a way to
form this mental model, then this option becomes truly "clear the
inclusion and exclusion patterns for ref decoration".

    "log --decorate" uses lists of include and exclude patterns to
    decide which refs are used for decoration.  Before the user
    gives any patterns, the system adds the default include and
    exclude patterns in the list.  The user can use --decorate-refs
    and --decorate-refs-exclude options to add more of them to the
    lists.

Then this option can be explained to "clear what has been
accumulated in the lists of include and exclude patterns" and that
also gets rid of what the system adds by default.

I am not sure what to call and how to explain the corresponding
configuration variable introduced in the next step, though.

Thanks.
