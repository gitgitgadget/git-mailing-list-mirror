Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FADC433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 23:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE62464DFB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 23:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhA2Xur (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 18:50:47 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54947 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhA2Xup (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 18:50:45 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 231C7105923;
        Fri, 29 Jan 2021 18:50:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RzVARuq10KTN5U7RHKU9rr4CKjE=; b=xUUPF8
        jujQo27DBv+Or5877ODLsRmEY0R8AnMxtX4gtXmzLXCRuXqkatvXOeo3Ej3TVztR
        DqevsuHxs59ARq3knwBQ65lr6kwGzfbsAvEy1GWiFehvP7HBxaK5+8r7iwNcTXla
        kMB/LHvPSPtCW688xAjawYYTYH6ap/AfywZx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y3o3DAECl3b+4haWfhKVak6tmx2lG9z9
        jrctLe7DiwIlmmEOJW9qW/j8G2nrRULkXO8go6x35on4TsXtUeY5iOiGmtD7I086
        B61nZCTZVkEPQppp8RrdTKdquYbpBrxXlv8jCivRjotmhqbtDTYAlbqV8DdqIrgN
        EC3hvliM9F0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1AB3E105922;
        Fri, 29 Jan 2021 18:50:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 63EB3105921;
        Fri, 29 Jan 2021 18:49:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v2 1/3] pretty.c: refactor trailer logic to
 `format_set_trailers_options()`
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
        <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
        <fc5fd5217dfc105f3e03a9800a35209a985775a4.1611954543.git.gitgitgadget@gmail.com>
Date:   Fri, 29 Jan 2021 15:49:55 -0800
In-Reply-To: <fc5fd5217dfc105f3e03a9800a35209a985775a4.1611954543.git.gitgitgadget@gmail.com>
        (Hariom Verma via GitGitGadget's message of "Fri, 29 Jan 2021 21:09:01
        +0000")
Message-ID: <xmqqwnvvqp5o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B148E67A-628C-11EB-AD48-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Hariom Verma <hariom18599@gmail.com>
>
> Refactored trailers formatting logic inside pretty.c to a new function
> `format_set_trailers_options()`. This change will allow us to reuse
> the same logic in other places.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Heba Waly <heba.waly@gmail.com>
> Signed-off-by: Hariom Verma <hariom18599@gmail.com>
> ---
>  pretty.c | 85 ++++++++++++++++++++++++++++++--------------------------
>  pretty.h | 11 ++++++++
>  2 files changed, 57 insertions(+), 39 deletions(-)
>
> diff --git a/pretty.c b/pretty.c
> index 3922f6f9f24..bb6a3c634ac 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1148,6 +1148,50 @@ static int format_trailer_match_cb(const struct strbuf *key, void *ud)
>  	return 0;
>  }
>  
> +int format_set_trailers_options(struct process_trailer_options *opts,
> +				struct string_list *filter_list,
> +				struct strbuf *sepbuf,
> +				struct strbuf *kvsepbuf,
> +				const char **arg)
> +{
> +	for (;;) {
> +		const char *argval;
> +		size_t arglen;
> +
> +		if (match_placeholder_arg_value(*arg, "key", arg, &argval, &arglen)) {
> +			uintptr_t len = arglen;
> +
> +			if (!argval)
> +				return 1;

The convention in this codebase is to signal unusual/error return
with a negative value, especially when a successful exit is signaled
by returning 0.  Perhaps return -1 from here instead?

> +			if (len && argval[len - 1] == ':')
> +				len--;
> +			string_list_append(filter_list, argval)->util = (char *)len;
> +
> +			opts->filter = format_trailer_match_cb;
> +			opts->filter_data = filter_list;
> +			opts->only_trailers = 1;
> +		} else if (match_placeholder_arg_value(*arg, "separator", arg, &argval, &arglen)) {
> +			char *fmt;
> +			fmt = xstrndup(argval, arglen);
> +			strbuf_expand(sepbuf, fmt, strbuf_expand_literal_cb, NULL);
> +			free(fmt);
> +			opts->separator = sepbuf;
> +		} else if (match_placeholder_arg_value(*arg, "key_value_separator", arg, &argval, &arglen)) {
> +			char *fmt;
> +			fmt = xstrndup(argval, arglen);
> +			strbuf_expand(kvsepbuf, fmt, strbuf_expand_literal_cb, NULL);
> +			free(fmt);
> +			opts->key_value_separator = kvsepbuf;

In these two else-if clauses, the original code clears sepbuf and
kvsepbuf before calling strbuf_expand(), but this one does not.

As strbuf_expand() is an appending function, this distinction would
matter if the for(;;) loop causes these two else-if clauses to be
entered twice.  The original code will implement the "last one wins"
semantics, and this new one acumulates what it sees.

Intended?  If so, the reason why we want the accumulating semantics,
instead of the last-one-wins we've been using, needs to be explained
in the log message.

> -				} else if (match_placeholder_arg_value(arg, "separator", &arg, &argval, &arglen)) {
> -					char *fmt;
> -
> -					strbuf_reset(&sepbuf);
> -					fmt = xstrndup(argval, arglen);
> -					strbuf_expand(&sepbuf, fmt, strbuf_expand_literal_cb, NULL);
> -					free(fmt);
> -					opts.separator = &sepbuf;

Here you can see that the original clears what was in sepbuf before
reading the separator anew.

Thanks.
