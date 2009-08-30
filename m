From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: git-svn messing up merge commits on dcommit
Date: Sun, 30 Aug 2009 03:32:25 +0200
Message-ID: <20090830013225.GA6475@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Aug 30 03:32:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhZHe-0005DH-RG
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 03:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbZH3Bca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2009 21:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753118AbZH3Bca
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Aug 2009 21:32:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:36565 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753105AbZH3Bc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2009 21:32:29 -0400
Received: (qmail invoked by alias); 30 Aug 2009 01:32:29 -0000
Received: from i59F54D3D.versanet.de (EHLO atjola.homenet) [89.245.77.61]
  by mail.gmx.net (mp002) with SMTP; 30 Aug 2009 03:32:29 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/oTX4bMPzosR5RWi2gANXQwTj0g57TFVAUxHtKgJ
	58ENFxl6gnHj2C
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127389>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Eric,

I have two "test cases" here (attached), which I actually wrote months
ago, but forgot to sent, as I wanted to clean them up/turn them into
something suitable for the test suite, but honestly, I'll probably never
get around to do that, so here they are, as they are. They show git-svn
messing up merge commits when dcommitting a branch that is not
up-to-date WRT the svn repo.

The basic history for both cases (before dcommit) is:

        C---D (master)
       /   /
      /---E (side)
     /
A---B (trunk)
     \
      X (revision in SVN, not yet fetched)

So the dcommit (which would send C and D to the svn repo) needs to
"rebase" C and D.

In the first test case, this rebasing causes conflicts, and leads to a
linearized history:

      E (side)
     /
A---B---X---C' (trunk)
             \
              D (master)

The merge is broken apart. This is probably expected, but I thought I'd
tell anyway.


The second test case is a bit more interesting, there are no conflicts
between the local commits to be dcommitted and the new commit X in the
svn repo. In this case, git-svn manages to dcommit the merge commit just
fine, keeping the history correct, but it messes the merge commit's
commit message up. So the history becomes:

A---B---X---C'--D' (trunk) (master)
     \         /
      --------E (side)

But D' has the same commit message as C/C', not the one from D.

I hope that makes any sense to you (or you can figure it out from the
testing scripts).

Björn

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=test

#!/bin/sh
mkdir git-svn-test
cd git-svn-test

SVN="file://$PWD/svnrepo"
svnadmin create svnrepo
svn co "$SVN" co
cd co
svn mkdir trunk tags branches
svn ci -m init

echo 123 > trunk/foo
svn add trunk/foo
svn ci -m "SVN 1"

cd ..

git svn clone -s "$SVN" git

cd co
echo 456 >> trunk/foo
svn ci -m "SVN 2"
cd ..

cd git
git checkout -b side
echo 123 >> foo
git add foo
git commit -m "On side"
git checkout master
echo 123 > foo3
git add foo3
git commit -m "On master"
git merge --no-ff side
gitk --all&
git svn dcommit
echo resolved > foo
git add -u
git rebase --continue
gitk --all

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=test2

#!/bin/sh
mkdir git-svn-test
cd git-svn-test

SVN="file://$PWD/svnrepo"
svnadmin create svnrepo
svn co "$SVN" co
cd co
svn mkdir trunk tags branches
svn ci -m init

echo 123 > trunk/foo
svn add trunk/foo
svn ci -m "SVN 1"

cd ..

git svn clone -s "$SVN" git

cd co
echo 456 >> trunk/foo
svn ci -m "SVN 2"
cd ..

cd git
git checkout -b side
echo 123 >> foo2
git add foo2
git commit -m "On side"
git checkout master
echo 123 > foo3
git add foo3
git commit -m "On master"
git merge --no-ff side
gitk --all&
git svn dcommit
gitk --all&

--J/dobhs11T7y2rNN--
