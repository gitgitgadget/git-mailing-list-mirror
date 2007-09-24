From: Stefan Sperling <stsp@elego.de>
Subject: [PATCH] resend: really plug memory leaks in git-svnimport
Date: Mon, 24 Sep 2007 12:57:40 +0200
Message-ID: <20070924105740.GB8900@ted>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 12:58:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZldV-00011g-Ab
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 12:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020AbXIXK5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 06:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbXIXK5u
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 06:57:50 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:50328 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbXIXK5t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 06:57:49 -0400
X-Envelope-From: stsp@stsp.name
Received: from stsp.lan (stsp.in-vpn.de [217.197.85.96])
	(authenticated bits=128)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id l8OAvgna019946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 24 Sep 2007 12:57:46 +0200
Received: from ted.stsp.lan (localhost [127.0.0.1])
	by stsp.lan (8.13.8/8.13.8/Debian-3) with ESMTP id l8OAvfcr013515
	for <git@vger.kernel.org>; Mon, 24 Sep 2007 12:57:41 +0200
Received: (from stsp@localhost)
	by ted.stsp.lan (8.13.8/8.13.8/Submit) id l8OAvfbK013512
	for git@vger.kernel.org; Mon, 24 Sep 2007 12:57:41 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59037>


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio asked me to resend this patch to the mailing list.

This version of the patch is adjusted to apply cleanly
to current HEAD.

@Junio: I'm not resending the multiple branch/tag dirs patch
just yet, because I want to polish it first -- I've got another
idea how to improve it.

Log message:

Fix pool handling in git-svnimport to avoid memory leaks.

- Create an explicit one-and-only root pool.
- Closely follow examples in SVN::Core man page.
  Before calling a subversion function, create a subpool of our
  root pool and make it the new default pool.=20
- Create a subpool for looping over svn revisions and clear
  this subpool (i.e. it mark for reuse, don't decallocate it)
  at the start of the loop instead of allocating new memory
  with each iteration.

See http://marc.info/?l=3Dgit&m=3D118554191513822&w=3D2 for a detailed
explanation of the issue.

Signed-off-by: Stefan Sperling <stsp@elego.de>

diff --git a/git-svnimport.perl b/git-svnimport.perl
index aa5b3b2..ea8c1b2 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -54,6 +54,7 @@ my $branch_name =3D $opt_b || "branches";
 my $project_name =3D $opt_P || "";
 $project_name =3D "/" . $project_name if ($project_name);
 my $repack_after =3D $opt_R || 1000;
+my $root_pool =3D SVN::Pool->new_default;
=20
 @ARGV =3D=3D 1 or @ARGV =3D=3D 2 or usage();
=20
@@ -132,7 +133,7 @@ sub conn {
 	my $auth =3D SVN::Core::auth_open ([SVN::Client::get_simple_provider,
 			  SVN::Client::get_ssl_server_trust_file_provider,
 			  SVN::Client::get_username_provider]);
-	my $s =3D SVN::Ra->new(url =3D> $repo, auth =3D> $auth);
+	my $s =3D SVN::Ra->new(url =3D> $repo, auth =3D> $auth, pool =3D> $root_p=
ool);
 	die "SVN connection to $repo: $!\n" unless defined $s;
 	$self->{'svn'} =3D $s;
 	$self->{'repo'} =3D $repo;
@@ -147,11 +148,10 @@ sub file {
=20
 	print "... $rev $path ...\n" if $opt_v;
 	my (undef, $properties);
-	my $pool =3D SVN::Pool->new();
 	$path =3D~ s#^/*##;
+	my $subpool =3D SVN::Pool::new_default_sub;
 	eval { (undef, $properties)
-		   =3D $self->{'svn'}->get_file($path,$rev,$fh,$pool); };
-	$pool->clear;
+		   =3D $self->{'svn'}->get_file($path,$rev,$fh); };
 	if($@) {
 		return undef if $@ =3D~ /Attempted to get checksum/;
 		die $@;
@@ -185,6 +185,7 @@ sub ignore {
=20
 	print "... $rev $path ...\n" if $opt_v;
 	$path =3D~ s#^/*##;
+	my $subpool =3D SVN::Pool::new_default_sub;
 	my (undef,undef,$properties)
 	    =3D $self->{'svn'}->get_dir($path,$rev,undef);
 	if (exists $properties->{'svn:ignore'}) {
@@ -202,6 +203,7 @@ sub ignore {
 sub dir_list {
 	my($self,$path,$rev) =3D @_;
 	$path =3D~ s#^/*##;
+	my $subpool =3D SVN::Pool::new_default_sub;
 	my ($dirents,undef,$properties)
 	    =3D $self->{'svn'}->get_dir($path,$rev,undef);
 	return $dirents;
@@ -358,10 +360,9 @@ open BRANCHES,">>", "$git_dir/svn2git";
=20
 sub node_kind($$) {
 	my ($svnpath, $revision) =3D @_;
-	my $pool=3DSVN::Pool->new;
 	$svnpath =3D~ s#^/*##;
-	my $kind =3D $svn->{'svn'}->check_path($svnpath,$revision,$pool);
-	$pool->clear;
+	my $subpool =3D SVN::Pool::new_default_sub;
+	my $kind =3D $svn->{'svn'}->check_path($svnpath,$revision);
 	return $kind;
 }
=20
@@ -889,7 +890,7 @@ sub commit_all {
 	# Recursive use of the SVN connection does not work
 	local $svn =3D $svn2;
=20
-	my ($changed_paths, $revision, $author, $date, $message, $pool) =3D @_;
+	my ($changed_paths, $revision, $author, $date, $message) =3D @_;
 	my %p;
 	while(my($path,$action) =3D each %$changed_paths) {
 		$p{$path} =3D [ $action->action,$action->copyfrom_path, $action->copyfro=
m_rev, $path ];
@@ -925,14 +926,14 @@ print "Processing from $current_rev to $opt_l ...\n" =
if $opt_v;
 my $from_rev;
 my $to_rev =3D $current_rev - 1;
=20
+my $subpool =3D SVN::Pool::new_default_sub;
 while ($to_rev < $opt_l) {
+	$subpool->clear;
 	$from_rev =3D $to_rev + 1;
 	$to_rev =3D $from_rev + $repack_after;
 	$to_rev =3D $opt_l if $opt_l < $to_rev;
 	print "Fetching from $from_rev to $to_rev ...\n" if $opt_v;
-	my $pool=3DSVN::Pool->new;
-	$svn->{'svn'}->get_log("/",$from_rev,$to_rev,0,1,1,\&commit_all,$pool);
-	$pool->clear;
+	$svn->{'svn'}->get_log("/",$from_rev,$to_rev,0,1,1,\&commit_all);
 	my $pid =3D fork();
 	die "Fork: $!\n" unless defined $pid;
 	unless($pid) {

--=20
Stefan Sperling <stsp@elego.de>                 Software Developer
elego Software Solutions GmbH                            HRB 77719
Gustav-Meyer-Allee 25, Gebaeude 12        Tel:  +49 30 23 45 86 96=20
13355 Berlin                              Fax:  +49 30 23 45 86 95
http://www.elego.de                 Geschaeftsfuehrer: Olaf Wagner

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG95gk5dMCc/WdJfARAhUmAKDqoW6PFzTE0Gfm0Z1Ef9mu2jkcOgCeL3eW
xCNRaHwH00CMdWzzGNC6HGw=
=dg+7
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
