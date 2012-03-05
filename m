From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] http: try http_proxy env var when http.proxy
 config option is not set
Date: Mon, 05 Mar 2012 09:30:30 -0800
Message-ID: <7v4nu32bwp.fsf@alter.siamese.dyndns.org>
References: <4F54D91C.6080905@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Mon Mar 05 18:30:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4bk5-0006wJ-Fb
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 18:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756438Ab2CERad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 12:30:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55459 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755509Ab2CERac (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 12:30:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E088A7516;
	Mon,  5 Mar 2012 12:30:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xnoo4po0cz22bcgOLb+fXAMZSkA=; b=tGeXMA
	LxV3aMfT+aBGi9U6jTIiH5tJEIR1pXhIpR1kX7Vkj3u4jEJtnIvzKIw6sJiWtVqP
	jKNdHN8FDfuhzsHL+NAXGoY5QdTnmXONwhhgM6vFxTHOTgYSdFQ1Z4MVzS6tjJ5E
	dsyF8eOand7xFfRR1GVjCbkZ70w2N55yGkC1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PsAjBlw9nZoi6cGibcGdCxs4tLGfeb77
	kP91kn9Dk7xypRKcwOmkIek37j2FSDc8ba+zdkbY630oPWsZau2XtZhxpgiy3qcj
	mYRtgUWUFb5QM8I3xnb8Ij8YyvEeTy4m9Wk6T6cJCz7zvAOAQgmpnEYiOLSzB7gj
	3usj1+ycP5M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D70D97515;
	Mon,  5 Mar 2012 12:30:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66DFA7514; Mon,  5 Mar 2012
 12:30:31 -0500 (EST)
In-Reply-To: <4F54D91C.6080905@seap.minhap.es> (Nelson Benitez Leon's message
 of "Mon, 05 Mar 2012 16:17:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E85796A6-66E8-11E1-B3B8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192255>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> cURL already reads it, but if $http_proxy has username but no password
> cURL will not ask you for the password and so failed to authenticate
> returning a 407 error code. So we read it ourselves to detect that and
> ask for the password. Also we read it prior to connection to be able to
> make a proactive authentication in case the flag http_proactive_auth is
> set.
>
> Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
> ---

The above does not address my earlier worries about compatibility
across curl applications (it does not even say "it does not matter;
we do not care about other's application"), so let's spell it out
again.  When the user has

	http_proxy=http://me@proxy.example.com
	export http_proxy

with your patch, git might do whatever we desire to do, and the end
result may be better, but how would the user experience be for the
user when using other curl based programs on the same system?

Also I thought the conclusion from the other thread was that even if
we were to do this, we should apply the http_proxy environment only
when we are talking to http:// and for https:// we would instead
read HTTPS_PROXY or something?

>  http.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/http.c b/http.c
> index 8ac8eb6..8932da5 100644
> --- a/http.c
> +++ b/http.c
> @@ -295,6 +295,13 @@ static CURL *get_curl_handle(void)
>  	if (curl_ftp_no_epsv)
>  		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
>  
> +	if (!curl_http_proxy) {
> +		const char *env_proxy;
> +		env_proxy = getenv("http_proxy");
> +		if (env_proxy) {
> +			curl_http_proxy = xstrdup(env_proxy);
> +		}
> +	}
>  	if (curl_http_proxy) {
>  		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>  		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
