From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/7] gitweb: Cleanups, fixes and small improvements
Date: Sat, 26 Aug 2006 23:18:23 +0200
Organization: At home
Message-ID: <ecqdqt$rcl$1@sea.gmane.org>
References: <1156612392716-git-send-email-jnareb@gmail.com> <7vd5an1afz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Aug 26 23:18:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH5YA-0003vU-Rv
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 23:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWHZVSj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 26 Aug 2006 17:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWHZVSj
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 17:18:39 -0400
Received: from main.gmane.org ([80.91.229.2]:41453 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750741AbWHZVSj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 17:18:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GH5Xy-0003u7-Ha
	for git@vger.kernel.org; Sat, 26 Aug 2006 23:18:30 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Aug 2006 23:18:30 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Aug 2006 23:18:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26069>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> * gitweb: Restore old git_blame using git-annotate under "annotate"
>=20
> =A0 I actually was hoping to see a patch to remove the git_blame
> =A0 which is not used as far as I can see.
>=20
> =A0 Although we carried annotate and blame in git.git tree for
> =A0 quite a while, the intention was always to deprecate one over
> =A0 the other once pros-and-cons of each implementation become
> =A0 clear (and I think people would not miss annotate if we remove=20
> =A0 annotate and make it an alias for blame -c anymore). =A0What's
> =A0 the reason we would want to have both?

Well, removing it completely might be not a best idea for now,
as git_annotate has for example two more columns ("Age" and "Author")=20
which might be usefull.

I guess the intention is to provide patch for those who want=20
to improve git_blame, to have comparison with git_annotate,
i.e. patch not applied but available.

> * gitweb: Use 'local $/ =3D undef;' before 'print <$fd>;'
>=20
> =A0 You changed:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0$/ =3D undef;
> =A0=A0=A0=A0=A0=A0=A0=A0print <$fd>;
> =A0 =A0 =A0 =A0 ... hope that nobody depends on standard value of $/
> =A0=A0=A0=A0=A0=A0=A0=A0... around here, which may still break if you=
 did sub
> =A0=A0=A0=A0=A0=A0=A0=A0... calls, the sub did not localize $/ (who w=
ould?),
> =A0 =A0 =A0 =A0 ... and depended to have a sane $/.
> =A0=A0=A0=A0=A0=A0=A0=A0$/ =3D "\n";
>=20
> =A0 to
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0local $/ =3D undef;
> =A0=A0=A0=A0=A0=A0=A0=A0print <$fd>;
> =A0 =A0 =A0 =A0 ... hope that nobody depends on standard value of $/
> =A0=A0=A0=A0=A0=A0=A0=A0... until the end of scope, and whoever chang=
es this
> =A0 =A0 =A0 =A0 ... sub is careful enough in the future
>=20
> =A0 which I think is worse. =A0Introducing an extra scope explicitly
> =A0 delimit the part you want to use localized $/ like this
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0{ local $/; print <$fd>; }=20
>=20
> =A0 might have been more palatable. =A0Am I guessing the reason of
> =A0 your change wrong?

Actually only one change was from '$/ =3D undef; print <$fd>; $/ =3D "\=
n"',
namely at the end of git_blob_plain. I think nobody will print anything
to the end of the sub.

Two other chunks actually _introduced_ 'local $/ =3D undef', both in th=
e
fairly short 'if' body. First to read $home_text (there change is not t=
hat
important, as $home_text should be fairly short), next more important i=
n
git_snapshot.

IMVHO 'local $/ =3D undef' in all commands that get the rest of the out=
put
from filehandle (and outputting nothing later), like all 'plain' output=
s
should be the idiom to use.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
