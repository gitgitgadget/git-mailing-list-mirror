From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] contrib/git-svn: fix UUID reading w/pre-1.2 svn; fetch args
Date: Tue, 7 Mar 2006 17:57:30 -0800
Message-ID: <20060308015730.GA28056@localdomain>
References: <20060307220837.GB27397@nowhere.earth> <20060308014207.GA31137@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 08 02:58:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGnwY-0006UY-IX
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 02:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWCHB6R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 20:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWCHB6R
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 20:58:17 -0500
Received: from hand.yhbt.net ([66.150.188.102]:57521 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S964847AbWCHB6Q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 20:58:16 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 469912DC033;
	Tue,  7 Mar 2006 17:58:14 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue,  7 Mar 2006 17:57:30 -0800
To: Yann Dirson <ydirson@altern.org>
Content-Disposition: inline
In-Reply-To: <20060308014207.GA31137@localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17360>

Junio: please don't apply this patch to git.git just yet.  It seems fine
to me, but I haven't tested it heavily yet (Yann can help me, I hope :)
I hardly slept the past few days and I may have broken something badly
(it pasts all the tests, though).

---

As a side effect, this should also work better for 'init' off
directories that are no longer in the latest revision of the
repository.

Fix 'fetch' args (<rev>=<commit> options) on brand-new heads

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

9f59596bde5bdd68d1a0a116f7383df74966de44
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index c575883..b8d2b3e 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -162,7 +162,8 @@ sub rebuild {
 				croak "SVN repository location required: $url\n";
 			}
 			$SVN_URL ||= $url;
-			$SVN_UUID ||= setup_git_svn();
+			$SVN_UUID ||= $uuid;
+			setup_git_svn();
 			$latest = $rev;
 		}
 		assert_revision_eq_or_unknown($rev, $c);
@@ -226,10 +227,12 @@ sub fetch {
 		push @svn_co,'--ignore-externals' unless $_no_ignore_ext;
 		sys(@svn_co, $SVN_URL, $SVN_WC);
 		chdir $SVN_WC or croak $!;
+		read_uuid();
 		$last_commit = git_commit($base, @parents);
 		assert_svn_wc_clean($base->{revision}, $last_commit);
 	} else {
 		chdir $SVN_WC or croak $!;
+		read_uuid();
 		$last_commit = file_to_s("$REV_DIR/$base->{revision}");
 	}
 	my @svn_up = qw(svn up);
@@ -275,7 +278,9 @@ sub commit {
 
 	fetch();
 	chdir $SVN_WC or croak $!;
-	my $svn_current_rev =  svn_info('.')->{'Last Changed Rev'};
+	my $info = svn_info('.');
+	read_uuid($info);
+	my $svn_current_rev =  $info->{'Last Changed Rev'};
 	foreach my $c (@revs) {
 		my $mods = svn_checkout_tree($svn_current_rev, $c);
 		if (scalar @$mods == 0) {
@@ -314,6 +319,14 @@ sub show_ignore {
 
 ########################### utility functions #########################
 
+sub read_uuid {
+	return if $SVN_UUID;
+	my $info = shift || svn_info('.');
+	$SVN_UUID = $info->{'Repository UUID'} or
+					croak "Repository UUID unreadable\n";
+	s_to_file($SVN_UUID,"$GIT_DIR/$GIT_SVN/info/uuid");
+}
+
 sub setup_git_svn {
 	defined $SVN_URL or croak "SVN repository location required\n";
 	unless (-d $GIT_DIR) {
@@ -323,14 +336,10 @@ sub setup_git_svn {
 	mkpath(["$GIT_DIR/$GIT_SVN/info"]);
 	mkpath([$REV_DIR]);
 	s_to_file($SVN_URL,"$GIT_DIR/$GIT_SVN/info/url");
-	$SVN_UUID = svn_info($SVN_URL)->{'Repository UUID'} or
-					croak "Repository UUID unreadable\n";
-	s_to_file($SVN_UUID,"$GIT_DIR/$GIT_SVN/info/uuid");
 
 	open my $fd, '>>', "$GIT_DIR/$GIT_SVN/info/exclude" or croak $!;
 	print $fd '.svn',"\n";
 	close $fd or croak $!;
-	return $SVN_UUID;
 }
 
 sub assert_svn_wc_clean {
@@ -860,7 +869,6 @@ sub git_commit {
 	my ($log_msg, @parents) = @_;
 	assert_revision_unknown($log_msg->{revision});
 	my $out_fh = IO::File->new_tmpfile or croak $!;
-	$SVN_UUID ||= svn_info('.')->{'Repository UUID'};
 
 	map_tree_joins() if (@_branch_from && !%tree_map);
 
@@ -922,7 +930,9 @@ sub git_commit {
 	}
 	my @update_ref = ('git-update-ref',"refs/remotes/$GIT_SVN",$commit);
 	if (my $primary_parent = shift @exec_parents) {
-		push @update_ref, $primary_parent;
+		if (!system('git-rev-parse',"refs/remotes/$GIT_SVN")){
+			push @update_ref, $primary_parent;
+		}
 	}
 	sys(@update_ref);
 	sys('git-update-ref',"$GIT_SVN/revs/$log_msg->{revision}",$commit);
-- 
1.2.4.g198d
