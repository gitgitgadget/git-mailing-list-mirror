From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv9 1/6] submodule-config: keep update strategy around
Date: Tue, 09 Feb 2016 13:08:53 -0800
Message-ID: <xmqqh9hh382i.fsf@gitster.mtv.corp.google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
	<1455051274-15256-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 22:09:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTFWu-0007ao-9l
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 22:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932775AbcBIVI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 16:08:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932209AbcBIVI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 16:08:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6F9444306D;
	Tue,  9 Feb 2016 16:08:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3wElrclaxiBJjXFY7FGaykC5a8M=; b=qDvMcc
	z4EJthfxltv33wJtksevRNNuyTvHswlLXs/YVdOOuWM5s2bHrrYxkdqGyMu4f50F
	PtO4Ur/7wB8VRVat3/D2hDM+28KSxccqqlG9KeLswbusBIcY1tAE5mb6Vu0UQLZA
	KcyPXRmB4PjZ9SSEgccXBhYpdW5vS2xuvNwhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uz1naCFfGMvfYGtvLv6NhEtMnwQ5L6yL
	IFa+WspIiHzQPAN0x2Zc0txCBVdqZz6Ce94Io493aE/LIRnSOahgDqnB+CkDakuS
	YWgsy40bvNiaWcJX/wwZ0R4Nj2gJ6jSDcduZFORYv4xRxwEQWTc6oBN85r2h28Lw
	iuoz5q7H5PY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 647D44306C;
	Tue,  9 Feb 2016 16:08:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CB3434306B;
	Tue,  9 Feb 2016 16:08:54 -0500 (EST)
In-Reply-To: <1455051274-15256-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 9 Feb 2016 12:54:29 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 53C75936-CF71-11E5-A63E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285867>

Stefan Beller <sbeller@google.com> writes:

> Currently submodule.<name>.update is only handled by git-submodule.sh.
> C code will start to need to make use of that value as more of the
> functionality of git-submodule.sh moves into library code in C.
>
> Add the update field to 'struct submodule' and populate it so it can
> be read as sm->update or from sm->update_command.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule-config.c | 22 ++++++++++++++++++++++
>  submodule-config.h | 11 +++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index afe0ea8..a1af5de 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -194,6 +194,8 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
>  
>  	submodule->path = NULL;
>  	submodule->url = NULL;
> +	submodule->update = SM_UPDATE_UNSPECIFIED;
> +	submodule->update_command = NULL;
>  	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
>  	submodule->ignore = NULL;
>  
> @@ -311,6 +313,26 @@ static int parse_config(const char *var, const char *value, void *data)
>  			free((void *) submodule->url);
>  			submodule->url = xstrdup(value);
>  		}
> +	} else if (!strcmp(item.buf, "update")) {
> +		if (!value)
> +			ret = config_error_nonbool(var);
> +		else if (!me->overwrite &&
> +		    submodule->update != SM_UPDATE_UNSPECIFIED)

Funny indentation here (locally fixable).

Thanks to this change, we do not need "'!= NULL' removal" for this
location in 2/6.

> +			warn_multiple_config(me->commit_sha1, submodule->name,
> +					     "update");
> +		else {
> +			submodule->update_command = NULL;
> +			if (!strcmp(value, "none"))
> +				submodule->update = SM_UPDATE_NONE;
> +			else if (!strcmp(value, "checkout"))
> +				submodule->update = SM_UPDATE_CHECKOUT;
> +			else if (!strcmp(value, "rebase"))
> +				submodule->update = SM_UPDATE_REBASE;
> +			else if (!strcmp(value, "merge"))
> +				submodule->update = SM_UPDATE_MERGE;
> +			else if (!skip_prefix(value, "!", &submodule->update_command))
> +				die(_("invalid value for %s"), var);
> +		}
>  	}
>  
>  	strbuf_release(&name);
> diff --git a/submodule-config.h b/submodule-config.h
> index 9061e4e..e3bd56e 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -4,6 +4,15 @@
>  #include "hashmap.h"
>  #include "strbuf.h"
>  
> +enum submodule_update_type {
> +	SM_UPDATE_CHECKOUT,
> +	SM_UPDATE_REBASE,
> +	SM_UPDATE_MERGE,
> +	SM_UPDATE_NONE,
> +	SM_UPDATE_COMMAND,
> +	SM_UPDATE_UNSPECIFIED
> +};
> +
>  /*
>   * Submodule entry containing the information about a certain submodule
>   * in a certain revision.
> @@ -14,6 +23,8 @@ struct submodule {
>  	const char *url;
>  	int fetch_recurse;
>  	const char *ignore;
> +	enum submodule_update_type update;
> +	const char *update_command;
>  	/* the sha1 blob id of the responsible .gitmodules file */
>  	unsigned char gitmodules_sha1[20];
>  };
