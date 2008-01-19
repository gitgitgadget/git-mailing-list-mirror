From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Sat, 19 Jan 2008 10:58:44 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801191026500.2957@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
 <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <2E6F57FC-3E78-4DD2-9B5B-CF75975D6A60@sb.org>
 <20080119084814.GH14871@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 19:59:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGIv1-0007tS-VA
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 19:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbYASS7W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2008 13:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbYASS7W
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 13:59:22 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44966 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750929AbYASS7V (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2008 13:59:21 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0JIwjZO028402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Jan 2008 10:58:46 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0JIwirL017148;
	Sat, 19 Jan 2008 10:58:44 -0800
In-Reply-To: <20080119084814.GH14871@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71125>



On Sat, 19 Jan 2008, Dmitry Potapov wrote:
>=20
> Actually, there is, if you care to do something. You can write a wrap=
per
> around readdir(3) that will recodes filenames in Unicode Normal Forms=
 C.

If somebody wants to do this, then readdir() isn't the only place, but=20
yes, readdir() is one of the places.

I suspect that if we were to just do the "turn into NFC on readdir() on=
 OS=20
X", that might actually be good enough to hide most of the problems. Th=
e=20
issue isn't just that OS X mangles the filenames, it's that it picks a=20
particularly *stupid* way to mangle them (the decomposed forms), which=20
means that OS X will actually not just corrupt "odd cases" of Unicode, =
but=20
will corrupt the obvious and *common* Latin1 translations of Unicode.

I don't know if NFC is better for other locales, but I doubt it. Usuall=
y=20
people want to do the *composite* forms, not the *de*composed forms.

A trivial example of this for some cross-OS issue:

 - let's say that you have a file "M=E4rchen" on just about *any* other=
 OS=20
   than OS X. It could be Latin1 or it could be Unicode, but even if it=
 is=20
   Unicode, I can almost guarantee that the '=E4' is going to be the=20
   *single* Unicode character U+00e4 (utf-8: "\xc3\xa4", latin1: "\xe4"=
)

   So from a cross-OS standpoint, that's the *common* representation, a=
nd=20
   yes, you can create the file that way (I don't know what happens if =
you=20
   actually create it with the Latin1 encoding, but I would not be=20
   surprised if OS X notices that it's not a valid UTF sequence and=20
   assumes it's Latin1 and converts it to Unicode)

 - But on OS X, because of Apples *insane* choice of normal form, it wi=
ll=20
   then be turned into "a=A8". I doubt *anybody* else does that. If you=
 have=20
   to normalize it, NFD is just about the *worst* choice.

So yeah, even just re-coding it as NFC on readdir() would at least mean=
=20
that any OS X git client would be MORE LIKELY to pick the same=20
representation as git clients on other OS's.

It wouldn't solve all problems (and it would almost certainly create a =
few=20
new ones), but it would likely at least increase compatibility between=20
systems.

So doing the NFC conversion on readdir() on OS X is probably a good ide=
a,=20
and probably is the simplest way to make it interact better with other=20
OS's. And it's definitely safe on OS X, since OS X _already_ corrupted =
the=20
name, so we're not losing any information (in contrast, on other system=
s,=20
doing a NFC conversion would possibly lose encoding detail _and_ might =
be=20
incorrect simply because they might not use Unicode in the first place)=
=2E

Anybody want to creat a compat layer around "readdir()" that does that =
NFC=20
conversion on OS X but not elsewhere?

		Linus
