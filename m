From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] submodule-config: keep update strategy around
Date: Wed, 03 Feb 2016 15:09:06 -0800
Message-ID: <xmqqy4b1l7cd.fsf@gitster.mtv.corp.google.com>
References: <1454435497-26429-1-git-send-email-sbeller@google.com>
	<1454435497-26429-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 00:09:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR6YG-0005Su-LU
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 00:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755711AbcBCXJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 18:09:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52300 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932749AbcBCXJO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 18:09:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6B51540E87;
	Wed,  3 Feb 2016 18:09:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=PBTQ0cJKzu9z7HIB3e+FAzDU9k8=; b=vddjja7XX66i7AZUpHIC
	9N9nwwUwfzxMecEbZhmeFXHH17glK4pUPshIS9LZEdf5xdkJga5QjLaOWMU0tc0l
	E+WuqhcHSy7xh59mZTSPI2ejNPrRblrlOn62XJ2F2ToB1pIcEjJoA46+DNzbAmdZ
	dH8L3Bv2ORCHT4QRw/+nEiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=LAiyTtXGBGbfDNdRjqkBK377DsOJ9802/MaEZPKiLp0GCP
	h535zCqXvEHuTdxXWlkt2BEKF6nfRycjqBs5Yr66L9IogPYI8fFh4Kfvqsfu/LUc
	a5ecnknLtNsi00IeG+afLgfdbou5KKFqjmsSajY+WfbeAWJQ5igSCjsNtwAdo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 62C0B40E86;
	Wed,  3 Feb 2016 18:09:08 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DB67140E83;
	Wed,  3 Feb 2016 18:09:07 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 209F1274-CACB-11E5-A2EF-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285379>

Stefan Beller <sbeller@google.com> writes:

> We need the submodule update strategies in a later patch.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  submodule-config.c | 11 +++++++++++
>  submodule-config.h |  1 +
>  2 files changed, 12 insertions(+)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index afe0ea8..4239b0e 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -194,6 +194,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
>  
>  	submodule->path = NULL;
>  	submodule->url = NULL;
> +	submodule->update = NULL;
>  	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
>  	submodule->ignore = NULL;
>  
> @@ -311,6 +312,16 @@ static int parse_config(const char *var, const char *value, void *data)
>  			free((void *) submodule->url);
>  			submodule->url = xstrdup(value);
>  		}
> +	} else if (!strcmp(item.buf, "update")) {
> +		if (!value)
> +			ret = config_error_nonbool(var);
> +		else if (!me->overwrite && submodule->update != NULL)
> +			warn_multiple_config(me->commit_sha1, submodule->name,
> +					     "update");
> +		else {
> +			free((void *) submodule->update);
> +			submodule->update = xstrdup(value);

This is a tangent, but whenever I see us needing to cast the
constness away to call free(), it makes me wonder how much value we
are getting by marking the field as a pointer to "const" in the
first place.  With this patch alone, we cannot really see it,
because we cannot see how it is used.

> +		}
>  	}
>  
>  	strbuf_release(&name);
> diff --git a/submodule-config.h b/submodule-config.h
> index 9061e4e..f9e2a29 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -14,6 +14,7 @@ struct submodule {
>  	const char *url;
>  	int fetch_recurse;
>  	const char *ignore;
> +	const char *update;
>  	/* the sha1 blob id of the responsible .gitmodules file */
>  	unsigned char gitmodules_sha1[20];
>  };
