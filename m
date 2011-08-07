From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Sun, 7 Aug 2011 15:06:33 -0600
Message-ID: <20110807210633.GA2336@sigill.intra.peff.net>
References: <20110801182516.GC10302@sigill.intra.peff.net>
 <4E371109.7050500@lsrfire.ath.cx>
 <4E3718B4.6090803@kdbg.org>
 <4E37202B.80208@lsrfire.ath.cx>
 <20110802040004.GC17494@sigill.intra.peff.net>
 <4E3829DC.8070802@lsrfire.ath.cx>
 <20110802181357.GA1861@sigill.intra.peff.net>
 <4E388A55.6080606@kdbg.org>
 <4E3D0C1D.9000807@lsrfire.ath.cx>
 <4E3EEF3B.80908@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Aug 07 23:06:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqAYY-0006Pu-Tl
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 23:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268Ab1HGVGl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Aug 2011 17:06:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46623
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755117Ab1HGVGk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 17:06:40 -0400
Received: (qmail 16731 invoked by uid 107); 7 Aug 2011 21:07:14 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Aug 2011 17:07:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Aug 2011 15:06:33 -0600
Content-Disposition: inline
In-Reply-To: <4E3EEF3B.80908@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178927>

On Sun, Aug 07, 2011 at 10:02:03PM +0200, Johannes Sixt wrote:

> Am 06.08.2011 11:40, schrieb Ren=C3=A9 Scharfe:
> > So here's an ugly patch to implement an internal passthrough filter=
 to
> > avoid newline conversions.  It makes the tar filter command (gzip e=
tc.)
> > write to a pipe instead of directly to a file.
>=20
> *If* we are working around the CRLF conversion issue in git itself,
> wouldn't it be much simpler to just:
>=20
> diff --git a/archive-tar.c b/archive-tar.c
> index 20af005..da3d98a 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -364,9 +364,9 @@ void init_tar_archiver(void)
>  	int i;
>  	register_archiver(&tar_archiver);
>=20
> -	tar_filter_config("tar.tgz.command", "gzip -cn", NULL);
> +	tar_filter_config("tar.tgz.command", "gzip -cn | cat", NULL);
>  	tar_filter_config("tar.tgz.remote", "true", NULL);
> -	tar_filter_config("tar.tar.gz.command", "gzip -cn", NULL);
> +	tar_filter_config("tar.tar.gz.command", "gzip -cn | cat", NULL);
>  	tar_filter_config("tar.tar.gz.remote", "true", NULL);
>  	git_config(git_tar_config, NULL);
>  	for (i =3D 0; i < nr_tar_filters; i++) {
>=20
> (provided that 'cat' magically does not suffer from the same problem,
> and I do think that it does not.)

I like that much better, but assumed cat was broken. It might be better
still to have a GZIP_FILTER variable in the Makefile. That would let
msysgit do this, but would also let people with a funny path to gzip
define it at build time (they could also just reconfigure it, of course=
,
but it is nice to work out of the box on odd platforms).

> Anyway, I think it would be better to address the problem on the msys=
git
> side. Perhaps by providing a gzip of a different vintage (e.g. a
> self-compiled one) that does not suffer from the CRLF conversion issu=
e.

Yeah, that would make me happy, too. :)

-Peff
