From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Mon, 8 Aug 2011 23:02:11 -0600
Message-ID: <20110809050211.GA3588@sigill.intra.peff.net>
References: <4E371109.7050500@lsrfire.ath.cx>
 <4E3718B4.6090803@kdbg.org>
 <4E37202B.80208@lsrfire.ath.cx>
 <20110802040004.GC17494@sigill.intra.peff.net>
 <4E3829DC.8070802@lsrfire.ath.cx>
 <20110802181357.GA1861@sigill.intra.peff.net>
 <4E388A55.6080606@kdbg.org>
 <4E3D0C1D.9000807@lsrfire.ath.cx>
 <4E3EEF3B.80908@kdbg.org>
 <4E401869.8060702@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Aug 09 07:02:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqeSW-0007bI-Jx
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 07:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966Ab1HIFCT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Aug 2011 01:02:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55837
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779Ab1HIFCS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 01:02:18 -0400
Received: (qmail 2560 invoked by uid 107); 9 Aug 2011 05:02:53 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Aug 2011 01:02:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Aug 2011 23:02:11 -0600
Content-Disposition: inline
In-Reply-To: <4E401869.8060702@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179019>

On Mon, Aug 08, 2011 at 07:10:01PM +0200, Ren=C3=A9 Scharfe wrote:

> > -	tar_filter_config("tar.tgz.command", "gzip -cn", NULL);
> > +	tar_filter_config("tar.tgz.command", "gzip -cn | cat", NULL);
> >  	tar_filter_config("tar.tgz.remote", "true", NULL);
> > -	tar_filter_config("tar.tar.gz.command", "gzip -cn", NULL);
> > +	tar_filter_config("tar.tar.gz.command", "gzip -cn | cat", NULL);
> >  	tar_filter_config("tar.tar.gz.remote", "true", NULL);
> >  	git_config(git_tar_config, NULL);
> >  	for (i =3D 0; i < nr_tar_filters; i++) {
> >=20
> > (provided that 'cat' magically does not suffer from the same proble=
m,
> > and I do think that it does not.)
>=20
> The external cat can indeed be used.  We'd need to do that for user
> supplied commands as well, though, like this (ugh):
>=20
> diff --git a/archive-tar.c b/archive-tar.c
> index 20af005..eaa9a1c 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -326,6 +326,9 @@ static int write_tar_filter_archive(const struct =
archiver *ar,
>  		die("BUG: tar-filter archiver called with no filter defined");
> =20
>  	strbuf_addstr(&cmd, ar->data);
> +#ifdef WIN32
> +	strbuf_addstr(&cmd, " | cat");
> +#endif
>  	if (args->compression_level >=3D 0)
>  		strbuf_addf(&cmd, " -%d", args->compression_level);

Do we need to? It seems to me that defaulting to "gzip -cn | cat" is no=
t
"we are on Windows, a platform that needs a special workaround in git",
but rather "this gzip is horribly broken, but at build-time you can
set a gzip that works".

So if the user wants to specify some broken filter, it is up to them to
add "| cat" if their filter merits it.

But that is somewhat a matter of perception, and it won't make a user o=
n
Windows who does "git config archive.bz2 bzip2 -c" any happier when the=
y
are told it is their responsibility to deal with it.

BTW, as nice as this "gzip -cn | cat" idea is, I think it needs to be
wrapped in a shell script. With the code above, we will generate "gzip
-cn | cat -9". So we really need:

  $ cat `which gzip`
  #!/bin/sh
  gzip.real -cn "$@" | cat

and then no hacks need to go into git at all. The fix is about providin=
g
a sane gzip, not fixing git.

BTW, from what Johannes said, the issue is about a non-msys program
calling an msys one. Does that mean that having git run:

  sh -c 'gzip -cn'

would work? If so, then could the solution be as simple as turning off
the "don't bother with the shell" optimization that run-command uses?
Something like "gzip -cn" gets split by git and run via spawn now
(because it has no metacharacters). But we could easily make it always
run through the shell.

-Peff
