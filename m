From: Sam Vilain <sam@vilain.net>
Subject: [PATCH] git-svn: re-map repository URLs and UUIDs on SVK mirror paths
Date: Sun, 11 Feb 2007 12:34:45 +1300
Message-ID: <20070210233750.A333013A384@magnus.utsl.gen.nz>
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Feb 11 00:38:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HG1n3-0006Eg-RF
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 00:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbXBJXhw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 18:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbXBJXhw
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 18:37:52 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:47626 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbXBJXhv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 18:37:51 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003)
	id A333013A384; Sun, 11 Feb 2007 12:37:50 +1300 (NZDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39264>

If an SVN revision has a property, "svm:headrev", it is likely that
the revision was created by SVN::Mirror (a part of SVK).  The property
contains a repository UUID and a revision.  We want to make it look
like we are mirroring the original URL, so introduce a helper function
that returns the original identity URL and UUID, and use it when
generating commit messages.
---
 git-svn.perl |   39 +++++++++++++++++++++++++++++++++------
 1 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 59d9faf..5b0d8b7 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1055,10 +1055,23 @@ sub do_git_commit {
 	defined(my $pid = open3(my $msg_fh, my $out_fh, '>&STDERR', @exec))
 	                                                           or croak $!;
 	print $msg_fh $log_entry->{log} or croak $!;
+	my $at = "";
 	unless ($_no_metadata) {
-		print $msg_fh "\ngit-svn-id: ", $self->full_url, '@',
-		              $log_entry->{revision}, ' ',
-		              $self->ra->uuid, "\n" or croak $!;
+		my $full_url = $self->full_url;
+		my $revision = $log_entry->{revision};
+		my $uuid = $self->ra->uuid;
+		my $repo_id = $Git::SVN::default_repo_id;
+		$DB::single = 1;
+		if ( $log_entry->{headrev} ) {
+			my ($from_uuid, $rev) = $log_entry->{headrev} =~ m{^([a-f0-9\-]{30,}):(\d+)$};
+			($full_url, $uuid) = get_svm_url( $repo_id, $full_url, $uuid );
+			die "UUID mismatch on SVM path : $uuid vs $from_uuid"
+				if $from_uuid ne $uuid;
+			$revision = $rev;
+			$at = " (\@$rev)";
+		}
+		print $msg_fh "\ngit-svn-id: ", $full_url, '@',
+		              $revision, ' ', $uuid, "\n" or croak $!;
 	}
 	$msg_fh->flush == 0 or croak $!;
 	close $msg_fh or croak $!;
@@ -1074,7 +1087,7 @@ sub do_git_commit {
 
 	$self->{last_rev} = $log_entry->{revision};
 	$self->{last_commit} = $commit;
-	print "r$log_entry->{revision} = $commit ($self->{ref_id})\n";
+	print "r$log_entry->{revision}$at = $commit ($self->{ref_id})\n";
 	if (defined $_repack && (--$_repack_nr == 0)) {
 		$_repack_nr = $_repack;
 		# repack doesn't use any arguments with spaces in them, does it?
@@ -1284,8 +1297,9 @@ sub make_log_entry {
 	my $rp = $self->ra->rev_proplist($rev);
 	foreach (sort keys %$rp) {
 		my $v = $rp->{$_};
-		if (/^svn:(author|date|log)$/) {
-			$log_entry{$1} = $v;
+		$DB::single = 1 if /svm:/;
+		if (/^(?:svn:(author|date|log)|svm:(headrev))$/) {
+			$log_entry{$1||$2} = $v;
 		} else {
 			print $un "  rev_prop: ", uri_encode($_), ' ',
 		                  uri_encode($v), "\n";
@@ -1492,6 +1506,19 @@ sub uri_encode {
 	$f
 }
 
+our %svm_urls;
+sub get_svm_url {
+	my ($repo_id, $url, $uuid) = @_;
+	my $spec = $url.":".$uuid;
+	if (!exists $svm_urls{$spec}) {
+		my $source = `git-repo-config --get svn-remote.$repo_id.source`;
+		my $svmuuid = `git-repo-config --get svn-remote.$repo_id.uuid`;
+		chomp for ($source, $svmuuid);
+		$svm_urls{$spec}=[$source,$svmuuid];
+	}
+	($url,$uuid) = @{$svm_urls{$spec}};
+}
+
 package Git::SVN::Prompt;
 use strict;
 use warnings;
-- 
1.5.0.rc3.g3e023
