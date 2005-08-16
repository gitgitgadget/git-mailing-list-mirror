From: martin@ng.eduforge.org (Martin Langhoff)
Subject: [PATCH] Add merge detection to git-cvsimport
Date: Tue, 16 Aug 2005 22:35:27 +1200 (NZST)
Message-ID: <20050816103527.F420A33010C@ng.eduforge.org>
X-From: git-owner@vger.kernel.org Tue Aug 16 12:36:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4yn6-0003fz-Tt
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 12:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbVHPKf3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 06:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbVHPKf3
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 06:35:29 -0400
Received: from 34.70-85-230.reverse.theplanet.com ([70.85.230.34]:52122 "EHLO
	ng.eduforge.org") by vger.kernel.org with ESMTP id S965199AbVHPKf3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 06:35:29 -0400
Received: by ng.eduforge.org (Postfix, from userid 3373)
	id F420A33010C; Tue, 16 Aug 2005 22:35:27 +1200 (NZST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Add merge detection to git-cvsimport

Added -m and -M flags for git-cvsimport to detect merge commits in cvs.
While this trusts the commit message, in repositories where merge commits
indicate 'merged from FOOBRANCH' the import works surprisingly well.

Even if some merges from CVS are bogus or incomplete, the resulting
branches are in better state to go forward (and merge) than without any
merge detection.

Signed-off-by: Martin Langhoff <martin.langhoff@gmail.com>
---

 Documentation/git-cvsimport-script.txt |   13 ++++++++-
 git-cvsimport-script                   |   48 +++++++++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 5 deletions(-)

066d2cb2435a963ee40e4899a76848ea51e972d2
diff --git a/Documentation/git-cvsimport-script.txt b/Documentation/git-cvsimport-script.txt
--- a/Documentation/git-cvsimport-script.txt
+++ b/Documentation/git-cvsimport-script.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 --------
 'git-cvsimport-script' [ -o <branch-for-HEAD> ] [ -h ] [ -v ]
 			[ -d <CVSROOT> ] [ -p <options-for-cvsps> ]
-			[ -C <GIT_repository> ] [ -i ] [ -k ] [ <CVS_module> ]
+			[ -C <GIT_repository> ] [ -i ] [ -k ] 
+			[ -m ] [ -M regex ] [ <CVS_module> ]
 
 
 DESCRIPTION
@@ -57,6 +58,16 @@ OPTIONS
 
 	If you need to pass multiple options, separate them with a comma.
 
+-m::    
+	Attempt to detect merges based on the commit message. This option
+	will enable default regexes that try to capture the name source 
+	branch name from the commit message. 
+
+-M <regex>::
+	Attempt to detect merges based on the commit message with a custom
+	regex. It can be used with -m to also see the default regexes. 
+	You must escape forward slashes. 
+
 -v::
 	Verbosity: let 'cvsimport' report what it is doing.
 
diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -28,19 +28,19 @@ use POSIX qw(strftime dup2);
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
-our($opt_h,$opt_o,$opt_v,$opt_k,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i);
+our($opt_h,$opt_o,$opt_v,$opt_k,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_m,$opt_M);
 
 sub usage() {
 	print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from CVS
        [ -o branch-for-HEAD ] [ -h ] [ -v ] [ -d CVSROOT ]
        [ -p opts-for-cvsps ] [ -C GIT_repository ] [ -z fuzz ]
-       [ -i ] [ -k ] [ CVS_module ]
+       [ -i ] [ -k ] [ -m ] [ -M regex] [ CVS_module ]
 END
 	exit(1);
 }
 
-getopts("hivko:d:p:C:z:") or usage();
+getopts("hivmko:d:p:C:z:M:") or usage();
 usage if $opt_h;
 
 @ARGV <= 1 or usage();
@@ -70,11 +70,19 @@ if ($#ARGV == 0) {
 	    die 'Failed to open CVS/Repository';
 	$cvs_tree = <$f>;
 	chomp $cvs_tree;
-	close $f
+	close $f;
 } else {
 	usage();
 }
 
+our @mergerx = ();
+if ($opt_m) {
+	@mergerx = ( qr/\W(?:from|of|merge|merging|merged) (\w+)/i );
+}
+if ($opt_M) {
+	push (@mergerx, qr/$opt_M/);
+}
+
 select(STDERR); $|=1; select(STDOUT);
 
 
@@ -374,6 +382,22 @@ sub getwd() {
 	return $pwd;
 }
 
+
+sub get_headref($$) {
+    my $name    = shift;
+    my $git_dir = shift; 
+    my $sha;
+    
+    if (open(C,"$git_dir/refs/heads/$name")) {
+	chomp($sha = <C>);
+	close(C);
+	length($sha) == 40
+	    or die "Cannot get head id for $name ($sha): $!\n";
+    }
+    return $sha;
+}
+
+
 -d $git_tree
 	or mkdir($git_tree,0777)
 	or die "Could not create $git_tree: $!";
@@ -548,6 +572,22 @@ my $commit = sub {
 
 		my @par = ();
 		@par = ("-p",$parent) if $parent;
+
+		# loose detection of merges
+		# based on the commit msg
+		foreach my $rx (@mergerx) {
+			if ($logmsg =~ $rx) {
+				my $mparent = $1;
+				if ($mparent eq 'HEAD') { $mparent = 'origin'};
+				if ( -e "$git_dir/refs/heads/$mparent") {
+					$mparent = get_headref($mparent, $git_dir);
+					push @par, '-p', $mparent;
+					# printing here breaks import # 
+					# # print "Merge parent branch: $mparent\n" if $opt_v;
+				}
+		    	} 
+		}
+
 		exec("env",
 			"GIT_AUTHOR_NAME=$author",
 			"GIT_AUTHOR_EMAIL=$author",
