From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: [PATCH] Allow passing of an alternative CVSROOT via -d.
Date: Sun, 18 Feb 2007 18:17:08 +0100
Message-ID: <45D88A14.4040400@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCEC80E4A1EA09F8243A264D1"
Cc: Martin Langhoff <martin@catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 18 18:17:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIpfJ-00057p-45
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 18:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbXBRRRR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 12:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbXBRRRR
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 12:17:17 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:60210 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbXBRRRO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 12:17:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 9A8E72820B;
	Sun, 18 Feb 2007 18:17:12 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SsA9iTpV-Xd5; Sun, 18 Feb 2007 18:17:12 +0100 (CET)
Received: from [62.216.207.82] (ppp-62-216-207-82.dynamic.mnet-online.de [62.216.207.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id D08182816E;
	Sun, 18 Feb 2007 18:17:11 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40079>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCEC80E4A1EA09F8243A264D1
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable

This is necessary if using CVS in an asymmetric fashion, i.e. when the
CVSROOT you are checking out from differs from the CVSROOT you have to
commit to.

Signed-off-by: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
---
 Documentation/git-cvsexportcommit.txt |    7 ++++++-
 git-cvsexportcommit.perl              |   27 +++++++++++++++++----------=

 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cv=
sexportcommit.txt
index 27d531b..555b823 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -8,7 +8,7 @@ git-cvsexportcommit - Export a single commit to a CVS che=
ckout
=20
 SYNOPSIS
 --------
-'git-cvsexportcommit' [-h] [-v] [-c] [-P] [-p] [-a] [-f] [-m msgprefix] =
[PARENTCOMMIT] COMMITID
+'git-cvsexportcommit' [-h] [-v] [-c] [-P] [-p] [-a] [-d cvsroot] [-f] [-=
m msgprefix] [PARENTCOMMIT] COMMITID
=20
=20
 DESCRIPTION
@@ -43,6 +43,11 @@ OPTIONS
 	Add authorship information. Adds Author line, and Committer (if
 	different from Author) to the message.
=20
+-d::
+	Set an alternative CVSROOT to use.  This corresponds to the CVS
+	-d parameter.  Usually users will not want to set this, except
+	if using CVS in an asymmetric fashion.
+
 -f::
 	Force the merge even if the files are not up to date.
=20
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 870554e..d08216c 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -15,14 +15,21 @@ unless ($ENV{GIT_DIR} && -r $ENV{GIT_DIR}){
     die "GIT_DIR is not defined or is unreadable";
 }
=20
-our ($opt_h, $opt_P, $opt_p, $opt_v, $opt_c, $opt_f, $opt_a, $opt_m );
+our ($opt_h, $opt_P, $opt_p, $opt_v, $opt_c, $opt_f, $opt_a, $opt_m, $op=
t_d);
=20
-getopts('hPpvcfam:');
+getopts('hPpvcfam:d:');
=20
 $opt_h && usage();
=20
 die "Need at least one commit identifier!" unless @ARGV;
=20
+my @cvs;
+if ($opt_d) {
+	@cvs =3D ('cvs', '-d', $opt_d);
+} else {
+	@cvs =3D ('cvs');
+}
+
 # setup a tempdir
 our ($tmpdir, $tmpdirname) =3D tempdir('git-cvsapplycommit-XXXXXX',
 				     TMPDIR =3D> 1,
@@ -160,7 +167,7 @@ foreach my $f (@afiles) {
 	my $p =3D $1;
 	next if (grep { $_ eq $p } @dirs);
     }
-    my @status =3D grep(m/^File/,  safe_pipe_capture('cvs', '-q', 'statu=
s' ,$f));
+    my @status =3D grep(m/^File/,  safe_pipe_capture(@cvs, '-q', 'status=
' ,$f));
     if (@status > 1) { warn 'Strange! cvs status returned more than one =
line?'};
     if (-d dirname $f and $status[0] !~ m/Status: Unknown$/
 	and $status[0] !~ m/^File: no file /) {
@@ -173,7 +180,7 @@ foreach my $f (@afiles) {
 foreach my $f (@files) {
     next if grep { $_ eq $f } @afiles;
     # TODO:we need to handle removed in cvs
-    my @status =3D grep(m/^File/,  safe_pipe_capture('cvs', '-q', 'statu=
s' ,$f));
+    my @status =3D grep(m/^File/,  safe_pipe_capture(@cvs, '-q', 'status=
' ,$f));
     if (@status > 1) { warn 'Strange! cvs status returned more than one =
line?'};
     unless ($status[0] =3D~ m/Status: Up-to-date$/) {
 	$dirty =3D 1;
@@ -194,7 +201,7 @@ print "Applying\n";
 print "Patch applied successfully. Adding new files and directories to C=
VS\n";
 my $dirtypatch =3D 0;
 foreach my $d (@dirs) {
-    if (system('cvs','add',$d)) {
+    if (system(@cvs,'add',$d)) {
 	$dirtypatch =3D 1;
 	warn "Failed to cvs add directory $d -- you may need to do it manually"=
;
     }
@@ -202,9 +209,9 @@ foreach my $d (@dirs) {
=20
 foreach my $f (@afiles) {
     if (grep { $_ eq $f } @bfiles) {
-      system('cvs', 'add','-kb',$f);
+      system(@cvs, 'add','-kb',$f);
     } else {
-      system('cvs', 'add', $f);
+      system(@cvs, 'add', $f);
     }
     if ($?) {
 	$dirtypatch =3D 1;
@@ -213,7 +220,7 @@ foreach my $f (@afiles) {
 }
=20
 foreach my $f (@dfiles) {
-    system('cvs', 'rm', '-f', $f);
+    system(@cvs, 'rm', '-f', $f);
     if ($?) {
 	$dirtypatch =3D 1;
 	warn "Failed to cvs rm -f $f -- you may need to do it manually";
@@ -223,7 +230,7 @@ foreach my $f (@dfiles) {
 print "Commit to CVS\n";
 print "Patch title (first comment line): $title\n";
 my @commitfiles =3D map { unless (m/\s/) { '\''.$_.'\''; } else { $_; };=
 } (@files);
-my $cmd =3D "cvs commit -F .msg @commitfiles";
+my $cmd =3D join(' ', @cvs)." commit -F .msg @commitfiles";
=20
 if ($dirtypatch) {
     print "NOTE: One or more hunks failed to apply cleanly.\n";
@@ -236,7 +243,7 @@ if ($dirtypatch) {
=20
 if ($opt_c) {
     print "Autocommit\n  $cmd\n";
-    print safe_pipe_capture('cvs', 'commit', '-F', '.msg', @files);
+    print safe_pipe_capture(@cvs, 'commit', '-F', '.msg', @files);
     if ($?) {
 	die "Exiting: The commit did not succeed";
     }
--=20
1.5.0.50.gb75812-dirty



--------------enigCEC80E4A1EA09F8243A264D1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF2IoXr5S+dk6z85oRAufdAKD+oRVkvI856sbWAC52Uw8ObcT6fQCeNoAb
wvf6nOzO5gIzBRJA1qLT2eY=
=rjNZ
-----END PGP SIGNATURE-----

--------------enigCEC80E4A1EA09F8243A264D1--
