From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] submodule-config: keep labels around
Date: Tue, 10 May 2016 18:15:38 -0700
Message-ID: <xmqqh9e5l7id.fsf@gitster.mtv.corp.google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<1462928397-1708-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de, git@vger.kernel.org,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 11 03:15:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Ikc-0002vY-Rh
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 03:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbcEKBPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 21:15:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62347 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751231AbcEKBPm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 21:15:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 020711BA04;
	Tue, 10 May 2016 21:15:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QmlN+3hvhp9sHhu6afu5dxQrVGo=; b=LvFIIG
	LnyCsNCvSBfnMRGBRFSvl56E+ZsOESaFLUnH3lQxKVNa996fsUZWgdlb3Jt8ECSw
	EMu2ZexGZRkUOy/NruoLaL1rLV8wplb2dWWzJQmEPB26VKfMPogsY7fsovnKvAjT
	bQaSJEPpeJ8VKWNq285XrGnJLwOxlQG15g3Pw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P7K2SPTNn2viNQ3gaA7MLvPCW/et2mle
	qetSDNUYJwpsHGWY0f9Fgh87jOU4+Uyms11ZifqRiEHoVrwsj7rigP7SfeDAO+Sh
	8hc6dh7CzwjA9Mw0JTIkueB7EcorNhcGNsj3Gpy/p52Q9swr+I7t9zXtDQUzFoFK
	RPvqBp5iQ9Y=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED76A1BA03;
	Tue, 10 May 2016 21:15:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 677B71BA02;
	Tue, 10 May 2016 21:15:40 -0400 (EDT)
In-Reply-To: <1462928397-1708-4-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 10 May 2016 17:59:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E0378A9E-1715-11E6-B66B-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294220>

Stefan Beller <sbeller@google.com> writes:

> @@ -199,6 +203,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
>  	submodule->update_strategy.command = NULL;
>  	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
>  	submodule->ignore = NULL;
> +	submodule->labels = NULL;

Hmph, is there a reason to do this, instead of embedding an instance
of "struct string_list" inside submodule structure?

I am not yet claiming that embedding is better.  Just wondering if
it makes it easier to handle initialization as seen in the hunk
below, and also _clear() procedure.

> @@ -353,6 +358,17 @@ static int parse_config(const char *var, const char *value, void *data)
>  		else if (parse_submodule_update_strategy(value,
>  			 &submodule->update_strategy) < 0)
>  				die(_("invalid value for %s"), var);
> +	} else if (!strcmp(item.buf, "label")) {
> +		if (!value)
> +			ret = config_error_nonbool(var);
> +		else {
> +			if (!submodule->labels) {
> +				submodule->labels =
> +					xmalloc(sizeof(*submodule->labels));
> +				string_list_init(submodule->labels, 1);
> +			}
> +			string_list_insert(submodule->labels, value);
> +		}
>  	}
