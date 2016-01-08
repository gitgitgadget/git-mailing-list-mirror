From: =?windows-1252?Q?Carlos_Mart=EDn_Nieto?= <cmn@dwim.me>
Subject: Re: Git 2.7.0 gitignore behaviour regression
Date: Fri, 8 Jan 2016 02:47:46 +0100
Message-ID: <C4B28537-628F-4EF6-8284-BE071CA834BE@dwim.me>
References: <4B0F686D-3DF9-4E5D-971D-DB106C6573FD@mikemcquaid.com> <20160105150602.GA4130@sigill.intra.peff.net> <CACsJy8AQ9s4VkFn+TNJLD55xJc40+-54BTYbC4Os71uSkL1QSA@mail.gmail.com> <5E517AD0-CD4E-4F85-8FEB-89B7A0183967@mikemcquaid.com> <CACsJy8CvPqYGRXB845+4fHjkXH_kSAWG684CoxtWAnXE-gM6ag@mail.gmail.com> <CAPc5daX+uGQfKEteT2dqax-m9dR76Gkg1YeiFjVU9dsTqnHDmw@mail.gmail.com> <20160107020406.GA9358@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mike McQuaid <mike@mikemcquaid.com>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 08 02:55:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHMGl-0000kM-Sb
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 02:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbcAHBzG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2016 20:55:06 -0500
Received: from hessy.dwim.me ([78.47.67.53]:53817 "EHLO hessy.dwim.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752634AbcAHBzF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2016 20:55:05 -0500
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jan 2016 20:55:04 EST
Received: from [IPv6:2001:6f8:900:8cd0:d8e5:7ea6:aa6b:bd16] (unknown [IPv6:2001:6f8:900:8cd0:d8e5:7ea6:aa6b:bd16])
	by hessy.dwim.me (Postfix) with ESMTPSA id CAA0A80650;
	Fri,  8 Jan 2016 02:47:48 +0100 (CET)
In-Reply-To: <20160107020406.GA9358@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283523>

On 07 Jan 2016, at 03:04, Jeff King <peff@peff.net> wrote:

> [+cc Carlos and Shawn for libgit2/JGit talk]
>=20
> On Wed, Jan 06, 2016 at 10:58:37AM -0800, Junio C Hamano wrote:
>=20
>> On Wed, Jan 6, 2016 at 2:03 AM, Duy Nguyen <pclouds@gmail.com> wrote=
:
>>>=20
>>> Yeah.. it looks like libgit2's gitignore support was written new, n=
ot
>>> imported from C Git, so behavior differences (especially in corner
>>> cases) and even lack of some feature ("**" support comes to mind). =
=46or
>>> isolated features like gitignore, perhaps we can have an option to
>>> replace C Git code with libgit2 and therefore can test libgit2 agai=
nst
>>> C Git test suite. It could be a good start for libgit2 to invade C
>>> Git. Not sure if anybody's interested in doing it though.
>=20
> Yeah, libgit2 is in the difficult position of trying to hit a moving
> target. There's a good chance that it _was_ the same as git's behavio=
r
> when it was written. :)

We did try to match the rules which git followed at the time when we ad=
ded the functionality, but sometimes small changes in git mean large ch=
anges for us. There=92s a couple of recent issues complaining that we d=
on=92t match git where *git* doesn=92t quite seem to match the rules as=
 I know them.

I don=92t recall the details of how we brought ignore support in, but w=
hen we don=92t just copy the code from git, it=92s generally because it=
=92s embedded into the rest of the code, or in some other way doesn=92t=
 make a lot of sense in a library API.

We do (at least I do) want to test libgit2 more against the git test su=
ite; this either involves porting it to our test suite (generally non-t=
rivial since we can=92t use shell, making it harder to compare) or crea=
ting a command which pretends to be git but uses libgit2. The latter is=
 what I think we=92ll have to do, as we keep hitting complex pieces whi=
ch git keeps changing like crlf and ignore handling. There=92s been pla=
ns to do this, but it=92s never been the top priority.

>=20
> JGit is in the same boat, and I wouldn't be surprised if they don't
> handle "**" either (I didn't check). Note that git inherited that
> feature (and probably some others) by importing a GPLv2 version of
> wildmatch. That certainly isn't an option for JGit (because it's not
> pure Java), and probably not for libgit2 (which would need the wildma=
tch
> authors to grant the linking exception).
>=20
>> Yup, an area that is reasonably isolated from the remainder of the s=
ystem like
>> this might be a good starting point. But I suspect that the invasion=
 needs to
>> happen in the opposite direction in this particular case before it h=
appens.
>> That is, if libgit2's implementation does not behave like how we do,=
 it needs to
>> be fixed, possibly by discarding what they did and instead importing=
 code from
>> us. After the behaviour of libgit2 is fixed, we can talk about the
>> invasion in the
>> opposite direction.
>=20
> Unfortunately, "importing code from us" is not so easy. :(
>=20
> They'll either need to contact the wildmatch authors, or rewrite
> wildmatch from scratch.

Yeah, we currently use the fnmatch code from Android IIRC. I=92m not lo=
oking forward to writing a variant of that for double-star. If the wild=
match authors are receptive to allowing the linking exception, that wou=
ld be ideal.

   cmn
