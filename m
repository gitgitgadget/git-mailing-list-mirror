From: Karl =?ISO-8859-1?Q?=20Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH 4/4] Read author names and emails from a file
Date: Sun, 26 Feb 2006 06:11:31 +0100
Message-ID: <20060226051131.24860.15804.stgit@backpacker.hemma.treskal.com>
References: <20060226050335.24860.95155.stgit@backpacker.hemma.treskal.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Feb 26 06:11:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDEC4-0000Rg-Kw
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 06:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWBZFLe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 00:11:34 -0500
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWBZFLd
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 00:11:33 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:27589 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751214AbWBZFLd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 00:11:33 -0500
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep01.bredband.com with ESMTP
          id <20060226051131.WHYC16046.mxfep01.bredband.com@backpacker.hemma.treskal.com>
          for <git@vger.kernel.org>; Sun, 26 Feb 2006 06:11:31 +0100
Received: from backpacker.hemma.treskal.com (localhost.localdomain [127.0.0.1])
	by backpacker.hemma.treskal.com (Postfix) with ESMTP id B04B4167C
	for <git@vger.kernel.org>; Sun, 26 Feb 2006 06:11:31 +0100 (CET)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20060226050335.24860.95155.stgit@backpacker.hemma.treskal.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16774>

Read a file with lines on the form

  username User's Full Name <email@addres.org>

and use "User's Full Name <email@addres.org>" as the GIT author and
committer for Subversion commits made by "username". If encountering a
commit made by a user not in the list, abort.

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>

---

 Documentation/git-svnimport.txt |   13 ++++++++++++-
 git-svnimport.perl              |   23 ++++++++++++++++++++---
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimp=
ort.txt
index c95ff84..e0e3a5d 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 		[ -C <GIT_repository> ] [ -i ] [ -u ] [-l limit_rev]
 		[ -b branch_subdir ] [ -T trunk_subdir ] [ -t tag_subdir ]
 		[ -s start_chg ] [ -m ] [ -r ] [ -M regex ]
-		[ -I <ignorefile_name> ] <SVN_repository_URL> [ <path> ]
+		[ -I <ignorefile_name> ] [ -A <author_file> ]
+		<SVN_repository_URL> [ <path> ]
=20
=20
 DESCRIPTION
@@ -71,6 +72,16 @@ When importing incrementally, you might=20
 	syntaxes are similar enough that using the Subversion patterns
 	directly with "-I .gitignore" will almost always just work.)
=20
+-A <author_file>::
+	Read a file with lines on the form
+
+	  username User's Full Name <email@addres.org>
+
+	and use "User's Full Name <email@addres.org>" as the GIT
+	author and committer for Subversion commits made by
+	"username". If encountering a commit made by a user not in the
+	list, abort.
+
 -m::
 	Attempt to detect merges based on the commit message. This option
 	will enable default regexes that try to capture the name source
diff --git a/git-svnimport.perl b/git-svnimport.perl
index 0dd9fab..75ce8e0 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -30,7 +30,7 @@ $SIG{'PIPE'}=3D"IGNORE";
 $ENV{'TZ'}=3D"UTC";
=20
 our($opt_h,$opt_o,$opt_v,$opt_u,$opt_C,$opt_i,$opt_m,$opt_M,$opt_t,$op=
t_T,
-    $opt_b,$opt_r,$opt_I,$opt_s,$opt_l,$opt_d,$opt_D);
+    $opt_b,$opt_r,$opt_I,$opt_A,$opt_s,$opt_l,$opt_d,$opt_D);
=20
 sub usage() {
 	print STDERR <<END;
@@ -38,12 +38,12 @@ Usage: ${\basename $0}     # fetch/updat
        [-o branch-for-HEAD] [-h] [-v] [-l max_rev]
        [-C GIT_repository] [-t tagname] [-T trunkname] [-b branchname]
        [-d|-D] [-i] [-u] [-r] [-I ignorefilename] [-s start_chg]
-       [-m] [-M regex] [SVN_URL]
+       [-m] [-M regex] [-A author_file] [SVN_URL]
 END
 	exit(1);
 }
=20
-getopts("b:C:dDhiI:l:mM:o:rs:t:T:uv") or usage();
+getopts("A:b:C:dDhiI:l:mM:o:rs:t:T:uv") or usage();
 usage if $opt_h;
=20
 my $tag_name =3D $opt_t || "tags";
@@ -68,6 +68,19 @@ if ($opt_M) {
 	push (@mergerx, qr/$opt_M/);
 }
=20
+our %users =3D ();
+if ($opt_A) {
+	die "Cannot open $opt_A\n" unless -f $opt_A;
+	open(my $authors,$opt_A);
+	while(<$authors>) {
+		chomp;
+		next unless /^(\S+)\s+(.+?)\s+<(\S+)>$/;
+		(my $user,my $name,my $email) =3D ($1,$2,$3);
+		$users{$user} =3D [$name,$email];
+	}
+	close($authors);
+}
+
 select(STDERR); $|=3D1; select(STDOUT);
=20
=20
@@ -485,6 +498,10 @@ sub commit {
=20
 	if (not defined $author) {
 		$author_name =3D $author_email =3D "unknown";
+	} elsif ($opt_A) {
+		die "User $author is not listed in $opt_A\n"
+		    unless exists $users{$author};
+		($author_name,$author_email) =3D @{$users{$author}};
 	} elsif ($author =3D~ /^(.*?)\s+<(.*)>$/) {
 		($author_name, $author_email) =3D ($1, $2);
 	} else {
