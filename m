From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] fill_textconv(): Don't get/put cache if sha1 is not
 valid
Date: Sat, 18 Dec 2010 11:13:37 -0500
Message-ID: <20101218161337.GB18643@sigill.intra.peff.net>
References: <b714f1939ef4fc73cb5f55c1d7784a08a34d3c3d.1292681111.git.kirr@landau.phys.spbu.ru>
 <14308c2dd50037246e319649944d308b9f32fc39.1292681111.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Sat Dec 18 17:13:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTzPm-0002VZ-CM
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 17:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756694Ab0LRQNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 11:13:41 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33700 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756419Ab0LRQNk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 11:13:40 -0500
Received: (qmail 14755 invoked by uid 111); 18 Dec 2010 16:13:39 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 18 Dec 2010 16:13:39 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Dec 2010 11:13:37 -0500
Content-Disposition: inline
In-Reply-To: <14308c2dd50037246e319649944d308b9f32fc39.1292681111.git.kirr@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163915>

On Sat, Dec 18, 2010 at 05:54:12PM +0300, Kirill Smelkov wrote:

> It turned out, under blame there are requests to fill_textconv() with
> sha1=0000000000000000000000000000000000000000 and sha1_valid=0.
> 
> As the code did not analyzed sha1 validity, we ended up putting 000000
> into textconv cache which was fooling later blames to discover lots of
> lines in 'Not Yet Committed' state.
> [...]
> -	if (driver->textconv_cache) {
> +	if (driver->textconv_cache && df->sha1_valid) {
>  		*outbuf = notes_cache_get(driver->textconv_cache, df->sha1,
>  					  &size);

In short:

  Acked-by: Jeff King <peff@peff.net>

But it took some thinking to convince myself, so the long answer is
below if anyone cares.

I was dubious at first that this could be the right solution. We still
end up putting the filespec through run_textconv, which didn't seem
right if it is not valid.

But reading into it more, there are two levels of invalidity:

  1. !DIFF_FILE_VALID(df) - we are not a valid file at all. I.e., we are
     /dev/null.

  2. !df->sha1_valid - we are pointing to a working tree file whose sha1
     we don't know

I think level (2) never happens at all in the regular diff code, which
is why this case was completely unhandled. But it is OK in that case
(required, even) to put the contents through run_textconv.

In theory we could actually calculate the sha1 in case (2) and cache
under that, but I don't know how much it would buy us in practice. It
saves us running the textconv filter at the expense of computing the
sha1. Which is probably a win for most filters, but on the other hand,
it is the wrong place to compute such a sha1. If it is a working tree
file, we should ideally update our stat info in the index so that the
info can be reused.

-Peff

PS It is a little disturbing that in fill_textconv, we handle
case (1), !DIFF_FILE_VALID for the non-textconv case, but not so for the
textconv case. I think we are OK, as get_textconv will never load a
textconv driver for a !DIFF_FILE_VALID filespec, so we always follow the
non-textconv codepath in that case. But I am tempted to do this just to
be more defensive:

diff --git a/diff.c b/diff.c
index b0ee213..5320849 100644
--- a/diff.c
+++ b/diff.c
@@ -4404,22 +4404,25 @@ size_t fill_textconv(struct userdiff_driver *driver,
 	if (!driver || !driver->textconv) {
 		if (!DIFF_FILE_VALID(df)) {
 			*outbuf = "";
 			return 0;
 		}
 		if (diff_populate_filespec(df, 0))
 			die("unable to read files to diff");
 		*outbuf = df->data;
 		return df->size;
 	}
 
+	if (!DIFF_FILE_VALID(df))
+		die("BUG: attempt to textconv an invalid filespec");
+
 	if (driver->textconv_cache) {
 		*outbuf = notes_cache_get(driver->textconv_cache, df->sha1,
 					  &size);
 		if (*outbuf)
 			return size;
 	}
 
 	*outbuf = run_textconv(driver->textconv, df, &size);
 	if (!*outbuf)
 		die("unable to read files to diff");
 
