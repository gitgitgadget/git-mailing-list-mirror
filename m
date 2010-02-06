From: Aaron Crane <git@aaroncrane.co.uk>
Subject: [PATCH v2] cvsimport: new -R option: generate .git/cvs-revisions 
	mapping
Date: Sat, 6 Feb 2010 18:26:24 +0000
Message-ID: <bc341e101002061026t2e7fa4cfte9119bf7fc2d2ddc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 06 19:26:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdpMk-0002GK-Go
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 19:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755947Ab0BFS0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 13:26:41 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:36616 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755617Ab0BFS0k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 13:26:40 -0500
Received: by mail-ew0-f228.google.com with SMTP id 28so1140801ewy.28
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 10:26:39 -0800 (PST)
Received: by 10.216.89.135 with SMTP id c7mr169400wef.62.1265480799169; Sat, 
	06 Feb 2010 10:26:39 -0800 (PST)
X-Originating-IP: [87.194.157.167]
X-Google-Sender-Auth: a7509dfe5952bd09
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139182>

This option causes the creation or updating of a file mapping CVS
(filename, revision number) pairs to Git commit IDs.  This is expected
to be useful if you have CVS revision numbers stored in commit messages,
bug-tracking systems, email archives, and the like.

Signed-off-by: Aaron Crane <git@aaroncrane.co.uk>
---
See also the thread beginning at
http://thread.gmane.org/gmane.comp.version-control.git/138079

Thanks to Peff for his review at
http://article.gmane.org/gmane.comp.version-control.git/138544

I believe this revised patch takes account of all his comments.  In
particular, compared to the previous version:

- Tests are included
- Now works with incremental import
- The file is always generated as .git/cvs-revisions, rather than
  letting the user pick the name

 Documentation/git-cvsimport.txt |   18 +++++++++++++++++-
 git-cvsimport.perl              |   21 +++++++++++++++++----
 t/t9600-cvsimport.sh            |   36 +++++++++++++++++++++++++++++++++---
 3 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index ddfcb3d..8bcd875 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	      [-A <author-conv-file>] [-p <options-for-cvsps>] [-P <file>]
 	      [-C <git_repository>] [-z <fuzz>] [-i] [-k] [-u] [-s <subst>]
 	      [-a] [-m] [-M <regex>] [-S <regex>] [-L <commitlimit>]
-	      [-r <remote>] [<CVS_module>]
+	      [-r <remote>] [-R] [<CVS_module>]


 DESCRIPTION
@@ -157,6 +157,22 @@ It is not recommended to use this feature if you intend to
 export changes back to CVS again later with
 'git cvsexportcommit'.

+-R::
+	Generate a `$GIT_DIR/cvs-revisions` file containing a mapping from CVS
+	revision numbers to newly-created Git commit IDs.  The generated file
+	will contain one line for each (filename, revision) pair imported;
+	each line will look like
++
+---------
+src/widget.c 1.1 1d862f173cdc7325b6fa6d2ae1cfd61fd1b512b7
+---------
++
+The revision data is appended to the file if it already exists, for use when
+doing incremental imports.
++
+This option may be useful if you have CVS revision numbers stored in commit
+messages, bug-tracking systems, email archives, and the like.
+
 -h::
 	Print a short usage message and exit.

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 4853bf7..9e03eee 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -29,7 +29,7 @@ use IPC::Open2;
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";

-our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P,
$opt_s,$opt_m,@opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r);
+our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P,
$opt_s,$opt_m,@opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r, $opt_R);
 my (%conv_author_name, %conv_author_email);

 sub usage(;$) {
@@ -40,7 +40,7 @@ Usage: git cvsimport     # fetch/update GIT from CVS
        [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT] [-A author-conv-file]
        [-p opts-for-cvsps] [-P file] [-C GIT_repository] [-z fuzz] [-i] [-k]
        [-u] [-s subst] [-a] [-m] [-M regex] [-S regex] [-L commitlimit]
-       [-r remote] [CVS_module]
+       [-r remote] [-R] [CVS_module]
 END
 	exit(1);
 }
@@ -110,7 +110,7 @@ sub read_repo_config {
 	}
 }

-my $opts = "haivmkuo:d:p:r:C:z:s:M:P:A:S:L:";
+my $opts = "haivmkuo:d:p:r:C:z:s:M:P:A:S:L:R";
 read_repo_config($opts);
 Getopt::Long::Configure( 'no_ignore_case', 'bundling' );

@@ -659,6 +659,11 @@ if ($opt_A) {
 	write_author_info("$git_dir/cvs-authors");
 }

+# open .git/cvs-revisions, if requested
+open my $revision_map, '>>', "$git_dir/cvs-revisions"
+    or die "Can't open $git_dir/cvs-revisions for appending: $!\n"
+	if defined $opt_R;
+

 #
 # run cvsps into a file unless we are getting
