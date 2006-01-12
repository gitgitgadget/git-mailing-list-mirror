From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH] git-cvsimport: Add -A <author-conv-file> option
Date: Fri, 13 Jan 2006 00:38:59 +0100 (CET)
Message-ID: <20060112233859.3438F5BED0@nox.op5.se>
X-From: git-owner@vger.kernel.org Fri Jan 13 00:39:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExC25-0006CK-R7
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 00:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161476AbWALXjB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 18:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161477AbWALXjB
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 18:39:01 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:49836 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1161476AbWALXjA
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 18:39:00 -0500
Received: from nox.op5.se (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 60ABD6BD00
	for <git@vger.kernel.org>; Fri, 13 Jan 2006 00:38:59 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 3438F5BED0; Fri, 13 Jan 2006 00:38:59 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14594>

This patch adds the option to specify an author name/email conversion
file in the format

	exon=Andreas Ericsson <ae@op5.se>
	spawn=Simon Pawn <spawn@frog-pond.org>

which will translate the ugly cvs authornames to the more informative
git style.

The info is saved in $GIT_DIR/cvs-authors, so that subsequent
incremental imports will use the same author-info even if no -A
option is specified. If an -A option *is* specified, the info in
$GIT_DIR/cvs-authors is appended/updated appropriately.

Docs updated accordingly.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 Documentation/git-cvsimport.txt |   20 ++++++++++++++
 git-cvsimport.perl              |   56 +++++++++++++++++++++++++++++++++++----
 2 files changed, 70 insertions(+), 6 deletions(-)

a1883e11a55c4684c0c5123c75425623a54f44cf
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 01ca7ef..dfe86ce 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -89,6 +89,26 @@ If you need to pass multiple options, se
 -s <subst>::
 	Substitute the character "/" in branch names with <subst>
 
+-A <author-conv-file>::
+	CVS by default uses the unix username when writing its
+	commit logs. Using this option and an author-conv-file
+	in this format
+
+	exon=Andreas Ericsson <ae@op5.se>
+	spawn=Simon Pawn <spawn@frog-pond.org>
+
+	git-cvsimport will make it appear as those authors had
+	their GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL set properly
+	all along.
+
+	For convenience, this data is saved to $GIT_DIR/cvs-authors
+	each time the -A option is provided and read from that same
+	file each time git-cvsimport is run.
+
+	It is not recommended to use this feature if you intend to
+	export changes back to CVS again later with
+	git-link[1]::git-cvsexportcommit.
+
 OUTPUT
 ------
 If '-v' is specified, the script reports what it is doing.
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 8619e7d..8d493c2 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -29,19 +29,52 @@ use IPC::Open2;
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
 
-our($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,$opt_M);
+our($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,$opt_M,$opt_A);
+my (%conv_author_name, %conv_author_email);
 
 sub usage() {
 	print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from CVS
-       [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT]
-       [-p opts-for-cvsps] [-C GIT_repository] [-z fuzz]
-       [-i] [-k] [-u] [-s subst] [-m] [-M regex] [CVS_module]
+       [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT] [-A author-conv-file]
+       [-p opts-for-cvsps] [-C GIT_repository] [-z fuzz] [-i] [-k] [-u]
+       [-s subst] [-m] [-M regex] [CVS_module]
 END
 	exit(1);
 }
 
-getopts("hivmkuo:d:p:C:z:s:M:P:") or usage();
+sub read_author_info($) {
+	my ($file) = @_;
+	my $user;
+	open my $f, '<', "$file" or die("Failed to open $file: $!\n");
+
+	while (<$f>) {
+		chomp;
+		# Expected format is this;
+		#   exon=Andreas Ericsson <ae@op5.se>
+		if (m/^([^ \t=]*)[ \t=]*([^<]*)(<.*$)\s*/) {
+			$user = $1;
+			$conv_author_name{$1} = $2;
+			$conv_author_email{$1} = $3;
+			# strip trailing whitespace from author name
+			$conv_author_name{$1} =~ s/\s*$//;
+		}
+	}
+	close ($f);
+}
+
+sub write_author_info($) {
+	my ($file) = @_;
+	open my $f, '>', $file or
+	  die("Failed to open $file for writing: $!");
+
+	foreach (keys %conv_author_name) {
+		print $f "$_=" . $conv_author_name{$_} .
+		  " " . $conv_author_email{$_} . "\n";
+	}
+	close ($f);
+}
+
+getopts("hivmkuo:d:p:C:z:s:M:P:A:") or usage();
 usage if $opt_h;
 
 @ARGV <= 1 or usage();
@@ -453,7 +486,7 @@ CVS2GIT_HEAD exists.
 Make sure your working directory corresponds to HEAD and remove CVS2GIT_HEAD.
 You may need to run
 
-    git-read-tree -m -u CVS2GIT_HEAD HEAD
+    git read-tree -m -u CVS2GIT_HEAD HEAD
 EOM
 	}
 	system('cp', "$git_dir/HEAD", "$git_dir/CVS2GIT_HEAD");
@@ -489,6 +522,14 @@ EOM
 -d $git_dir
 	or die "Could not create git subdir ($git_dir).\n";
 
+# now we read (and possibly save) author-info as well
+-f "$git_dir/cvs-authors" and
+  read_author_info("$git_dir/cvs-authors");
+if ($opt_A) {
+	read_author_info($opt_A);
+	write_author_info("$git_dir/cvs-authors");
+}
+
 my $pid = open(CVS,"-|");
 die "Cannot fork: $!\n" unless defined $pid;
 unless($pid) {
@@ -702,6 +743,9 @@ while(<CVS>) {
 		s/\s+$//;
 		if (/^(.*?)\s+<(.*)>/) {
 		    ($author_name, $author_email) = ($1, $2);
+		} elsif ($conv_author_name{$_}) {
+			$author_name = $conv_author_name{$_};
+			$author_email = $conv_author_email{$_};
 		} else {
 		    $author_name = $author_email = $_;
 		}
-- 
1.1.1-g4c34-dirty
