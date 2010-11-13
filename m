From: Seth Robertson <in-gitvger@baka.org>
Subject: [BUG] git show <remote>: bad information: Local branch|ref configured
Date: Fri, 12 Nov 2010 19:41:39 -0500
Message-ID: <201011130041.oAD0fdmM017083@no.baka.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 13 01:41:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH4Bh-0004RI-5u
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 01:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757666Ab0KMAll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 19:41:41 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:55094 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753586Ab0KMAll (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 19:41:41 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id oAD0fdpl029153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 12 Nov 2010 19:41:39 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id oAD0fdmM017083
	for <git@vger.kernel.org>; Fri, 12 Nov 2010 19:41:39 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161373>


Over in #git we ran into a user wondering why a particular remote said
something about "master pushes to master" when the local branch mapped
to that remote was not named master.

Not having inspected the code, it certainly appears as if the "Local
branch configured" and "Local ref configured" information is only
accidentally correct, but since the normal configuration is the case
in which it is accurate, no-one noticed the problem.

In the test case below, in the "bar" case we are missing the "Local
ref configured for 'git push'" section entirely.  Strange since git push
does indeed work.

In the "baz" case we see the message and master does push to master.

In the "biff" case we see the confluence of the two previous cases.
The "foo" remote/subcase shows what we might expect, but the "baz"
remote/subcase shows the 'Local ref configured' information is a lie.
Finally, the "bar" remote/subcase shows that even the "Local branch
configured" information is somehow magic based on the remote branch
being named master.

This test was done using git 1.7.3.1

Test case prep
----------------------------------------------------------------------
mkdir foo; cd foo; git init; echo A>A; git add A; git commit -m A;
git checkout -b other; echo B>B; git add B; git commit -m B;
git checkout master

mkdir ../bar; cd ../bar; git init; git remote add foo ../foo;
git fetch foo; git checkout --track -b foo_master foo/other

mkdir ../baz; cd ../baz; git init; git remote add foo ../foo;
git fetch foo; git checkout --track -b master foo/master

mkdir ../biff; cd ../biff; git init; git remote add foo ../foo;
git fetch foo; git checkout --track -b master foo/master;
git remote add baz ../baz; git fetch baz;
git checkout --track -b baz_master baz/master
git remote add bar ../bar; git fetch bar;
git checkout --track -b bar_master bar/master
----------------------------------------------------------------------

cd ../bar; git remote show foo
 --------------------------------------------------
 * remote foo
   Fetch URL: ../foo
   Push  URL: ../foo
   HEAD branch: master
   Remote branches:
     master tracked
     other  tracked
   Local branch configured for 'git pull':
     foo_master merges with remote other
 --------------------------------------------------

cd ../baz; git remote show foo
 --------------------------------------------------
 * remote foo
   Fetch URL: ../foo
   Push  URL: ../foo
   HEAD branch: master
   Remote branches:
     master tracked
     other  tracked
   Local branch configured for 'git pull':
     master merges with remote master
   Local ref configured for 'git push':
     master pushes to master (up to date)
 --------------------------------------------------

cd ../biff; git remote show foo; git remote show baz; git remote show bar
 --------------------------------------------------
 * remote foo
   Fetch URL: ../foo
   Push  URL: ../foo
   HEAD branch: master
   Remote branches:
     master tracked
     other  tracked
   Local branch configured for 'git pull':
     master merges with remote master
   Local ref configured for 'git push':
     master pushes to master (up to date)
 * remote baz
   Fetch URL: ../baz
   Push  URL: ../baz
   HEAD branch: master
   Remote branch:
     master tracked
   Local branch configured for 'git pull':
     baz_master merges with remote master
   Local ref configured for 'git push':
     master pushes to master (up to date)
 * remote bar
   Fetch URL: ../bar
   Push  URL: ../bar
   HEAD branch: foo_master
   Remote branch:
     foo_master tracked
 --------------------------------------------------

					-Seth Robertson
