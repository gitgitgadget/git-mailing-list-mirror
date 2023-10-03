Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8998E7AD78
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 17:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjJCRPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 13:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjJCRPe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 13:15:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C736A3
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 10:15:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17E751B6FF3;
        Tue,  3 Oct 2023 13:15:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vbvFbQAgIsjJ
        91pOnszbXP+bh3HPIsqhtldOjq1o5GY=; b=J+ZRqG+HCN2Hcx3AOxmAHpZdMXyf
        iMigHbE0+gSunzndNTD1AaUwPa2vBkCjl7hV/G54ujfLZhlVnxBqiM8dccCwF3i0
        +2vIkN9hJow18d5jbwjsF00XIlhRD0jMbkAsEATsh2FClqJnRdouZmO2Qj2tuAju
        JlRttLyUosSOSrE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EFA541B6FF2;
        Tue,  3 Oct 2023 13:15:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 453E21B6FF1;
        Tue,  3 Oct 2023 13:15:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     phillip.wood@dunelm.org.uk, Jeff King <peff@peff.net>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
In-Reply-To: <6cb09270-04b9-456e-8d7e-97137e56e9e2@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 3 Oct 2023 10:49:15 +0200")
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
        <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de> <ZP2X9roiaeEjzf24@ugly>
        <15530a5f-8d06-24c9-bc2d-e313c895f477@web.de>
        <20230912084029.GD1630538@coredump.intra.peff.net>
        <xmqqa5tmau6e.fsf@gitster.g>
        <6dc558c6-f78c-4d9c-8444-498de8e4d22a@web.de>
        <0bf56c65-e59f-4290-8160-cce141f692d5@gmail.com>
        <xmqqedivl832.fsf@gitster.g>
        <000ff1b9-e7a5-4dd6-bc61-4b6761f66997@gmail.com>
        <6cb09270-04b9-456e-8d7e-97137e56e9e2@web.de>
Date:   Tue, 03 Oct 2023 10:15:28 -0700
Message-ID: <xmqq4jj71vbj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 742AE0BE-6210-11EE-97C1-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> +DEFINE_OPTION_VALUE_TYPE(resume_type, enum resume_type);

These are a bit annoying, but because we need a token that can be ## past=
ed
to form a valid identifier, we cannot help it.

> diff --git a/parse-options.c b/parse-options.c
> index e8e076c3a6..63a2247128 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -85,7 +85,7 @@ static enum parse_opt_result opt_command_mode_error(
>  		if (that =3D=3D opt ||
>  		    !(that->flags & PARSE_OPT_CMDMODE) ||
>  		    that->value !=3D opt->value ||
> -		    that->defval !=3D *(int *)opt->value)
> +		    that->defval !=3D opt->get_value(opt->value))
>  			continue;

So, instead of assuming the pointer stuffed in opt->value member can
be dereferenced as inteter pointer, we have the get_value method for
the option and invoke it to grab the value, and compare it with the
default value.

> @@ -122,7 +122,8 @@ static enum parse_opt_result get_value(struct parse=
_opt_ctx_t *p,
>  	 * is not a grave error, so let it pass.
>  	 */
>  	if ((opt->flags & PARSE_OPT_CMDMODE) &&
> -	    *(int *)opt->value && *(int *)opt->value !=3D opt->defval)
> +	    opt->get_value(opt->value) &&
> +	    opt->get_value(opt->value) !=3D opt->defval)
>  		return opt_command_mode_error(opt, all_opts, flags);

Likewise.

> @@ -160,6 +161,10 @@ static enum parse_opt_result get_value(struct pars=
e_opt_ctx_t *p,
>  		*(int *)opt->value =3D unset ? 0 : opt->defval;
>  		return 0;
>
> +	case OPTION_SET_VALUE:
> +		opt->set_value(opt->value, unset ? 0 : opt->defval);
> +		return 0;

Here we see the previous way in the precontext of this hunk that is
used for OPTION_SET_INT, but in the new type-safe-enum world order,
that uses OPTION_SET_VALUE, the set_value method should know what to
do with the pointer that is in opt->value.

> diff --git a/parse-options.h b/parse-options.h
> index 57a7fe9d91..764e7f7896 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -20,6 +20,7 @@ enum parse_opt_type {
>  	OPTION_BITOP,
>  	OPTION_COUNTUP,
>  	OPTION_SET_INT,
> +	OPTION_SET_VALUE,
>  	/* options with arguments (usually) */
>  	OPTION_STRING,
>  	OPTION_INTEGER,
> @@ -158,8 +159,34 @@ struct option {
>  	parse_opt_ll_cb *ll_callback;
>  	intptr_t extra;
>  	parse_opt_subcommand_fn *subcommand_fn;
> +	intptr_t (*get_value)(void *);
> +	void (*set_value)(void *, intptr_t);
>  };

OK.

> +#define DEFINE_OPTION_VALUE_TYPE(type_name, type) \
> +static inline intptr_t type_name##__get(void *void_ptr) \
> +{ \
> +	type *ptr =3D void_ptr; \
> +	return (intptr_t)*ptr; \
> +} \
> +static inline void type_name##__set(void *void_ptr, intptr_t value) \
> +{ \
> +	type *ptr =3D void_ptr; \
> +	*ptr =3D (type)value; \
> +} \
> +static inline void *type_name##__check(type *ptr) \
> +{ \
> +	return ptr; \
> +} \
> +static inline void *type_name##__check(type *ptr)

Fun.  So a typical pattern is that for "enum foo", the foo__get() is
created from the above template and becomes the .get_value method.

Copying from an earlier hunk, the get_value() method is used like
so:

> -		    that->defval !=3D *(int *)opt->value)
> +		    that->defval !=3D opt->get_value(opt->value))

We pass opt->value (which is void *) to foo__get(), we have a local
variable "enum foo *ptr" and assign it in there, and dereference it.
We used to dereference the pointer as if it were a pointer to an
integer, so the type of foo__get() could be "int", but because we
compare it with the .defval member, which is of type "intptr_t", the
return type of the get_value() method being "intptr_t" would make it
consistent here.  I am not sure why defval need to be "intptr_t", and
for the purpose of this topic it would have been cleaner if it were
"int", but that is a tangent (probably somebody uses it as the default
value for a pointer variable and points it at some default object).

The setter is also reasonable.  An earlier hunk used it like so:

> +		opt->set_value(opt->value, unset ? 0 : opt->defval);

opt->value which is (void *) is assigned to "enum foo *ptr", and
using that pointer, "(enum foo)opt->defval" (or 0) is assinged
there.  Pretty straight-forward.

> +DEFINE_OPTION_VALUE_TYPE(int, int);
> +
> +#define OPTION_VALUE(type_name, v) \
> +	.get_value =3D type_name##__get, \
> +	.set_value =3D type_name##__set, \
> +	.value =3D (1 ? (v) : type_name##__check(v))

This is cute.  foo__check() is declared to take "enum foo *" and
returns it as "void *", but because the condition to the ternary
operator is constant "true", it is discarded.  The only expected
effect is to force the compiler to catch type errors when v is not
of type "enum foo *".

Unless it is "void *", I presume?  Then foo__check() would be happy,
but typically OPTION_VALUE() is used as an implementation detail of
OPT_CMDMODE_T() and you are expected to say something like "&variable"
for "v" above, so it would be OK (because you cannot have a variable
of type "void").

Thanks for a fun read.

