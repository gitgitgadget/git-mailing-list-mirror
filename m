Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D47CA0FEF
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 17:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350433AbjIAR7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 13:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbjIAR7i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 13:59:38 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F49FD
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 10:59:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C64FF270BB;
        Fri,  1 Sep 2023 13:59:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=f/soXWb+7GZ6UoT7E0fTZZsNe14LwOoeCLyXsM
        Ikni0=; b=T/BjXG35t97KNj+OC8PdN4ZPcY0T787MdnFcnxUcGI9q2Mn5928KJr
        FKIzbz4vvYEYX9Nl5lwGaWXTLnEiLshbSj9NCKVakyLDh7VgcH/86wz2/zYg7rA6
        CeKEBWYAgUGXa293OSzAbl84s1fE5Sv15k2MIYIulpw0v3eg/0Zeg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BE2D9270BA;
        Fri,  1 Sep 2023 13:59:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A2D0D270B9;
        Fri,  1 Sep 2023 13:59:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] ref-filter: sort numerically when ":size" is used
In-Reply-To: <20230901174540.GB1947546@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 1 Sep 2023 13:45:40 -0400")
References: <20230901142624.12063-1-five231003@gmail.com>
        <xmqqa5u5rgis.fsf@gitster.g>
        <20230901174540.GB1947546@coredump.intra.peff.net>
Date:   Fri, 01 Sep 2023 10:59:28 -0700
Message-ID: <xmqqr0nhpyf3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C245614-48F1-11EE-B7D7-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Sep 01, 2023 at 09:43:07AM -0700, Junio C Hamano wrote:
>
>> IOW, when you notice that you need to set, say, u.contents.option of
>> an atom to C_LENGTH, shouldn't you set cmp_type of the atom to
>> FIELD_ULONG, somewhere in contents_atom_parser() and friends, and
>> everything should naturally follow, no?
>
> Yeah, I had the same thought after reading the patch. Unfortunately the
> "type" is used only for comparison, not formatting. So you are still
> stuck setting both v->value and v->s in grab_sub_body_contents(). It
> feels like we could hoist that xstrfmt("%"PRIuMAX) to a higher level as
> a preparatory refactoring. But it's not that big a deal to work around
> it if that turns out to be hard.

Setting of the .value member happens O(N) times for the number of
refs involved, which does not bother me.  Do you mean "when we know
we are not sorting with size we should omit parsing the string into
the .value member"?  If so, I think that would be nice to have.

>> It seems that support for other cmp_types are incomplete in the
>> current code.  There are FIELD_ULONG and FIELD_TIME defined, but
>> they do not appear to be used in any way, so the cmp_ref_sorting()
>> would need to be updated to make it actually pay attention to the
>> cmp_type and perform numeric comparison.
>
> I think they are covered implicitly by the "else" block of the
> conditional that checks for FIELD_STR.

Ah, OK.  That needs to be future-proofed to force future developers
who want to add different FIELD_FOO type to look at the comparison
logic.  If we want to do so, it should be done as a separate topic
for cleaning-up the mess, not as part of this effort.

> So just this is sufficient to make contents:size work:
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 88b021dd1d..02e3b6ba82 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -583,9 +583,10 @@ static int contents_atom_parser(struct ref_format *format, struct used_atom *ato
>  		atom->u.contents.option = C_BARE;
>  	else if (!strcmp(arg, "body"))
>  		atom->u.contents.option = C_BODY;
> -	else if (!strcmp(arg, "size"))
> +	else if (!strcmp(arg, "size")) {
> +		atom->type = FIELD_ULONG;
>  		atom->u.contents.option = C_LENGTH;
> -	else if (!strcmp(arg, "signature"))
> +	} else if (!strcmp(arg, "signature"))
>  		atom->u.contents.option = C_SIG;
>  	else if (!strcmp(arg, "subject"))
>  		atom->u.contents.option = C_SUB;
> @@ -1885,9 +1886,10 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
>  			v->s = strbuf_detach(&sb, NULL);
>  		} else if (atom->u.contents.option == C_BODY_DEP)
>  			v->s = xmemdupz(bodypos, bodylen);
> -		else if (atom->u.contents.option == C_LENGTH)
> -			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
> -		else if (atom->u.contents.option == C_BODY)
> +		else if (atom->u.contents.option == C_LENGTH) {
> +			v->value = strlen(subpos);
> +			v->s = xstrfmt("%"PRIuMAX, v->value);
> +		} else if (atom->u.contents.option == C_BODY)
>  			v->s = xmemdupz(bodypos, nonsiglen);
>  		else if (atom->u.contents.option == C_SIG)
>  			v->s = xmemdupz(sigpos, siglen);

Yup, exactly.

Thanks.
