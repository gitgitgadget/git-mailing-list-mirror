From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/5] http: handle proxy proactive authentication
Date: Mon, 12 Mar 2012 15:25:43 -0700
Message-ID: <7vk42po3rs.fsf@alter.siamese.dyndns.org>
References: <4F5E31DB.5050900@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Mon Mar 12 23:25:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Dgd-00082p-Kv
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 23:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757703Ab2CLWZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 18:25:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44869 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755948Ab2CLWZq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 18:25:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92E146781;
	Mon, 12 Mar 2012 18:25:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nOsVPdmTq3F6Nl01i8JK0aY9FVU=; b=tVnvDx
	S81vM3mdu2gME9kZWnRwLVL7mZXprQtgrDxwoUbBbsYyaMZUWT5iLAooJEpdbkLY
	j5AYfKo3+JIt5rnNXjavueQ8RrkLLgs9BtQMbGfZnK8KHLTqVzDAJ+vn+vdddHN6
	9hoyryusvVU1iVXMI1/Ld1ufZT3uvEzcKPqLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gun3wgyqUpE9DtPgTkDXfcHY6sUq/PP5
	xSoP6ssGRNHan1Q4dzs4wFq6Zjj9svPpqNpq1jGWCiPJ6UWhmDriMAQ4Edkwzx7l
	acDgQTcN8XzX3RsAq5lQDqpDvX0K1lpV4ALp+CPLIfJIrvSOV0paQCLycSd45tzr
	02Csv+MWpVY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A2326780;
	Mon, 12 Mar 2012 18:25:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D529677E; Mon, 12 Mar 2012
 18:25:45 -0400 (EDT)
In-Reply-To: <4F5E31DB.5050900@seap.minhap.es> (Nelson Benitez Leon's message
 of "Mon, 12 Mar 2012 18:26:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F6BDCC2-6C92-11E1-8B74-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192963>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> If http_proactive_auth flag is set and there is a username
> but no password in the proxy url, then interactively ask for
> the password.
>
> This makes possible to not have the password written down in
> http_proxy env var or in http.proxy config option.
>
> Also take care that CURLOPT_PROXY don't include username or
> password, as we now set them in the new set_proxy_auth() function
> where we use their specific cURL options.
>
> Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
> ---
>  http.c |   27 ++++++++++++++++++++++++++-
>  1 files changed, 26 insertions(+), 1 deletions(-)

Just a minor style nit first so that we do not have to go ping-pong
on the trivialities.

> @@ -303,8 +318,18 @@ static CURL *get_curl_handle(void)
>  		}
>  	}
>  	if (curl_http_proxy) {
> -		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> +		if (!proxy_auth.host) { // check to parse only once

No C99 // comments.

> +			credential_from_url(&proxy_auth, curl_http_proxy);
> +		}
> +		if (http_proactive_auth && proxy_auth.username && !proxy_auth.password) {
> +			/* proxy string has username but no password, ask for password */
> +			credential_fill(&proxy_auth);
> +		}

No {} around single statement block (this comment applies also to
the previous "if (!proxy_auth.host)").

> +		char proxyhost[100];

No decl-after-statement.

> +		snprintf(proxyhost, 100, "%s://%s", proxy_auth.protocol, proxy_auth.host);

Wouldn't it be far more pleasant if you used strbuf_addf() for
things like this?  That way you do not have to wonder if a 100-byte
buffer is too small.

> +		curl_easy_setopt(result, CURLOPT_PROXY, proxyhost);
>  		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> +		set_proxy_auth(result);
>  	}
>  
>  	return result;
