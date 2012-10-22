From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] git-submodule add: Record branch name in .gitmodules
Date: Mon, 22 Oct 2012 18:55:46 -0400
Message-ID: <20121022225546.GO23101@odin.tremily.us>
References: <61a31f6bc61d4df322a097e32ba472390c583a81.1350923683.git.wking@tremily.us>
 <CABURp0pqg7XC6makK2OcundMabV9AtcBNGNK6Q0TMZfJbt3anw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=dwWFXG4JqVa0wfCP
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 03:04:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRBs0-0008Qm-1V
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 03:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758902Ab2JYBEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 21:04:11 -0400
Received: from vms173021pub.verizon.net ([206.46.173.21]:46383 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757302Ab2JYBEK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 21:04:10 -0400
Received: from odin.tremily.us ([unknown] [72.68.84.95])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MCF00DVZCA8JC00@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 24 Oct 2012 20:03:45 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 2766967F3BE; Wed,
 24 Oct 2012 21:03:44 -0400 (EDT)
Content-disposition: inline
In-reply-to: <CABURp0pqg7XC6makK2OcundMabV9AtcBNGNK6Q0TMZfJbt3anw@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208332>


--dwWFXG4JqVa0wfCP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 22, 2012 at 06:03:53PM -0400, Phil Hord wrote:
> Some projects now use the 'branch' config value to record the tracking
> branch for the submodule.  Some ascribe different meaning to the
> configuration if the value is given vs. undefined.  For example, see
> the Gerrit submodule-subscription mechanism.  This change will cause
> those workflows to behave differently than they do now.

For those to lazy to hunt down a reference, Gerrit uses
submodule.$name.branch to

  =E2=80=9Cindicate the branch of a submodule project that when updated will
  trigger automatic update of its registered gitlink.=E2=80=9D [1]

They also have some extra sauce:

  =E2=80=9CThe branch value could be '.' if the submodule project branch has
  the same name as the destination branch of the commit having
  gitlinks/.gitmodules file.
  =E2=80=A6
  Any git submodules which are added and not have the branch field
  available in the .gitmodules file will not be subscribed by Gerrit
  to automatically update the superproject.=E2=80=9D

> I do like the idea, but I wish it had a different name for the
> recording.  Maybe --record-branch=3D${BRANCH} as an extra switch so the
> action is explicitly requested.
>=20
>   git submodule add --branch=3Dmaster --record-branch=3Dmaster foo bar

Ugh, I don't want to retype the branch name whenever I do this.

<brainstorming>

How about -r/--record, with the recorded name being optional?

  --record-branch[=3D<recorded_name>]

This would satisfy Gerrit users that wanted to use '.', but also
satisfy me with:

  git submodule add -rb=3Dmaster foo bar

However, there is a change that people would see that, and then use

  git submodule add -r -b=3Dmaster foo bar

which would checkout the HEAD from foo and store `-b=3Dmaster` in
submodule.$name.branch.

A more verbose, but less dangerous, option would be a boolean
-r/--record that enables the recording of whatever was passed to
-b/--branch.  This looses the flexibility of running something like

  git submodule add --branch=3Dmaster --record-branch=3D. foo bar

but the Gerrit folks have gotten along OK without any branch recording
so far ;).  They can keep setting '.' the same way they always have.

</brainstorming>

On a tangentially related note, it would be nice to set environment
variables for each of the settings in submodule.$name during a foreach
call.  Then you could use

  git submodule foreach 'git checkout $branch && git pull'

Perhaps you'd want to blacklist/whitelist or downcase settings names
to avoid things like

  [submodule "foo"]
        PATH =3D /my/rootkit/

but the update line is much cleaner.

Cheers,
Trevor

[1]: https://gerrit.googlesource.com/gerrit/+/master/Documentation/user-sub=
modules.txt

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--dwWFXG4JqVa0wfCP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQhc7xAAoJEEUbTsx0l5OMOh4P/2r65Yh5XoxvvC7Jjfx2c08X
Niy0NRphOyutaPvQH9ZM6872dMlHBVEB5+Fxl7+NWmAbkGMSSn06RIkTPft7EdjR
mDQywYFj4L4jSwhWdOyXAOth6o28aOOExfl5ORgR82LIq5JubGt8+dlRoK9qTFeG
i9ZhZ9NeHC7C0LxZx8zzGO9qo4PuTD6AnJ5n2Wswkx/UH3bJe4Lamj0mzFsFJKbC
7aNpw+13TzGdIYl2QzQypPgKvUezaR8rhDdWzu1dW8dd9zbUUiZzjXdgHwpt/am3
cWlGtQUdozBV2NxZNUTeT8xYu0MhUxE6NfDw0+yRsY2akhy6pinPw+oYOwdTTKmg
eUMQMBtafuFZslOHHwoOpqS2289F/JbcWzNE4klHIoask9FualT5WzEiNbNBkbNC
yEkcQWgLDH89Ga/RXB6EFPZ8XISmzzzllwrLx+VyUNVPEekbkH6tw9fZX03bw68q
XY0v7gvGJcd693eo+P201YBprNxMXmslDRgBdL2/+1hN7di9i/BOPM0Di6aYhkgP
5RtvXOWeGuuXvNoZLfbZx7fsL9d6sr/5VNcxSVOs+4AJXXNitd8zc6WjxtpauH2r
l/FVf2TAxowxmYXwMQ1DSfL0XF/zYVPoeNMokSw6CMJFuriGBugZntB5MrhBeHhJ
zdIq8bGTdKEALl0LHom7
=9mrw
-----END PGP SIGNATURE-----

--dwWFXG4JqVa0wfCP--
