From: Karl =?ISO-8859-1?Q?=20Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH 2/4] Convert executable flag
Date: Sun, 26 Feb 2006 06:11:27 +0100
Message-ID: <20060226051126.24860.61044.stgit@backpacker.hemma.treskal.com>
References: <20060226050335.24860.95155.stgit@backpacker.hemma.treskal.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Feb 26 06:11:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDEBv-0000Op-0M
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 06:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWBZFL3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 00:11:29 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWBZFL3
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 00:11:29 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:12008 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1751209AbWBZFL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 00:11:28 -0500
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep02.bredband.com with ESMTP
          id <20060226051127.WRNW29994.mxfep02.bredband.com@backpacker.hemma.treskal.com>
          for <git@vger.kernel.org>; Sun, 26 Feb 2006 06:11:27 +0100
Received: from backpacker.hemma.treskal.com (localhost.localdomain [127.0.0.1])
	by backpacker.hemma.treskal.com (Postfix) with ESMTP id 24A3A167C
	for <git@vger.kernel.org>; Sun, 26 Feb 2006 06:11:27 +0100 (CET)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20060226050335.24860.95155.stgit@backpacker.hemma.treskal.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16771>

Convert the svn:executable property to file mode 755 when converting
an SVN repository to GIT.

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>

---

 git-svnimport.perl |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/git-svnimport.perl b/git-svnimport.perl
index ee2940f..6603b96 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -112,16 +112,22 @@ sub file {
 		    DIR =3D> File::Spec->tmpdir(), UNLINK =3D> 1);
=20
 	print "... $rev $path ...\n" if $opt_v;
-	my $pool =3D SVN::Pool->new();
-	eval { $self->{'svn'}->get_file($path,$rev,$fh,$pool); };
-	$pool->clear;
+	my (undef, $properties);
+	eval { (undef, $properties)
+		   =3D $self->{'svn'}->get_file($path,$rev,$fh); };
 	if($@) {
 		return undef if $@ =3D~ /Attempted to get checksum/;
 		die $@;
 	}
+	my $mode;
+	if (exists $properties->{'svn:executable'}) {
+		$mode =3D '0755';
+	} else {
+		$mode =3D '0644';
+	}
 	close ($fh);
=20
-	return $name;
+	return ($name, $mode);
 }
=20
 package main;
@@ -296,7 +302,7 @@ sub get_file($$$) {
 	my $svnpath =3D revert_split_path($branch,$path);
=20
 	# now get it
-	my $name;
+	my ($name,$mode);
 	if($opt_d) {
 		my($req,$res);
=20
@@ -316,8 +322,9 @@ sub get_file($$$) {
 			return undef if $res->code =3D=3D 301; # directory?
 			die $res->status_line." at $url\n";
 		}
+		$mode =3D '0644'; # can't obtain mode via direct http request?
 	} else {
-		$name =3D $svn->file("$svnpath",$rev);
+		($name,$mode) =3D $svn->file("$svnpath",$rev);
 		return undef unless defined $name;
 	}
=20
@@ -331,7 +338,6 @@ sub get_file($$$) {
 	chomp $sha;
 	close $F;
 	unlink $name;
-	my $mode =3D "0644"; # SV does not seem to store any file modes
 	return [$mode, $sha, $path];
 }
=20
