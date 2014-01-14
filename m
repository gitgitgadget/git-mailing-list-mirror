From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4: exception when cloning a perforce repository
Date: Tue, 14 Jan 2014 18:24:32 -0500
Message-ID: <20140114232432.GA31465@padd.com>
References: <01EF41A4-533B-4A24-8952-CAEB49970272@iwi.me>
 <20140114001820.GA12058@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alexandru Juncu <alexj@rosedu.org>
To: Damien =?iso-8859-1?Q?G=E9rard?= <damien@iwi.me>
X-From: git-owner@vger.kernel.org Wed Jan 15 00:24:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3DLe-0006og-51
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 00:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbaANXYh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jan 2014 18:24:37 -0500
Received: from honk.padd.com ([74.3.171.149]:53815 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947AbaANXYg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 18:24:36 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id A6BC3713F;
	Tue, 14 Jan 2014 15:24:35 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id DD1A8200BB; Tue, 14 Jan 2014 18:24:32 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20140114001820.GA12058@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240422>

pw@padd.com wrote on Mon, 13 Jan 2014 19:18 -0500:
> damien@iwi.me wrote on Mon, 13 Jan 2014 14:37 +0100:
> > I am trying to clone a perforce repository via git and I am having =
the following backtrace :
> >=20
> > {14:20}~/projects/####:master =E2=9C=97 =E2=9E=AD git p4 clone //de=
pot/@all .
> > Importing revision =E2=80=A6
> > [...]
> > Importing revision 59702 (45%)Traceback (most recent call last):
> [..]
> >   File "/opt/git/libexec/git-core/git-p4", line 2078, in streamOneP=
4File
> >     if data[-1] =3D=3D '\n':
> > IndexError: string index out of range
> >=20
> > git =E2=80=94version: git version 1.8.5.2.309.ga25014b [last commit=
 from master from github.com/git/git]
> > os : ubuntu 13.10
>=20
> This code:
>=20
>         if type_base =3D=3D "symlink":
>             git_mode =3D "120000"
>             # p4 print on a symlink sometimes contains "target\n";
>             # if it does, remove the newline
>             data =3D ''.join(contents)
>   =3D=3D>       if data[-1] =3D=3D '\n':
>                 contents =3D [data[:-1]]
>             else:
>                 contents =3D [data]
>=20
> means that data is an empty string.  Implies you've got a
> symlink pointing to nothing.  Is that even possible?
>=20
> It could be this is a regression introduced at 1292df1 (git-p4:
> Fix occasional truncation of symlink contents., 2013-08-08).  The
> old way of doing data[:-1] unconditionally would have worked but
> was broken for other reasons.
>=20
> Could you investigate the symlink a bit?  We're looking for
> one in change 59702 that points to nowhere.  Maybe do:
>=20
>     $ p4 describe -s 59702
>=20
> and see if you can figure out which of those could be a symlink, then
> inspect it:
>=20
>     $ p4 fstat //depot/symlink@59702
>     (probably shows it is "headRev 1")
>=20
>     $ p4 print -q //depot/symlink#1
>=20
>     $ p4 print -q //depot/symlink#1 | od -c
>=20
> Thanks for checking this depot info first.

I've tried to hack a test that produces a null symlink,
and having done so, find an error later on trying to
generate a symlink that points to "".  So the "easy"
fix of checking for an empty string is unlikely to work
for your repo.

Curious as to how you managed to generate such a thing.
If you find the file, and can get at the p4 depot, the
full ,v file would be interesting too.

		-- Pete
