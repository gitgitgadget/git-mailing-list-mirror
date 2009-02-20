From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: Recovering from missing objects?
Date: Fri, 20 Feb 2009 15:31:22 +0100 (CET)
Message-ID: <alpine.LRH.2.00.0902201440140.18017@vixen.sonytel.be>
References: <alpine.LRH.2.00.0902191447040.16988@vixen.sonytel.be> <7vvdr6j6hz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 15:33:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaWQy-0002jV-CH
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 15:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbZBTOb3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Feb 2009 09:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbZBTOb2
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 09:31:28 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:33865 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752720AbZBTOb1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2009 09:31:27 -0500
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 9597858ABD;
	Fri, 20 Feb 2009 15:31:22 +0100 (MET)
In-Reply-To: <7vvdr6j6hz.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110848>

	Hi Junio,

On Thu, 19 Feb 2009, Junio C Hamano wrote:
> Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> writes:
> > I start to see suspicious messages about missing objects in one of =
my working
> > repositories:
> >
> > | vixen$ git gc
> > | error: Could not read c406ab0be69c912ea59233595a071478103cdad8
> > | fatal: bad tree object c406ab0be69c912ea59233595a071478103cdad8
> > | error: failed to run repack
> > | vixen$=20
> >
> > I identified the missing object listed above to be part of a remote=
 repository.
> > Doing a `git remote update' doesn't fetch it again, as git is too s=
mart and
> > thinks I already have everything.
> >
> > If I clone the remote repository, I have the object in the new clon=
e.
> > However, how do I get the missing object back into the .git directo=
ry of my
> > working repository?
>=20
> In the new clone:
>=20
> 	$ IT=3Dc406ab0be69c912ea59233595a071478103cdad8
> 	$ TYPE=3D$(git cat-file -t $IT)
>         $ git cat-file $TYPE $IT >/var/tmp/$IT.raw
>=20
> Go to the repository that lacks the object and then
>=20
> 	$ git hash-object -t $TYPE -w --stdin </var/tmp/$IT.raw
>=20
> After that you may find objects that $IT needs to reference.  You can
> obviously repeat the above procedure until you have nothing missing.

Thanks! It worked fine for most of the missing objects.

=46or some of them (type commit), I still get:

| vixen$ git show 32582324956483840d1ae90726bbe879cc48f63d
| fatal: unable to read destination tree (32582324956483840d1ae90726bbe=
879cc48f63d
| vixen$=20

after importing it from the other repository.

> I also suspect you could do this instead; I haven't thought things th=
rough
> and that is why I say "suspect" but this is safe (i.e. not destructiv=
e)
> and may worth a try.
>=20
> In the new clone:
>=20
> 	$ IT=3Dc406ab0be69c912ea59233595a071478103cdad8
> 	$ H=3D$(git rev-list --objects $IT | git pack-objects mine)
>         $ mv mine-$H.pack /var/tmp
>=20
> Go to the repository that lacks the object and then
>=20
> 	$ git unpack-objects </var/tmp/mine-$H.pack

That one did the trick for the "stubborn" commits I couldn't get import=
ed the
other way.

BTW, I kept a copy of the repository with the missing commit
32582324956483840d1ae90726bbe879cc48f63d, just in case you have another=
 idea to
revive that single one without creating a (big) pack ;-)

Anyway, I think it wouldn't hurt to have an option for "git remote upda=
te" to
retrieve all lost commits from the remote...

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Bel=
gium

Phone:    +32 (0)2 700 8453
=46ax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
=46ortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010
