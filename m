From: Jeff King <peff@peff.net>
Subject: Re: [PATCH ] t4210-log-i18n: spell encoding name "UTF-8" correctly
Date: Mon, 25 Feb 2013 15:31:00 -0500
Message-ID: <20130225203100.GA15932@sigill.intra.peff.net>
References: <7vobfuxrns.fsf@alter.siamese.dyndns.org>
 <20130209002710.GA5570@sigill.intra.peff.net>
 <7vfw16xqvj.fsf@alter.siamese.dyndns.org>
 <7va9rexqii.fsf@alter.siamese.dyndns.org>
 <20130211191607.GA21269@sigill.intra.peff.net>
 <7v621ymxfv.fsf@alter.siamese.dyndns.org>
 <20130211205958.GA32740@sigill.intra.peff.net>
 <512B22DE.9070603@viscovery.net>
 <20130225151916.GA7725@sigill.intra.peff.net>
 <7vmwusxlfm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Thomas Haller <thom311@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 21:31:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA4hv-0004D4-Ed
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 21:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757391Ab3BYUbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 15:31:07 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60205 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754233Ab3BYUbE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 15:31:04 -0500
Received: (qmail 26928 invoked by uid 107); 25 Feb 2013 20:32:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Feb 2013 15:32:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2013 15:31:00 -0500
Content-Disposition: inline
In-Reply-To: <7vmwusxlfm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217102>

On Mon, Feb 25, 2013 at 11:06:37AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... I think the simplest thing would just be:
> >
> > diff --git a/utf8.c b/utf8.c
> > index 1087870..8d42b50 100644
> > --- a/utf8.c
> > +++ b/utf8.c
> > @@ -507,6 +507,17 @@ char *reencode_string(const char *in, const char *out_encoding, const char *in_e
> >  
> >  	if (!in_encoding)
> >  		return NULL;
> > +
> > +	/*
> > +	 * Some platforms do not have the variously spelled variants of
> > +	 * UTF-8, so let us feed iconv the most official spelling, which
> > +	 * should hopefully be accepted everywhere.
> > +	 */
> > +	if (is_encoding_utf8(in_encoding))
> > +		in_encoding = "UTF-8";
> > +	if (is_encoding_utf8(out_encoding))
> > +		out_encoding = "UTF-8";
> > +
> >  	conv = iconv_open(out_encoding, in_encoding);
> >  	if (conv == (iconv_t) -1)
> >  		return NULL;
> >
> > Does that fix the tests for you? It's a larger change, but I think it
> > makes git friendlier all around for people on Windows.
> 
> Yeah, if this is confirmed to work OK (from eyeballing I do not see
> a reason why not...) I agree this is the cleanest way forward.

The only reason I can think of is that you specify "utf8", your platform
understands "utf8" but not "UTF-8", and we rewrite it silently to
"UTF-8". That seems somewhat unlikely, but to be on the safe side, why
don't we do it as a fallback? That should be fine performance-wise, as
it only triggers on the error case.

Like this:

-- >8 --
Subject: [PATCH] utf8: accept alternate spellings of UTF-8

The iconv implementation on many platforms will accept
variants of UTF-8, including "UTF8", "utf-8", and "utf8",
but some do not. We make allowances in our code to treat
them all identically, but we sometimes hand the string from
the user directly to iconv. In this case, the platform iconv
may or may not work.

There are really four levels of platform iconv support for
these synonyms:

  1. All synonyms understood (e.g., glibc).

  2. Only the official "UTF-8" understood (e.g., Windows).

  3. Official "UTF-8" not understood, but some other synonym
     understood (it's not known whether such a platform exists).

  4. Neither "UTF-8" nor any synonym understood (e.g.,
     ancient systems, or ones without utf8 support
     installed).

This patch teaches git to fall back to using the official
"UTF-8" spelling when iconv_open fails (and the encoding was
one of the synonym spellings). This makes things more
convenient to users of type 2 systems, as they can now use
any of the synonyms for the log output encoding.

Type 1 systems are not affected, as iconv already works on
the first try.

Type 4 systems are not affected, as both attempts already
fail.

Type 3 systems will not benefit from the feature, but
because we only use "UTF-8" as a fallback, they will not be
regressed (i.e., you can continue to use "utf8" if your
platform supports it). We could try all the various
synonyms, but since such systems are not even known to
exist, it's not worth the effort.

Signed-off-by: Jeff King <peff@peff.net>
---
JSixt, can you double-check that this passes t4210 for you?

 utf8.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/utf8.c b/utf8.c
index 1087870..8f6e84b 100644
--- a/utf8.c
+++ b/utf8.c
@@ -507,9 +507,25 @@ char *reencode_string(const char *in, const char *out_encoding, const char *in_e
 
 	if (!in_encoding)
 		return NULL;
+
 	conv = iconv_open(out_encoding, in_encoding);
-	if (conv == (iconv_t) -1)
-		return NULL;
+	if (conv == (iconv_t) -1) {
+		/*
+		 * Some platforms do not have the variously spelled variants of
+		 * UTF-8, so let's fall back to trying the most official
+		 * spelling. We do so only as a fallback in case the platform
+		 * does understand the user's spelling, but not our official
+		 * one.
+		 */
+		if (is_encoding_utf8(in_encoding))
+			in_encoding = "UTF-8";
+		if (is_encoding_utf8(out_encoding))
+			out_encoding = "UTF-8";
+		conv = iconv_open(out_encoding, in_encoding);
+		if (conv == (iconv_t) -1)
+			return NULL;
+	}
+
 	out = reencode_string_iconv(in, strlen(in), conv);
 	iconv_close(conv);
 	return out;
-- 
1.8.1.4.4.g265d2fa
