From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC/GSOC] make git-pull a builtin
Date: Wed, 18 Mar 2015 15:26:02 -0700
Message-ID: <xmqqpp86kkn9.fsf@gitster.dls.corp.google.com>
References: <1426600662-32276-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 23:49:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYMm6-0005Oo-BF
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 23:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbbCRWtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 18:49:14 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61097 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751793AbbCRWtN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 18:49:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19CE1423E4;
	Wed, 18 Mar 2015 18:49:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OZObz+/v6O3vjLXNNFw5ukcqBVw=; b=a1jPSH
	mFBFG+KA1Rcy+ZcetyrthPARbQp1DHclisMb9LYi8qVdQAlCpTyyw6NCWoVqTn/z
	+v4buaJmyVINVjq9pCTf58XAIYIEB3U2h7QRLCGHX+DONxq84JXl9LF1Ut2wPTfh
	OC20gHX3t5Q6cZ0VekLTEoKsRK9ohvkOt1NJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mXlHp4ZwnnOYG4txpxHC5TJ/d4z9OuQz
	qM5rT+f1eLvttkxiNPrN3KYlN9tYQ2Cs/CknU/GtEqc11IrmnXtOm6C68EDtlwiQ
	Ps2eFY0nfXNxb5Fk+SwRFpfsfPbVI7sy2J69H243YgGyksDxWO57oefHPRDMTiwS
	J0WSA0gbsBI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 05630423E3;
	Wed, 18 Mar 2015 18:49:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ABC5A4499B;
	Wed, 18 Mar 2015 18:26:03 -0400 (EDT)
In-Reply-To: <1426600662-32276-1-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Tue, 17 Mar 2015 21:57:42 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C34E7642-CDBD-11E4-B78D-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265771>

Paul Tan <pyokagan@gmail.com> writes:

> +/* Global vars since they are used often */
> +static char *head_name;
> +static const char *head_name_short;
> +static unsigned char head_sha1[20];
> +static int head_flags;
> +
> +enum rebase_type {
> +	REBASE_FALSE = 0,
> +	REBASE_TRUE = 1,
> +	REBASE_PRESERVE = 2
> +};
> +
> +/**
> + * Parse rebase config/option value and return corresponding int
> + */
> +static int parse_rebase(const char *arg)
> +{
> +	if (!strcmp(arg, "true"))
> +		return REBASE_TRUE;
> +	else if (!strcmp(arg, "false"))
> +		return REBASE_FALSE;
> +	else if (!strcmp(arg, "preserve"))
> +		return REBASE_PRESERVE;
> +	else
> +		return -1; /* Invalid value */
> +}

Even though the original does not use bool-or-string-config, we
would want to do the same by doing something like

	case (config_maybe_bool()) {
	case 0:
        	return REBASE_FALSE;
	case 1:
        	return REBASE_TRUE;
	default:
        	if (!strcmp(arg, "preserve"))
                	return REBASE_PRESERVE;
		return -1;
	}

and then use that in rebase_config_default().

> +
> +/**
> + * Returns default rebase option value
> + */
> +static int rebase_config_default(void)
> +{
> +	struct strbuf name = STRBUF_INIT;
> +	const char *value = NULL;
> +	int boolval;
> +
> +	strbuf_addf(&name, "branch.%s.rebase", head_name_short);
> +	if (git_config_get_value(name.buf, &value))
> +		git_config_get_value("pull.rebase", &value);

What happens when neither is defined?

> +	strbuf_release(&name);
> +	if (!value)
> +		return REBASE_FALSE;

Hmph, are you sure about this?  Isn't this "[pull] rebase" that does
not have "= value", in which case pull.rebase is "true"?

You cannot use NULL as the sentinel value to tell that you did not
find either branch.*.rebase nor pull.rebase (in which case you want
to default to 'false').  Either of them can be spelled as an
equal-less true, which you will see as value==NULL, and you want to
take that as 'true'.

	const char *value = "false";
        ...
        if (get_value(..., &value))
        	get_value(..., &value));
        strbuf_release(&name);
        if (!value)
        	return REBASE_TRUE;
	return parse_rebase(value);

or something along that line, perhaps?

> +	boolval = git_config_maybe_bool("pull.rebase", value);
> +	if (boolval >= 0)
> +		return boolval ? REBASE_TRUE : REBASE_FALSE;
> +	else if (value && !strcmp(value, "preserve"))
> +		return REBASE_PRESERVE;

Is value something you need to free before returning from this
function?

> +static int parse_opt_recurse_submodules(const struct option *opt, const char *arg, int unset)
> +{
> +	if (!arg)
> +		*(int *)opt->value = unset ? RS_NO : RS_YES;
> +	else if (!strcmp(arg, "no"))
> +		*(int *)opt->value = RS_NO;
> +	else if (!strcmp(arg, "yes"))
> +		*(int *)opt->value = RS_YES;
> +	else if (!strcmp(arg, "on-demand"))
> +		*(int *)opt->value = RS_ON_DEMAND;
> +	else
> +		return -1;
> +	return 0;

I suspect that maybe-bool-or-string comment applies equally here for
the UI consistency.

I'll stop here for now.  Thanks.
