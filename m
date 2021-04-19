Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280ECC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 21:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 020806101C
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 21:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhDSVFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 17:05:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58802 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhDSVFD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 17:05:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CF37E12FAC9;
        Mon, 19 Apr 2021 17:04:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UeNQkUH05+zMnZh2JqTwFweHWPg=; b=hmSgis
        5Z3zqP6cSs48OXfnjj9qMmG+kSChcvhwsK8mMMYSsI/4Nuv/04qwPBe/GvBPQcjc
        hnTV4Qq/LALkG0l4yH9gGTcXUPO+CyjBK+DsstHVI5sORtkzkPM98i/qDJKYsL3/
        0D1ymJBXLGoatnFDan7/rQ3PTdAdkc92iVK88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v/J6Cm8mpHoUtoyMrKlJ4/LBWkATLW8i
        IvjbUUc0T619KrL1ngHJXrxE69t5eHtoFt+fY0TQvdAFi6ff8j0UGjcy7maixkEA
        iyAiXuw30v00iTzrNVeW2EbY/9K4EdAPwibusv64CVDcFMuh7JIpxw0jPORD2cZT
        4fSba3rkzn0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7B1E12FAC8;
        Mon, 19 Apr 2021 17:04:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 08F5212FAC7;
        Mon, 19 Apr 2021 17:04:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 2/2] [GSOC] ref-filter: reuse output buffer
References: <pull.935.git.1618831726.gitgitgadget@gmail.com>
        <1c7a69ba072ac740273ef06972122f74cf3fa684.1618831726.git.gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 14:04:28 -0700
In-Reply-To: <1c7a69ba072ac740273ef06972122f74cf3fa684.1618831726.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Mon, 19 Apr 2021 11:28:45
        +0000")
Message-ID: <xmqq7dky9ear.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D528AE04-A152-11EB-BFD3-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/branch.c b/builtin/branch.c
> index bcc00bcf182d..00081de1aed8 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -411,6 +411,8 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
>  {
>  	int i;
>  	struct ref_array array;
> +	struct strbuf out = STRBUF_INIT;
> +	struct strbuf err = STRBUF_INIT;
>  	int maxwidth = 0;
>  	const char *remote_prefix = "";
>  	char *to_free = NULL;
> @@ -440,8 +442,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
>  	ref_array_sort(sorting, &array);
>  
>  	for (i = 0; i < array.nr; i++) {
> -		struct strbuf out = STRBUF_INIT;
> -		struct strbuf err = STRBUF_INIT;
> +		strbuf_reset(&out);
>  		if (format_ref_array_item(array.items[i], format, &out, &err))
>  			die("%s", err.buf);

This change relies on the fact that format_ref_array_item() will
never touch error when it returns 0 (success); otherwise, we'd end
up accumulating err from multiple calls to it in the loop until it
returns non-zero (failure), at which point we emit a single "fatal:"
prefix to show multiple error messages.  Which leans me ...

> @@ -452,10 +453,10 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
>  			fwrite(out.buf, 1, out.len, stdout);
>  			putchar('\n');
>  		}
> -		strbuf_release(&err);
> -		strbuf_release(&out);
>  	}
>  
> +	strbuf_release(&err);
> +	strbuf_release(&out);

... to suspect that the _release() of err will always be a no-op.

It may be easier to follow if err is _reset() always where out is
_reset(), from code cleanliness's perspective.  Then nobody has to
wonder why we do not reset err inside loop even though we release
at the end.

It also is OK to document more clearly that we assume that the loop
will not exit without calling die() when err is not empty.  If we
take that route, we may want to drop _release(&err) at the end.

I do not know which of the two is better, but the code presented
which is halfway between these two does not quite look easy to
reason about.

Thanks.

