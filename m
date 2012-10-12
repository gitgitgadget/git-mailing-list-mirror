From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: fix segfault in handle_curl_result
Date: Fri, 12 Oct 2012 09:46:53 -0700
Message-ID: <7vmwzr4ozm.fsf@alter.siamese.dyndns.org>
References: <CAJa+X0OkzAX9E2SnDmU=on0yzzVZ9OMa2dJZgKMK=gQu2Rhf_Q@mail.gmail.com>
 <CAJa+X0MefHXTu_D7-SN8itQVO4sMyc4O7=bK=-sUP+W4GHOu9g@mail.gmail.com>
 <20121012062249.GB17026@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad Hein <linuxbrad@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 12 18:47:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMiOK-00080s-5P
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 18:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759850Ab2JLQrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 12:47:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759818Ab2JLQrE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 12:47:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E9548E4A;
	Fri, 12 Oct 2012 12:47:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=LBkBGMorKExB9No5GmrJhQoIk+4=; b=IF5ibAo+R10v2X5FqfML
	aHJKsNW/sKX+bc/AjenBPguGSxf17o7Uy6pJ/hPEGRT5LBlVDWrkWmjXDCsNt6oI
	7gLylO5nZbCl5LWp1S/cztRzBb1XrYlePtcvgck0SZgpjaMmC3pYShKP4uxpn2VU
	sa21SwDTu2LvlF83XNGIuy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=G5Kd+zRvslgKOhm2mtb84xY2zakoNEOSBeNOkosBEA5cPC
	xhSjLb6N0OIZfuWsNAuzHkYx4HyZd1ZMfTUptsa2lj6EpB1NkKVa62ZB1o6TwpYz
	e+47OoeHTi6Lv97xl7IlJQDwTRqcN5V3S/lk5Ro0w7UBzrCACCZr4tvJcmkiE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D75E8E3F;
	Fri, 12 Oct 2012 12:47:02 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3ACC8E3D; Fri, 12 Oct 2012
 12:47:00 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71B2F23C-148C-11E2-9E34-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207555>

Jeff King <peff@peff.net> writes:

> When we create an http active_request_slot, we can set its
> "results" pointer back to local storage. The http code will
> fill in the details of how the request went, and we can
> access those details even after the slot has been cleaned
> up.
> ...
> However, I'm leaving that out of this patch.  Commit 8809703 was
> supposed to be a refactor with zero behavior changes, but it regressed.
> This fixes the regression by behaving exactly as we did beforehand. We
> can build the other thing on top.

Thanks for a good write-up.

I agree with the fix, and I also agree that it does not make sense
to pass slot to handle-curl-RESULT when we know the slot may not
have anything to do with the result we are dealing with.  If
anything, we should be passing result (which this patch already
does) and curl handle (the sole reason why slot is passed, after
this patch, becomes to let the function access it via slot->curl),
but as your analysis shows, with dfa1725 (post 1.7.10.2) it should
not be even needed to call init_curl_http_auth() here, which is the
[2/2] of your follow-up.

Happy I am.  Thanks.

>  http.c        | 7 +++----
>  http.h        | 3 ++-
>  remote-curl.c | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/http.c b/http.c
> index 7c4a407..9334386 100644
> --- a/http.c
> +++ b/http.c
> @@ -744,10 +744,9 @@ int handle_curl_result(struct active_request_slot *slot)
>  	return strbuf_detach(&buf, NULL);
>  }
>  
> -int handle_curl_result(struct active_request_slot *slot)
> +int handle_curl_result(struct active_request_slot *slot,
> +		       struct slot_results *results)
>  {
> -	struct slot_results *results = slot->results;
> -
>  	if (results->curl_result == CURLE_OK) {
>  		credential_approve(&http_auth);
>  		return HTTP_OK;
> @@ -818,7 +817,7 @@ static int http_request(const char *url, void *result, int target, int options)
>  
>  	if (start_active_slot(slot)) {
>  		run_active_slot(slot);
> -		ret = handle_curl_result(slot);
> +		ret = handle_curl_result(slot, &results);
>  	} else {
>  		error("Unable to start HTTP request for %s", url);
>  		ret = HTTP_START_FAILED;
> diff --git a/http.h b/http.h
> index 12de255..0bd1e84 100644
> --- a/http.h
> +++ b/http.h
> @@ -78,7 +78,8 @@ extern void finish_all_active_slots(void);
>  extern void run_active_slot(struct active_request_slot *slot);
>  extern void finish_active_slot(struct active_request_slot *slot);
>  extern void finish_all_active_slots(void);
> -extern int handle_curl_result(struct active_request_slot *slot);
> +extern int handle_curl_result(struct active_request_slot *slot,
> +			      struct slot_results *results);
>  
>  #ifdef USE_CURL_MULTI
>  extern void fill_active_slots(void);
> diff --git a/remote-curl.c b/remote-curl.c
> index 3ec474f..6054e47 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -369,7 +369,7 @@ static int run_slot(struct active_request_slot *slot)
>  	slot->curl_result = curl_easy_perform(slot->curl);
>  	finish_active_slot(slot);
>  
> -	err = handle_curl_result(slot);
> +	err = handle_curl_result(slot, &results);
>  	if (err != HTTP_OK && err != HTTP_REAUTH) {
>  		error("RPC failed; result=%d, HTTP code = %ld",
>  		      results.curl_result, results.http_code);
