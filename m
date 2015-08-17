From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] utf8.c: print warning about iconv errors
Date: Mon, 17 Aug 2015 15:02:38 -0400
Message-ID: <20150817190238.GA3594@sigill.intra.peff.net>
References: <1433624551-20730-1-git-send-email-max@max630.net>
 <1439589334-32318-1-git-send-email-max@max630.net>
 <xmqqvbchfqgh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:02:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRPgH-0001QO-SM
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 21:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbbHQTCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 15:02:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:46273 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750741AbbHQTCo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 15:02:44 -0400
Received: (qmail 13676 invoked by uid 102); 17 Aug 2015 19:02:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Aug 2015 14:02:44 -0500
Received: (qmail 31975 invoked by uid 107); 17 Aug 2015 19:02:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Aug 2015 15:02:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Aug 2015 15:02:38 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbchfqgh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276074>

On Fri, Aug 14, 2015 at 03:35:58PM -0700, Junio C Hamano wrote:

> Max Kirillov <max@max630.net> writes:
> 
> > * do not limit number of warnings - does not worth complicating the code
> 
> Unless the warning leads to a quick "die()", wouldn't this make Git
> unusable by spewing a "falling back to verbatim copy" for each and
> every line of the message of a commit that has 'encoding' element in
> its header in the "git log" output, no?

We only do the reencode once per commit. So it would be once per commit
rather than once per line. Which still sounds kind of annoying, if you
are using "git log --oneline" or similar.

I think I'd favor a single warning in general, along the lines of
"some encodings could not be converted". But of course if you are trying
to figure out _which_ encodings your system doesn't have, that's not
very helpful. Maybe we could have an advice.encodingFailure config flag
with a tristate:

  - false: don't spew any warnings

  - true: give a generic warning once per program

  - all: give a specific warning for each case, like "unable to convert
    EUC-JP to UTF-8: iconv_open: Invalid argument". (Sadly EINVAL is
    what iconv_open seems to return when you it doesn't know about a
    particular encoding; it may be nicer to translate to something more
    reasonable than what strerror() provides).

> > +char *reencode_string_len(const char *in, int insz,
> > +			  const char *out_encoding, const char *in_encoding,
> > +			  int *outsz)
> > +{
> > +	if (!same_encoding(in_encoding, out_encoding))
> > +		warning("Iconv support is disabled at compile time. It is likely that\nincorrect data will be printed or stored in repository.\nConsider using other build for this task.");
> > +	return NULL;
> > +}
> 
> Hmmm, I suspect this may be seen as regression by those who build
> Git without ICONV for performance, knowing that there is nothing in
> their data that requires character set conversion.

I don't think it matters that much. The obvious tight loop is
logmsg_reencode, and it already checks same_encoding (because it really
wants to avoid reallocation in the first place if it can). So anybody
who cares about the performance of reencode_string_len would do better
to optimize out any calls to it. :)

If anything, we could make same_encoding faster by memo-izing its ptrs,
like:

diff --git a/utf8.c b/utf8.c
index 28e6d76..50a8ac0 100644
--- a/utf8.c
+++ b/utf8.c
@@ -409,13 +409,26 @@ int is_encoding_utf8(const char *name)
 	return 0;
 }
 
-int same_encoding(const char *src, const char *dst)
+static int same_encoding_1(const char *src, const char *dst)
 {
+	warning("actually checking same_encoding(%s, %s)", src, dst);
 	if (is_encoding_utf8(src) && is_encoding_utf8(dst))
 		return 1;
 	return !strcasecmp(src, dst);
 }
 
+int same_encoding(const char *src, const char *dst)
+{
+	static const char *cached_src, *cached_dst;
+	static int cached_ret = -1;
+
+	if (src == cached_src && dst == cached_dst && cached_ret >= 0)
+		return cached_ret;
+	cached_src = src;
+	cached_dst = dst;
+	return cached_ret = same_encoding_1(src, dst);
+}
+
 /*
  * Wrapper for fprintf and returns the total number of columns required
  * for the printed string, assuming that the string is utf8.


But I couldn't measure any real speedup on "git log --oneline" from
doing so. It's also kind of gross (it will yield the wrong answer if you
write a different encoding to the same buffer; I don't think we do that,
but it's quite a gotcha).

Another approach would be to preserve NULL encodings (which we treat as
utf8) through the code base more. The common case of utf8 should be a
quick check for two NULLs, then. Unfortunately just teaching
get_commit_encoding and get_log_output_encoding to return NULL isn't
enough. Some parts of the code want to output the actual value (e.g.,
format-patch for a charset header), and would need to be adjusted. Given
that I couldn't measure any speedup, I don't think it's worth pursuing,
though.

-Peff
