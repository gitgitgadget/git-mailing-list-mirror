From: Raphael Hertzog <hertzog@debian.org>
Subject: Re: git: problematic git status output with some translations (such
 as fr_FR)
Date: Thu, 16 Jan 2014 23:00:45 +0100
Message-ID: <20140116220045.GA18773@x230-buxy.home.ouaza.com>
References: <20131008085036.11434.25160.reportbug@x230-buxy.home.ouaza.com>
 <20131219104613.GA18379@x230-buxy.home.ouaza.com>
 <20131219194319.GB20443@google.com>
 <xmqqk3f0efhe.fsf@gitster.dls.corp.google.com>
 <20131219205049.GE20443@google.com>
 <CACsJy8Cw+YpG3C8PFuBOddDWLTBZB=bHDFBtTwYzLO=1a15LuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 23:09:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3v8J-0002yF-Mo
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 23:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbaAPWJs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jan 2014 17:09:48 -0500
Received: from mail.vm.ouaza.com ([88.190.240.227]:56092 "EHLO
	mail.vm.ouaza.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbaAPWJr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 17:09:47 -0500
X-Greylist: delayed 528 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jan 2014 17:09:46 EST
Received: from soleymieux.ouaza.com (unknown [IPv6:2a01:e34:ee13:c200:3e97:eff:fe2c:3ebf])
	by mail.vm.ouaza.com (Postfix) with ESMTPSA id A7FD020303;
	Thu, 16 Jan 2014 23:00:45 +0100 (CET)
Received: by soleymieux.ouaza.com (Postfix, from userid 1000)
	id BF8CD5A0131; Thu, 16 Jan 2014 23:00:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CACsJy8Cw+YpG3C8PFuBOddDWLTBZB=bHDFBtTwYzLO=1a15LuA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97.8 at mail
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240540>

Hi,

On Fri, 20 Dec 2013, Duy Nguyen wrote:
> On Fri, Dec 20, 2013 at 3:50 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
> > Junio C Hamano wrote:
> >> Jonathan Nieder <jrnieder@gmail.com> writes:
> >
> >>> This includes the colon in the translated string, to make it easi=
er to
> >>> remember to keep the non-breaking space before it.
> >>
> >> Hmph, recent 3651e45c (wt-status: take the alignment burden off
> >> translators, 2013-11-05) seems to have gone in the different
> >> direction when it updated similar code for the non-unmerged paths.
> >
> > Yes, if this seems to go in the right direction, I'd add a follow-u=
p
> > for that when rerolling.
>=20
> i'm fine either way.

In both cases, the alignment burden is taken off the translators. But I
agree that it's best to keep the colon in the translatable string so th=
at
translators can add the space required by proper typography.

So I'd favor Jonathan's approach. I just tested his patch and it
solves the immediate problem for me. Without the patch I have this
(French translation):

| Chemins non fusionn=C3=A9s :
|   (utilisez "git add <fichier>..." pour marquer comme r=C3=A9solu)
|=20
| 	modifi=C3=A9 des deux c=C3=B4t=C3=A9s :fichier

And with it:

| Chemins non fusionn=C3=A9s :
|   (utilisez "git add <fichier>..." pour marquer comme r=C3=A9solu)
|=20
| 	modifi=C3=A9 des deux c=C3=B4t=C3=A9s :     fichier

However it looks like the padding is calculated on bytes
and not on (wide) characters, so we have 3 extra spaces before
the filename (one for =C3=B4, =C3=A9, and the non-breaking space).
This can be problematic for translations where all characters
require multiple bytes. :-)

The patch is also incomplete since it currently breaks
the test suite in multiple places (the unnecessary padding
before the filename goes away), for example:

--- expected	2014-01-16 21:37:11.270535950 +0000
+++ actual	2014-01-16 21:37:11.270535950 +0000
@@ -5,7 +5,7 @@
 Unmerged paths:
   (use "git add/rm <file>..." as appropriate to mark resolution)
=20
-	both added:         conflict.txt
-	deleted by them:    main.txt
+	both added:      conflict.txt
+	deleted by them: main.txt
=20
 no changes added to commit (use "git add" and/or "git commit -a")
not ok 11 - status when conflicts with add and rm advice (deleted by th=
em)


That was my two euros to help get this fixed because it annoys me
quite often.

Cheers,

--=20
Rapha=C3=ABl Hertzog =E2=97=88 Debian Developer

Discover the Debian Administrator's Handbook:
=E2=86=92 http://debian-handbook.info/get/
