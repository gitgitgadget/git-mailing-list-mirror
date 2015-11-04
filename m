From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] http: allow selection of proxy authentication method
Date: Wed, 04 Nov 2015 11:42:51 -0800
Message-ID: <xmqqlhada6v8.fsf@gitster.mtv.corp.google.com>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
	<1446628405-8070-1-git-send-email-k.franke@science-computing.de>
	<1446628405-8070-2-git-send-email-k.franke@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:43:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu3xT-0001bp-0O
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 20:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174AbbKDTmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 14:42:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751633AbbKDTmx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 14:42:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 06D6A27792;
	Wed,  4 Nov 2015 14:42:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pzJ2i1GnSQgw3o4ZZTi4CxDDPGA=; b=qTiLOp
	lyAqrFA/uIEQuR9Vo4sYQGJfoG3L47IQup9xVtYQEOb5IsN/7Cn2NvKxgXIe4DLN
	0RjPguoJ/53yJu3C3CEwd+SRB4Fai8P3d+SLwHYFxFW46LM2Vx/ZwDPxIga0g0QG
	WN3sZvDjmW6CN8mZXcFYGVgoIqFVMCYFJ5p4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vFyKEIbbQxoptVOf+EvSMaiS5DEQw3SL
	brFZqFnbPlUxPz16+ii9YMmM9eaQtcQU0jbKzpwM6pwWBv2ceB3OF0IsVD50Wz5J
	UfLwlHTgrcUaQmcX8XVbiyUzS4GOyNEuC/7koY56XEPxZzGLN7ROkZUkyN1kKm2B
	RcxOTE7qtdE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F3B0727791;
	Wed,  4 Nov 2015 14:42:52 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8E3D227790;
	Wed,  4 Nov 2015 14:42:52 -0500 (EST)
In-Reply-To: <1446628405-8070-2-git-send-email-k.franke@science-computing.de>
	(Knut Franke's message of "Wed, 4 Nov 2015 10:13:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3CC3E9DE-832C-11E5-A50B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280869>

Knut Franke <k.franke@science-computing.de> writes:

> diff --git a/http.c b/http.c
> index 7da76ed..a786802 100644
> --- a/http.c
> +++ b/http.c
> @@ -305,6 +326,40 @@ static void init_curl_http_auth(CURL *result)
>  #endif
>  }
>  
> +/* assumes *var is free-able */

This is not just "assumes", but it is wrong for the callers to pass
unfreeable memory, so

	/* *var must be free-able */

> +static void var_override(const char **var, char *value)
> +{
> +	if (value) {
> +		free((void*) *var);

There may be a similar whitespace damage but I happened to notice
this one.

	free((void *)*var);

> +static void init_curl_proxy_auth(CURL *result)
> +{
> +	var_override(&http_proxy_authmethod, getenv("GIT_HTTP_PROXY_AUTHMETHOD"));

If your libcurl does not understand CURLOPT_PROXYAUTH, do you need
to do this var_override()?  Shouldn't this be inside the #if..#endif
below?

> +
> +#if LIBCURL_VERSION_NUM >= 0x070a07 /* CURLOPT_PROXYAUTH and CURLAUTH_ANY */
> +	if (http_proxy_authmethod) {
> +...
> +	else
> +		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> +#endif
> +}

Other than that, looks cleanly done.  Thanks.
