From: Alex Bennee <kernel-hacker@bennee.com>
Subject: [PATCH] Add -k option to cvsexportcommit to squash CVS keywords
Date: Thu, 28 May 2009 14:36:34 +0100
Message-ID: <b2cdc9f30905280636p404525e2u6f3eb21700b6da66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 15:36:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9fmm-0007HI-Br
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 15:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809AbZE1Ngg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 09:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755227AbZE1Ngf
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 09:36:35 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:50390 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbZE1Nge (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 09:36:34 -0400
Received: by fxm12 with SMTP id 12so3695093fxm.37
        for <git@vger.kernel.org>; Thu, 28 May 2009 06:36:34 -0700 (PDT)
Received: by 10.103.115.12 with SMTP id s12mr826870mum.89.1243517794856; Thu, 
	28 May 2009 06:36:34 -0700 (PDT)
X-Google-Sender-Auth: 0f4ca9cba6dc888f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120189>

My CVS repo is converted by parsecvs and although I don't often mess
around in the headers I did hit a problem when exporting some commits
that had removed some lines which would have had an expanded
$Revision$ in a code string.

Rather than make it default behaviour I've added a quick filter to
cvsexportcommit so I don't have to go back to patching and committing
those commits by ahdn :-)


>From a1a9477d6e332617526aaab488602552b77832d9 Mon Sep 17 00:00:00 2001
From: Alex Bennee <alex@bennee.com>
Date: Thu, 28 May 2009 14:31:51 +0100
Subject: [PATCH] Add -k option to cvsexportcommit to squash CVS keywords

Depending on how your CVS->GIT conversion went you will have some
unexpanded CVS keywords in your
GIT repo. If any of your git commits touch these lines then the patch
application will fail. This
patch addresses that by filtering files before applying the patch
---
 Documentation/git-cvsexportcommit.txt |    3 +++
 git-cvsexportcommit.perl              |   31 +++++++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cvsexportcommit.txt
b/Documentation/git-cvsexportcommit.txt
index 2da8588..b328dd4 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -63,6 +63,9 @@ OPTIONS
 -u::
 	Update affected files from CVS repository before attempting export.

+-k::
+	Filter CVS keywords (like $Revision$) before applying patch.
+	
 -w::
 	Specify the location of the CVS checkout to use for the export. This
 	option does not require GIT_DIR to be set before execution if the
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 6d9f0ef..dd41b0c 100755
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

@@ -266,9 +266,32 @@ foreach my $f (@files) {
 	$dirty = 1;
 	warn "File $f not up to date but has status '$cvsstat{$f}' in your
CVS checkout!\n";
     }
+
+    # Depending on how your GIT tree got imported some of the CVS
+    # expansion keywords would have been squashed. This will break
+    # application of the patch if you touched any lines that had them.
+    if ($opt_k)
+    {
+	my $orig_file ="$f.orig";
+	rename $f, $orig_file;
+	open(FILTER_IN, "<$orig_file") or die "Cannot open $orig_file\n";
+	open(FILTER_OUT, ">$f") or die "Cannot open $f\n";
+	while (<FILTER_IN>)
+	{
+	    my $line = $_;
+	    $line =~ s#\$Revision:[ \.\d]+ \$#\$Revision\$#;
+	    $line =~ s#\$Id: [^\$]+\$#\$Id\$#;
+
+	    print FILTER_OUT $line;
+	}
+	close FILTER_IN;
+	close FILTER_OUT;
+    }
 }
+
 if ($dirty) {
-    if ($opt_f) {	warn "The tree is not clean -- forced merge\n";
+    if ($opt_f) {
+	warn "The tree is not clean -- forced merge\n";
 	$dirty = 0;
     } else {
 	die "Exiting: your CVS tree is not clean for this merge.";
@@ -370,7 +393,7 @@ sleep(1);

 sub usage {
 	print STDERR <<END;
-Usage: GIT_DIR=/path/to/.git git cvsexportcommit [-h] [-p] [-v] [-c]
[-f] [-u] [-w cvsworkdir] [-m msgprefix] [ parent ] commit
+Usage: GIT_DIR=/path/to/.git git cvsexportcommit [-h] [-p] [-v] [-c]
[-f] [-u] [-k] [-w cvsworkdir] [-m msgprefix] [ parent ] commit
 END
 	exit(1);
 }
-- 
1.6.0.2.95.g72d40



-- 
Alex, homepage: http://www.bennee.com/~alex/
CV: http://www.bennee.com/~alex/cv.php
