From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v11 2/4] parse-options.c: make OPTION_COUNTUP respect "unspecified" values
Date: Thu, 31 Mar 2016 11:41:42 -0700
Message-ID: <xmqq60w2o5g9.fsf@gitster.mtv.corp.google.com>
References: <01020153cd2340f8-4665cd5f-cd5c-41ab-a162-20acc43ca52e-000000@eu-west-1.amazonses.com>
	<01020153cd2341e2-2616ba0b-9271-4a97-87d1-b6dedbf31828-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 20:41:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alhXT-0001F0-9O
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 20:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756624AbcCaSlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 14:41:47 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61080 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754538AbcCaSlq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 14:41:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3EF5D52F88;
	Thu, 31 Mar 2016 14:41:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y6irsE5VS60QPuDe5q/pOf4eqPs=; b=SIGSYx
	cblhwl/YD3sQgdLl9FwVv++n59XXv1+U1Zv34CHPM9ma84b6oN4xFXYilwZE2pT3
	dwZ8a7pYZH6s8P/xh02VPKAWA0dCDG50JygO1sieaKgd1kymYBuhagbalDVAxFX7
	StkhnWBowAKghfdmo7RdfG7rDwai/4b/lOj1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kGeLT7Zme+TN09aGJB5dHFpZNJFAqKi0
	OtlAZwbiPzfBiKp5/0Y+vJNjx90oRwbvLsaJumWBCptuQkQ68FwKrNTBrLFFUJee
	blJUrQAvTYtGeNnnE4Gq7YcTJaOrMhpTzWHsAA0B1dbqfn4jUb6+WSSvtKq97hqO
	VnKdVucnPNI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1862D52F86;
	Thu, 31 Mar 2016 14:41:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D71BD52F84;
	Thu, 31 Mar 2016 14:41:43 -0400 (EDT)
In-Reply-To: <01020153cd2341e2-2616ba0b-9271-4a97-87d1-b6dedbf31828-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Thu, 31 Mar 2016 14:45:53 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3730F35A-F770-11E5-9056-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290442>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> This change will not affect existing users of COUNTUP at all, as long as
> they use the initial value of 0 (or more).
>
> Force uses the "unspecified" value in conjunction with OPT__FORCE in
> builtin/clean.c in a different way to handle its config which
> munges the "-1" into 0 before we get to parse_options.

These two paragraphs leave the readers wondering what the conclusion
is.  "it is OK as long as..." makes us wonder "so are there users
that do not satisfy that condition?"  "in a different way" makes us
wonder "Does this change break builtin/clean.c because COUNTUP is
used in a different way?".

	This change does not affect existing users of COUNTUP,
	because they all use the initial value of 0 (or more).

	Note that builtin/clean.c initializes the variable used with
	OPT__FORCE (which uses OPT_COUNTUP()) to a negative value,
	but it is set to either 0 or 1 by reading the configuration
	before the code calls parse_options(), i.e. as far as
	parse_options() is concerned, the initial value of the
	variable is not negative.

perhaps?

>  `OPT_COUNTUP(short, long, &int_var, description)`::
>  	Introduce a count-up option.
> -	`int_var` is incremented on each use of `--option`, and
> -	reset to zero with `--no-option`.
> +	Each use of `--option` increments `int_var`, starting from zero
> +	(even if initially negative), and `--no-option` resets it to
> +	zero. To determine if `--option` or `--no-option` was set at
> +	all, set `int_var` to a negative value, and if it is still
> +	negative after parse_options(), then neither `--option` nor
> +	`--no-option` was seen.
>  
>  `OPT_BIT(short, long, &int_var, description, mask)`::
>  	Introduce a boolean option.
> diff --git a/parse-options.c b/parse-options.c
> index 47a9192..86d30bd 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -110,7 +110,13 @@ static int get_value(struct parse_opt_ctx_t *p,
>  		return 0;
>  
>  	case OPTION_COUNTUP:
> -		*(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;
> +		if (unset)
> +			*(int *)opt->value = 0;
> +		else {
> +			if (*(int *)opt->value < 0)
> +				*(int *)opt->value = 0;
> +			*(int *)opt->value += 1;
> +		}
>  		return 0;
>  
>  	case OPTION_SET_INT:

The new behaviour given by the patch looks very sensible, but I
wonder if this is easier to reason about:

	case OPTION_COUNTUP:
+		if (*(int *)opt->value < 0)
+			*(int *)opt->value = 0;
		*(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;

That is, upon hitting this case arm, we know that an explicit option
was given from the command line, so the "unspecified" initial value,
if it is still there, gets reset to 0, and after doing that, we just
do the usual thing.
