From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix potential hang in https handshake.
Date: Thu, 18 Oct 2012 15:59:41 -0700
Message-ID: <7vd30fl736.fsf@alter.siamese.dyndns.org>
References: <5080761e.IEDySUuQzlCwL6fM%szager@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sop@google.com
To: szager@google.com
X-From: git-owner@vger.kernel.org Fri Oct 19 01:00:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOz4H-00069B-57
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 00:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756231Ab2JRW7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 18:59:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50953 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211Ab2JRW7p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 18:59:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23C419FED;
	Thu, 18 Oct 2012 18:59:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kgxYeIcoFS6z/2SDINtVS4lD8ZE=; b=XJ3LIg
	4w76lh2B0n8hAUx/BtDcbF8OT2PydZg3vzdAZIJWVYR+vEOPahkyFIE8cPxqaKta
	5B0+RRnj2O45C4l0+dJX4izXg4qhrT45rwUU50OAK+46OicUSptKgRD1N31d2Vjt
	0ITs0yamL69Rxb2h4OPTsACANwWTtTJsB6DGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XGEDN/rfnhkwlHKXcJP3vNJku193koLq
	/GVF3MNhE69dYrc7E2avZHj6CdT0O6FRP3ssWKrHuMWGKy97Yiz5XDHhktOdB+fV
	5vRij8Qd0sqVPJyhP50R2f/QWMfOTTQBQaRqDvcT6u4LDmrVot6YVQuFQ5dFPNO9
	GDtK2GfVX0g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 105F39FEC;
	Thu, 18 Oct 2012 18:59:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B83B9FEA; Thu, 18 Oct 2012
 18:59:43 -0400 (EDT)
In-Reply-To: <5080761e.IEDySUuQzlCwL6fM%szager@google.com>
 (szager@google.com's message of "Thu, 18 Oct 2012 14:35:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 81275812-1977-11E2-BB5B-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208028>

szager@google.com writes:

> From 700b8075c578941c8f951711825c390ac68b190f Mon Sep 17 00:00:00 2001
> From: Stefan Zager <szager@google.com>
> Date: Thu, 18 Oct 2012 14:03:59 -0700
> Subject: [PATCH] Fix potential hang in https handshake.
>
> It will sometimes happen that curl_multi_fdset() doesn't
> return any file descriptors.  In that case, it's recommended
> that the application sleep for a short time before running
> curl_multi_perform() again.
>
> http://curl.haxx.se/libcurl/c/curl_multi_fdset.html
>
> Signed-off-by: Stefan Zager <szager@google.com>
> ---

Thanks.  Would it be a better idea to "patch up" in problematic
case, instead of making this logic too deeply nested, like this
instead, I have to wonder...


	... all the existing code above unchanged ...
	curl_multi_fdset(..., &max_fd);
+	if (max_fd < 0) {    
+		/* nothing actionable??? */
+		select_timeout.tv_sec = 0;
+		select_timeout.tv_usec = 50000;
+	}

	select(max_fd+1, ..., &select_timeout);



>  http.c |   40 ++++++++++++++++++++++++++--------------
>  1 files changed, 26 insertions(+), 14 deletions(-)
>
> diff --git a/http.c b/http.c
> index df9bb71..a6f66c0 100644
> --- a/http.c
> +++ b/http.c
> @@ -602,35 +602,47 @@ void run_active_slot(struct active_request_slot *slot)
>  	int max_fd;
>  	struct timeval select_timeout;
>  	int finished = 0;
> +	long curl_timeout;
>  
>  	slot->finished = &finished;
>  	while (!finished) {
>  		step_active_slots();
>  
>  		if (slot->in_use) {
> +			max_fd = -1;
> +			FD_ZERO(&readfds);
> +			FD_ZERO(&writefds);
> +			FD_ZERO(&excfds);
> +			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
> +
>  #if LIBCURL_VERSION_NUM >= 0x070f04
> -			long curl_timeout;
> -			curl_multi_timeout(curlm, &curl_timeout);
> -			if (curl_timeout == 0) {
> -				continue;
> -			} else if (curl_timeout == -1) {
> +			/* It will sometimes happen that curl_multi_fdset() doesn't
> +			   return any file descriptors.  In that case, it's recommended
> +			   that the application sleep for a short time before running
> +			   curl_multi_perform() again.
> +
> +			   http://curl.haxx.se/libcurl/c/curl_multi_fdset.html
> +			*/
> +			if (max_fd == -1) {
>  				select_timeout.tv_sec  = 0;
>  				select_timeout.tv_usec = 50000;
>  			} else {
> -				select_timeout.tv_sec  =  curl_timeout / 1000;
> -				select_timeout.tv_usec = (curl_timeout % 1000) * 1000;
> +				curl_timeout = 0;
> +				curl_multi_timeout(curlm, &curl_timeout);
> +				if (curl_timeout == 0) {
> +					continue;
> +				} else if (curl_timeout == -1) {
> +					select_timeout.tv_sec  = 0;
> +					select_timeout.tv_usec = 50000;
> +				} else {
> +					select_timeout.tv_sec  =  curl_timeout / 1000;
> +					select_timeout.tv_usec = (curl_timeout % 1000) * 1000;
> +				}
>  			}
>  #else
>  			select_timeout.tv_sec  = 0;
>  			select_timeout.tv_usec = 50000;
>  #endif
> -
> -			max_fd = -1;
> -			FD_ZERO(&readfds);
> -			FD_ZERO(&writefds);
> -			FD_ZERO(&excfds);
> -			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
> -
>  			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
>  		}
>  	}
