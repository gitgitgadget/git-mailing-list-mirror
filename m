From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] color: make it easier for non-config to parse
	color specs
Date: Sun, 18 Jan 2009 12:28:02 -0500
Message-ID: <20090118172802.GA17434@coredump.intra.peff.net>
References: <20090117152108.GA24899@coredump.intra.peff.net> <20090117153229.GA27071@coredump.intra.peff.net> <4973628C.8080501@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jan 18 18:29:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LObSm-0000bD-3R
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 18:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761493AbZARR2I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 12:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760597AbZARR2H
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 12:28:07 -0500
Received: from peff.net ([208.65.91.99]:41705 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760333AbZARR2G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 12:28:06 -0500
Received: (qmail 22065 invoked by uid 107); 18 Jan 2009 17:28:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 18 Jan 2009 12:28:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Jan 2009 12:28:02 -0500
Content-Disposition: inline
In-Reply-To: <4973628C.8080501@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106247>

On Sun, Jan 18, 2009 at 06:10:36PM +0100, Ren=C3=A9 Scharfe wrote:

> >  - right now, it is implemented in terms of color_parse().
> >    But it would be more efficient to reverse this and
> >    implement color_parse in terms of color_parse_mem.
>=20
> Thusly?

Yes, except for the bugs you introduced. :)

> +void color_parse_mem(const char *value, int len, const char *var, ch=
ar *dst)
> +{
>  	const char *ptr =3D value;
>  	int attr =3D -1;
>  	int fg =3D -2;

What's missing in the context here (because it wasn't changed) is:

>	if (!strcasecmp(value, "reset")) {
>		strcpy(dst, "\033[m");
>		return;
>	}

which doesn't work, since our string is actually something like
"reset)\0" or even "reset)some totally unrelated string". So we would
need a "memcasecmp" here.

And then in the error case, we call:

> die("bad color value '%s' for variable '%s'", value, var);

which is also bogus.

I don't know if this is really even worth it. The timing difference is
pretty minimal:

  $ time ./git log --pretty=3Dtformat:'%Credfoo%Creset' >/dev/null
  real    0m0.673s
  user    0m0.652s
  sys     0m0.016s
  $ time ./git log --pretty=3Dtformat:'%C(red)foo%C(reset)' >/dev/null
  real    0m0.692s
  user    0m0.660s
  sys     0m0.032s

That's about 1 microsecond per commit.

-Peff
