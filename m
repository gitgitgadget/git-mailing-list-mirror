From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH v2 19/24] Added the class AddRuleListFactory.
Date: Tue, 13 May 2008 21:49:02 -0400
Message-ID: <20080514014902.GL29038@spearce.org>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <20080513012909.GG29038@spearce.org> <48297A88.5040508@web.de> <200805132255.46363.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian =?utf-8?Q?K=C3=B6berle?= <FloriansKarten@web.de>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed May 14 03:49:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw67x-000528-JG
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 03:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757165AbYENBtK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2008 21:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756823AbYENBtK
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 21:49:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55061 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008AbYENBtH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 May 2008 21:49:07 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jw66u-0004xc-Rn; Tue, 13 May 2008 21:48:52 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D7D0E20FBAE; Tue, 13 May 2008 21:49:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200805132255.46363.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82063>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> tisdagen den 13 maj 2008 13.24.56 skrev Florian K=C3=B6berle:
> >=20
> > Still I think that the behavior of git-add is strange:
> > For example, if you want to add the following file:
> > a/b/c/test.txt
> > Then I can do this with "a/\*.txt" or "a/b\*.txt" but not with=20
> > "a/\*/c/test.txt"
=2E..
> Correctness is very important. Obviously we will slip bugs trough, bu=
t
> not intentionally in a part where legacy behaviour may play an import=
ant
> role. With these options available I'd select number 2.
>=20
> I think your observations are interesting, especially the one you mak=
e
> here about a/*/c/test.txt not matching because I don't see from the g=
it
> add manual why it shouldn't. I does not look like a recent git bug ei=
ther.=20

Wow.  The behavior of git-add makes _no_ sense to me.

  $ git init
  $ mkdir -p a/b/c; touch a/b/c/test.txt
  $ find a
  a
  a/b
  a/b/c
  a/b/c/test.txt

  $ git add 'a/*/test.txt'
  fatal: pathspec 'a/*/test.txt' did not match any files

(sure, ok, even my shell agrees)

  $ git add 'a/*/c/test.txt'
  fatal: pathspec 'a/*/c/test.txt' did not match any files

  $ ls a/*/c/test.txt
  a/b/c/test.txt

(hmm, now my shell says otherwise)

  $ git add 'a/b*/c/test.txt'
  fatal: pathspec 'a/b*/c/test.txt' did not match any files

  $ ls a/b*/c/test.txt
  a/b/c/test.txt

(also odd)

This last case does match with fnmatch:

  $ cat fnmatch.c=20
  #include <fnmatch.h>
  #include <stdio.h>
 =20
  int main (int argc, char *argv[]) {
  	const char *name =3D argv[1];
  	const char *patt =3D argv[2];
  	printf("\"%s\" matches \"%s\" =3D %d\n",
  		name, patt,
  		fnmatch(patt, name, 0));
  	return 0;
  }

  $ gcc -o fnmatch fnmatch.c
  $ ./fnmatch a/b/c/test.txt 'a/b*/c/test.txt'
  "a/b/c/test.txt" matches "a/b*/c/test.txt" =3D 0

So I find it odd that git-add does not match this name, but fnmatch
does.  I suspect the problem here is git-add has pruned away the
subdirectory "a/b" and did not enter into it, so the pattern was
never even given a chance to look at test.txt.  This sounds like
a bug to me in git's working directory filter.

Even if Linus says matching names incorrectly is not a bug, I'm
not sure its an implementation detail we should mirror in jgit.

Where does that leave us?  I'm not sure.  But treating git-add as
a black box and replicating its behavior looks loony to me right now.

--=20
Shawn.
