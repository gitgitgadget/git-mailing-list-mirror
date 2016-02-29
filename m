From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: honor no_http env variable to bypass proxy
Date: Mon, 29 Feb 2016 11:29:40 -0800
Message-ID: <xmqqio179uxn.fsf@gitster.mtv.corp.google.com>
References: <5652e025323b60ccf5a59bcbdc7266d4f4e32fc4.1456758964.git.xin.jiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Jiang Xin <xin.jiang@huawei.com>,
	Knut Franke <k.franke@science-computing.de>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 20:29:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTVr-0005VF-Sf
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbcB2T3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:29:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751390AbcB2T3n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:29:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EAF3A4832C;
	Mon, 29 Feb 2016 14:29:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NPGdATYlDLUMpK+KN80yg+4VD9k=; b=Smz/KR
	MSN+9HjXcNRliC2Ip+4piuB6MyKcIYHVVNtHVmyIpg+rLxH8kwxZvABXmFJo0sL0
	MBR/SZePuwiaYDIV/EIrYm/MCVxFqLI4aZ6tj9+srqFBUjuTyy4yW8YNFoXvVPGm
	hAigyD4TnxiCaTzxEeO4lZdkDYGkZbAJyYX50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DpGGNcT+XwGefwbPnXjPxsGiQjci2E4b
	o0bbXXx4qNH5YUTWJlhaoKR0sfD2tDD3eNIeaqyyyIg0CH2E/03Z++dyBgT/DE1S
	p8GKC2bGMXpkrIUUMCqmceLzk8gZZeviz2HZJ5foozWfvRaERDLpxznngSaSpNSt
	naToH4wMK7o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E21AF4832B;
	Mon, 29 Feb 2016 14:29:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5415248327;
	Mon, 29 Feb 2016 14:29:41 -0500 (EST)
In-Reply-To: <5652e025323b60ccf5a59bcbdc7266d4f4e32fc4.1456758964.git.xin.jiang@huawei.com>
	(Jiang Xin's message of "Mon, 29 Feb 2016 23:16:57 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C77B555E-DF1A-11E5-8403-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287888>

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <xin.jiang@huawei.com>
>
> Curl and its families honor several proxy related environment variables:
>
> * http_proxy and https_proxy define proxy for http/https connections.
> * no_proxy (a comma separated hosts) defines hosts bypass the proxy.
>
> This command will bypass the bad-proxy and connect to the host directly:
>
>     no_proxy=* https_proxy=http://bad-proxy/ \
>     curl -sk https://google.com/
>
> Before commit 372370f (http: use credential API to handle proxy auth...),
> Environment variable "no_proxy" will take effect if the config variable
> "http.proxy" is not set.  So the following comamnd won't fail if not
> behind a firewall.
>
>     no_proxy=* https_proxy=http://bad-proxy/ \
>     git ls-remote https://github.com/git/git
>
> But commit 372370f not only read git config variable "http.proxy", but
> also read "http_proxy" and "https_proxy" environment variables, and set
> the curl option using:
>
>     curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
>
> This caused "no_proxy" environment variable not working any more.
>
> Set extra curl option "CURLOPT_NOPROXY" will fix this issue.
>
> Signed-off-by: Jiang Xin <xin.jiang@huawei.com>
> ---
>  http.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Sounds sensible; I am guessing that this is 2.8.0-rc0 regression
that we need to fast-track?

Knut, does this look good?

Thanks.

> diff --git a/http.c b/http.c
> index 1d5e3bb..69da445 100644
> --- a/http.c
> +++ b/http.c
> @@ -70,6 +70,7 @@ static long curl_low_speed_limit = -1;
>  static long curl_low_speed_time = -1;
>  static int curl_ftp_no_epsv;
>  static const char *curl_http_proxy;
> +static const char *curl_no_proxy;
>  static const char *http_proxy_authmethod;
>  static struct {
>  	const char *name;
> @@ -624,6 +625,11 @@ static CURL *get_curl_handle(void)
>  		}
>  
>  		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
> +#if LIBCURL_VERSION_NUM >= 0x071304
> +		var_override(&curl_no_proxy, getenv("NO_PROXY"));
> +		var_override(&curl_no_proxy, getenv("no_proxy"));
> +		curl_easy_setopt(result, CURLOPT_NOPROXY, curl_no_proxy);
> +#endif
>  	}
>  	init_curl_proxy_auth(result);
