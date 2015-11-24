From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] wt-status: use strncmp() for length-limited string
 comparison
Date: Tue, 24 Nov 2015 16:36:01 -0500
Message-ID: <20151124213601.GB29185@sigill.intra.peff.net>
References: <563D2DE7.1030005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 24 22:36:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1LG2-0004tp-7c
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 22:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587AbbKXVgH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2015 16:36:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:33439 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752133AbbKXVgF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 16:36:05 -0500
Received: (qmail 24297 invoked by uid 102); 24 Nov 2015 21:36:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 15:36:04 -0600
Received: (qmail 18509 invoked by uid 107); 24 Nov 2015 21:36:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 16:36:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 16:36:01 -0500
Content-Disposition: inline
In-Reply-To: <563D2DE7.1030005@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281633>

On Fri, Nov 06, 2015 at 11:47:03PM +0100, Ren=C3=A9 Scharfe wrote:

> When a branch name is longer than four characters, memcmp() can read
> past the end of the string literal "HEAD".  Use strncmp() instead, wh=
ich
> stops at the end of a string.  This fixes the following test failures
> with AddressSanitizer:

Hmm. I think this is mostly harmless, as a comparison like:

  memcmp("HEAD and more", "HEAD", strlen("HEAD"))

would yield non-zero when we compare the NUL in the second string to
whatever is in the first. So I assume what is going on is that memcmp i=
s
doing larger compares than byte by byte, and is examining 4 or 8 bytes
starting at that NUL.

The outcome is equivalent, but we do touch memory that is not ours, so =
I
think this is a positive direction in that sense.

But...

> diff --git a/wt-status.c b/wt-status.c
> index 435fc28..8dc281b 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1319,7 +1319,7 @@ static int grab_1st_switch(unsigned char *osha1=
, unsigned char *nsha1,
>  	hashcpy(cb->nsha1, nsha1);
>  	for (end =3D target; *end && *end !=3D '\n'; end++)
>  		;
> -	if (!memcmp(target, "HEAD", end - target)) {
> +	if (!strncmp(target, "HEAD", end - target)) {

This will match prefixes like "HEA" in the target, won't it?

I think you want something more like:

  if (end - target =3D=3D 4 && !memcmp(target, "HEAD", 4))

I tried to think of a way that didn't involve a magic number. The best =
I
came up with is:

  if (skip_prefix(target, "HEAD", &v) && v =3D=3D end)

but that requires an extra variable, and is arguably more obfuscated.

-Peff
