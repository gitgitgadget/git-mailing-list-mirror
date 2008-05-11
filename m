From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Git branches - confusing behavior
Date: Sun, 11 May 2008 14:57:22 +0200
Message-ID: <20080511125722.GA22075@atjola.homenet>
References: <4826D8FA.30305@gmail.com> <m31w495apd.fsf@localhost.localdomain> <4826E791.7030407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dima Kagan <dima.kagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 14:58:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvB83-0002Cd-QY
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 14:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbYEKM50 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 May 2008 08:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbYEKM50
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 08:57:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:60115 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750885AbYEKM5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 08:57:25 -0400
Received: (qmail invoked by alias); 11 May 2008 12:57:23 -0000
Received: from i577B82CA.versanet.de (EHLO atjola.local) [87.123.130.202]
  by mail.gmx.net (mp043) with SMTP; 11 May 2008 14:57:23 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+iKqtU7lCikniZytEXeHI7oI/gtFYWMALcxWzh7x
	7QqDdhKG9/aeNl
Content-Disposition: inline
In-Reply-To: <4826E791.7030407@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81768>

On 2008.05.11 15:33:21 +0300, Dima Kagan wrote:
> >> Basically I see that the same file I edited on the 'test_branch'
> >> branch appears to be modified on the 'master' branch as well. This
> >> behavior is unwanted, of course.
> >>
> >> Can someone please tell me, what am doing wrong? Or is this git's
> >> normal behavior?
> >=20
>=20
> I just realized that this behavior is even more confusing.  If I
> commit the file on 'test_branch' and only then 'git checkout master'
> the changes are not visible on 'master' until I merge. So why should
> 'master' be affected by uncommitted changes on some branch???

Uncommitted changes are not on any branch, they are in your working tre=
e
and/or your index. And actually, SVN does the exact same thing.

# Create a SVN repository with trunk/ and branches/
# ----
$ mkdir svn
$ cd svn
$ svnadmin create repo
$ export REPO=3D"file://$PWD/repo"
$ svn co $REPO wc
Checked out revision 0.
$ cd wc
$ svn mkdir trunk branches
A         trunk
A         branches
$ svn commit -m init
Adding         branches
Adding         trunk

Committed revision 1.
$ svn switch $REPO/trunk
D    trunk
D    branches
Updated to revision 1.


# Create some content in trunk
# ----
$ echo 123 > testfile
$ svn add testfile
A         testfile
$ svn commit -m test
Adding         testfile
Transmitting file data .
Committed revision 2.


# Create a branch
# ----
$ svn cp $REPO/trunk $REPO/branches/b1 -m branch

Committed revision 3.


# Produce some uncommitted changes on trunk
# ----
$ echo 456 > testfile
$ svn st
M      testfile
$ svn diff
Index: testfile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- testfile    (revision 2)
+++ testfile    (working copy)
@@ -1 +1 @@
-123
+456


# Switch to the branch
# ----
$ svn switch $REPO/branches/b1
At revision 3.
$ svn st
M      testfile
$ svn diff
Index: testfile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- testfile    (revision 3)
+++ testfile    (working copy)
@@ -1 +1 @@
-123
+456


The uncommitted changes survived the branch change and are still in the
working tree, in svn just like in git.

Bj=F6rn
