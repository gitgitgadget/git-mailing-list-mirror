From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] http: use credential API to handle proxy authentication
Date: Mon, 02 Nov 2015 14:54:51 -0800
Message-ID: <xmqqbnbcdnb8.fsf@gitster.mtv.corp.google.com>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
	<1446483264-15123-1-git-send-email-k.franke@science-computing.de>
	<1446483264-15123-3-git-send-email-k.franke@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Mon Nov 02 23:55:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtO0B-00038o-58
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 23:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbbKBWyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 17:54:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53228 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751415AbbKBWyy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 17:54:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 52D692773E;
	Mon,  2 Nov 2015 17:54:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ChBMYe/tKFacJEhNDloJ3rhD6Oo=; b=Nl+3Qp
	P5L4Wop20AKqNaQiCaoj0VIVG739yQIIBRImrjARCe4EPZD2EKG0idDJ9S0n1svU
	vr6Mu/GMyDg/Qd91s6a5PRoomDIA/GlzEQhvMLU1X1kvDYggxC90ua8NgAPRvvbP
	BaYG/JvcgVg0ZNS0PKEalDd96+zQqbTnysgQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mTEYw+js3OCis7/agEx0ylEdnVo5dHiA
	1E12Ozgr/82eZFAiHQx/TnfzK5nb1gRhuBDKNH1Nivl9FqbgnJewSantKE7SEhEf
	Z2ZCVr0+U5SceyiVHs2yqc49L2PgZm3LVIAdfNBdr6e7sqtgj55+VcNL0iSV1bXf
	UZ+lMAjl+mo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4B4EE2773D;
	Mon,  2 Nov 2015 17:54:53 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CA1CA2773C;
	Mon,  2 Nov 2015 17:54:52 -0500 (EST)
In-Reply-To: <1446483264-15123-3-git-send-email-k.franke@science-computing.de>
	(Knut Franke's message of "Mon, 2 Nov 2015 17:54:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BA8A7AAA-81B4-11E5-A86F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280735>

Knut Franke <k.franke@science-computing.de> writes:

> Currently, the only way to pass proxy credentials to curl is by including them
> in the proxy URL. Usually, this means they will end up on disk unencrypted, one
> way or another (by inclusion in ~/.gitconfig, shell profile or history). Since
> proxy authentication often uses a domain user, credentials can be security
> sensitive; therefore, a safer way of passing credentials is desirable.
>
> If the configured proxy contains a username but not a password, query the
> credential API for one. Also, make sure we approve/reject proxy credentials
> properly.
>
> For consistency reasons, add parsing of http_proxy/https_proxy/all_proxy
> environment variables, which would otherwise be evaluated as a fallback by curl.
> Without this, we would have different semantics for git configuration and
> environment variables.
>
> Signed-off-by: Knut Franke <k.franke@science-computing.de>
> Reviewed-by: Junio C Hamano <gitster@pobox.com>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

As 1/2, I never reviewed this version yet.

> ---
>  http.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  http.h |  1 +
>  2 files changed, 75 insertions(+), 2 deletions(-)
>
> diff --git a/http.c b/http.c
> index 1172819..5708c7a 100644
> --- a/http.c
> +++ b/http.c
> @@ -62,7 +62,7 @@ static const char *ssl_cainfo;
>  static long curl_low_speed_limit = -1;
>  static long curl_low_speed_time = -1;
>  static int curl_ftp_no_epsv;
> -static const char *curl_http_proxy;
> +static const char *curl_http_proxy = NULL;
>  static const char *http_proxy_authmethod = NULL;

We do not do unnecessary initialization of file-scope globals to 0
or NULL.  The existing definition of curl_http_proxy is correct;
the one for http_proxy_authmethod needs to be changed to match.

>  static void init_curl_proxy_auth(CURL *result)
>  {
> +	if (proxy_auth.username) {
> +		if (!proxy_auth.password)
> +			credential_fill(&proxy_auth);
> +#if LIBCURL_VERSION_NUM >= 0x071301
> +		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME,
> +			proxy_auth.username);
> +		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD,
> +			proxy_auth.password);
> +#else
> +		struct strbuf s = STRBUF_INIT;
> +		strbuf_addstr_urlencode(&s, proxy_auth.username, 1);
> +		strbuf_addch(&s, ':');
> +		strbuf_addstr_urlencode(&s, proxy_auth.password, 1);
> +		curl_proxyuserpwd = strbuf_detach(&s, NULL);
> +		curl_easy_setopt(result, CURLOPT_PROXYUSERPWD, curl_proxyuserpwd);
> +#endif

I think #else clause of this thing would introduce decl-after-stmt
compilation error.
