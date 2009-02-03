From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Fix AbstractTreeIterator path comparion betwen
	'a' and 'a/b'
Date: Tue, 3 Feb 2009 08:57:12 -0800
Message-ID: <20090203165712.GW26880@spearce.org>
References: <1233605617-14513-1-git-send-email-torarnv@gmail.com> <20090203161539.GV26880@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: Tor Arne =?iso-8859-1?Q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 17:58:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUObg-0000OI-G9
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 17:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbZBCQ5O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2009 11:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752597AbZBCQ5O
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 11:57:14 -0500
Received: from george.spearce.org ([209.20.77.23]:59140 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583AbZBCQ5N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 11:57:13 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id D2CE738210; Tue,  3 Feb 2009 16:57:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090203161539.GV26880@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108213>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Tor Arne Vestb=F8 <torarnv@gmail.com> wrote:
> > The occurance of a '/' as the next character in the longer path
> > does not neccecarily mean the two paths are equal, for example
> > when the longer path has more components following the '/'.
> >=20
> > Signed-off-by: Tor Arne Vestb=F8 <torarnv@gmail.com>
> > ---
> >  .../jgit/treewalk/AbstractTreeIteratorTest.java    |   93 ++++++++=
++++++++++++
> >  .../jgit/treewalk/AbstractTreeIterator.java        |    4 +-
> >  2 files changed, 95 insertions(+), 2 deletions(-)
> >  create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/tree=
walk/AbstractTreeIteratorTest.java
>=20
> *sigh*
>=20
> I can't get Eclipse to run this test.  Every time I try it comes
> up with a CNFE:

@#*@!#@!!@*@ MAVEN ECLIPSE PLUGIN.

The Maven Eclipse plugin, which shouldn't have even been invoked
because JGit doesn't use Maven within Eclipse, was crashing and
causing the JDT to stop compiling.  No records was reported in
the Problems view, but my Error Log was full of JDT crashes due
to ClassCastExceptions.  Uninstalling the Maven plugin fixed the
build and made Eclipse come up with the same failures:

>   Failed tests:
>     testNoDF_NoGap(org.spearce.jgit.treewalk.NameConflictTreeWalkTest=
)
>     testDF_GapByOne(org.spearce.jgit.treewalk.NameConflictTreeWalkTes=
t)
>     testDF_SkipsSeenSubtree(org.spearce.jgit.treewalk.NameConflictTre=
eWalkTest)
>=20
>   Tests run: 773, Failures: 3, Errors: 0, Skipped: 0

So at least my workbench is now reporting the same as Maven on
the command line.  But elsewhere I use Maven (different workbench,
same Eclipse installation) so now I've just shot myself in the foot
and need to install a duplicate copy of Eclipse.  Whoopie.

</unrelated-to-your-patch>

I'm quite certain the breakage in testNoDF_NoGap on line 86 of
NameConflictTreeWalkTest is caused by your change.  Your code is
making "a.b" (a file) equal to "a/" (a tree).  That can't be right.

Going back through the code, the old version of pathCompare
still seems right to me.  And your test cases are somewhat
broken.  We shouldn't ever be looking at cases like this:

  assertTrue(new FakeTreeIterator("a", FileMode.TREE).pathCompare(
             new FakeTreeIterator("a/b", FileMode.REGULAR_FILE)) < 0);

There's no such thing as a tree entry with '/' in the name.  Really
this should have been:

  assertTrue(new FakeTreeIterator("a", FileMode.TREE).pathCompare(
             new FakeTreeIterator("a", FileMode.TREE)) < 0);

at which point they must be equal, because they are both a tree
named "a".  So that throws off a good chunk of your new test cases.
I don't know how I missed this yesterday when you showed me a version
of the tests, but I did.  We should never be doing a compare of
"a/b" in the pathCompare method.

--=20
Shawn.
