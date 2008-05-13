From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH v2 19/24] Added the class AddRuleListFactory.
Date: Tue, 13 May 2008 22:55:45 +0200
Message-ID: <200805132255.46363.robin.rosenberg.lists@dewire.com>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <20080513012909.GG29038@spearce.org> <48297A88.5040508@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Florian =?utf-8?q?K=C3=B6berle?= <FloriansKarten@web.de>
X-From: git-owner@vger.kernel.org Tue May 13 22:59:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw1ZC-0000ey-GO
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 22:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758401AbYEMU44 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2008 16:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758327AbYEMU44
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 16:56:56 -0400
Received: from [83.140.172.130] ([83.140.172.130]:6409 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755723AbYEMU4z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 May 2008 16:56:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 453381434CCD;
	Tue, 13 May 2008 22:56:53 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9+cTm0K7kYym; Tue, 13 May 2008 22:56:52 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 88C7280265F;
	Tue, 13 May 2008 22:56:52 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <48297A88.5040508@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82044>

tisdagen den 13 maj 2008 13.24.56 skrev Florian K=C3=B6berle:
> Shawn O. Pearce wrote:
> > Florian Koeberle <florianskarten@web.de> wrote:
> >> +class AddRuleListFactory {
> >> +	/*
> >> +	 * The add command of git 1.5.2.5 behaves a little bit stange: "=
git add
> >> +	 * a/\*z" adds the file "a/b/xyz" but "git add a/x\*" does not.
You mean a/\*/x* does not?
> >> +	 *=20
> >> +	 * The first is parsed as pattern "*z" for whole directory tree =
"a". The
> >> +	 * second is parsed as an path.
> >> +	 *=20
> >> +	 */
> >=20
> > Its not strange.  C Git expands each file path to its _full_ path
> > and stores that into a buffer, then runs fnmatch() for each pattern
> > on the buffer.  If fnmatch() succeeds the path is added to the inde=
x.
> >=20
> > In the case above we are running a match of "a/\*.z" against
> > "a/b/xyz" and that passes.  Or we run "a/x\*" on "a/b/xyz" and it
> > fails as the sequence of characters "a/x" does not appear in the
> > string "a/b".
> >=20
> > You are running into this odd corner case because you are not
> > treating the pattern passed as something that matches against the
> > entire path.  This is one reason why TreeFilter's use the entire
> > path when they process an entry for inclusion or exclusion, and why
> > TreeWalk has each AbstractTreeIterator append the current entry nam=
e
> > onto the end of the current path buffer, so we can always examine
> > the full path from the root of the repository/working directory.
> >=20
> > Trying to avoid the full path in classes like ComplexFilePattern
> > is why you are running into this corner case here, and must now do
> > extra contortions to somewhat match the behavior of C Git.
> >=20
> > At this point I think most of the rules package is overcomplicated
> > and overoptimized, and yet doesn't actually quite match the behavio=
r
> > of C Git.
> >=20
>=20
> Still I think that the behavior of git-add is strange:
> For example, if you want to add the following file:
> a/b/c/test.txt
> Then I can do this with "a/\*.txt" or "a/b\*.txt" but not with=20
> "a/\*/c/test.txt"
>=20
> I know that I handle "a/b\*.txt" wrong, and I don't know a nice way t=
o=20
> implement it in the current rules framework.
>=20
> I see three options:
> 1.) Let the jgit add command work in another way then git-add does.
> 2.) Don't use the rules framework to determine if a file is selected =
by=20
> the add command.
> 3.) Completely drop the patches
> [4.) Add some evil hacks to make it working] <- I don't like that ver=
sion
>=20
> Please tell me which way to go, so that I don't waste even more time =
on=20
> patches which will never make it in.

Correctness is very important. Obviously we will slip bugs trough, but
not intentionally in a part where legacy behaviour may play an importan=
t
role. With these options available I'd select number 2.

I think your observations are interesting, especially the one you make
here about a/*/c/test.txt not matching because I don't see from the git
add manual why it shouldn't. I does not look like a recent git bug eith=
er.=20

btw, I should you can use the =C3=B6 in your name in mail and too. It'l=
l make
for some interesting testing of non-ascii handling that we need to take
on (another argument for not complicating handling of names too much).
I'm sure it will get pretty hairy regardless.

-- robin
