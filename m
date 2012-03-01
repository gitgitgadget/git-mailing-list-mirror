From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] http: try http_proxy env var when http.proxy
 config option is not set
Date: Thu, 01 Mar 2012 11:10:38 -0800
Message-ID: <7vy5rkm91t.fsf@alter.siamese.dyndns.org>
References: <4F4FBE0F.6020004@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Thu Mar 01 20:10:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3BOp-000114-1p
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 20:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785Ab2CATKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 14:10:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33718 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964772Ab2CATKk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 14:10:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF6BF6C67;
	Thu,  1 Mar 2012 14:10:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JHw+P3pl7dRl9qaEPooJ/B9/u+g=; b=YhDBHl
	DAzFt8wB/OGJ1YLHWeUMVlfAWTNbfcck0N5xkiktsAafF7OkkCIpLfionkCBehzj
	Eq8XwpzZCzh4XfnXZii/STxM7c2ud2f7rv3YWkA3ErVf/9fDga63sJfs4hgemkXX
	OAxutvhgzZcQNTRoYplcyQ0rCRvwgbXDi6ReI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j0fcKeUNSDbXYU5MHdSaX8C87yQ3vOJm
	bmSkv7QcvJ2f3PuRn8rSrLk8B9VNY7kXRu/JSG0n2eAziHppX9c25dh2wFSW+qKT
	z5CD5GvpAPsXIJMkMUmAZ+YVy9wm2Um4mebtYTQ+DjjN+23/y6gEllonOsgNBShr
	ZFliIVnZY8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E20056C66;
	Thu,  1 Mar 2012 14:10:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C24A6C64; Thu,  1 Mar 2012
 14:10:39 -0500 (EST)
In-Reply-To: <4F4FBE0F.6020004@seap.minhap.es> (Nelson Benitez Leon's message
 of "Thu, 01 Mar 2012 19:21:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3BC003A6-63D2-11E1-9C11-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191959>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> CuRL already reads it, but if $http_proxy has username but no password
> curl will not ask you for the password.. so we read it ourselves to
> detect that and ask for the password.

Please stop the double-dot.  Also your capitalization for cURL is screwed
up.

More importantly, please describe what happens after "will not ask".
"will not ask you for the password and the connection fails"?
"will not ask you for the password and the gives an error message saying
'authentication failure'"?

The logic in the patch, needless to say, seems OK, though.

Thanks.

>
> Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
> ---
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
