From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: [PATCH] Allow forcing of a parent commit, even if the parent is not
 a direct one.
Date: Thu, 01 Feb 2007 11:43:39 +0100
Message-ID: <45C1C45B.1000003@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD0854EA87905CD77E7576706"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 11:43:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCZPw-0002Mm-GO
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 11:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422775AbXBAKnp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 05:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422773AbXBAKnp
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 05:43:45 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:46998 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422775AbXBAKno (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 05:43:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 0D3E228255
	for <git@vger.kernel.org>; Thu,  1 Feb 2007 11:43:43 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PzaocunkSI0m for <git@vger.kernel.org>;
	Thu,  1 Feb 2007 11:43:42 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-202-10.dynamic.mnet-online.de [62.216.202.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id B16CC2824E
	for <git@vger.kernel.org>; Thu,  1 Feb 2007 11:43:42 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38342>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD0854EA87905CD77E7576706
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable

This can be used to compress multiple changesets into one, for example
like

	git cvsexportcommit -P cvshead mybranch

without having to do so in git first.

Signed-off-by: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
---
 Documentation/git-cvsexportcommit.txt |    5 ++++-
 git-cvsexportcommit.perl              |    6 +++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cv=
sexportcommit.txt
index 347cbce..27d531b 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -8,7 +8,7 @@ git-cvsexportcommit - Export a single commit to a CVS che=
ckout
=20
 SYNOPSIS
 --------
-'git-cvsexportcommit' [-h] [-v] [-c] [-p] [-a] [-f] [-m msgprefix] [PARE=
NTCOMMIT] COMMITID
+'git-cvsexportcommit' [-h] [-v] [-c] [-P] [-p] [-a] [-f] [-m msgprefix] =
[PARENTCOMMIT] COMMITID
=20
=20
 DESCRIPTION
@@ -46,6 +46,9 @@ OPTIONS
 -f::
 	Force the merge even if the files are not up to date.
=20
+-P::
+	Force the parent commit, even if it is not a direct parent.
+
 -m::
 	Prepend the commit message with the provided prefix.=20
 	Useful for patch series and the like.
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 4863c91..870554e 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -15,9 +15,9 @@ unless ($ENV{GIT_DIR} && -r $ENV{GIT_DIR}){
     die "GIT_DIR is not defined or is unreadable";
 }
=20
-our ($opt_h, $opt_p, $opt_v, $opt_c, $opt_f, $opt_a, $opt_m );
+our ($opt_h, $opt_P, $opt_p, $opt_v, $opt_c, $opt_f, $opt_a, $opt_m );
=20
-getopts('hpvcfam:');
+getopts('hPpvcfam:');
=20
 $opt_h && usage();
=20
@@ -89,7 +89,7 @@ if ($parent) {
 	    last;
 	}; # found it
     }
-    die "Did not find $parent in the parents for this commit!" if !$foun=
d;
+    die "Did not find $parent in the parents for this commit!" if !$foun=
d and !$opt_P;
 } else { # we don't have a parent from the cmdline...
     if (@parents =3D=3D 1) { # it's safe to get it from the commit
 	$parent =3D $parents[0];
--=20
1.5.0.rc2.g544a



--------------enigD0854EA87905CD77E7576706
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFwcRer5S+dk6z85oRAoqZAKCK2bVWbJ8mMKZeYvbfzUeb6GuN9QCg52/H
s4sVaXnbYfPKztxqcLS0wsw=
=fNHA
-----END PGP SIGNATURE-----

--------------enigD0854EA87905CD77E7576706--
