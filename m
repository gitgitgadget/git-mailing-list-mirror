From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] tag: support --sort=<spec>
Date: Wed, 26 Feb 2014 04:05:11 -0500
Message-ID: <20140226090511.GA32537@sigill.intra.peff.net>
References: <1393039762-4843-1-git-send-email-pclouds@gmail.com>
 <1393330935-22229-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 10:05:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIaQm-0004iY-R2
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 10:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbaBZJFV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Feb 2014 04:05:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:57191 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751223AbaBZJFO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 04:05:14 -0500
Received: (qmail 3570 invoked by uid 102); 26 Feb 2014 09:05:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Feb 2014 03:05:14 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Feb 2014 04:05:11 -0500
Content-Disposition: inline
In-Reply-To: <1393330935-22229-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242704>

On Tue, Feb 25, 2014 at 07:22:15PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> versioncmp() is copied from string/strverscmp.c in glibc commit
> ee9247c38a8def24a59eb5cfb7196a98bef8cfdc, reformatted to Git coding
> style. The implementation is under LGPL-2.1 and according to [1] I ca=
n
> relicense it to GPLv2.

Cool. I think doing this makes the most sense, as we do not have to
worry about build-time config (and I do not see any particular reason
why we would want to use the system strverscmp on glibc systems).

> +static int parse_opt_sort(const struct option *opt, const char *arg,=
 int unset)
> +{
> +	int *sort =3D opt->value;
> +	if (*arg =3D=3D '-') {
> +		*sort =3D REVERSE_SORT;
> +		arg++;
> +	} else
> +		*sort =3D STRCMP_SORT;
> +	if (starts_with(arg, "version:")) {
> +		*sort |=3D VERCMP_SORT;
> +		arg +=3D 8;
> +	} else if (starts_with(arg, "v:")) {
> +		*sort |=3D VERCMP_SORT;
> +		arg +=3D 2;
> +	}
> +	if (strcmp(arg, "refname"))
> +		die(_("unsupported sort specification %s"), arg);

I found this logic a bit weird, as STRCMP_SORT and VERCMP_SORT are not
mutually exclusive flags, but REVERSE and STRCMP are. I would have
thought REVERSE is the flag, and the other two are selections. Like:

  int flags =3D 0;

  if (*arg =3D=3D '-') {
          flags |=3D REVERSE_SORT;
          arg++;
  }
  if (starts_with(arg, "version:")) {
          *sort =3D VERCMP_SORT;
          arg +=3D 8;
  } else
          *sort =3D STRCMP_SORT;

  *sort |=3D flags;

I think they end up doing the same thing, but maybe I am missing
something.

-Peff
