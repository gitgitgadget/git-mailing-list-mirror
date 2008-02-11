From: Johan Herland <johan@herland.net>
Subject: [PATCH] Fix 'git cvsexportcommit -w $cvsdir ...' when used with
 relative $GIT_DIR
Date: Tue, 12 Feb 2008 00:43:41 +0100
Message-ID: <200802120043.41610.johan@herland.net>
References: <200802110228.05233.johan@herland.net>
 <200802112158.16830.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 00:44:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOiKH-0000HT-7M
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 00:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165AbYBKXoG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 18:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753773AbYBKXoF
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 18:44:05 -0500
Received: from smtp.getmail.no ([84.208.20.33]:57262 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752829AbYBKXoD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 18:44:03 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JW30011FLXDAI00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 12 Feb 2008 00:44:01 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JW300HX0LWTXB10@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 12 Feb 2008 00:43:41 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JW300MUQLWT4Y20@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 12 Feb 2008 00:43:41 +0100 (CET)
In-reply-to: <200802112158.16830.robin.rosenberg.lists@dewire.com>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73606>

When using the '-w $cvsdir' option to cvsexportcommit, it will chdir in=
to
$cvsdir before executing several other git commands. If $GIT_DIR is set=
 to
a relative path (e.g. '.'), the git commands executed by cvsexportcommi=
t
will naturally fail.

Therefore, ensure that $GIT_DIR is absolute before the chdir to $cvsdir=
=2E

Signed-off-by: Johan Herland <johan@herland.net>
---

On Monday 11 February 2008, Robin Rosenberg wrote:
> m=C3=A5ndagen den 11 februari 2008 skrev Johan Herland:
> > -		# Remember where our GIT_DIR is before changing to CVS checkout
> > +		# Oops no GIT_DIR set. Figure out for ourselves
>=20
> That's not an "Oops". It's perfectly normal not to have GIT_DIR set.

Of course not. Fixed.

> > +	unless ($ENV{GIT_DIR} =3D~ m[^/]) {
>=20
> Hmm. C:/foo? You should probably use rel2abs in the File::Spec=20
> module.

Thanks. Fixed.


Have fun! :)

=2E..Johan


 git-cvsexportcommit.perl |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d2e50c3..2a8ad1e 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -5,6 +5,7 @@ use Getopt::Std;
 use File::Temp qw(tempdir);
 use Data::Dumper;
 use File::Basename qw(basename dirname);
+use File::Spec;
=20
 our ($opt_h, $opt_P, $opt_p, $opt_v, $opt_c, $opt_f, $opt_a, $opt_m, $=
opt_d, $opt_u, $opt_w);
=20
@@ -15,17 +16,15 @@ $opt_h && usage();
 die "Need at least one commit identifier!" unless @ARGV;
=20
 if ($opt_w) {
+	# Remember where GIT_DIR is before changing to CVS checkout
 	unless ($ENV{GIT_DIR}) {
-		# Remember where our GIT_DIR is before changing to CVS checkout
+		# No GIT_DIR set. Figure it out for ourselves
 		my $gd =3D`git-rev-parse --git-dir`;
 		chomp($gd);
-		if ($gd eq '.git') {
-			my $wd =3D `pwd`;
-			chomp($wd);
-			$gd =3D $wd."/.git"	;
-		}
 		$ENV{GIT_DIR} =3D $gd;
 	}
+	# Make sure GIT_DIR is absolute
+	$ENV{GIT_DIR} =3D File::Spec->rel2abs($ENV{GIT_DIR});
=20
 	if (! -d $opt_w."/CVS" ) {
 		die "$opt_w is not a CVS checkout";
--=20
1.5.4.2.g41ac4
