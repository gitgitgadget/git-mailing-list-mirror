From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] submodule-config: keep groups around
Date: Wed, 20 Jan 2016 13:23:16 -0800
Message-ID: <xmqqwpr43pyz.fsf@gitster.mtv.corp.google.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
	<1453260880-628-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 22:23:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM0Dr-00040u-FO
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 22:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbcATVXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 16:23:20 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58335 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751773AbcATVXS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 16:23:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4CDA63CFF5;
	Wed, 20 Jan 2016 16:23:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oUNlR8Ifyd8tiXrIh8EMb3evaB0=; b=Jp+JcS
	fdnshpFm0rDyWYmDrUQkbP3becdkqNVKk3UKWXDHuYKJbBL763b/DrM+sTrz/JUX
	MUFQg/lANxsZA8LoVj1hdZXRZeMAKpP41+ftKNzWHOrS+kda4lDTdmVKgYFzHBrY
	XX3wWiDuOuk4UsrxEbmeK36zJtMFhB/kaOixk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x9z1RrEGqFWlThRoZpo/DaRixZIQrtae
	7wtzbig3M95weytXfm14Jk1cGGFtid4X+8ytNMCm8+2ZjuF7JZSLLFInGjgOvezG
	+wmLGBP0IlzmhvIPptHErzYjNWyRKOAEx9kg1PDPoovSrvZZj4M5ODb7m1Q4RJdM
	bJSP1rem55E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 449073CFF4;
	Wed, 20 Jan 2016 16:23:18 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B37173CFF3;
	Wed, 20 Jan 2016 16:23:17 -0500 (EST)
In-Reply-To: <1453260880-628-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 19 Jan 2016 19:34:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 05D83D72-BFBC-11E5-9A62-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284469>

Stefan Beller <sbeller@google.com> writes:

> We need the submodule groups in a later patch.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule-config.c | 13 +++++++++++++
>  submodule-config.h |  1 +
>  2 files changed, 14 insertions(+)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index a32259e..b5453d0 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -60,6 +60,8 @@ static void free_one_config(struct submodule_entry *entry)
>  {
>  	free((void *) entry->config->path);
>  	free((void *) entry->config->name);
> +	if (entry->config->groups)
> +		string_list_clear(entry->config->groups, 0);

You are allocating entry->config->groups itself in the in the hunk
around ll.327, so that also need to be freed, I would think.

>  	free(entry->config);
>  }
>  
> @@ -184,6 +186,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
>  	submodule->update = NULL;
>  	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
>  	submodule->ignore = NULL;
> +	submodule->groups = NULL;
>  
>  	hashcpy(submodule->gitmodules_sha1, gitmodules_sha1);
>  
> @@ -324,6 +327,16 @@ static int parse_specific_submodule_config(const char *subsection, int subsectio
>  			free((void *) submodule->update);
>  			submodule->update = xstrdup(value);
>  		}
> +	} else if (!strcmp(key, "group")) {
> +		if (!value)
> +			ret = config_error_nonbool(var);
> +		else {
> +			if (!submodule->groups) {
> +				submodule->groups = xmalloc(sizeof(*submodule->groups));
> +				string_list_init(submodule->groups, 1);
> +			}
> +			string_list_insert(submodule->groups, value);
> +		}
>  	}
>  
>  	return ret;
> diff --git a/submodule-config.h b/submodule-config.h
> index d9bbf9a..332f5be 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -17,6 +17,7 @@ struct submodule {
>  	const char *update;
>  	/* the sha1 blob id of the responsible .gitmodules file */
>  	unsigned char gitmodules_sha1[20];
> +	struct string_list *groups;
>  };

Is there a case where you need to enumerate and show the groups a
submodule belongs to to the end users?  Using string_list_insert()
to manage this list would mean you will lose the original ordering
you saw the list of groups in their .gitmodules files, which may or
may not matter.  I'd assume that the ordering should not matter, but
that is something the user may want to see documented.

>  
>  int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
