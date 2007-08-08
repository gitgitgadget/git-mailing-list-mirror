From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Bug in git-svn: dcommit commits in the wrong branch after a rebase
Date: Wed, 8 Aug 2007 23:35:47 +0200
Message-ID: <21FC6D7F-5459-406D-AA06-D16E525B3C17@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-9--4166392"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 09 16:25:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ8x3-0005r2-4C
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 16:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939452AbXHIOZT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 10:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939309AbXHIOZT
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 10:25:19 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:45016 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937744AbXHIOZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 10:25:16 -0400
Received: from [82.229.223.213] (helo=[82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA:16)
	(Exim 4.50)
	id 1IItDP-0004qg-Ls; Wed, 08 Aug 2007 23:37:15 +0200
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55455>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-9--4166392
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Hi,
I was working with Git on a SVN branch `a' (say my Git branch is  
`mya') and I wanted to create a new SVN branch `b' and dcommit my  
changes there for others (poor SVN users) to see.  So I did a svn cp  
url://a url://b to create the branch `b' in SVN, git-svn fetch to  
import this branch, git checkout -b myb b and then rebased mya and  
then did a dcommit.  Although the last commit at this point (in  
branch myb) had a svn-id "pointing to" the SVN branch b, dcommit sent  
the commits to the branch `a'.

Test case:

svnadmin create repos
svn co file://`pwd`/repos wc
cd wc
svn mkdir branches
svn mkdir branches/a
echo foo >branches/a/foo
svn add branches/a/foo
svn ci -m 'branch a'
cd ..
git-svn clone --branches=branches file://`pwd`/repos wc.git
cd wc.git
echo git is cool >>foo
git-commit -a -m 'commit in git in branch a'
cd ../wc
svn cp branches/a branches/b
svn ci -m 'branch b'
cd ../wc.git
git-svn fetch
git-checkout -b myb b
git-rebase master
git-svn dcommit # sends the commit to SVN branch `a' instead of SVN  
branch `b'!

Temporary workaround (in case someone finds this post after stumbling  
on this problem):
svn mv branches/a branches/tmp
<commit>
svn mv branches/b branches/a
<commit>
svn mv branches/tmp branches/b
<commit>

After this, git-svn fetch will slightly complain but it will work  
nevertheless.

Found possible branch point: url://repo/branches/a => url://repo/ 
branches/tmp, <N>
Found branch parent: (b) <sha1>
Following parent with do_switch
Successfully followed parent
r<N> = <sha1> (b)
Found possible branch point: url://repo/branches/b => url://repo/ 
branches/a, <N+1>
Found branch parent: (a) <sha1-X>
Index mismatch: <sha1> != <sha1>
rereading <sha1-X>
Following parent with do_switch
Successfully followed parent
r<N+1> = <sha1> (a)
[...]

Despite the `Index mismatch' sort of warning, the Git repo seems to  
be correct.

Cheers,

PS: I use git version 1.5.3.rc3.25.gf9208-dirty

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-9--4166392
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFGujczwwE67wC8PUkRAjZ2AJ9Oyq3O0iO5oGvuhfnA18JY0QiXCwCfbKo7
ChACLWXUTX8ZgimX3MhA9PI=
=FlJ+
-----END PGP SIGNATURE-----

--Apple-Mail-9--4166392--
