From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Correct conditions to free textconv result data
Date: Mon, 22 Feb 2016 13:06:46 -0500
Message-ID: <20160222180645.GB4587@sigill.intra.peff.net>
References: <1456145545-5374-1-git-send-email-pclouds@gmail.com>
 <1456145545-5374-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 19:07:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXuss-0001UD-2P
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 19:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281AbcBVSGu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 13:06:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:46858 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754712AbcBVSGs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 13:06:48 -0500
Received: (qmail 9460 invoked by uid 102); 22 Feb 2016 18:06:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 13:06:48 -0500
Received: (qmail 20436 invoked by uid 107); 22 Feb 2016 18:06:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 13:06:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 13:06:46 -0500
Content-Disposition: inline
In-Reply-To: <1456145545-5374-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286939>

On Mon, Feb 22, 2016 at 07:52:25PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> fill_textconv() have four code paths to return a new buffer. Two of
> them, run_textconv() and notes_cache_get(), return a newly allocated
> buffer. The other two return either a constant string or an existing
> buffer (mmfile_t). We can only free the result buffer if it's allocat=
ed
> by fill_textconv(). Correct all call sites.

Right, and those two cases (allocated or not) should follow based on
whether you passed in a textconv-enabled driver.

> diff --git a/builtin/blame.c b/builtin/blame.c
> index cb6f2fb..b5477ad 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -166,7 +166,7 @@ int textconv_object(const char *path,
>  	df =3D alloc_filespec(path);
>  	fill_filespec(df, sha1, sha1_valid, mode);
>  	textconv =3D get_textconv(df);
> -	if (!textconv) {
> +	if (!textconv || !textconv->textconv) {
>  		free_filespec(df);
>  		return 0;
>  	}

This change (and the other similar ones) doesn't make any sense to me.
The point of get_textconv() is to return the userdiff driver if and onl=
y
if it has textconv enabled.

I have a feeling you were confused by the fact that fill_textconv()
does:

  if (!driver || !driver->textconv)

to decide whether to allocate the textconv buffer. The latter half of
that is really just defensive programming, and I think this would
probably be better as:

  if (driver)
	....

  assert(driver->textconv);

to make it more clear that we assume the parameter came from
get_textconv().

And if there's a case that triggers that assert(), then I think the bug
is in the caller, which should be fixed.

Is there a case I'm missing here where we actually leak memory or try t=
o
free non-allocated memory? I didn't see it.

-Peff
