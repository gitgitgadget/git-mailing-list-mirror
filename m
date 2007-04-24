From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Only use ETC_GITCONFIG=$(prefix)/etc/gitconfig ifeq ($(prefix),$(HOME))
Date: Tue, 24 Apr 2007 00:23:40 -0700
Message-ID: <462DB07C.5060500@freedesktop.org>
References: <462D673A.1010805@freedesktop.org>	<7vhcr6bdmk.fsf@assigned-by-dhcp.cox.net>	<462D9938.8020206@freedesktop.org> <7vlkgi9utk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5E59177BA3D5F0CCBE59D885"
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 24 09:24:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgFO0-0007a7-AW
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 09:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161688AbXDXHYX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 03:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161690AbXDXHYX
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 03:24:23 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:34382 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161688AbXDXHYW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 03:24:22 -0400
Received: (qmail 24025 invoked from network); 24 Apr 2007 07:24:21 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail2.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <junkio@cox.net>; 24 Apr 2007 07:24:20 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <7vlkgi9utk.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45421>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5E59177BA3D5F0CCBE59D885
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Josh Triplett <josh@freedesktop.org> writes:
>=20
>> Junio C Hamano wrote:
>>> Is this really necessary?
>>>
>>> I personally think distro people (or anybody who configures git
>>> for system-wide deployment for that matter) already has Makefile
>>> wrapper (a la debian/rules) to take care of this and other
>>> issues.
>> So did I.  Then I noticed (while stracing git to diagnose the issue wi=
th
>> git-add searching the whole working copy for .gitignore files) that th=
e
>> Debian-packaged git looked for /usr/etc/gitconfig.  See
>> <http://bugs.debian.org/420675>.  Apparently few enough people use
>> /etc/gitconfig that nobody noticed and reported that it didn't work. :=
)
>>
>> Why not make the defaults more resistant to broken configuration?
>=20
> Hmm.
>=20
> It's tempting to leave this as is to gauge which distribution
> has more competent package maintainer and which ones have sloppy
> ones ;-).
>
> Sympathetic, but still not entirely convinced.

commit cc58fc0684396c5298b21c97f00a568e46224258
Merge: 8a13bec... 8565d2d...
Author: Junio C Hamano <junkio@cox.net>
Date:   Sat Feb 24 01:43:28 2007 -0800

    Merge branch 'js/etc-config'

    * js/etc-config:
      Make tests independent of global config files
      config: read system-wide defaults from /etc/gitconfig


Fairly recent feature, only a few Debian package releases have come out s=
ince
then, and I strongly suspect that few people use /etc/gitconfig.  I didn'=
t
even know it existed until the strace, and none of the other Git users I =
know
use it.

It seems harder to make the mistake *now*, while looking at the Makefile =
to
see what variables need setting, but it seems easy to have not noticed th=
e
necessary change for existing packaging.

Furthermore, people often forget the same thing with autofoo-based progra=
ms;
--prefix=3D/usr or --prefix=3D/usr/local works for many programs (since a=
 small
fraction of autofoo-using programs have systemwide configuration, compare=
d to
all autoconf programs), and it seems easy enough to forget about
--sysconfdir=3D/etc.  Most of the time, however, the configuration file g=
ets
used more often, and often a default version exists that would get instal=
led
to the wrong place, so this mistake gets more readily noticed.

git does not install a default systemwide configuration file, and it does=
 not
attempt to create the target etc directory, making it easy to not notice =
the
mistake.  In order to notice, you would have to re-read the Makefile in
detail, read the git-config manpage in detail (it shows up in no other
documentation), read the source code, or notice a line in an strace.  Or =
you
would have to get a bugreport from someone using /etc/gitconfig, but agai=
n,
few do.

Finally, more people install Git than just experienced and observant pack=
age
maintainers.  Random sysadmins install Git too (I know some of them), and=

making life easier for them seems like a good idea.

Overall, this seems like an easy change, with good benefits, and no drawb=
acks
that I can see.


That said, I can see another way to make it slightly more forward-looking=
:
create a sysconfdir variable in Makefile, like the existing bindir and
gitexecdir, and apply the appropriate logic to it instead.  Then, any fut=
ure
configuration files can take advantage of the same logic.

Furthermore, I think my original logic may have a flaw in it: someone
installing with prefix=3D$HOME/local (which I do for other software, thou=
gh not
Git because I use the Debian package) would likely expect $(prefix)/etc a=
s
well.  For /usr/local, it can go either way; some people apparently do ex=
pect
/usr/local/etc and some people expect /etc.  Overall, someone installing =
in a
strange nonstandard location probably wants $(prefix)/etc.  So, I think t=
he
right logic for sysconfdir looks like:

ifeq ($(prefix),/usr)
sysconfdir=3D/etc
else
sysconfdir=3D$(prefix)/etc
endif

Personally, I wish automake and autoconf had exactly the same logic; it j=
ust
makes sense.

- Josh Triplett


--------------enig5E59177BA3D5F0CCBE59D885
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLbB8GJuZRtD+evsRAiAFAKC7tM2yzFYvN6xIS59UrsKwQV9OeACgjYCg
yEthUe34dPWaZ9wFtT16pGc=
=HoZs
-----END PGP SIGNATURE-----

--------------enig5E59177BA3D5F0CCBE59D885--
