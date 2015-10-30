From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] http.c: use CURLOPT_RANGE for range requests
Date: Fri, 30 Oct 2015 16:13:29 -0700
Message-ID: <xmqqwpu4hrvq.fsf@gitster.mtv.corp.google.com>
References: <1446245682-18087-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 00:13:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsIrY-0005ma-Ue
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 00:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760185AbbJ3XNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 19:13:32 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54034 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760178AbbJ3XNb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 19:13:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA5532817B;
	Fri, 30 Oct 2015 19:13:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m6UjD+ic9QF93Ag758Nb6+R+Gmc=; b=GnsODh
	WLwNXOITxlcGOI0ObN6rfI72aB/E90sRc7/SjNf95PWSPMA+aMlRKgLx+ndzloHG
	4dRVmCW04GHUkN/qs3m2UbrUAs9HnhSSmp2stE5WA1f5CnmThxvwGdgN+G2H0r7n
	ARdZ8+ZVa3STYQcKbQ8us8yGAF4vZHwzyFLEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PlRNhvBK4GRashlhiVgeVmbWWehqNJHH
	Qf6BMpakD8hGYO7/o1DcmoenVJlLTPLJfMAxXs84uj8kHEKkRVxaW9vsUm/jfuTD
	GiorDsoy1xso3lashLvCbvHYupdZ2QX/MsLmXXGfc+MWL2nqFU4ukezpwL34CbJK
	8NB0VGm6gIE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B22D62817A;
	Fri, 30 Oct 2015 19:13:30 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4E45E28179;
	Fri, 30 Oct 2015 19:13:30 -0400 (EDT)
In-Reply-To: <1446245682-18087-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Fri, 30 Oct 2015 18:54:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D560E950-7F5B-11E5-AFAA-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280560>

David Turner <dturner@twopensource.com> writes:

> A HTTP server is permitted to return a non-range response to a HTTP
> range request (and Apache httpd in fact does this in some cases).
> While libcurl knows how to correctly handle this (by skipping bytes
> before and after the requested range), it only turns on this handling
> if it is aware that a range request is being made.  By manually
> setting the range header instead of using CURLOPT_RANGE, we were
> hiding the fact that this was a range request from libcurl.  This
> could cause corruption.

Wow, that looks really bad.

> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>
> This version applies on top of pu.  It also catches all of the range
> requests instead of just the one that I happened to notice.
>
> ---
>  http.c | 24 ++++++++----------------
>  http.h |  1 -
>  2 files changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/http.c b/http.c
> index 6b89dea..16610b9 100644
> --- a/http.c
> +++ b/http.c
> @@ -30,7 +30,7 @@ static CURL *curl_default;
>  #endif
>  
>  #define PREV_BUF_SIZE 4096
> -#define RANGE_HEADER_SIZE 30
> +#define RANGE_HEADER_SIZE 17

Was this change necessary and is 17-byte string sufficient for
64-bit longs?

> @@ -1213,8 +1213,9 @@ static int http_request(const char *url,
>  			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
>  					 fwrite);
>  			if (posn > 0) {
> -				strbuf_addf(&buf, "Range: bytes=%ld-", posn);
> -				headers = curl_slist_append(headers, buf.buf);
> +				strbuf_addf(&buf, "%ld-", posn);
> +				curl_easy_setopt(slot->curl, CURLOPT_RANGE,
> +						 &buf.buf);
>  				strbuf_reset(&buf);

Makes me wonder if all the callers have a CURL* and a long so that a
new helper range_opt_ask_remainder(CURL *, long) can make the
resulting code even simpler; we only say "we know what comes before
this position, give us everything from there" in all callers, right?
