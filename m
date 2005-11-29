From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] SVN import: Use one log call
Date: Tue, 29 Nov 2005 08:13:04 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.29.07.13.02.145977@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Nov 29 10:17:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh0nV-00063r-JW
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 09:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVK2IYo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 03:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbVK2IYo
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 03:24:44 -0500
Received: from main.gmane.org ([80.91.229.2]:12468 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750906AbVK2IYn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 03:24:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Eh07p-0005Xk-DG
	for git@vger.kernel.org; Tue, 29 Nov 2005 08:42:06 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Nov 2005 08:42:05 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Nov 2005 08:42:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12932>

One "svn log" (or its equivalent) per revision adds delay and server load.
Instead, open two SVN connections -- one for the log, and one for the files.

Positive side effect: Only those log entries which actually contain data
are committed => no more empty commits.

Also, change the "-l" option to set the maximum revision to be pulled,
not the number of revisions.

---

... or pull from http://netz.smurf.noris.de/git/git.git#svnup.

 Documentation/git-svnimport.txt |   15 ++++++---------
 git-svnimport.perl              |   37 ++++++++++++++++---------------------
 2 files changed, 22 insertions(+), 30 deletions(-)

applies-to: 744acb3ef516240503d9a13cf1adb6a9670f905e
81da2a98762ef4965e6410c1c83600f2d80dc67a
diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimport.txt
index fcc79fa..f8dbee7 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -10,7 +10,7 @@ git-svnimport - Import a SVN repository 
 SYNOPSIS
 --------
 'git-svnimport' [ -o <branch-for-HEAD> ] [ -h ] [ -v ] [ -d | -D ]
-			[ -C <GIT_repository> ] [ -i ] [ -u ] [-l limit_nr_changes]
+			[ -C <GIT_repository> ] [ -i ] [ -u ] [-l limit_rev]
 			[ -b branch_subdir ] [ -t trunk_subdir ] [ -T tag_subdir ]
 			[ -s start_chg ] [ -m ] [ -M regex ]
 			<SVN_repository_URL> [ <path> ]
@@ -71,14 +71,11 @@ When importing incementally, you might n
 	regex. It can be used with -m to also see the default regexes.
 	You must escape forward slashes.
 
--l <max_num_changes>::
-	Limit the number of SVN changesets we pull before quitting.
-	This option is necessary because the SVN library has serious memory
-	leaks; the recommended value for nontrivial imports is 100.
-
-	git-svnimport will still exit with a zero exit code. You can check
-	the size of the file ".git/svn2git" to determine whether to call
-	the importer again.
+-l <max_rev>::
+	Specify a maximum revision number to pull.
+
+	Formerly, this option controlled how many revisions to pull, due to
+	SVN memory leaks. (These have been worked around.)
 
 -v::
 	Verbosity: let 'svnimport' report what it is doing.
diff --git a/git-svnimport.perl b/git-svnimport.perl
index af13fdd..640d675 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -35,7 +35,7 @@ our($opt_h,$opt_o,$opt_v,$opt_u,$opt_C,$
 sub usage() {
 	print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from SVN
-       [-o branch-for-HEAD] [-h] [-v] [-l max_num_changes]
+       [-o branch-for-HEAD] [-h] [-v] [-l max_rev]
        [-C GIT_repository] [-t tagname] [-T trunkname] [-b branchname]
        [-d|-D] [-i] [-u] [-s start_chg] [-m] [-M regex] [SVN_URL]
 END
@@ -126,8 +126,9 @@ sub file {
 package main;
 use URI;
 
-my $svn = $svn_url;
+our $svn = $svn_url;
 $svn .= "/$svn_dir" if defined $svn_dir;
+my $svn2 = SVNconn->new($svn);
 $svn = SVNconn->new($svn);
 
 my $lwp_ua;
@@ -198,7 +199,7 @@ $ENV{GIT_INDEX_FILE} = $git_index;
 my $maxnum = 0;
 my $last_rev = "";
 my $last_branch;
-my $current_rev = $opt_s-1;
+my $current_rev = $opt_s || 1;
 unless(-d $git_dir) {
 	system("git-init-db");
 	die "Cannot init the GIT db at $git_tree: $?\n" if $?;
@@ -250,7 +251,7 @@ EOM
 		my($num,$branch,$ref) = split;
 		$branches{$branch}{$num} = $ref;
 		$branches{$branch}{"LAST"} = $ref;
-		$current_rev = $num if $current_rev < $num;
+		$current_rev = $num+1 if $current_rev <= $num;
 	}
 	close($B);
 }
@@ -704,17 +705,17 @@ sub commit {
 	print "DONE: $revision $dest $cid\n" if $opt_v;
 }
 
-my ($changed_paths, $revision, $author, $date, $message, $pool) = @_;
-sub _commit_all {
-	($changed_paths, $revision, $author, $date, $message, $pool) = @_;
+sub commit_all {
+	# Recursive use of the SVN connection does not work
+	local $svn = $svn2;
+
+	my ($changed_paths, $revision, $author, $date, $message, $pool) = @_;
 	my %p;
 	while(my($path,$action) = each %$changed_paths) {
 		$p{$path} = [ $action->action,$action->copyfrom_path, $action->copyfrom_rev, $path ];
 	}
 	$changed_paths = \%p;
-}
 
-sub commit_all {
 	my %done;
 	my @col;
 	my $pref;
@@ -730,18 +731,12 @@ sub commit_all {
 	}
 }
 
-while(++$current_rev <= $svn->{'maxrev'}) {
-	if (defined $opt_l) {
-		$opt_l--;
-		if ($opt_l < 0) {
-			last;
-		}
-	}
-	my $pool=SVN::Pool->new;
-	$svn->{'svn'}->get_log("/",$current_rev,$current_rev,1,1,1,\&_commit_all,$pool);
-	$pool->clear;
-	commit_all();
-}
+$opt_l = $svn->{'maxrev'} if not defined $opt_l or $opt_l > $svn->{'maxrev'};
+print "Fetching from $current_rev to $opt_l ...\n" if $opt_v;
+
+my $pool=SVN::Pool->new;
+$svn->{'svn'}->get_log("/",$current_rev,$opt_l,0,1,1,\&commit_all,$pool);
+$pool->clear;
 
 
 unlink($git_index);
---


-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
There was a young peasant named Gorse Who fell madly in love with his horse.
Said his wife, "You rapscallion, That horse is a stallion -- This constitutes
grounds for divorce."
