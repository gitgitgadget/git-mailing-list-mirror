X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 4/4] git-svn: re-map repository URLs and UUIDs on SVK mirror paths
Date: Mon, 4 Dec 2006 20:43:41 +1100
Message-ID: <20061204235724.72628139B0E@magnus.utsl.gen.nz>
NNTP-Posting-Date: Mon, 4 Dec 2006 23:57:32 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33266>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrNgh-0005UP-7j for gcvg-git@gmane.org; Tue, 05 Dec
 2006 00:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936111AbWLDX52 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 18:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937190AbWLDX52
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 18:57:28 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:58604 "EHLO
 magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S936111AbWLDX5Z (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 18:57:25 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003) id 72628139B0E;
 Tue,  5 Dec 2006 12:57:24 +1300 (NZDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

If an SVN revision has a property, "svm:headrev", it is likely that
the revision was created by "svk sync".  The property contains a
repository UUID and a revision.  We want to make it look like we are
mirroring the original URL, so introduce a helper function that
returns the original identity trio, and use it when generating commit
messages and dummy e-mail domains.
---
 git-svn.perl |   31 +++++++++++++++++++++++++++----
 1 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 74b04d0..1f72f0d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2076,8 +2076,9 @@ sub git_commit {
 								or croak $!;
 	print $msg_fh $log_msg->{msg} or croak $!;
 	unless ($_no_metadata) {
-		print $msg_fh "\ngit-svn-id: $SVN_URL\@$log_msg->{revision}",
-					" $SVN_UUID\n" or croak $!;
+	    my ($url, $uuid, $rev) = svn_commit_id($log_msg);
+	    print $msg_fh "\ngit-svn-id: $url\@$rev $uuid\n"
+		or croak $!;
 	}
 	$msg_fh->flush == 0 or croak $!;
 	close $msg_fh or croak $!;
@@ -2109,14 +2110,36 @@ sub get_svm_url {
     chomp($SVM_UUID = `git-repo-config --get svn.svkuuid`);
 }
 
+sub svn_commit_id {
+    my $log_msg = shift;
+    my ($url, $uuid, $rev) = ($SVN_URL, $SVN_UUID, $log_msg->{revision});
+    my $svm_headrev = $log_msg->{revprops}{'svm:headrev'};
+    if ( $svm_headrev ) {
+	my ( $_uuid, $_rev) = split /:/, $svm_headrev;
+	chomp($_rev);
+	if ( !$SVM_URL ) {
+	    get_svm_url();
+	}
+	if ( $_uuid ne $SVM_UUID ) {
+	    warn "$uuid:$rev claims to be $_uuid:$_rev, but that's unknown";
+	} else {
+	    ($url, $uuid, $rev) = ($SVM_URL, $SVM_UUID, $_rev);
+	}
+    }
+    ($url, $uuid, $rev);
+}
+
 sub set_commit_env {
 	my ($log_msg) = @_;
 	my $author = $log_msg->{author};
 	if (!defined $author || length $author == 0) {
 		$author = '(no author)';
 	}
-	my ($name,$email) = defined $users{$author} ?  @{$users{$author}}
-				: ($author,"$author\@$SVN_UUID");
+	my ($name,$email) = defined $users{$author} ? @{$users{$author}}
+	    : do {
+		my (undef, $uuid, undef) = svn_commit_id($log_msg);
+		($author,"$author\@$uuid")
+	    };
 	$ENV{GIT_AUTHOR_NAME} = $ENV{GIT_COMMITTER_NAME} = $name;
 	$ENV{GIT_AUTHOR_EMAIL} = $ENV{GIT_COMMITTER_EMAIL} = $email;
 	$ENV{GIT_AUTHOR_DATE} = $ENV{GIT_COMMITTER_DATE} = $log_msg->{date};
-- 
1.4.4.1.ge918e-dirty
