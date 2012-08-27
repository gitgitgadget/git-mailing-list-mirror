From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] http: prompt for credentials on failed POST
Date: Mon, 27 Aug 2012 10:48:28 -0700
Message-ID: <7v3938rztf.fsf@alter.siamese.dyndns.org>
References: <20120827132145.GA17265@sigill.intra.peff.net>
 <20120827132714.GH17375@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Iain Paton <ipaton0@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 27 19:49:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T63R2-000203-7H
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 19:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650Ab2H0Rsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 13:48:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32771 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656Ab2H0Rsb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 13:48:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D00FA76B9;
	Mon, 27 Aug 2012 13:48:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R7jF4uUcMWocn1tEK+gA05j6W2Y=; b=JK7Igi
	AB4lF/5KwRwVQm/xO187RPE2gV9T6QqY6PricAPzrg/8UFy3ygn6hR+G4ggxAyzN
	G+UEtEAoo6GBS/FfNNq/tNx+dJPtOEhM6h0GQ90HsZQcQEVIOLt31+V+57OyijMY
	3MjBlKhmmyWsX+8S1pv3I6m/5QQ0HB62PYm+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mQjEAMTEhbW2hG1gf1Us3TEBnqafW7+C
	JaYhUWspA1zWRptEhxPrylxdUoR/FLZxk4r17P1pkhqCDrCmcxqLeLo0WTP0XxuB
	RU+gGlrwtGSZ0UyHJU1WisRsWfo0sCgotBkztG3GG5/rCQ4+KqAUSMgmwlzlR5eP
	tot/cJkB8hk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD76376B8;
	Mon, 27 Aug 2012 13:48:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD0DD76B6; Mon, 27 Aug 2012
 13:48:29 -0400 (EDT)
In-Reply-To: <20120827132714.GH17375@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 27 Aug 2012 09:27:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6960E120-F06F-11E1-8A4C-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204361>

Jeff King <peff@peff.net> writes:

> Most of the time, this is not a big deal; for both fetching
> and pushing, we make a GET request before doing any POSTs,
> so typically we figure out the credentials during the first
> request, then reuse them during the POST. However, some
> servers may allow a client to get the list of refs from
> receive-pack without authentication, and then require
> authentication when the client actually tries to POST the
> pack.

A silly question.  Does the initial GET request when we push look
any different from the initial GET request when we fetch?  Can we
make them look different in an updated client, so that the server
side can say "this GET is about pushing into us, and we require
authentication"?

> Unfortunately, it is not as easy as simply calling post_rpc
> again when it fails, due to the input issue mentioned above.
> However, we can still make this specific case work by
> retrying in two specific instances:
>
>   1. If the request is large (bigger than LARGE_PACKET_MAX),
>      we will first send a probe request with a single flush
>      packet. Since this request is static, we can freely
>      retry it.
>
>   2. If the request is small and we are not using gzip, then
>      we have the whole thing in-core, and we can freely
>      retry.
>
> That means we will not retry in some instances, including:
>
>   1. If we are using gzip. However, we only do so when
>      calling git-upload-pack, so it does not apply to
>      pushes.
>
>   2. If we have a large request, the probe succeeds, but
>      then the real POST wants authentication. This is an
>      extremely unlikely configuration and not worth worrying
>      about.
>
> While it might be nice to cover those instances, doing so
> would be significantly more complex for very little
> real-world gain. In the long run, we will be much better off
> when curl learns to internally handle authentication as a
> callback, and we can cleanly handle all cases that way.

I suspect that in real life, almost nobody runs smart HTTP server
that allows anonymous push.

How much usability penalty would it be if we always fill credential
before pushing?  Alternatively, how much latency penalty would it
incur if we always send a probe request regardless of the request
size when we try to push without having an authentication material?

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Sorry for the wordy explanation. I really tried to refactor this into a
> nice single code path for making both GET and POST requests, but I think
> there are just too many corner cases. Suggestions welcome if somebody
> has a better idea of how to refactor it (preferably in the form of a
> patch).
>
>  remote-curl.c        | 23 +++++++++++++++--------
>  t/t5541-http-push.sh |  2 +-
>  2 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index 04a9d62..3ec474f 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -362,16 +362,17 @@ static size_t rpc_in(char *ptr, size_t eltsize,
>  
>  static int run_slot(struct active_request_slot *slot)
>  {
> -	int err = 0;
> +	int err;
>  	struct slot_results results;
>  
>  	slot->results = &results;
>  	slot->curl_result = curl_easy_perform(slot->curl);
>  	finish_active_slot(slot);
>  
> -	if (results.curl_result != CURLE_OK) {
> -		err |= error("RPC failed; result=%d, HTTP code = %ld",
> -			results.curl_result, results.http_code);
> +	err = handle_curl_result(slot);
> +	if (err != HTTP_OK && err != HTTP_REAUTH) {
> +		error("RPC failed; result=%d, HTTP code = %ld",
> +		      results.curl_result, results.http_code);
>  	}
>  
>  	return err;
> @@ -436,9 +437,11 @@ static int post_rpc(struct rpc_state *rpc)
>  	}
>  
>  	if (large_request) {
> -		err = probe_rpc(rpc);
> -		if (err)
> -			return err;
> +		do {
> +			err = probe_rpc(rpc);
> +		} while (err == HTTP_REAUTH);
> +		if (err != HTTP_OK)
> +			return -1;
>  	}
>  
>  	slot = get_active_slot();
> @@ -525,7 +528,11 @@ static int post_rpc(struct rpc_state *rpc)
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
>  	curl_easy_setopt(slot->curl, CURLOPT_FILE, rpc);
>  
> -	err = run_slot(slot);
> +	do {
> +		err = run_slot(slot);
> +	} while (err == HTTP_REAUTH && !large_request && !use_gzip);
> +	if (err != HTTP_OK)
> +		err = -1;
>  
>  	curl_slist_free_all(headers);
>  	free(gzip_body);
> diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
> index 9b1cd60..ef6d6b6 100755
> --- a/t/t5541-http-push.sh
> +++ b/t/t5541-http-push.sh
> @@ -280,7 +280,7 @@ test_expect_success 'push over smart http with auth' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_failure 'push to auth-only-for-push repo' '
> +test_expect_success 'push to auth-only-for-push repo' '
>  	cd "$ROOT_PATH/test_repo_clone" &&
>  	echo push-half-auth >expect &&
>  	test_commit push-half-auth &&
