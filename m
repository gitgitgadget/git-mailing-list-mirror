From: Eric Wong <normalperson@yhbt.net>
Subject: [1/2 PATCH] git-svn: make multi-init less confusing
Date: Thu, 4 Jan 2007 18:02:00 -0800
Message-ID: <20070105020158.GA21925@localdomain>
References: <87fyaqvgoz.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri Jan 05 03:02:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2ePS-0006xb-5F
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 03:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbXAECCF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 4 Jan 2007 21:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbXAECCE
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 21:02:04 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60669 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030259AbXAECCD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 21:02:03 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 7B1307DC094;
	Thu,  4 Jan 2007 18:02:00 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 04 Jan 2007 18:02:00 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <87fyaqvgoz.fsf@morpheus.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35967>

It now requires at least one of the (trunk|branch|tags) arguments
(either from the command-line or in .git/config).  Also we make
sure that anything that is passed as a URL ('help') in David's
case is actually a URL.

Thanks to David K=E5gedal for reporting this issue.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   78 +++++++++++++++++++++++++++++---------------------=
-------
 1 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b28c5bb..0fc386a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -571,28 +571,25 @@ sub graft_branches {
=20
 sub multi_init {
 	my $url =3D shift;
-	$_trunk ||=3D 'trunk';
-	$_trunk =3D~ s#/+$##;
-	$url =3D~ s#/+$## if $url;
-	if ($_trunk !~ m#^[a-z\+]+://#) {
-		$_trunk =3D '/' . $_trunk if ($_trunk !~ m#^/#);
-		unless ($url) {
-			print STDERR "E: '$_trunk' is not a complete URL ",
-				"and a separate URL is not specified\n";
-			exit 1;
-		}
-		$_trunk =3D $url . $_trunk;
-	}
-	my $ch_id;
-	if ($GIT_SVN eq 'git-svn') {
-		$ch_id =3D 1;
-		$GIT_SVN =3D $ENV{GIT_SVN_ID} =3D 'trunk';
+	unless (defined $_trunk || defined $_branches || defined $_tags) {
+		usage(1);
 	}
-	init_vars();
-	unless (-d $GIT_SVN_DIR) {
-		print "GIT_SVN_ID set to 'trunk' for $_trunk\n" if $ch_id;
-		init($_trunk);
-		command_noisy('repo-config', 'svn.trunk', $_trunk);
+	if (defined $_trunk) {
+		my $trunk_url =3D complete_svn_url($url, $_trunk);
+		my $ch_id;
+		if ($GIT_SVN eq 'git-svn') {
+			$ch_id =3D 1;
+			$GIT_SVN =3D $ENV{GIT_SVN_ID} =3D 'trunk';
+		}
+		init_vars();
+		unless (-d $GIT_SVN_DIR) {
+			if ($ch_id) {
+				print "GIT_SVN_ID set to 'trunk' for ",
+				      "$trunk_url ($_trunk)\n";
+			}
+			init($trunk_url);
+			command_noisy('repo-config', 'svn.trunk', $trunk_url);
+		}
 	}
 	complete_url_ls_init($url, $_branches, '--branches/-b', '');
 	complete_url_ls_init($url, $_tags, '--tags/-t', 'tags/');
@@ -872,29 +869,34 @@ sub rec_fetch {
 	}
 }
=20
+sub complete_svn_url {
+	my ($url, $path) =3D @_;
+	$path =3D~ s#/+$##;
+	$url =3D~ s#/+$## if $url;
+	if ($path !~ m#^[a-z\+]+://#) {
+		$path =3D '/' . $path if ($path !~ m#^/#);
+		if (!defined $url || $url !~ m#^[a-z\+]+://#) {
+			fatal("E: '$path' is not a complete URL ",
+			      "and a separate URL is not specified\n");
+		}
+		$path =3D $url . $path;
+	}
+	return $path;
+}
+
 sub complete_url_ls_init {
-	my ($url, $var, $switch, $pfx) =3D @_;
-	unless ($var) {
+	my ($url, $path, $switch, $pfx) =3D @_;
+	unless ($path) {
 		print STDERR "W: $switch not specified\n";
 		return;
 	}
-	$var =3D~ s#/+$##;
-	if ($var !~ m#^[a-z\+]+://#) {
-		$var =3D '/' . $var if ($var !~ m#^/#);
-		unless ($url) {
-			print STDERR "E: '$var' is not a complete URL ",
-				"and a separate URL is not specified\n";
-			exit 1;
-		}
-		$var =3D $url . $var;
-	}
-	my @ls =3D libsvn_ls_fullurl($var);
-	my $old =3D $GIT_SVN;
+	my $full_url =3D complete_svn_url($url, $path);
+	my @ls =3D libsvn_ls_fullurl($full_url);
 	defined(my $pid =3D fork) or croak $!;
 	if (!$pid) {
-		foreach my $u (map { "$var/$_" } (grep m!/$!, @ls)) {
+		foreach my $u (map { "$full_url/$_" } (grep m!/$!, @ls)) {
 			$u =3D~ s#/+$##;
-			if ($u !~ m!\Q$var\E/(.+)$!) {
+			if ($u !~ m!\Q$full_url\E/(.+)$!) {
 				print STDERR "W: Unrecognized URL: $u\n";
 				die "This should never happen\n";
 			}
@@ -912,7 +914,7 @@ sub complete_url_ls_init {
 	waitpid $pid, 0;
 	croak $? if $?;
 	my ($n) =3D ($switch =3D~ /^--(\w+)/);
-	command_noisy('repo-config', "svn.$n", $var);
+	command_noisy('repo-config', "svn.$n", $full_url);
 }
=20
 sub common_prefix {

--=20
Eric Wong
