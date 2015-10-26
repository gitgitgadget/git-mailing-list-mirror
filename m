From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] remote-http(s): Support SOCKS proxies
Date: Mon, 26 Oct 2015 13:15:17 -0700
Message-ID: <xmqq7fm9gze2.fsf@gitster.mtv.corp.google.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
	<bf218d020e24216f55d1514c4459e645b13ec075.1445865176.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 26 21:15:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqoBM-00077B-75
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 21:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbbJZUPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 16:15:21 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751059AbbJZUPU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 16:15:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5CD0E26CA6;
	Mon, 26 Oct 2015 16:15:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=No3oXavg1KnqwAJsEMQdNEBDr/E=; b=ZRb/gd
	C1Z/+uOLA/I99P76/YCtO1eMCrJa2oHdeB6VqBXXzxeZiMdmX++fFO8tjl4NEB9b
	hz5RlzHt/VocQztBntqrnEZMMHiSSvPPIb+it3grnacq6X+Il8boaNKYI82G9DqP
	TVpePjJdshOvieMeVIGJ58RtprQOhs9cWcGvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WOO53YYMon0Gbkyw865MyLyylka+j8og
	cN4w/K+gupZeuXmjlXLsj+ssM2dxzTnjpglCijSQyp3816BXHX827viOB8r97Ryb
	qp3Qp1bJnuI67JVKs05TNTnWGmmRjR+QUSSyLKZKNV/omM1EEdT9AUnk/M08VUld
	OYIEAoglke4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 54A5026CA5;
	Mon, 26 Oct 2015 16:15:19 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CFB0726CA4;
	Mon, 26 Oct 2015 16:15:18 -0400 (EDT)
In-Reply-To: <bf218d020e24216f55d1514c4459e645b13ec075.1445865176.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 26 Oct 2015 14:15:07 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 471D2072-7C1E-11E5-BDC3-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280217>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This patch was required to work behind a faulty AP and scraped from
> http://stackoverflow.com/questions/15227130/#15228479 and guarded with
> an appropriate cURL version check by Johannes Schindelin.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks.

The code looks OK but the last paragraph makes _us_ worried.  What
is the licensing status of the original at SO?  I can see that you
are taking legal responsibility with the Signed-off-by: line; you
state that to the best of your knowledge the patch is covered under
an appropriate open source license and you ahve the right under that
license to submit it here to the project.

But it is my job to double check when in doubt, hence this question.

> ---
>  http.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/http.c b/http.c
> index 7da76ed..6b89dea 100644
> --- a/http.c
> +++ b/http.c
> @@ -465,6 +465,17 @@ static CURL *get_curl_handle(void)
>  
>  	if (curl_http_proxy) {
>  		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> +#if LIBCURL_VERSION_NUM >= 0x071800
> +		if (starts_with(curl_http_proxy, "socks5"))
> +			curl_easy_setopt(result,
> +				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5);
> +		else if (starts_with(curl_http_proxy, "socks4a"))
> +			curl_easy_setopt(result,
> +				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4A);
> +		else if (starts_with(curl_http_proxy, "socks"))
> +			curl_easy_setopt(result,
> +				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
> +#endif
>  	}
>  #if LIBCURL_VERSION_NUM >= 0x070a07
>  	curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
