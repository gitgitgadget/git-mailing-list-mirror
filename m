From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] parse-options-cb.c: use string_list_append_nodup in
 OPT_STRING_LIST()
Date: Sun, 12 Jun 2016 18:03:16 -0400
Message-ID: <20160612220316.GB5428@sigill.intra.peff.net>
References: <20160610115726.4805-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 00:03:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCDTY-0003uY-F6
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 00:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933130AbcFLWDU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 18:03:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:53529 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932426AbcFLWDT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 18:03:19 -0400
Received: (qmail 5941 invoked by uid 102); 12 Jun 2016 22:03:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Jun 2016 18:03:19 -0400
Received: (qmail 8624 invoked by uid 107); 12 Jun 2016 22:03:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Jun 2016 18:03:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Jun 2016 18:03:16 -0400
Content-Disposition: inline
In-Reply-To: <20160610115726.4805-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297143>

On Fri, Jun 10, 2016 at 06:57:26PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> If the given string list has strdup_strings set (*), the string will =
be
> duplicated again. Pointless and leak memory. Ignore that flag.
>=20
> (*) only interpret-trailers.c does it at the moment
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  parse-options-cb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/parse-options-cb.c b/parse-options-cb.c
> index 239898d..8a1b6e6 100644
> --- a/parse-options-cb.c
> +++ b/parse-options-cb.c
> @@ -144,7 +144,7 @@ int parse_opt_string_list(const struct option *op=
t, const char *arg, int unset)
>  	if (!arg)
>  		return -1;
> =20
> -	string_list_append(v, xstrdup(arg));
> +	string_list_append_nodup(v, xstrdup(arg));

Hmm. So I agree this is an improvement, in the sense that we are
double-allocating when v->strdup_strings is set.  But I think there's a
deeper issue here. Why are we always allocating in the first place?

If the memory we are getting in "arg" is not stable, then we _do_ need
to make a copy of it. But in that case, we want "strdup_strings" to be
set; without it any time we later run string_list_clear(), we leak the
allocated memory, because the struct has no idea that it is the owner o=
f
the memory (and we do call string_list_clear() when we see "--no-foo").

If the memory _is_ stable, then we are fine to add a direct reference t=
o
it, and can lose the extra xstrdup() here. Only the caller knows for
sure, so we should be respecting their value of strdup_strings (so lose
the xstrdup, but keep calling string_list_append()).

In practice, I suspect the memory _is_ stable, because we are generally
parsing command-line arguments. But it does not hurt to stay on the
conservative side, and always make a copy (in case we are parsing
something besides the global argv array) . Apparently I am the original
author of this code, in c8ba163 (parse-options: add OPT_STRING_LIST
helper, 2011-06-09), but there's no mention of this point there, in the
list archives, or in my brain.

So if we are doing the conservative thing, then I think the resulting
code should either look like:

  if (!v->strdup_strings)
	die("BUG: OPT_STRING_LIST should always use strdup_strings");
  string_list_append(v, arg);

or:

  /* silently enable for convenience */
  v->strdup_strings =3D 1;
  string_list_append(v, arg);

Of the two, I like the top one as it is less magical, but it would
require adjusting the initialization of the string-list for most of the
callers.

-Peff
