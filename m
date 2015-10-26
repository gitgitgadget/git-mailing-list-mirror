From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] http: allow selection of proxy authentication method
Date: Mon, 26 Oct 2015 13:33:42 -0700
Message-ID: <xmqqk2q9fjyx.fsf@gitster.mtv.corp.google.com>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Mon Oct 26 21:33:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqoSk-00084z-3L
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 21:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbbJZUdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 16:33:46 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751399AbbJZUdp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 16:33:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 70835252AC;
	Mon, 26 Oct 2015 16:33:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M/R4QtPr6XVRs22W1xWChTsxyPU=; b=IvvMLX
	JJYFAsy0LX1oEwqeNZgnEb9XFDR38IhB+7tfIoUCymrUH+XnIsviaWRAPx09vXcK
	r0tEzmGhmIUVnUI0qD1q18rAmwp7ihbRKTDlgHFKLlRDEYtDyCeNdvRqvNQhjy2e
	PA4IgNIRZAMQTZ5UvGITZfKfhNUFn3FTlZCrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xx3T0AT+T71Q13mbgKYWFFsG9OJZjPwe
	JQClZns8UOzH+Uad9nelNB8ODcy2imDiAVVsiL7Fkfp0kQ2yTQNLHEn5IQtDVb0F
	1+SWTi8EQjvHowMubypngKhA3LLIFCBMe6A+vGNYqHQJb/D+uPBuP3fNu3beU/r+
	ounmM4PrdoI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 67DA7252AB;
	Mon, 26 Oct 2015 16:33:44 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CAB9E252A3;
	Mon, 26 Oct 2015 16:33:43 -0400 (EDT)
In-Reply-To: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
	(Knut Franke's message of "Mon, 26 Oct 2015 18:55:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D9BBB856-7C20-11E5-BE26-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280222>

Knut Franke <k.franke@science-computing.de> writes:

> CURLAUTH_ANY does not work with proxies which answer unauthenticated requests
> with a 307 redirect to an error page instead of a 407 listing supported
> authentication methods. Therefore, allow the authentication method to be set
> using the environment variable GIT_HTTP_PROXY_AUTHMETHOD or configuration
> variables http.proxy-authmethod and remote.<name>.proxy-authmethod (in analogy
> to http.proxy and remote.<name>.proxy).

Please do not name configuration variable with dashes (or
underscores).  There still may be existing aberrations that are
deprecated and need to be removed over time that are misnamed, but
the core git variables are named without dashes and underscores.

Call yours "http.proxyAuthmethod" in the documentation, and use
strcmp("http.proxyauthmethod", var) in the options callback code.

> +static void init_curl_proxy_auth(CURL *result)
> +{
> +    set_from_env(&http_proxy_authmethod, "GIT_HTTP_PROXY_AUTHMETHOD");

Strange indentation here...

> +
> +	if (http_proxy_authmethod) {
> +		if (!strcmp(http_proxy_authmethod, "basic"))
> +			curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_BASIC);
> +		else if (!strcmp(http_proxy_authmethod, "digest"))
> +			curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_DIGEST);
> +		else if (!strcmp(http_proxy_authmethod, "negotiate"))
> +			curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_GSSNEGOTIATE);
> +		else if (!strcmp(http_proxy_authmethod, "ntlm"))
> +			curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_NTLM);
> +#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
> +		else if (!strcmp(http_proxy_authmethod, "anyauth"))
> +			curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> +#endif
> +		// CURLAUTH_DIGEST_IE has no corresponding command-line option in
> +		// curl(1) and is not included in CURLAUTH_ANY, so we leave it out
> +		// here, too
> +		else
> +			error("Unknown proxy authentication method: %s",
> +			      http_proxy_authmethod);

Along the same line as how we do sslversions[] instead of a long
if/else if/ chain is preferrable.

Thansk.