@@ -742,7 +747,7 @@ sub write_tree () {
 }

 my ($patchset,$date,$author_name,$author_email,$branch,$ancestor,$tag,$logmsg);
-my (@old,@new,@skipped,%ignorebranch);
+my (@old,@new,@skipped,%ignorebranch,@commit_revisions);

 # commits that cvsps cannot place anywhere...
 $ignorebranch{'#CVSPS_NO_BRANCH'} = 1;
@@ -825,6 +830,11 @@ sub commit {
 	system('git' , 'update-ref', "$remote/$branch", $cid) == 0
 		or die "Cannot write branch $branch for update: $!\n";

+	if ($revision_map) {
+		print $revision_map "@$_ $cid\n" for @commit_revisions;
+	}
+	@commit_revisions = ();
+
 	if ($tag) {
 	        my ($xtag) = $tag;
 		$xtag =~ s/\s+\*\*.*$//; # Remove stuff like ** INVALID ** and ** FUNKY **
@@ -959,6 +969,7 @@ while (<CVS>) {
 		    push(@skipped, $fn);
 		    next;
 		}
+		push @commit_revisions, [$fn, $rev];
 		print "Fetching $fn   v $rev\n" if $opt_v;
 		my ($tmpname, $size) = $cvs->file($fn,$rev);
 		if ($size == -1) {
@@ -981,7 +992,9 @@ while (<CVS>) {
 		unlink($tmpname);
 	} elsif ($state == 9 and
/^\s+(.+?):\d+(?:\.\d+)+->(\d+(?:\.\d+)+)\(DEAD\)\s*$/) {
 		my $fn = $1;
+		my $rev = $2;
 		$fn =~ s#^/+##;
+		push @commit_revisions, [$fn, $rev];
 		push(@old,$fn);
 		print "Delete $fn\n" if $opt_v;
 	} elsif ($state == 9 and /^\s*$/) {
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 363345f..b572ce3 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -47,13 +47,20 @@ EOF

 test_expect_success 'import a trivial module' '

-	git cvsimport -a -z 0 -C module-git module &&
+	git cvsimport -a -R -z 0 -C module-git module &&
 	test_cmp module-cvs/o_fortuna module-git/o_fortuna

 '

 test_expect_success 'pack refs' 'cd module-git && git gc && cd ..'

+test_expect_success 'initial import has correct .git/cvs-revisions' '
+
+	(cd module-git &&
+	 git log --format="o_fortuna 1.1 %H" -1) > expected &&
+	test_cmp expected module-git/.git/cvs-revisions
+'
+
 test_expect_success 'update cvs module' '

 	cd module-cvs &&
@@ -86,13 +93,21 @@ EOF
 test_expect_success 'update git module' '

 	cd module-git &&
-	git cvsimport -a -z 0 module &&
+	git cvsimport -a -R -z 0 module &&
 	git merge origin &&
 	cd .. &&
 	test_cmp module-cvs/o_fortuna module-git/o_fortuna

 '

+test_expect_success 'update has correct .git/cvs-revisions' '
+
+	(cd module-git &&
+	 git log --format="o_fortuna 1.1 %H" -1 HEAD^ &&
+	 git log --format="o_fortuna 1.2 %H" -1 HEAD) > expected &&
+	test_cmp expected module-git/.git/cvs-revisions
+'
+
 test_expect_success 'update cvs module' '

 	cd module-cvs &&
@@ -107,13 +122,22 @@ test_expect_success 'cvsimport.module config works' '

 	cd module-git &&
 		git config cvsimport.module module &&
-		git cvsimport -a -z0 &&
+		git cvsimport -a -R -z0 &&
 		git merge origin &&
 	cd .. &&
 	test_cmp module-cvs/tick module-git/tick

 '

+test_expect_success 'second update has correct .git/cvs-revisions' '
+
+	(cd module-git &&
+	 git log --format="o_fortuna 1.1 %H" -1 HEAD^^ &&
+	 git log --format="o_fortuna 1.2 %H" -1 HEAD^
+	 git log --format="tick 1.1 %H" -1 HEAD) > expected &&
+	test_cmp expected module-git/.git/cvs-revisions
+'
+
 test_expect_success 'import from a CVS working tree' '

 	$CVS co -d import-from-wt module &&
@@ -126,6 +150,12 @@ test_expect_success 'import from a CVS working tree' '

 '

+test_expect_success 'no .git/cvs-revisions created by default' '
+
+	! test -e import-from-wt/.git/cvs-revisions
+
+'
+
 test_expect_success 'test entire HEAD' 'test_cmp_branch_tree master'

 test_done
-- 
1.6.6.1
