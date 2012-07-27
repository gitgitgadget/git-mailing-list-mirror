From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 2/5] Make Git::SVN use an accessor for URLs internally.
Date: Fri, 27 Jul 2012 13:00:49 -0700
Message-ID: <1343419252-9447-3-git-send-email-schwern@pobox.com>
References: <1343419252-9447-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 27 22:01:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Suqj0-0003Oo-JZ
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 22:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab2G0UBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 16:01:19 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52645 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642Ab2G0UBR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 16:01:17 -0400
Received: by yhmm54 with SMTP id m54so3608712yhm.19
        for <git@vger.kernel.org>; Fri, 27 Jul 2012 13:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=yacmY3R1Y6Gbd9hqTnew5UDYpPsny4q/tkG+HF1w7eY=;
        b=SJeOutThZtRcfzRLCpmd3oyteC6B+JUMzKGUj0zNJhh4fXupZMbF5JDBQDX1CwKLR4
         SeqDK1fh9D/842AESe49uHaKhkB1ha0bASTrsj5Cyz09LdO+T8Jk9BiWBo9gBXXCwMuW
         3vb3NUOiJgGdr+twhJQU0GXNekneHxiFkLUotJjbIec00+NguS+UGyFPs4kJpLZ/d4+6
         GrQN2v2evBNCCbOCgv3gGzOdNPiQhQDMgZMpMhIJUz/ANTNGhs4jpEZdlFCn3YoUkKlJ
         az5bv3LnBtc/crl4j+rSHK7ndTBVPWlUEWrj+9azfSZg/qV1xvOCbPEwdN4IuXo+8iMf
         QCpw==
Received: by 10.66.75.162 with SMTP id d2mr7772110paw.59.1343419276650;
        Fri, 27 Jul 2012 13:01:16 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id sk5sm2489907pbc.7.2012.07.27.13.01.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Jul 2012 13:01:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343419252-9447-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202369>

From: "Michael G. Schwern" <schwern@pobox.com>

So later it can do automatic canonicalization.

A later patch will make other things use the accessor.

No functional change here.
---
 perl/Git/SVN.pm | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 0aff9d0..59bca51 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -351,7 +351,7 @@ sub init_remote_config {
 			      "svn-remote.$self->{repo_id}.fetch",
 			      $self->path.":".$self->refname);
 	}
-	$self->{url} = $url;
+	$self->url($url);
 }
 
 sub find_by_url { # repos_root and, path are optional
@@ -453,9 +453,10 @@ sub new {
 		$path =~ s{/\z}{};
 		$self->path($path);
 	}
-	$self->{url} = command_oneline('config', '--get',
-	                               "svn-remote.$repo_id.url") or
+	my $url = command_oneline('config', '--get',
+	                          "svn-remote.$repo_id.url") or
                   die "Failed to read \"svn-remote.$repo_id.url\" in config\n";
+	$self->url($url);
 	$self->{pushurl} = eval { command_oneline('config', '--get',
 	                          "svn-remote.$repo_id.pushurl") };
 	$self->rebuild;
@@ -577,17 +578,18 @@ sub _set_svm_vars {
 	my $path = $self->path;
 	my %tried;
 	while (length $path) {
-		unless ($tried{"$self->{url}/$path"}) {
+		my $try = $self->url . "/$path";
+		unless ($tried{$try}) {
 			return $ra if $self->read_svm_props($ra, $path, $r);
-			$tried{"$self->{url}/$path"} = 1;
+			$tried{$try} = 1;
 		}
 		$path =~ s#/?[^/]+$##;
 	}
 	die "Path: '$path' should be ''\n" if $path ne '';
 	return $ra if $self->read_svm_props($ra, $path, $r);
-	$tried{"$self->{url}/$path"} = 1;
+	$tried{$self->url."/$path"} = 1;
 
-	if ($ra->{repos_root} eq $self->{url}) {
+	if ($ra->{repos_root} eq $self->url) {
 		die @err, (map { "  $_\n" } keys %tried), "\n";
 	}
 
@@ -610,7 +612,7 @@ sub _set_svm_vars {
 	if (!$ok) {
 		die @err, (map { "  $_\n" } keys %tried), "\n";
 	}
-	Git::SVN::Ra->new($self->{url});
+	Git::SVN::Ra->new($self->url);
 }
 
 sub svnsync {
@@ -677,7 +679,7 @@ sub ra_uuid {
 		if (!$@ && $uuid && $uuid =~ /^([a-f\d\-]{30,})$/i) {
 			$self->{ra_uuid} = $uuid;
 		} else {
-			die "ra_uuid called without URL\n" unless $self->{url};
+			die "ra_uuid called without URL\n" unless $self->url;
 			$self->{ra_uuid} = $self->ra->get_uuid;
 			tmp_config('--add', $key, $self->{ra_uuid});
 		}
@@ -701,7 +703,7 @@ sub repos_root {
 
 sub ra {
 	my ($self) = shift;
-	my $ra = Git::SVN::Ra->new($self->{url});
+	my $ra = Git::SVN::Ra->new($self->url);
 	$self->_set_repos_root($ra->{repos_root});
 	if ($self->use_svm_props && !$self->{svm}) {
 		if ($self->no_metadata) {
@@ -926,13 +928,13 @@ sub rewrite_uuid {
 
 sub metadata_url {
 	my ($self) = @_;
-	($self->rewrite_root || $self->{url}) .
+	($self->rewrite_root || $self->url) .
 	   (length $self->path ? '/' . $self->path : '');
 }
 
 sub full_url {
 	my ($self) = @_;
-	$self->{url} . (length $self->path ? '/' . $self->path : '');
+	$self->url . (length $self->path ? '/' . $self->path : '');
 }
 
 sub full_pushurl {
@@ -1436,7 +1438,7 @@ sub find_extra_svk_parents {
 	for my $ticket ( @tickets ) {
 		my ($uuid, $path, $rev) = split /:/, $ticket;
 		if ( $uuid eq $self->ra_uuid ) {
-			my $url = $self->{url};
+			my $url = $self->url;
 			my $repos_root = $url;
 			my $branch_from = $path;
 			$branch_from =~ s{^/}{};
@@ -1682,7 +1684,7 @@ sub find_extra_svn_parents {
 	# are now marked as merge, we can add the tip as a parent.
 	my @merges = split "\n", $mergeinfo;
 	my @merge_tips;
-	my $url = $self->{url};
+	my $url = $self->url;
 	my $uuid = $self->ra_uuid;
 	my %ranges;
 	for my $merge ( @merges ) {
@@ -2307,6 +2309,20 @@ sub path {
     return $self->{path};
 }
 
+
+sub url {
+    my $self = shift;
+
+    if( @_ ) {
+        my $url = shift;
+        $self->{url} = $url;
+        return;
+    }
+
+    return $self->{url};
+}
+
+
 # for read-only access of old .rev_db formats
 sub unlink_rev_db_symlink {
 	my ($self) = @_;
-- 
1.7.11.3
