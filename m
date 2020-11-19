Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15803C388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 22:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A720221F8
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 22:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BgHQ1u2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgKSWcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 17:32:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57690 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgKSWcu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 17:32:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5E2899B02;
        Thu, 19 Nov 2020 17:32:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cYeway9dYWSFiBfZK2wDY/cz2Zk=; b=BgHQ1u
        2ZhCX/BlizAL2BzlFK7uoPd5xAgXRGFyPKIFF6+qGbeSPy7CG/x5lVuJpOb+6Ruv
        TQCaBoouBURCWSqTrbtBNwHMBA577zrmAUrCslS9Ttl/y4mIYz9Gf4j98Sa82uex
        AEItJVgH1xmzi7DdumWVknsCMqo33dP3nvVH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=blnQqr8akEGKL/w10YVRJbtXbApAMf45
        8X6qxREQEjxaAfQ5wcgor/TqqGIuMGSD1vBHJx0OYfOnR0VCDEt0/96bNIfnllzv
        273sXJBzNcUPiFKev4WsjJgdc2x8kJfDgWs/wQYM20TQwW+USsmbyNEQkhIUgHbn
        5cxjYdPw7Ac=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DCFDA99B01;
        Thu, 19 Nov 2020 17:32:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C6DF99B00;
        Thu, 19 Nov 2020 17:32:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/7] config: convert multi_replace to flags
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <c9caed3854cfe694f105b19657cf57f73412ad4a.1605801143.git.gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 14:32:46 -0800
In-Reply-To: <c9caed3854cfe694f105b19657cf57f73412ad4a.1605801143.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 19 Nov 2020
        15:52:19 +0000")
Message-ID: <xmqqk0uhvuy9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26499B26-2AB7-11EB-A4E4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> We will extend the flexibility of the config API. Before doing so, let's
> take an existing 'int multi_replace' parameter and replace it with a new
> 'int flags' parameter that can take multiple options as a bit field.

Nice.  I was afraid we may have to _add_ a new parameter, but here,
we can turn an existing bool into a flags word, which is great.  But
please use "unsigned" for such flags, just out of inertia/convention.

> @@ -70,6 +70,13 @@ enum config_event_t {
>  	CONFIG_EVENT_ERROR
>  };
>  
> +/*
> + * When CONFIG_FLAGS_MULTI_REPLACE is specified, all matching key/values
> + * are removed before a new pair is written. If the flag is not present,
> + * then set operations replace only the first match.
> + */
> +#define CONFIG_FLAGS_MULTI_REPLACE (1 << 0)
> +

The description is clear, but how far is this comment from the
actual parameter definition where "flag" is used?  What I am trying
to get at is if it is clear enough to the readers, when we say "when
... is specified", where they can specify it.  If it is not clear,
perhaps we want to start the above comment like so:

	/*
	 * These are bits in the flags word to be given to functions
	 * like git_config_set_multivar_in_file(), etc.
	 *
	 * When CONFIG_FLAGS_MULTI_REPLACE is specified, ...


> @@ -276,13 +283,15 @@ int git_config_set_multivar_in_file_gently(const char *, const char *, const cha
>   * - the value regex, as a string. It will disregard key/value pairs where value
>   *   does not match.
>   *
> - * - a multi_replace value, as an int. If value is equal to zero, nothing or only
> - *   one matching key/value is replaced, else all matching key/values (regardless
> - *   how many) are removed, before the new pair is written.
> + * - a flags value with bits corresponding to the CONFIG_FLAG_* macros.

This side is good---it tells readers what the bits in the flags word
are called (i.e. they can look for CONFIG_FLAGS_ in the file).

>   *
>   * It returns 0 on success.
>   */
> -void git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
> +void git_config_set_multivar_in_file(const char *config_filename,
> +				     const char *key,
> +				     const char *value,
> +				     const char *value_regex,
> +				     int flags);
>  
>  /**
>   * rename or remove sections in the config file
