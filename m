From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] http.c: use CURLOPT_RANGE for range requests
Date: Mon, 2 Nov 2015 15:18:32 -0500
Message-ID: <20151102201831.GA10722@sigill.intra.peff.net>
References: <1446492986-32350-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 21:18:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtLYt-0002hz-BH
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 21:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbbKBUSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 15:18:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:51626 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750887AbbKBUSe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 15:18:34 -0500
Received: (qmail 12431 invoked by uid 102); 2 Nov 2015 20:18:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Nov 2015 14:18:34 -0600
Received: (qmail 16694 invoked by uid 107); 2 Nov 2015 20:19:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Nov 2015 15:19:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Nov 2015 15:18:32 -0500
Content-Disposition: inline
In-Reply-To: <1446492986-32350-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280714>

On Mon, Nov 02, 2015 at 02:36:26PM -0500, David Turner wrote:

> A HTTP server is permitted to return a non-range response to a HTTP
> range request (and Apache httpd in fact does this in some cases).
> While libcurl knows how to correctly handle this (by skipping bytes
> before and after the requested range), it only turns on this handling
> if it is aware that a range request is being made.  By manually
> setting the range header instead of using CURLOPT_RANGE, we were
> hiding the fact that this was a range request from libcurl.  This
> could cause corruption.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> 
> This version breaks the range option formatting/setting out to a
> helper function, as suggested by Junio and Jeff.
> 
> In addition, it clears the range option when curl slots are cleared
> before reuse, also as suggested

Thanks, this looks much nicer to me.

A few minor comments:

> +static void http_opt_request_remainder(CURL *curl, ssize_t lo)

I notice you used ssize_t here. If we are going to deal with large files, I
would think off_t would make more sense (i.e., to allow >2GB on a 32-bit
system).

But much worse than that, the value we are passing typically comes from
ftell(), which only returns a long. So we're truncated anyway in that
case.

I certainly don't think we are making anything _worse_ here; the problem
is in the existing code. But I don't think ssize_t is making anything
better (it's generally the same size as a long anyway). So I think I'd
prefer one of the following:

  1. Leave it as "long". At least then we are matching ftell(), which is
     clear (and works fine on 64-bit machines).

  2. Use off_t here instead. It doesn't fix the problem, but at least
     fixes our one component, so it's working towards a better solution
     in the long run.

  3. Detect and complain when we overflow the long. Hopefully ftell()
     returns -1 on a 32-bit system when the file is larger than 2GB, so
     this Just Works already, and we don't create a broken output.

  4. Fix all of the callers. I suspect this would involve calling
     fstat(fileno(fh)) to get a real off_t.

Options (3) and (4) are obviously more work, and I don't necessarily
expect you to do them. But I think I'd prefer (2) to what you have now.
Using off_t has an issue with being unsigned, but...

> +{
> +	char buf[128];
> +	int len = 0;
> +
> +	if (lo >= 0)
> +		len += xsnprintf(buf + len, 128 - len, "%"PRIiMAX,
> +				 (intmax_t)lo);
> +	len += xsnprintf(buf + len, 128 - len, "-");

I think we could just drop this "lo >= 0". Now that there is no "hi"
(which I think is fine), there's no reason to call the function at all
if you do not have a limit.

Also, we should prefer "sizeof(buf)" to repeating the "128", as the two
getting out of sync would be disastrous. So altogether something like:


  static void http_opt_request_remainder(CURL *curl, off_t pos)
  {
	char buf[128];
	xsnprintf(buf, sizeof(buf), "%"PRIuMAX", (uintmax_t)pos);
	curl_easy_setopt(curl, CURLOPT_RANGE, buf);
  }

would be enough, I think.

-Peff
