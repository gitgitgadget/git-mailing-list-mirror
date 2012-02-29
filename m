From: Jeff King <peff@peff.net>
Subject: Re: Building GIT on older systems.
Date: Wed, 29 Feb 2012 15:55:10 -0500
Message-ID: <20120229205510.GA628@sigill.intra.peff.net>
References: <CAFqtsHfrk89qHexg8VwMZnKwgWDqbseJNNKFSUkwDtVKX_t=5g@mail.gmail.com>
 <CAFqtsHd=b=Ey8j1zTCC4-fut7rno3daQ2Q3HMs3k2SHFvE4dSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tim Schumacher <schumact@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 21:55:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2qYS-0004jC-Da
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 21:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756059Ab2B2UzO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 15:55:14 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33390
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755959Ab2B2UzN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 15:55:13 -0500
Received: (qmail 27242 invoked by uid 107); 29 Feb 2012 20:55:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 Feb 2012 15:55:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Feb 2012 15:55:10 -0500
Content-Disposition: inline
In-Reply-To: <CAFqtsHd=b=Ey8j1zTCC4-fut7rno3daQ2Q3HMs3k2SHFvE4dSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191855>

On Wed, Feb 29, 2012 at 01:22:21PM -0700, Tim Schumacher wrote:

> After a long battle trying to get git to compile on my dev boxes I am
> seeking help from the gurus...=C2=A0 I have an old system, redhat lin=
ux
> 7.3, with a 2.4.18 kernel with gcc 2.96 toolchain.=C2=A0 Unfortuneatl=
y,
> upgrading is not currently an option.

That's pretty old, but I would think git should be build-able on it wit=
h
the right Makefile flags set. We build on even older versions of
Solaris.

> I have figured out so far that I can run the command
>=20
> make NO_NSEC=3Dtrue
>=20
> to get past the time struct compile error.

As an aside, you can put definitions like this into config.mak, which i=
s
read automatically by the Makefile. Then you don't have to specify them
on the command line for each 'make' invocation.

> After that, I was able to hand edit the Makefile to set
>=20
> BASIC_LDFLAGS =3D -ldl
>=20
> so linking the git-imap-send program succeeds (was failing to link
> against this library for some reason...).=C2=A0

What was the link error? I don't know why imap-send would need to link
against -ldl. However, you should be able to just put -ldl into the
LDFLAGS on the command-line or in config.mak.

> I tried to run configure with these options, but it did not seem to
> take, only setting NO_NSEC=3Dtrue to the make command line seems to
> work.

Was NO_NSEC set in the resulting config.mak.autogen?

> Anyway, now I get to the point in the build where it goes into the
> perl subdir and fails with:
>=20
> =C2=A0=C2=A0 SUBDIR perl
> /bin/sh: -c: line 3: syntax error near unexpected token
> `"s<\Q++LOCALEDIR++\E></'
> /bin/sh: -c: line 3: `=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e "=
pm_to_blib({qw{Git/I18N.pm
> blib/lib/Git/I18N.pm private-Error.pm blib/lib/Error.pm Git.pm
> blib/lib/Git.pm}},'blib/lib/auto','/usr/bin/perl -pe
> "s<\Q++LOCALEDIR++\E></usr/local/git-1.7.9.2/share/locale>"')"'
> make[2]: *** [pm_to_blib] Error 2
> make[1]: *** [all] Error 2
> make: *** [all] Error 2

I haven't seen that before. The snippet mentioned in the error message
is actually written to the Makefile by Makefile.PL. Can you show us the
relevant part of the Makefile (i.e., the command that contains
"++LOCALEDIR++") so we can see if it's broken? My suspicion is that
there is an error in the generation of the Makefile by Makefile.PL.

Although your perl is so old the first step may be either to turn off
perl or upgrade to a newer version (see below).

> A couple questions I have so far:
> (1)=C2=A0 how can I make make output the actual command it is executi=
ng so
> I can try to debug things more quickly?

Doing "make V=3D1" will be more verbose. You can also use "make -d" to =
get
more output about which rules and commands are being followed, but its
output can be a bit overwhelming (and I don't think you have a make
problem, exactly).

> (2)=C2=A0 how can I configure the Makefile to automatically set -ldl =
as
> well as the NO_NSEC flag?

Put it in LDFLAGS.

> (3)=C2=A0 My perl -v output: This is perl, v5.6.1 built for i386-linu=
x.=C2=A0 Is
> this sufficient?

These days we require at least 5.8, mostly because no developers are us=
ing 5.6
and support for it is bit-rotting. If your perl is that old, probably
setting NO_PERL is the best option. You will lose a few perl features
like interactive patch selection ("git add -p") and git-svn.

-Peff
