From: Francis Galiegue <fg@one2team.net>
Subject: Re: [PATCH] sha1_file: make sure correct error is propagated
Date: Fri, 14 Nov 2008 21:08:46 +0100
Organization: One2team
Message-ID: <200811142108.46762.fg@one2team.net>
References: <1226647174-15844-1-git-send-email-sam@vilain.net> <200811142009.51803.fg@one2team.com> <491DD671.8070801@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Sam Vilain <sam@vilain.net>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 14 21:11:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L150u-0005Tx-98
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 21:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbYKNUKR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Nov 2008 15:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbYKNUKR
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 15:10:17 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:48505 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641AbYKNUKQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Nov 2008 15:10:16 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-134-72.w90-24.abo.wanadoo.fr [90.24.53.72])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 8FDB392C002;
	Fri, 14 Nov 2008 21:10:03 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <491DD671.8070801@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101012>

Le Friday 14 November 2008 20:50:09 Andreas Ericsson, vous avez =E9crit=
=A0:
> Francis Galiegue wrote:
> > Le Friday 14 November 2008 20:05:19 Junio C Hamano, vous avez =E9cr=
it :
> > [...]
> >
> >>>  	fd =3D mkstemp(buffer);
> >>> -	if (fd < 0 && dirlen && (errno !=3D EPERM)) {
> >>> +	if (fd < 0 && dirlen && (errno !=3D EACCESS)) {
> >>
> >> Is this accepting the two as equivalents???
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe git" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> > Well, looking at mkdir(2), it says:
> >
> >        EPERM  The file system containing pathname does not support =
the
> > creation of directories.
> >
> > Hmm, err... git would fail at an earlier point anyway, wouldn't it?=
 Even
> > git init would fail there.
>
> Not necessarily. .git could be mounted erroneously from via a network=
ed
> filesystem but without write permissions.=20

In which case EACCESS would be returned anyway. There is quite a differ=
ence=20
between EACCESS (Permission denied) and EPERM (operation not permitted)=
=2E

Basically, my understanding is that mkdir() will only return EPERM if t=
he=20
underlying filesystem can not even CREATE directories on the filesystem=
=2E So,=20
unless you are doing very bizarre things with your git repository, I ca=
nnot=20
see how you can even trigger an EPERM unless you asked for it.

> Yes, other things would fail=20
> then too, but both EPERM and EACCESS are valid and possible return co=
des.

And so is ENOSPC, and so is EIO, and so is... It's endless. I think foc=
us=20
should be made on the most common ones, and EACCESS _is_ such one. Othe=
rs=20
just aren't.

This is why I suggested replacing EPERM with EACCESS in the first place=
:=20
EACCESS is by far the most common error code you will get (even root wi=
ll get=20
that on a read-only filesystem, not EPERM).

--=20
fge
