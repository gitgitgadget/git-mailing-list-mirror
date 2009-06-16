From: Alex Bennee <kernel-hacker@bennee.com>
Subject: [PATCH] Add -k option to cvsexportcommit to revert expanded CVS 
	keywords in CVS working tree before applying commit patch
Date: Tue, 16 Jun 2009 15:21:04 +0100
Message-ID: <b2cdc9f30906160721re87e2efvd342dc60e0f24c75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 16:21:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGZXS-0000Hj-Jf
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 16:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337AbZFPOVH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Jun 2009 10:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbZFPOVG
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 10:21:06 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:36549 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbZFPOVE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jun 2009 10:21:04 -0400
Received: by bwz9 with SMTP id 9so4084691bwz.37
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 07:21:05 -0700 (PDT)
Received: by 10.103.240.15 with SMTP id s15mr4502819mur.102.1245162064904; 
	Tue, 16 Jun 2009 07:21:04 -0700 (PDT)
X-Google-Sender-Auth: f0f728094bd9db87
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121684>

Depending on how your CVS->GIT conversion went you will have some
unexpanded CVS keywords in your GIT repo. If any of your git commits
touch these lines then the patch application will fail. This patch
addresses that by adding an option that will revert and expanded CVS
keywords to files in the working CVS directory that are affected by
the commit being applied.

Signed-off-by: Alex Benn=EF=BF=BDe <alex@bennee.com>
---
 Documentation/git-cvsexportcommit.txt |    4 ++++
 git-cvsexportcommit.perl              |   25 ++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cvsexportcommit.txt
b/Documentation/git-cvsexportcommit.txt
index 2da8588..7488b6d 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -63,6 +63,10 @@ OPTIONS
 -u::
 	Update affected files from CVS repository before attempting export.

+-k::
+	Reverse CVS keyword expansion (e.g. $Revision: 1.2.3.4$
+	becomes $Revision$) in working CVS checkout before applying patch.
+=09
 -w::
 	Specify the location of the CVS checkout to use for the export. This
 	option does not require GIT_DIR to be set before execution if the
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 6d9f0ef..c3ebeac 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -8,9 +8,9 @@ use File::Basename qw(basename dirname);
 use File::Spec;
 use Git;

-our ($opt_h, $opt_P, $opt_p, $opt_v, $opt_c, $opt_f, $opt_a, $opt_m,
$opt_d, $opt_u, $opt_w, $opt_W);
+our ($opt_h, $opt_P, $opt_p, $opt_v, $opt_c, $opt_f, $opt_a, $opt_m,
$opt_d, $opt_u, $opt_w, $opt_W, $opt_k);

-getopts('uhPpvcfam:d:w:W');
+getopts('uhPpvcfkam:d:w:W');

 $opt_h && usage();

@@ -266,7 +266,26 @@ foreach my $f (@files) {
 	$dirty =3D 1;
 	warn "File $f not up to date but has status '$cvsstat{$f}' in your
CVS checkout!\n";
     }
+
+    # Depending on how your GIT tree got imported from CVS you may
+    # have a conflict between expanded keywords in your CVS tree and
+    # unexpanded keywords in the patch about to be applied.
+    if ($opt_k) {
+	my $orig_file =3D"$f.orig";
+	rename $f, $orig_file;
+	open(FILTER_IN, "<$orig_file") or die "Cannot open $orig_file\n";
+	open(FILTER_OUT, ">$f") or die "Cannot open $f\n";
+	while (<FILTER_IN>)
+	{
+	    my $line =3D $_;
+	    $line =3D~ s/\$([A-Z][a-z]+):[^\$]+\$/\$\1\$/g;
+	    print FILTER_OUT $line;
+	}
+	close FILTER_IN;
+	close FILTER_OUT;
+    }
 }
+
 if ($dirty) {
     if ($opt_f) {	warn "The tree is not clean -- forced merge\n";
 	$dirty =3D 0;
@@ -370,7 +389,7 @@ sleep(1);

 sub usage {
 	print STDERR <<END;
-Usage: GIT_DIR=3D/path/to/.git git cvsexportcommit [-h] [-p] [-v] [-c]
[-f] [-u] [-w cvsworkdir] [-m msgprefix] [ parent ] commit
+Usage: GIT_DIR=3D/path/to/.git git cvsexportcommit [-h] [-p] [-v] [-c]
[-f] [-u] [-k] [-w cvsworkdir] [-m msgprefix] [ parent ] commit
 END
 	exit(1);
 }
--=20
1.6.0.2.95.g72d40


--
Alex, homepage: http://www.bennee.com/~alex/
http://www.half-llama.co.uk
