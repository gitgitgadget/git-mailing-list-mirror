From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 7/9] contrib/git-svn: avoid re-reading the repository uuid, it never changes
Date: Fri, 3 Mar 2006 01:20:09 -0800
Message-ID: <11413776092493-git-send-email-normalperson@yhbt.net>
References: <11413776092820-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 10:20:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FF6Sh-00041U-4o
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 10:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbWCCJUV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 04:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbWCCJUV
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 04:20:21 -0500
Received: from hand.yhbt.net ([66.150.188.102]:1411 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1752209AbWCCJUJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 04:20:09 -0500
Received: from Muzzle (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 78B297DC026;
	Fri,  3 Mar 2006 01:20:09 -0800 (PST)
In-Reply-To: <11413776092820-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17149>

If it does change, we're screwed anyways as SVN will refuse to
commit or update.  We also never access more than one SVN
repository per-invocation, so we can store it as a global, too.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |   27 ++++++++++++---------------
 1 files changed, 12 insertions(+), 15 deletions(-)

3dc689059bd5cffa12bb2b8cdc0f1965d5f6cee2
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 69b6be3..041791b 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -4,7 +4,7 @@
 use warnings;
 use strict;
 use vars qw/	$AUTHOR $VERSION
-		$SVN_URL $SVN_INFO $SVN_WC
+		$SVN_URL $SVN_INFO $SVN_WC $SVN_UUID
 		$GIT_SVN_INDEX $GIT_SVN
 		$GIT_DIR $REV_DIR/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
@@ -114,7 +114,6 @@ sub version {
 
 sub rebuild {
 	$SVN_URL = shift or undef;
-	my $repo_uuid;
 	my $newest_rev = 0;
 	if ($_upgrade) {
 		sys('git-update-ref',"refs/remotes/$GIT_SVN","$GIT_SVN-HEAD");
@@ -150,7 +149,7 @@ sub rebuild {
 
 		# if we merged or otherwise started elsewhere, this is
 		# how we break out of it
-		next if (defined $repo_uuid && ($uuid ne $repo_uuid));
+		next if (defined $SVN_UUID && ($uuid ne $SVN_UUID));
 		next if (defined $SVN_URL && ($url ne $SVN_URL));
 
 		print "r$rev = $c\n";
@@ -159,7 +158,7 @@ sub rebuild {
 				croak "SVN repository location required: $url\n";
 			}
 			$SVN_URL ||= $url;
-			$repo_uuid ||= setup_git_svn();
+			$SVN_UUID ||= setup_git_svn();
 			$latest = $rev;
 		}
 		assert_revision_eq_or_unknown($rev, $c);
@@ -252,7 +251,7 @@ sub commit {
 		print "Reading from stdin...\n";
 		@commits = ();
 		while (<STDIN>) {
-			if (/\b($sha1_short)\b/) {
+			if (/\b($sha1_short)\b/o) {
 				unshift @commits, $1;
 			}
 		}
@@ -320,14 +319,14 @@ sub setup_git_svn {
 	mkpath(["$GIT_DIR/$GIT_SVN/info"]);
 	mkpath([$REV_DIR]);
 	s_to_file($SVN_URL,"$GIT_DIR/$GIT_SVN/info/url");
-	my $uuid = svn_info($SVN_URL)->{'Repository UUID'} or
+	$SVN_UUID = svn_info($SVN_URL)->{'Repository UUID'} or
 					croak "Repository UUID unreadable\n";
-	s_to_file($uuid,"$GIT_DIR/$GIT_SVN/info/uuid");
+	s_to_file($SVN_UUID,"$GIT_DIR/$GIT_SVN/info/uuid");
 
 	open my $fd, '>>', "$GIT_DIR/$GIT_SVN/info/exclude" or croak $!;
 	print $fd '.svn',"\n";
 	close $fd or croak $!;
-	return $uuid;
+	return $SVN_UUID;
 }
 
 sub assert_svn_wc_clean {
@@ -850,9 +849,7 @@ sub git_commit {
 	my ($log_msg, @parents) = @_;
 	assert_revision_unknown($log_msg->{revision});
 	my $out_fh = IO::File->new_tmpfile or croak $!;
-	my $info = svn_info('.');
-	my $uuid = $info->{'Repository UUID'};
-	defined $uuid or croak "Unable to get Repository UUID\n";
+	$SVN_UUID ||= svn_info('.')->{'Repository UUID'};
 
 	map_tree_joins() if (@_branch_from && !%tree_map);
 
@@ -891,11 +888,11 @@ sub git_commit {
 		my $msg_fh = IO::File->new_tmpfile or croak $!;
 		print $msg_fh $log_msg->{msg}, "\ngit-svn-id: ",
 					"$SVN_URL\@$log_msg->{revision}",
-					" $uuid\n" or croak $!;
+					" $SVN_UUID\n" or croak $!;
 		$msg_fh->flush == 0 or croak $!;
 		seek $msg_fh, 0, 0 or croak $!;
 
-		set_commit_env($log_msg, $uuid);
+		set_commit_env($log_msg);
 
 		my @exec = ('git-commit-tree',$tree);
 		push @exec, '-p', $_  foreach @exec_parents;
@@ -923,10 +920,10 @@ sub git_commit {
 }
 
 sub set_commit_env {
-	my ($log_msg, $uuid) = @_;
+	my ($log_msg) = @_;
 	my $author = $log_msg->{author};
 	my ($name,$email) = defined $users{$author} ?  @{$users{$author}}
-				: ($author,"$author\@$uuid");
+				: ($author,"$author\@$SVN_UUID");
 	$ENV{GIT_AUTHOR_NAME} = $ENV{GIT_COMMITTER_NAME} = $name;
 	$ENV{GIT_AUTHOR_EMAIL} = $ENV{GIT_COMMITTER_EMAIL} = $email;
 	$ENV{GIT_AUTHOR_DATE} = $ENV{GIT_COMMITTER_DATE} = $log_msg->{date};
-- 
1.2.3.g4676
