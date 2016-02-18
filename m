From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv11 1/7] submodule-config: keep update strategy around
Date: Thu, 18 Feb 2016 11:28:12 -0800
Message-ID: <xmqq37sphl83.fsf@gitster.mtv.corp.google.com>
References: <1455320080-14648-1-git-send-email-sbeller@google.com>
	<1455320080-14648-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 20:28:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWUFP-0002Wh-ME
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 20:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946981AbcBRT2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 14:28:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50600 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946588AbcBRT2P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 14:28:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 57C99452C0;
	Thu, 18 Feb 2016 14:28:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BOTdlqBSJE2XEcE3dAyPP5u05T8=; b=IdzPXs
	b1PK/ZWmU1RNJtD9uZMV6mm1Xsy9foRXuKJy6EQUfgi/hWcm7FUxHm3lu/0OZIUO
	RIMh/+dxgyv9EA5/JUDHIVdotHG56NaWyaJE8VZyrzyh8StDFN8rb4wy//hRB6da
	u6jtLnLDpMFVIwXjR8fbyJV/vsF3bK2Xy/+24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l7/l9618I743i9yPrZWqWQB7bYilXpS1
	U+NVkxrtwhMStbofHzyuVQNTIwOjK9YL/R+nzDLrboQKSwNy2XKX/xBeROWH40vm
	12EMD5GZOnZbFIZwFxhe+e5xx2kQQrvHjAs8rK1TYNfgLAk4JauQYM7xUetmiiXw
	veI8zMkEzIw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4E05B452BF;
	Thu, 18 Feb 2016 14:28:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C37AB452BE;
	Thu, 18 Feb 2016 14:28:13 -0500 (EST)
In-Reply-To: <1455320080-14648-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 12 Feb 2016 15:34:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C0C2AF44-D675-11E5-BF05-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286615>

Stefan Beller <sbeller@google.com> writes:

> @@ -340,6 +342,16 @@ static int parse_config(const char *var, const char *value, void *data)
>  			free((void *) submodule->url);
>  			submodule->url = xstrdup(value);
>  		}
> +	} else if (!strcmp(item.buf, "update")) {
> +		if (!value)
> +			ret = config_error_nonbool(var);
> +		else if (!me->overwrite &&
> +			 submodule->update_strategy.type != SM_UPDATE_UNSPECIFIED)
> +			warn_multiple_config(me->commit_sha1, submodule->name,
> +					     "update");
> +		else if (parse_submodule_update_strategy(value,
> +			 &submodule->update_strategy) < 0)
> +				die(_("invalid value for %s"), var);

Mental note.  This takes "value" that comes from the config API; the
pre-context in this hunk treats it as a transient piece of memory
and uses xstrdup() on it before storing it away in submodule->url.

> +int parse_submodule_update_strategy(const char *value,
> +		struct submodule_update_strategy *dst)
> +{
> +	dst->command = NULL;
> +	if (!strcmp(value, "none"))
> +		dst->type = SM_UPDATE_NONE;
> +	else if (!strcmp(value, "checkout"))
> +		dst->type = SM_UPDATE_CHECKOUT;
> +	else if (!strcmp(value, "rebase"))
> +		dst->type = SM_UPDATE_REBASE;
> +	else if (!strcmp(value, "merge"))
> +		dst->type = SM_UPDATE_MERGE;
> +	else if (skip_prefix(value, "!", &dst->command))
> +		dst->type = SM_UPDATE_COMMAND;

This however uses skip_prefix() on value, making dst->command store
a pointer into that transient piece of memory.

That looks inconsistent, doesn't it?  I think this part should be

	else if (value[0] == '!') {
		dst->type = SM_UPDATE_COMMAND;
                dst->command = xstrdup(value + 1);
        }

or something like that.  I.e. dst->command should own the piece of
memory it points at, no?
