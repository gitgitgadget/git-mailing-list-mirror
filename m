From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] http: factor out http error code handling
Date: Tue, 28 Aug 2012 11:06:52 -0700
Message-ID: <7vd32a28n7.fsf@alter.siamese.dyndns.org>
References: <20120827132145.GA17265@sigill.intra.peff.net>
 <20120827132604.GG17375@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Iain Paton <ipaton0@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 28 20:07:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6QBo-0005y8-PB
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 20:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603Ab2H1SG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 14:06:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42998 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752225Ab2H1SGy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 14:06:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DB6B939D;
	Tue, 28 Aug 2012 14:06:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=XGUxZHNptSS57s2kRord+QOA7yE=; b=CXbzNrW5MrG0jqMIzWa7
	4MldA9a+EvXwKKSB+yG3nKqbH0n2l4R/vOQWGsPlNKDE68SmBOSMRtXVvNNhI6DF
	Q/H1oYLE1xiT+kqMmtLH+hmO1yFtYYbX+88WB2d0/P8c5eVnTMBqyXFqZbqBAmni
	HjS58HuUuLcJsnu/l+yVGYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=MDXVA8H6fvz5M2SjWUVtwexFZiVpr9J9f4mlfM15iCB2xa
	30Zi/5LDsKiimSyNozrg6upA6AWekpxjATgrZjZLj5Zd2/29RaCeZdK1t4XzGqNg
	qz6NwzRew8k/InWOVdvSaVYyRvXm6X7bRVanDZQ+zNvbJpNzgmcMFy/sKiPlo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4ABC5939C;
	Tue, 28 Aug 2012 14:06:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A147B9399; Tue, 28 Aug 2012
 14:06:53 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 25C237DA-F13B-11E1-A97E-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204444>

Jeff King <peff@peff.net> writes:

> Most of our http requests go through the http_request()
> interface, which does some nice post-processing on the
> results. In particular, it handles prompting for missing
> credentials as well as approving and rejecting valid or
> invalid credentials. Unfortunately, it only handles GET
> requests. Making it handle POSTs would be quite complex, so
> let's pull result handling code into its own function so
> that it can be reused from the POST code paths.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  http.c | 51 ++++++++++++++++++++++++++++-----------------------
>  http.h |  1 +
>  2 files changed, 29 insertions(+), 23 deletions(-)
>
> diff --git a/http.c b/http.c
> index b61ac85..6793137 100644
> --- a/http.c
> +++ b/http.c
> @@ -745,6 +745,33 @@ char *get_remote_object_url(const char *url, const char *hex,
>  	return strbuf_detach(&buf, NULL);
>  }
>  
> +int handle_curl_result(struct active_request_slot *slot)
> +{
> +	struct slot_results *results = slot->results;
> +
> +	if (results->curl_result == CURLE_OK) {
> +		credential_approve(&http_auth);
> +		return HTTP_OK;
> +	} else if (missing_target(results))
> +...
> +		return HTTP_ERROR;
> +	}
> +}
> +
> @@ -820,9 +828,6 @@ static int http_request(const char *url, void *result, int target, int options)
>  	curl_slist_free_all(headers);
>  	strbuf_release(&buf);
>  
> -	if (ret == HTTP_OK)
> -		credential_approve(&http_auth);

OK, now this is part of handle_curl_result() so the caller does not
have to worry about it, which is nice ;-)

>  	return ret;
>  }
