From: Eduardo Pereira Habkost <ehabkost@mandriva.com>
Subject: git-svnimport issue with rename+change in the same commit
Date: Tue, 14 Feb 2006 15:12:33 -0200
Message-ID: <20060214171233.GC4381@duckman.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
X-From: git-owner@vger.kernel.org Tue Feb 14 18:09:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F93e5-0007rv-MQ
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 18:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422682AbWBNRGz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 12:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422681AbWBNRGz
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 12:06:55 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:8924 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1422682AbWBNRGy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 12:06:54 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 1D81736D49
	for <git@vger.kernel.org>; Tue, 14 Feb 2006 15:06:51 -0200 (BRST)
Received: from perninha.conectiva.com.br ([127.0.0.1])
 by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 14857-04 for <git@vger.kernel.org>;
 Tue, 14 Feb 2006 15:06:50 -0200 (BRST)
Received: from duckman.conectiva.com.br (duckman.conectiva [10.0.2.193])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 7315D36D39
	for <git@vger.kernel.org>; Tue, 14 Feb 2006 15:06:50 -0200 (BRST)
Received: by duckman.conectiva.com.br (Postfix, from userid 500)
	id AA4D13FB7; Tue, 14 Feb 2006 15:12:33 -0200 (BRST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new at conectiva.com.br
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16142>


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I've just hit a problem when using git-svnimport to import a big
subversion repository: it doesn't import correctly a commit when the
commit renames (or copies) and modify a file at the same time.

At the bottom of this message, there is a script that reproduces the bug.

The result of the final 'diff' command on the script is:

diff -u --exclude .git --exclude .svn checkout/universe.py
git/universe.py
--- checkout/universe.py        2006-02-14 14:55:37.000000000 -0200
+++ git/universe.py     2006-02-14 14:55:38.000000000 -0200
@@ -1 +1 @@
-print "Hello, universe!"
+print "Hello, world!"

git-svnadmin is just taking the original version of the file when
the commit has a 'file copy', even if this copy was modified before
the commit.

However I can't see a way to fix this problem without making the script
ignore completely the the "copied from" information from the svn commits
(and always fetching the resulting files from the repository). It seems
that subversion doesn't tell us if the copied file was changed (or this
information is hidden somewhere else).

--=20
Eduardo


#!/bin/sh
set -e

mkdir repos
svnadmin create $PWD/repos
repos=3Dfile://$PWD/repos
svn mkdir $repos/trunk -m 'creating trunk'
svn co file://$PWD/repos/trunk checkout
cd checkout
cat >hello.py <<EOF
print "Hello, world!"
EOF
svn add hello.py
svn commit -m 'adding hello.py'
svn mv hello.py world.py
svn commit -m 'renaming to world.py'
svn mv world.py universe.py
sed -i -e 's/world/universe/' universe.py
svn commit -m 'universe, now'
cd ..
mkdir git
cd git
git svnimport $repos
cd ..
diff -u --exclude .git --exclude .svn checkout git # will report differences

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD8g+BcaRJ66w1lWgRArEIAJ9I/dG82Tf8kczUAzDU1GUpC7oH3wCcDlik
LkUyngc9cb+Tl9z678W2fSA=
=gQ4q
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
