From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] http: try http_proxy env var when http.proxy config
 option is not set
Date: Thu, 03 May 2012 11:05:33 -0700
Message-ID: <7vk40tf8cy.fsf@alter.siamese.dyndns.org>
References: <4FA2B4D3.90809@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Thu May 03 20:05:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ0PP-0001Mo-5h
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 20:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724Ab2ECSFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 14:05:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49649 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297Ab2ECSFh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 14:05:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC6F9664B;
	Thu,  3 May 2012 14:05:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kw7iCCWCfV6kIrf+I07VU0FzchU=; b=ma4vFT
	uL+8o695F3wn0FFZ0h31UhMsFfKVJZjAqyOqN5kmNANKiJREvU9ow5vyzABXxu1b
	rnuyTfRoz0X5bxlSJplAbekBPZUzXjHegEU+ABZEYhjh5q13xdZK0i9fvB6Q4V38
	5zEuKyMY8oJSm7BWb9V3oDExXjubAiYErwWX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fcc6OKYxyB6qI2XC18QuNpPrFfMsifW6
	/CuWMTZDNI1OXjPIbDPHzdIJnGnh2dqdZV1wwI4yf6WZf3rKtCLqCohsN+BH0X4C
	GqMtcHt2j/6nmlSYIZtweH7ROAjsRY3+vRkwbPUkc9w4OYcwkXh0kTIqbMEdU0Zq
	e4ZYsaVdO9U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0B4F664A;
	Thu,  3 May 2012 14:05:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A61F6643; Thu,  3 May 2012
 14:05:35 -0400 (EDT)
In-Reply-To: <4FA2B4D3.90809@seap.minhap.es> (Nelson Benitez Leon's message
 of "Thu, 03 May 2012 18:39:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94B9ED92-954A-11E1-89D6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196926>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> cURL already reads it, but if $http_proxy has username but no password
> cURL will not ask you for the password and so failed to authenticate
> returning a 407 error code. So we read it ourselves to detect that and
> ask for the password. Also we read it prior to connection to be able to
> make a proactive authentication in case the flag http_proactive_auth is
> set.
>
> We also take care to read env proxy var according to protocol being
> used in the destination url, e.g.  when the url to retrieve is a https
> one, then the proxy env var we look at is https_proxy. We also look at
> the uppercase version of these if the lowercase is not found, with the
> exception of HTTP_PROXY because cURL ignores it. To make this possible
> we now passed destination url parameter to get_active_slot() and
> get_curl_handle() functions.
>
> We also read no_proxy env var so to ignore aforementioned proxy env var
> if no_proxy contains an asterisk ('*') or contains the host used in url
> destination.
>
> Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

I'll trust Peff to point out anything I missed, but from a cursory look,
the result looks much cleaner than the previous round.

> diff --git a/http.c b/http.c
> index 5cb87f1..64df7b1 100644
> --- a/http.c
> +++ b/http.c
> @@ -229,6 +229,37 @@ static void init_curl_http_auth(CURL *result)
> ...
> +static int host_allowed_by_noproxy_env (const char *host)
> +{

I'll queue the updated series with s/_env (/_env(/; here, and also add a
missing explanation on the bulk of "noise" in the patch at the end of the
log message:

    In order to be able to determine what proxy settings is needed from
    the very beginning of a request, get_active_slot() learns to take the
    destination URL, as it needs to pass it to get_curl_handle() that
    implements the logic to pick proxies based on the protocol used.


Thanks.
