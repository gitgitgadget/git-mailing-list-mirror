From: Kevin Daudt <me@ikke.info>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Fri, 4 Mar 2016 12:56:34 +0100
Message-ID: <20160304115634.GC26609@ikke.info>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
 <20160304055117.GB26609@ikke.info>
 <1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Charles Strahan <charles@cstrahan.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 12:56:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aboLi-0000Tq-Nx
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 12:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbcCDL4j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2016 06:56:39 -0500
Received: from ikke.info ([178.21.113.177]:45868 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbcCDL4g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 06:56:36 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
	id E4F2E2D8007; Fri,  4 Mar 2016 12:56:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288250>

On Fri, Mar 04, 2016 at 01:12:37AM -0500, Charles Strahan wrote:
> I'm on 2.7.0.
>=20
> Here's a quick sanity check:
>=20
> =E2=94=9C=E2=94=80=E2=94=80 baz
> =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 quux
> =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80=
 corge
> =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=
=94=94=E2=94=80=E2=94=80 wibble.txt
> =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80=
 grault.txt
> =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 waldo.txt
> =E2=94=94=E2=94=80=E2=94=80 foo
>     =E2=94=9C=E2=94=80=E2=94=80 bar.txt
>     =E2=94=94=E2=94=80=E2=94=80 garply.txt
>=20
> $ git --version
> git version 2.7.0
>=20
> $ git status -sb -uall
> ## Initial commit on master
> ?? baz/quux/corge/wibble.txt
> ?? baz/quux/grault.txt
> ?? baz/waldo.txt
> ?? foo/bar.txt
> ?? foo/garply.txt
>=20
>=20
> For the lazy (such as myself), this will set up an identical tree:
>=20
> mkdir -p foo
> mkdir -p baz/quux/corge
> touch foo/bar.txt
> touch foo/garply.txt
> touch baz/waldo.txt
> touch baz/quux/grault.txt
> touch baz/quux/corge/wibble.txt
> cat <<"EOF" > .gitignore
> *
> !/foo
> !/foo/bar.txt
> !/baz
> !/baz/quux
> !/baz/quux/**/*
> EOF
>=20
>=20
> I just checked https://git-scm.com/docs/gitignore and the example at =
the
> bottom
> suggests that this behavior may be expected:
>=20
>     $ cat .gitignore
>     # exclude everything except directory foo/bar
>     /*
>     !/foo
>     /foo/*
>     !/foo/bar
>=20
> Note the /foo/*, explicitly ignoring the entries below /foo.
>=20
> This wasn't always the case, though, so I'd love to hear if it was
> intentional
> (or if I've lost my mind, which is quite possible).
>=20
> -Charles
>=20
>=20
>=20
> On Fri, Mar 4, 2016, at 12:51 AM, Kevin Daudt wrote:
> > On Thu, Mar 03, 2016 at 09:11:56PM -0500, Charles Strahan wrote:
> > > Hello,
> > >=20
> > > I've found a change in the way .gitignore works, and I'm not sure=
 if
> > > it's a bug
> > > or intended.
> > >=20
> > > Previously, one could use the following .gitignore:
> > >=20
> > >     *
> > >     !/foo
> > >     !/foo/bar.txt
> > >     !/baz
> > >     !/baz/quux
> > >     !/baz/quux/**/*
> > >=20
> > > And these files would be seen by git:
> > >=20
> > >     foo/bar.txt
> > >     baz/quux/grault.txt
> > >     baz/quux/corge/wibble.txt
> > >=20
> > > And these files would be ignored:
> > >=20
> > >     foo/garply.txt
> > >     baz/waldo.txt
> > >=20
> > > At some point (between git 2.6.0 and 2.7.0, I think), the behavio=
r
> > > changed such
> > > that _none_ of the files above would be ignored. Previously, git =
would
> > > treat
> > > !/foo as an indication that it should not prune /foo, but that
> > > _wouldn't_ be
> > > sufficient to un-ignore the contents thereof. Now, it seems the n=
ew
> > > scheme
> > > treats !/foo as functionally equivalent to !/foo followed by !/fo=
o/**/*
> > > in the
> > > old scheme.
> > >=20
> > > I manage my home directory by making it a git repo, and using
> > > ~/.gitignore to
> > > selectively permit certain files or subdirectories to be seen by =
git.
> > > The recent
> > > change in behavior has resulted in sensitive directories like ~/.=
gpg
> > > being
> > > un-ignored. For reference, I've appended my .gitignore to the end=
 of
> > > this email.
> > >=20
> > > So, is this behavior intended, or is this a bug? If the former, i=
s there
> > > an
> > > announcement explaining this change?
> > >=20
> > > -Charles
> > >=20
> > > [snip]
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe git" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> >=20
> > Works as intended for me:
> >=20
> > =E2=94=9C=E2=94=80=E2=94=80 baz
> > =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 quux
> > =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 corge
> > =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=
=94=94=E2=94=80=E2=94=80 wibble.txt
> > =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=
=80 grault.txt
> > =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 waldo.txt
> > =E2=94=94=E2=94=80=E2=94=80 foo
> >     =E2=94=9C=E2=94=80=E2=94=80 bar.txt
> >     =E2=94=94=E2=94=80=E2=94=80 garply.txt
> >=20
> > $ git status -s -uall
> > ?? baz/quux/corge/wibble.txt
> > ?? baz/quux/grault.txt
> > ?? foo/bar.txt
> >=20
> > garply.txt and waldo.txt are ignore, but the rest is still tracked.
> >=20
> > I'm on 2.7.2.
> --

Verified that it's different in 2.7.0, but 2.7.2 gives expected output.
