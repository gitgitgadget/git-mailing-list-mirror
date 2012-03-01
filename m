From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] http: when proxy url has username but no
 password, ask for password
Date: Thu, 01 Mar 2012 11:16:18 -0800
Message-ID: <7vty28m8sd.fsf@alter.siamese.dyndns.org>
References: <4F4FBE6C.5050507@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Thu Mar 01 20:16:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3BUL-0004nC-Nk
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 20:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860Ab2CATQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 14:16:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37506 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964801Ab2CATQV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 14:16:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 339406EF2;
	Thu,  1 Mar 2012 14:16:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6pLauVnv0anWNe00pSsHXyZQXdE=; b=obfdu4
	J1ThZYbBe5Ht8rXV1nUnBCFYKUIMy8gwCSSiVCsJgoqAv0qxJUz2JB9y8ay4ePi3
	7EDg+MJcx1EYyZBkgmm4n1pTSSEK8yJDjTPht+B/a//NxxQmwWFwvLXCDsj7rRAv
	12ELxlH6Yv7Hlkv8yZvBqP/Odop1MLzuqGcW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K4IaHxsbmQ3jFFaq8ECNbEf7tL/y9H8c
	eR+SV9jOz5/ZdWf0Trt7XADZZMiSzuJbTizN8AVeL2SLTZiaOwZ/WBU+I7NfXN/d
	M+6bvra9KDp0q2Bx9GXnOtLQjNZ7yGIz9+g9hHEJbx+eRCpemTxRMnM1Gw4wyCyf
	eVK+H98PT6o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A8316EEE;
	Thu,  1 Mar 2012 14:16:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EF126EEB; Thu,  1 Mar 2012
 14:16:20 -0500 (EST)
In-Reply-To: <4F4FBE6C.5050507@seap.minhap.es> (Nelson Benitez Leon's message
 of "Thu, 01 Mar 2012 19:22:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 070C265C-63D3-11E1-AF35-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191960>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> Support proxy urls with username but without a password, in which
> case we interactively ask for the password (using credential api).
> This makes possible to not have the password written down in
> http_proxy env var or in http.proxy config option.

How do other people's applications that use http_proxy environment
variable handle this situation?

With this patch and the previous 2/3, we are allowing people to set
"http_proxy=http://me@over.there/", but an environment variable is global
to the user's environment, so if other applications do not grok the "name
only" proxy URL the same way as this patch does, adding this code only to
Git does not make users' lives any better.

Of course the above does not apply to http.proxy configuration, which is
specific to Git.

>
> Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
> ---
>  http.c |   16 +++++++++++++++-
>  1 files changed, 15 insertions(+), 1 deletions(-)
>
> diff --git a/http.c b/http.c
> index 8932da5..5916194 100644
> --- a/http.c
> +++ b/http.c
> @@ -43,6 +43,7 @@ static int curl_ftp_no_epsv;
>  static const char *curl_http_proxy;
>  static const char *curl_cookie_file;
>  static struct credential http_auth = CREDENTIAL_INIT;
> +static struct credential proxy_auth = CREDENTIAL_INIT;
>  static int http_proactive_auth;
>  static const char *user_agent;
>  
> @@ -303,7 +304,20 @@ static CURL *get_curl_handle(void)
>  		}
>  	}
>  	if (curl_http_proxy) {
> -		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> +		credential_from_url(&proxy_auth, curl_http_proxy);
> +		if (proxy_auth.username != NULL && proxy_auth.password == NULL) {

Just a style, but 

		if (proxy_auth.username && !proxy_auth.password) {

is much more preferred.

> +			free ((void *)curl_http_proxy);

I think somebody already pointed out interaction of this with 2/3.
