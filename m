From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] test: Add target test-lint-shell-syntax
Date: Wed, 2 Jan 2013 18:22:39 -0500
Message-ID: <20130102232239.GA27952@sigill.intra.peff.net>
References: <201301012240.10722.tboegi@web.de>
 <20130102094635.GD9328@sigill.intra.peff.net>
 <50E4BF58.4090808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 03 00:23:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqXeG-0001rV-LN
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 00:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758Ab3ABXWm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2013 18:22:42 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41625 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752751Ab3ABXWl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 18:22:41 -0500
Received: (qmail 1379 invoked by uid 107); 2 Jan 2013 23:23:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Jan 2013 18:23:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Jan 2013 18:22:39 -0500
Content-Disposition: inline
In-Reply-To: <50E4BF58.4090808@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212557>

On Thu, Jan 03, 2013 at 12:14:32AM +0100, Torsten B=C3=B6gershausen wro=
te:

> > This is wrong if $(PERL_PATH) contains spaces, no? Doing "$(PERL_PA=
TH)"
> > is also wrong, because the expansion happens in 'make', and a
> > $(PERL_PATH) with double-quotes would fool the shell. Since we expo=
rt
> > $PERL_PATH, I think doing:
> >=20
> >   "$$PERL_PATH"" check-non-portable-shell.pl $(T)
> Thanks, but:            =20
> - The double "" after PERL_PATH makes the string un-terminated.

Yeah, sorry, typo on my part.

> - Using "$$PERL_PATH" expands from make into "$PERL_PATH" on the comm=
and line

Right. That's what I intended.

> - If the Makefile looks like this:
> PERL_PATH =3D "/Users/tb/projects/git/tb/pe rl"
> [snip]
> $(PERL_PATH) check-non-portable-shell.pl $(T)
> The command line will look like this:
> "/Users/tb/projects/git/tb/pe rl" check-non-portable-shell.pl t0000-b=
asic.sh ...
>=20
> So I think that PERL_PATH should be quoted when it is defined in the =
Makefile.

Does a $PERL_PATH with quotes actually work?

Usually in our runtime environment, commands that are handed to git are
assumed to be passed directly to the shell, and you need to quote. E.g.=
,
setting diff.external to:

  [diff]
  external =3D "foo --bar"

will let the shell split the argument out; if you have a space, you
would want to set it like:

  [diff]
  external =3D "'command with space'"

This is the most flexible way to do it.

However, for Makefile variables, I think we do not (and cannot) follow
the same rule.  Notice that all of the uses of $PERL_PATH in the test
suite enclose it in quotes. Having extra quotes would break those
invocations. And the value of $PERL_PATH will be put on the #!-line,
which cannot not be quoted.

-Peff
