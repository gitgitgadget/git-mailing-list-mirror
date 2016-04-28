From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4 1/2] http.c: implement the GIT_TRACE_CURL environment
 variable
Date: Thu, 28 Apr 2016 10:47:10 -0400
Message-ID: <20160428144710.GD25364@sigill.intra.peff.net>
References: <20160428115748.37177-1-gitter.spiros@gmail.com>
 <20160428115748.37177-2-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, tboegi@web.de, ramsay@ramsayjones.plus.com,
	gitster@pobox.com, sunshine@sunshineco.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 16:47:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avnEI-0005KP-LU
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 16:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbcD1OrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 10:47:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:58375 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752819AbcD1OrY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 10:47:24 -0400
Received: (qmail 29089 invoked by uid 102); 28 Apr 2016 14:47:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 10:47:13 -0400
Received: (qmail 10031 invoked by uid 107); 28 Apr 2016 14:47:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 10:47:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 10:47:10 -0400
Content-Disposition: inline
In-Reply-To: <20160428115748.37177-2-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292891>

On Thu, Apr 28, 2016 at 11:57:47AM +0000, Elia Pinto wrote:

> +static void curl_dump(const char *text, unsigned char *ptr, size_t size, char nohex, char nopriv)

We usually use "int" for our boolean flags. Space savings don't matter
outside of a struct (and if they did, you should be using a single flags
field), and this way the user does not have to guess whether the "char"
is significant.

It looks like we never pass anything but "1" for nohex. Can we drop this
parameter entirely? But see below...

> +{
> +	size_t i;
> +	struct strbuf out = STRBUF_INIT;
> +	unsigned int width = 0x10;
> +
> +	/* without the hex output, we can fit more on screen */
> +	if (nohex) width = 0x50;

Maybe it is just me, but I think this is more readable using decimal
constants. I mind it less in checking ASCII values like 0x20, but here I
think just saying "80" is more customary.

> +	for (i = 0; i < size; i += width) {
> +		size_t w;
> +		strbuf_addf(&out, "%s: ", text);

I really like this new format. Doing:

  GIT_TRACE_CURL=1 git ... 2>&1 | grep '=> Send header: '

is very readable.

However, I did run into an interesting case. The output looks like:

  10:24:04.540803 http.c:527              => Send header: Host: github.com
  10:24:04.540809 http.c:527              => Send header: x
  10:24:04.540811 http.c:527              => Send header: User-Agent: git/2.8.1.341.g2caf4c9.dirty

What's that weird "x" line?

It turns out that the line before it is:

  Authorization: Basic some-really-long-opaque-token-that-ends-in-x

Since we break at a newline _or_ at the width, that gets broken onto the
following line. The Authorization line hits the code below to suppress
the output.

So not only do I find the breaking of the line hard to read, but it
means we may leak data from the Authorization line that got broken into
the next chunk (here it was only one character, but with a sufficiently
long header, it could be real data).

So I think we probably want to _just_ break at newlines, however long
they are.

But that probably isn't a good idea for binary data. So I'd suggest that
sending/receiving headers break on newlines, and actual body data should
respect the width field (we may still have line-oriented data in the
body which would be easier to read without line-breaking, but if you are
debugging that you are better off with GIT_TRACE_PACKET anyway).

> +		 for (w = 0; (w < width) && (i + w < size); w++) {
> +			   if (nohex && (i + w + 1 < size) && ptr[i + w] == '\r'
> +				&& ptr[i + w + 1] == '\n') {
> +				    i += (w + 2 - width);
> +				    break;
> +			   }

This loop puzzled me for a bit. When we end early due to a newline, we
subtract out the width here. I guess that's to accomodate the "i +=
width" that the outer for-loop is going to do.

If you follow my suggestion above to split the code paths for
line-oriented and fixed-width data, then this all gets much simpler.

> +		/* if we are called with nopriv we skip the Authorization field if present
> +		 * and print a blank line
> +		*/
> +		if ( nopriv && strstr(out.buf, "Authorization:"))
> +			strbuf_reset(&out);

Style: multi-line comments should look like:

  /*
   * the comment
   * goes here
   */

and there should be no whitespace after the opening "(".

Removing the field entirely may be a bit confusing when you're
debugging. Instead, perhaps we can just redact the interesting bits,
like:

diff --git a/http.c b/http.c
index 8ab0adc..30e8858 100644
--- a/http.c
+++ b/http.c
@@ -481,7 +481,11 @@ static void curl_dump(const char *text, unsigned char *ptr, size_t size, char no
 
 	for (i = 0; i < size; i += width) {
 		size_t w;
+		size_t prefix_len;
+		const char *header;
+
 		strbuf_addf(&out, "%s: ", text);
+		prefix_len = out.len;
 		if (!nohex) {
 			for (w = 0; w < width; w++)
 				if (i + w < size)
@@ -507,8 +511,17 @@ static void curl_dump(const char *text, unsigned char *ptr, size_t size, char no
 		/* if we are called with nopriv we skip the Authorization field if present
 		 * and print a blank line
 		*/
-		if ( nopriv && strstr(out.buf, "Authorization:"))
-			strbuf_reset(&out);
+		if (nopriv &&
+		    skip_prefix(out.buf + prefix_len, "Authorization:", &header)) {
+			/* The first token is the type, which is OK to log */
+			while (isspace(*header))
+				header++;
+			while (*header && !isspace(*header))
+				header++;
+			/* Everything else is opaque and possibly sensitive */
+			strbuf_setlen(&out, header - out.buf);
+			strbuf_addstr(&out, " <redacted>");
+		}
 
 		strbuf_addch(&out, '\n');
 		trace_strbuf(&trace_curl, &out);

That tells the viewer that we did in fact send the header (which is
useful to know), and which type it used.

> +		strbuf_addch(&out, '\n');
> +		trace_strbuf(&trace_curl, &out);
> +		strbuf_release(&out);
> +	}
> +}

This is the only strbuf_release() in the function, and it's inside the
loop. Yet we use the strbuf to print the initial line (and do a reset()
after). So if the field we get is 0 bytes, we'll leak the strbuf memory
used by the initial line.

I don't know if that's possible with curl or not. But just in case, we
could structure the loop more like:

  ... output initial line ...
  for (i = 0; i < size; i += width) {
	strbuf_reset(&out);
	... output data line ...
  }
  strbuf_release(&out);

That has the added bonus that we do not have to reallocate for each
iteration of the loop (we just reset the length back to zero each time,
and then free the memory at the very end).

-Peff
