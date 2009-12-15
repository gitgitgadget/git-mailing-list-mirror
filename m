From: Joey Hess <joey@kitenet.net>
Subject: the 100 mb push
Date: Tue, 15 Dec 2009 14:23:38 -0500
Message-ID: <20091215192338.GA16654@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 20:34:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKdAP-0008G5-DA
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 20:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933529AbZLOTea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 14:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933520AbZLOTe3
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 14:34:29 -0500
Received: from wren.kitenet.net ([80.68.85.49]:41382 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933475AbZLOTe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 14:34:28 -0500
X-Greylist: delayed 645 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Dec 2009 14:34:28 EST
Received: from gnu.kitenet.net (tn-76-5-155-2.dhcp.embarqhsd.net [76.5.155.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 4130A118FE4
	for <git@vger.kernel.org>; Tue, 15 Dec 2009 14:23:41 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 575EC2981CE; Tue, 15 Dec 2009 14:23:38 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135293>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Is it normal for git push to sometimes transfer much more data
than seems necessary? Here is a case where that happens:

joey@gnu:~/src/p.t>git branch
* master
  pristine-tar
  testsuite
joey@gnu:~/src/p.t>git remote show origin
* remote origin
  Fetch URL: ssh://joey@git.kitenet.net/srv/git/pristine-tar.test
  Push  URL: ssh://joey@git.kitenet.net/srv/git/pristine-tar.test
  HEAD branch: master
  Remote branches:
    master       tracked
    pristine-tar tracked
    testsuite    tracked
  Local branches configured for 'git pull':
    master       merges with remote master
    pristine-tar merges with remote pristine-tar
    testsuite    merges with remote testsuite
  Local refs configured for 'git push':
    master       pushes to master       (fast forwardable)
    pristine-tar pushes to pristine-tar (up to date)
    testsuite    pushes to testsuite    (local out of date)

Here, master is a typical small project branch. It has a 1 line change
made locally.

Meanwhile, the testsuite branch is a 100+ mb monster, containing a lot
of big binaries. In it, a small change has been made in the origin
repo. In the local repo, a *lot* of *big* files have been deleted from
the same branch, about 20 mb of files were removed all told. But the diff
for this change should be quite small.

So, testsuite needs to be merged before it can be pushed, but git push
doesn't tell me that. Instead, it goes off and does this for 2+ hours:

joey@gnu:~/src/p.t>git push
Counting objects: 241, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (206/206), done.
Writing objects:  15% (36/237), 2.16 MiB | 15 KiB/s=20
^C

It seems to be uploading the entire repo over the wire, and this is a
typical asymmetric network connection, so that goes slow. (Took me a
while to realize it was not just auto-gcing the repo locally.)

Once I realized what was going on, it was easy to merge it as shown
below, and then the push transferred an appropriatly small amount of data.
So, my question is, assuming this is not a straight up bug in git, would
it make sense to avoid this gotcha in some way?

joey@gnu:~/src/p.t2>git checkout testsuite
Switched to branch 'testsuite'
Your branch is ahead of 'origin/testsuite' by 1 commit.
joey@gnu:~/src/p.t2>git pull
remote: Counting objects: 5, done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 3 (delta 2), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
=46rom ssh://git.kitenet.net/srv/git/pristine-tar.test
   3c16948..fce7ec1  testsuite  -> origin/testsuite
Merge made by recursive.
 Makefile |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)
joey@gnu:~/src/p.t2>git push
Counting objects: 13, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (8/8), done.
Writing objects: 100% (8/8), 889 bytes, done.
Total 8 (delta 5), reused 0 (delta 0)
To ssh://joey@git.kitenet.net/srv/git/pristine-tar.test
   aab45a1..cc93945  master -> master
   fce7ec1..d82f225  testsuite -> testsuite

git version 1.6.5.3

--=20
see shy jo

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBSyfiN8kQ2SIlEuPHAQhmBw//eX1wW8te9WwJti4fCqO6D9OwJU/kbVVK
tqrVf4kmjDlUD0eJLmo4T249TSqejEjq3E6ETSjzXeL2Odf7fprBgQYX1pshFIVI
vuVT5jnvOlzkgjW8kYKnmGJWUjlrtkK5uY7VXYS0iOymIhtWFX4dyhadiaQvX0+H
2Du4uLtYWInaBV2944Z4d3Wxct1M4xiG2L1zrDP+hbGsnX3OSKO5EbX5hr2EeDas
+beHi8W4SjjRNU93a4ReRuqeaU6eFNGStPgt1RBnfgExWNsUJxhI1fIg1beB8GHD
oDlOrydakG3i5wu55fPP5r5iFViFH8mFHELVr4rqjxZnh798x7CJPvw3vFJDhKZI
NiMioxbrM2Jt5quCsE60aYWseIb3WzqDRe//ct+bNExSWML0l/tFR4v0Ql/j91qJ
tyYyPgcRHedxfbjp3eVUiXlboz/iVj7B35wn3KSFvoRsjXznxxBlJmAkCYGIhED6
IYx1o25v2W1+ddKIGKwhmp9NDv7fGQgAnlBAI0AZCDKFZr9dvdkM/MGwVGIsXNoM
Gke5iYWiQDEnAE73QFfcUmvDCrU3K0jsiFqBoGWZKKXHticFnkJQRo4TWnp4PCus
1LinAD7aSR+JzgSU6fT4O/EO7ToQ2ONUUJw1rfKguDgzlEfV+V0r0DuAGb4RatRM
s+O8hEgyZZs=
=tTDG
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
