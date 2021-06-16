Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF305C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 07:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF2096109D
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 07:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhFPHiM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 03:38:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52683 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhFPHiL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 03:38:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51B84B00C8;
        Wed, 16 Jun 2021 03:36:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CD5IArhr2xDuXuR6YP61ZcY2kzElPCkPrC/YdY
        xWObo=; b=Lr2f/uNoP/KN6L40V/a5a6faZBPZmlluPG7ktJcJJCNxCE5/alGpyl
        Fja7NPpHbQygQd4j8V36e74ldQw3Kk7k09ePVCM86/lfrVOAlizDJdpz6fhwb3qM
        68L0HmPXE4GB0eMhwlKSUVPhdFW0Hx324NR2xOs/mS7f6oKa5j9/Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BA0DB00C7;
        Wed, 16 Jun 2021 03:36:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 62477B00C6;
        Wed, 16 Jun 2021 03:36:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2 5/9] [GSOC] ref-filter: teach get_object() return
 useful value
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
        <pull.980.v2.git.1623763746.gitgitgadget@gmail.com>
        <49063372e0035c5384f834d78854da56f5726d13.1623763747.git.gitgitgadget@gmail.com>
Date:   Wed, 16 Jun 2021 16:36:03 +0900
In-Reply-To: <49063372e0035c5384f834d78854da56f5726d13.1623763747.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Tue, 15 Jun 2021 13:29:01
        +0000")
Message-ID: <xmqq1r92qn18.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 818299FE-CE75-11EB-BCAF-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Let `populate_value()`, `get_ref_atom_value()` and
> `format_ref_array_item()` get the return value of `get_object()`
> correctly.

The "get" the value correctly, I think.  What you are teaching them
is to pass the return value from get_object() through the callchain
to their callers.

The readers will be helped if you say what kind of errors
get_object() wants to tell its callers, not just "-1" is for error,
which is what populate_value() assumes to be sufficient.  In other
words, which non-zero returns from get_object() are interesting and
why?

> @@ -1997,9 +1997,11 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>  static int get_ref_atom_value(struct ref_array_item *ref, int atom,
>  			      struct atom_value **v, struct strbuf *err)
>  {
> +	int ret = 0;
> +
>  	if (!ref->value) {
> -		if (populate_value(ref, err))
> -			return -1;
> +		if ((ret = populate_value(ref, err)))
> +			return ret;

The new variable only needs to be in this scope, and does not have
to be shown to the entire function.

> @@ -2573,6 +2575,7 @@ int format_ref_array_item(struct ref_array_item *info,
>  {
>  	const char *cp, *sp, *ep;
>  	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
> +	int ret = 0;

This is dubious...

>  	state.quote_style = format->quote_style;
>  	push_stack_element(&state.stack);
> @@ -2585,10 +2588,10 @@ int format_ref_array_item(struct ref_array_item *info,
>  		if (cp < sp)
>  			append_literal(cp, sp, &state);
>  		pos = parse_ref_filter_atom(format, sp + 2, ep, error_buf);
> -		if (pos < 0 || get_ref_atom_value(info, pos, &atomv, error_buf) ||
> +		if (pos < 0 || (ret = get_ref_atom_value(info, pos, &atomv, error_buf)) ||

Here, if "ret" gets assigned any non-zero value, the condition is
satisfied, and ...

>  		    atomv->handler(atomv, &state, error_buf)) {
>  			pop_stack_element(&state.stack);
> -			return -1;
> +			return ret ? ret : -1;

... the control flow will leave this function.  Therefore, ...

>  		}
>  	}
>  	if (*cp) {
> @@ -2610,7 +2613,7 @@ int format_ref_array_item(struct ref_array_item *info,
>  	}
>  	strbuf_addbuf(final_buf, &state.stack->output);
>  	pop_stack_element(&state.stack);
> -	return 0;
> +	return ret;

... at this point, "ret" can never be anything other than zero.  Am
I misreading the patch?

If I am not misreading the patch, then "ret" does not have to be
globally visible in this function---it can have the same scope as
"pos".

>  }
>  
>  void pretty_print_ref(const char *name, const struct object_id *oid,
