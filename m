From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] git-svn: add support for pulling author from From: and Signed-off-by:
Date: Thu, 22 Nov 2007 13:44:42 -0000
Message-ID: <1195739082.0@pinky>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 14:44:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvCME-00068e-FU
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 14:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbXKVNoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 08:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbXKVNoX
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 08:44:23 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:2657 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbXKVNoW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 08:44:22 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1IvCLt-0003C0-24
	for git@vger.kernel.org; Thu, 22 Nov 2007 13:44:21 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65823>


Add support for pulling the real author of a commit from the From:
and first Signed-off-by: fields of the SVN commit message.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

---
	This is a feature that git-svnimport had and I have just
	discovered that git-svnimport was deleted some time back
	but due to the install strategy I seem to have an old
	one in there which I was still using; and so had not noticed
	its official removal.  Ouch.

	Perhaps we should install a "gone" stub for things which are
	removed for one release to partly catch this.
---
 git-svn.perl |   36 +++++++++++++++++++++++++++++-------
 1 files changed, 29 insertions(+), 7 deletions(-)
diff --git a/git-svn.perl b/git-svn.perl
index 5b1deea..a99982d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -80,6 +80,7 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'quiet|q' => \$_q,
 		'repack-flags|repack-args|repack-opts=s' =>
 		   \$Git::SVN::_repack_flags,
+		'use-log-author' => \$Git::SVN::_use_log_author,
 		%remote_opts );
 
 my ($_trunk, $_tags, $_branches, $_stdlayout);
@@ -1048,7 +1049,8 @@ use strict;
 use warnings;
 use vars qw/$default_repo_id $default_ref_id $_no_metadata $_follow_parent
             $_repack $_repack_flags $_use_svm_props $_head
-            $_use_svnsync_props $no_reuse_existing $_minimize_url/;
+            $_use_svnsync_props $no_reuse_existing $_minimize_url
+	    $_use_log_author/;
 use Carp qw/croak/;
 use File::Path qw/mkpath/;
 use File::Copy qw/copy/;
@@ -1873,11 +1875,17 @@ sub do_git_commit {
 		croak "$log_entry->{revision} = $c already exists! ",
 		      "Why are we refetching it?\n";
 	}
-	$ENV{GIT_AUTHOR_NAME} = $ENV{GIT_COMMITTER_NAME} = $log_entry->{name};
-	$ENV{GIT_AUTHOR_EMAIL} = $ENV{GIT_COMMITTER_EMAIL} =
-	                                                  $log_entry->{email};
+	$ENV{GIT_AUTHOR_NAME} = $log_entry->{name};
+	$ENV{GIT_AUTHOR_EMAIL} = $log_entry->{email};
 	$ENV{GIT_AUTHOR_DATE} = $ENV{GIT_COMMITTER_DATE} = $log_entry->{date};
 
+	$ENV{GIT_COMMITTER_NAME} = (defined $log_entry->{commit_name})
+						? $log_entry->{commit_name}
+						: $log_entry->{name};
+	$ENV{GIT_COMMITTER_EMAIL} = (defined $log_entry->{commit_email})
+						? $log_entry->{commit_email}
+						: $log_entry->{email};
+
 	my $tree = $log_entry->{tree};
 	if (!defined $tree) {
 		$tree = $self->tmp_index_do(sub {
@@ -2165,7 +2173,16 @@ sub make_log_entry {
 	$log_entry{log} .= "\n";
 	my $author = $log_entry{author} = check_author($log_entry{author});
 	my ($name, $email) = defined $::users{$author} ? @{$::users{$author}}
-	                                               : ($author, undef);
+						       : ($author, undef);
+
+	my ($commit_name, $commit_email) = ($name, $email);
+	if ($_use_log_author) {
+		if ($log_entry{log} =~ /From:\s+(.*?)\s+<(.*)>\s*\n/) {
+			($name, $email) = ($1, $2);
+        	} elsif ($log_entry{log} =~ /Signed-off-by:\s+(.*?)\s+<(.*)>\s*\n/) {
+			($name, $email) = ($1, $2);
+		}
+	}
 	if (defined $headrev && $self->use_svm_props) {
 		if ($self->rewrite_root) {
 			die "Can't have both 'useSvmProps' and 'rewriteRoot' ",
@@ -2188,23 +2205,28 @@ sub make_log_entry {
 		remove_username($full_url);
 		$log_entry{metadata} = "$full_url\@$r $uuid";
 		$log_entry{svm_revision} = $r;
-		$email ||= "$author\@$uuid"
+		$email ||= "$author\@$uuid";
+		$commit_email ||= "$author\@$uuid";
 	} elsif ($self->use_svnsync_props) {
 		my $full_url = $self->svnsync->{url};
 		$full_url .= "/$self->{path}" if length $self->{path};
 		remove_username($full_url);
 		my $uuid = $self->svnsync->{uuid};
 		$log_entry{metadata} = "$full_url\@$rev $uuid";
-		$email ||= "$author\@$uuid"
+		$email ||= "$author\@$uuid";
+		$commit_email ||= "$author\@$uuid";
 	} else {
 		my $url = $self->metadata_url;
 		remove_username($url);
 		$log_entry{metadata} = "$url\@$rev " .
 		                       $self->ra->get_uuid;
 		$email ||= "$author\@" . $self->ra->get_uuid;
+		$commit_email ||= "$author\@" . $self->ra->get_uuid;
 	}
 	$log_entry{name} = $name;
 	$log_entry{email} = $email;
+	$log_entry{commit_name} = $commit_name;
+	$log_entry{commit_email} = $commit_email;
 	\%log_entry;
 }
 
