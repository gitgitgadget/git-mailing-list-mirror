From: Karl =?ISO-8859-1?Q?=20Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH 2/2] Save username -> Full Name <email@addr.es> map file
Date: Tue, 28 Feb 2006 00:08:19 +0100
Message-ID: <20060227230817.12298.79184.stgit@backpacker.hemma.treskal.com>
References: <440195D4.7080905@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Feb 28 00:08:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDrTf-0001Fy-Mw
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 00:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbWB0XIW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 18:08:22 -0500
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWB0XIW
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 18:08:22 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:10139 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1751847AbWB0XIV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 18:08:21 -0500
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep02.bredband.com with ESMTP
          id <20060227230819.OXQD29994.mxfep02.bredband.com@backpacker.hemma.treskal.com>
          for <git@vger.kernel.org>; Tue, 28 Feb 2006 00:08:19 +0100
Received: from backpacker.hemma.treskal.com (localhost.localdomain [127.0.0.1])
	by backpacker.hemma.treskal.com (Postfix) with ESMTP id 5F6D12727
	for <git@vger.kernel.org>; Tue, 28 Feb 2006 00:08:19 +0100 (CET)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <440195D4.7080905@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16889>

When the user specifies a username -> Full Name <email@addr.es> map
file with the -A option, save a copy of that file as
$git_dir/svn-authors. When running git-svnimport with an existing GIT
directory, use $git_dir/svn-authors (if it exists) unless a file was
explicitly specified with -A.

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>

---

 Documentation/git-svnimport.txt |    5 +++++
 git-svnimport.perl              |   25 ++++++++++++++++++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimp=
ort.txt
index 912a808..a158813 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -82,6 +82,11 @@ When importing incrementally, you might=20
 	"username". If encountering a commit made by a user not in the
 	list, abort.
=20
+	For convenience, this data is saved to $GIT_DIR/svn-authors
+	each time the -A option is provided, and read from that same
+	file each time git-svnimport is run with an existing GIT
+	repository without -A.
+
 -m::
 	Attempt to detect merges based on the commit message. This option
 	will enable default regexes that try to capture the name source
diff --git a/git-svnimport.perl b/git-svnimport.perl
index 86837ed..639aa41 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -13,6 +13,7 @@
 use strict;
 use warnings;
 use Getopt::Std;
+use File::Copy;
 use File::Spec;
 use File::Temp qw(tempfile);
 use File::Path qw(mkpath);
@@ -68,10 +69,16 @@ if ($opt_M) {
 	push (@mergerx, qr/$opt_M/);
 }
=20
+# Absolutize filename now, since we will have chdir'ed by the time we
+# get around to opening it.
+$opt_A =3D File::Spec->rel2abs($opt_A) if $opt_A;
+
 our %users =3D ();
-if ($opt_A) {
-	die "Cannot open $opt_A\n" unless -f $opt_A;
-	open(my $authors,$opt_A);
+our $users_file =3D undef;
+sub read_users($) {
+	$users_file =3D File::Spec->rel2abs(@_);
+	die "Cannot open $users_file\n" unless -f $users_file;
+	open(my $authors,$users_file);
 	while(<$authors>) {
 		chomp;
 		next unless /^(\S+?)\s*=3D\s*(.+?)\s*<(.+)>\s*$/;
@@ -302,6 +309,14 @@ EOM
 -d $git_dir
 	or die "Could not create git subdir ($git_dir).\n";
=20
+my $default_authors =3D "$git_dir/svn-authors";
+if ($opt_A) {
+	read_users($opt_A);
+	copy($opt_A,$default_authors) or die "Copy failed: $!";
+} else {
+	read_users($default_authors) if -f $default_authors;
+}
+
 open BRANCHES,">>", "$git_dir/svn2git";
=20
 sub node_kind($$$) {
@@ -498,8 +513,8 @@ sub commit {
=20
 	if (not defined $author) {
 		$author_name =3D $author_email =3D "unknown";
-	} elsif ($opt_A) {
-		die "User $author is not listed in $opt_A\n"
+	} elsif (defined $users_file) {
+		die "User $author is not listed in $users_file\n"
 		    unless exists $users{$author};
 		($author_name,$author_email) =3D @{$users{$author}};
 	} elsif ($author =3D~ /^(.*?)\s+<(.*)>$/) {
