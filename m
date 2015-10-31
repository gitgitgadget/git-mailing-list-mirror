From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] http.c: use CURLOPT_RANGE for range requests
Date: Fri, 30 Oct 2015 20:08:37 -0400
Message-ID: <20151031000837.GA25849@sigill.intra.peff.net>
References: <1446245682-18087-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 01:08:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsJiv-0006Sn-LB
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 01:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbbJaAIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 20:08:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:50742 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932253AbbJaAIk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 20:08:40 -0400
Received: (qmail 994 invoked by uid 102); 31 Oct 2015 00:08:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Oct 2015 19:08:40 -0500
Received: (qmail 27742 invoked by uid 107); 31 Oct 2015 00:09:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Oct 2015 20:09:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2015 20:08:37 -0400
Content-Disposition: inline
In-Reply-To: <1446245682-18087-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280562>

On Fri, Oct 30, 2015 at 06:54:42PM -0400, David Turner wrote:

> A HTTP server is permitted to return a non-range response to a HTTP
> range request (and Apache httpd in fact does this in some cases).
> While libcurl knows how to correctly handle this (by skipping bytes
> before and after the requested range), it only turns on this handling
> if it is aware that a range request is being made.  By manually
> setting the range header instead of using CURLOPT_RANGE, we were
> hiding the fact that this was a range request from libcurl.  This
> could cause corruption.

The goal makes sense. Why weren't we using CURLOPT_RANGE before? Did it
not exist (or otherwise have limitations) in 2005, and if so, when did
it become usable? Do we need to protect this with an #ifdef for the curl
version?

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
>  			}
>  		} else

We reuse curl slots from request to request, and curl options may
persist.  The old code appended to the header list, which then gets
added to the curl object with CURLOPT_HTTPHEADER. Subsequent requests,
even if they are not using ranges, would also set CURLOPT_HTTPHEADER,
possibly to NULL, so the range header would not accidentally creep into
the next request.

But with CURLOPT_RANGE, I think the value would persist to the next
request (unless curl automagically forgets it after making the request,
but I don't think it generally does so). I think the cleanest thing
would be to reset it back to NULL in get_active_slot (there are several
other fields that we reset there, too).

> @@ -1685,7 +1680,6 @@ struct http_object_request *new_http_object_request(const char *base_url,
>  	ssize_t prev_read = 0;
>  	long prev_posn = 0;
>  	char range[RANGE_HEADER_SIZE];
> -	struct curl_slist *range_header = NULL;
>  	struct http_object_request *freq;

Junio asked elsewhere if we really need to tweak RANGE_HEADER_SIZE. But
I think we should go even further, and bump the definition much closer
to the point of use[1], and not worry about an arbitrary constant. After
all, we already use sizeof(), so we do not even end up repeating the
constant.

We could even hide the whole thing away with something like:

  void http_set_range(CURL *curl, long lo, long hi)
  {
	char buf[128];
	int len = 0;

	if (lo >= 0)
		len += xsnprintf(buf + len, "%ld", lo);
	len += xsnprintf(buf + len, "-");
	if (hi >= 0)
		len += xsnprintf(buf + len, "%ld", hi);

	curl_easy_setopt(curl, CURLOPT_RANGE, buf);
  }

That would also make it easier to replace if we do need to keep an
#ifdef for older versions of curl. But maybe it is just
over-engineering.

-Peff

[1] Antique versions of curl needed the buffer to remain valid through
    the whole request, but these days it makes its own copy (and even
    under the old regime, I am not sure if the existing code would work
    anyway, as we return the request from this function, and the buffer
    is function-local).
