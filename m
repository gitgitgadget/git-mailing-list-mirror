From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] tag: support --sort=<spec>
Date: Sat, 22 Feb 2014 03:04:04 -0500
Message-ID: <20140222080404.GB1576@sigill.intra.peff.net>
References: <1392817167-29802-1-git-send-email-pclouds@gmail.com>
 <1393039762-4843-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 22 09:04:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH7ZF-000519-C5
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 09:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbaBVIEI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Feb 2014 03:04:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:54922 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750965AbaBVIEH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 03:04:07 -0500
Received: (qmail 15260 invoked by uid 102); 22 Feb 2014 08:04:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 22 Feb 2014 02:04:06 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Feb 2014 03:04:04 -0500
Content-Disposition: inline
In-Reply-To: <1393039762-4843-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242504>

On Sat, Feb 22, 2014 at 10:29:22AM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  The new prereq GNULINUX is an ugly workaround until people provide
>  strverscmp compat implementation. I hope that will happen soon as
>  strverscmp.c does not look very complex.

Should GNULINUX be called HAVE_STRVERSCMP in the Makefile?

Then this:

> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -721,4 +721,11 @@ void warn_on_inaccessible(const char *path);
>  /* Get the passwd entry for the UID of the current process. */
>  struct passwd *xgetpwuid_self(void);
> =20
> +#ifndef __GNU_LIBRARY__
> +static inline int strverscmp(const char *s1, const char *s2)
> +{
> +	die("strverscmp() not supported");
> +}
> +#endif

becomes "#ifndef HAVE_STRVERSCMP", and this:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1531c24..5e8c39a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -771,6 +771,8 @@ case $(uname -s) in
>  	;;
>  esac
> =20
> +[ "$(uname -o)" =3D "GNU/Linux" ] && test_set_prereq GNULINUX
> +

can pick up the value from GIT-BUILD-OPTIONS as a prerequisite (see the
way we handle NO_PERL for an example). Though if we can just grab the
glibc version as a fallback, we can do away with that completely.

-Peff
