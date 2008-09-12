From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [JGIT PATCH 1/2] Issue 23: Resolve tag^0 as tag^{commit}
Date: Fri, 12 Sep 2008 02:00:07 +0200
Message-ID: <20080912000007.GA31931@diku.dk>
References: <20080911213927.GA20238@diku.dk> <200809120047.58484.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 02:01:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdw6C-0005B9-Tq
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 02:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbYILAAN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Sep 2008 20:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753439AbYILAAN
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 20:00:13 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:49628 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753061AbYILAAL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 20:00:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 95FF852C44A;
	Fri, 12 Sep 2008 02:00:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h+qKELHWQaUc; Fri, 12 Sep 2008 02:00:08 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 17A2D52C365;
	Fri, 12 Sep 2008 02:00:08 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 156276DF894; Fri, 12 Sep 2008 01:59:55 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id F2DDC1A4001; Fri, 12 Sep 2008 02:00:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809120047.58484.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95673>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote Fri, Sep 12, 2=
008:
> torsdagen den 11 september 2008 23.39.27 skrev Jonas Fonseca:
> > Repository.resolve("tag^0") failed with "not a commit". Fix it and =
add a
> > test case for it.
>=20
> It seems this case is not *that* special. It is tag^N =3D=3D tag^{com=
mit}^N
> Same for tag~N =3D=3D tag^{commit}~N-
=20
git-rev-parse(1) says:

 =B7 A suffix ^ to a revision parameter means the first parent of that
   commit object.  ^<n> means the <n>th parent (i.e.  rev^ is
   equivalent to rev^1). As a special rule, rev^0 means the commit
   itself and is used when rev is the object name of a tag object that
   refers to a commit object.

but does take tag^1, however not tag^2. It looks like tag~N is broken i=
n
JGit ("not a commit") so should also be fixed if we want to be
compatible with git-rev-parse.

BTW, I just noticed that ^{} is not handled correctly either for tags.

 =B7 A suffix ^ followed by an empty brace pair (e.g.  v0.99.8^{}) mean=
s
   the object could be a tag, and dereference the tag recursively
   until a non-tag object is found.

Only one derefence is performed.

> My fault, i guess, but it would be nice of you fixed it while you are=
 at it.

I will try to make fixes for the above cases tomorrow.

> Second, the testcase in the second patch fails on my machine.
>=20
> testDerefTaggedTagTree(org.spearce.jgit.lib.T0008_testparserev)
> junit.framework.ComparisonFailure: expected:<[269e1253bad5c247c6bde37=
aa48ae1e03138206c]> but was:<[be83157b4ffe650d728ba4f98ad47b623b0d0c20]=
>
> 	at junit.framework.Assert.assertEquals(Assert.java:81)
> 	at junit.framework.Assert.assertEquals(Assert.java:87)
> 	at org.spearce.jgit.lib.T0008_testparserev.testDerefTaggedTagTree(T0=
008_testparserev.java:123)

I reran all the test before formatting the patch, but after doing some
last minut changes. When I run all the tests using maven (inside
NetBeans or from the command line) it tells me:

	Tests run: 428, Failures: 0, Errors: 0, Skipped: 0

=46rom the output it looks like the tests in the files named T000* are
never run. However, where the breakage is (could be my setup) I don't
know. Imran?

Anyway, for now I will just run the single test specifically. Perhaps I
should just put this into the same patch. Anyway, the following should
fix it.

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testp=
arserev.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_tes=
tparserev.java
index 2a1a4ad..1fc73b4 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev=
=2Ejava
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev=
=2Ejava
@@ -117,7 +117,7 @@ public void testDerefTagIssue23() throws IOExceptio=
n {
 	}
=20
 	public void testDerefTaggedTagTree() throws IOException {
-		assertEquals("269e1253bad5c247c6bde37aa48ae1e03138206c",db.resolve("=
refs/tags/C").name());
+		assertEquals("be83157b4ffe650d728ba4f98ad47b623b0d0c20",db.resolve("=
refs/tags/C").name());
 		assertEquals("d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864",db.resolve("=
refs/tags/C^{commit}").name());
 		assertEquals("856ec208ae6cadac25a6d74f19b12bb27a24fe24",db.resolve("=
refs/tags/C^{tree}").name());
 	}

--=20
Jonas Fonseca
