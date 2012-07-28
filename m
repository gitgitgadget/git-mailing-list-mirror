From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 6/8] Add function to append a path to a URL.
Date: Sat, 28 Jul 2012 02:47:50 -0700
Message-ID: <1343468872-72133-7-git-send-email-schwern@pobox.com>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 28 11:49:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv3du-0005QI-Dn
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 11:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172Ab2G1Jsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 05:48:51 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57120 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab2G1JsK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 05:48:10 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so6503035pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Yb2ug3qzGLX6s+5Pz5gfR7TtHuQzHTU3GiPjQiAZM3k=;
        b=xwTN442P5HuCiOM/ziSTpuXo+hBLLdylFjA7EUlulRA8jUkRPOF4q0XQvh0ovrBPIS
         gQ5OOJhgBo5DMWHstD/M78n9XiEmTOYZqm+HeJAGFBb4fnU+U5laknN/IlDHDF1kdHTS
         R35U0jimH7dTMzhYJiWW11T9V5FAffJYxaBtUBib25pdkRsn4WhXZBhY9xBxTPmYnF/4
         Nt7Xtz3AM2JmZLEt6gRBFhfXOejXbS+ux/kvOkcUBpMjCCNEv3X2Uuiet1Uhi5oMowoi
         Yb0DTSIsk9SVmlMN1Y194HBaCKzs+nw566LlnPxImcaAq6Im/lBSorj5vznVP6Or+EP4
         JvPA==
Received: by 10.66.74.3 with SMTP id p3mr11182934pav.49.1343468890177;
        Sat, 28 Jul 2012 02:48:10 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id nv6sm3692274pbc.42.2012.07.28.02.48.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 02:48:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343468872-72133-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202422>

From: "Michael G. Schwern" <schwern@pobox.com>

Remove the ad-hoc versions.

This is mostly to normalize the process and ensure the URLs produced
don't have double slashes or anything.

Also provides a place to fix the corner case where a file path
contains a percent sign.
---
 git-svn.perl                      |  3 ++-
 perl/Git/SVN.pm                   | 33 +++++++++++++++------------------
 perl/Git/SVN/Ra.pm                |  8 ++++----
 perl/Git/SVN/Utils.pm             | 27 +++++++++++++++++++++++++++
 t/Git-SVN/Utils/add_path_to_url.t | 27 +++++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 23 deletions(-)
 create mode 100644 t/Git-SVN/Utils/add_path_to_url.t

diff --git a/git-svn.perl b/git-svn.perl
index 6b90765..3d120d5 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -35,6 +35,7 @@ use Git::SVN::Utils qw(
 	canonicalize_path
 	canonicalize_url
 	join_paths
+	add_path_to_url
 );
 
 use Git qw(
@@ -1436,7 +1437,7 @@ sub cmd_info {
 	# canonicalize_path() will return "" to make libsvn 1.5.x happy,
 	$path = "." if $path eq "";
 
-	my $full_url = canonicalize_url( $url . ($fullpath eq "" ? "" : "/$fullpath") );
+	my $full_url = canonicalize_url( add_path_to_url( $url, $fullpath ) );
 
 	if ($_url) {
 		print "$full_url\n";
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 4219e5b..22bf207 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -29,6 +29,7 @@ use Git::SVN::Utils qw(
 	join_paths
 	canonicalize_path
 	canonicalize_url
+	add_path_to_url
 );
 
 my $can_use_yaml;
@@ -564,8 +565,7 @@ sub _set_svm_vars {
 		# username is of no interest
 		$src =~ s{(^[a-z\+]*://)[^/@]*@}{$1};
 
-		my $replace = $ra->url;
-		$replace .= "/$path" if length $path;
+		my $replace = add_path_to_url($ra->url, $path);
 
 		my $section = "svn-remote.$self->{repo_id}";
 		tmp_config("$section.svm-source", $src);
@@ -582,7 +582,7 @@ sub _set_svm_vars {
 	my $path = $self->path;
 	my %tried;
 	while (length $path) {
-		my $try = $self->url . "/$path";
+		my $try = add_path_to_url($self->url, $path);
 		unless ($tried{$try}) {
 			return $ra if $self->read_svm_props($ra, $path, $r);
 			$tried{$try} = 1;
@@ -591,7 +591,7 @@ sub _set_svm_vars {
 	}
 	die "Path: '$path' should be ''\n" if $path ne '';
 	return $ra if $self->read_svm_props($ra, $path, $r);
-	$tried{$self->url."/$path"} = 1;
+	$tried{ add_path_to_url($self->url, $path) } = 1;
 
 	if ($ra->{repos_root} eq $self->url) {
 		die @err, (map { "  $_\n" } keys %tried), "\n";
@@ -603,7 +603,7 @@ sub _set_svm_vars {
 	$path = $ra->{svn_path};
 	$ra = Git::SVN::Ra->new($ra->{repos_root});
 	while (length $path) {
-		my $try = $ra->url ."/$path";
+		my $try = add_path_to_url($ra->url, $path);
 		unless ($tried{$try}) {
 			$ok = $self->read_svm_props($ra, $path, $r);
 			last if $ok;
@@ -613,7 +613,7 @@ sub _set_svm_vars {
 	}
 	die "Path: '$path' should be ''\n" if $path ne '';
 	$ok ||= $self->read_svm_props($ra, $path, $r);
-	$tried{$ra->url ."/$path"} = 1;
+	$tried{ add_path_to_url($ra->url, $path) } = 1;
 	if (!$ok) {
 		die @err, (map { "  $_\n" } keys %tried), "\n";
 	}
@@ -933,20 +933,19 @@ sub rewrite_uuid {
 
 sub metadata_url {
 	my ($self) = @_;
-	($self->rewrite_root || $self->url) .
-	   (length $self->path ? '/' . $self->path : '');
+	my $url = $self->rewrite_root || $self->url;
+	return add_path_to_url( $url, $self->path );
 }
 
 sub full_url {
 	my ($self) = @_;
-	$self->url . (length $self->path ? '/' . $self->path : '');
+	return add_path_to_url( $self->url, $self->path );
 }
 
 sub full_pushurl {
 	my ($self) = @_;
 	if ($self->{pushurl}) {
-		return $self->{pushurl} . (length $self->path ? '/' .
-		       $self->path : '');
+		return add_path_to_url( $self->{pushurl}, $self->path );
 	} else {
 		return $self->full_url;
 	}
@@ -1114,7 +1113,7 @@ sub find_parent_branch {
 	my $r = $i->{copyfrom_rev};
 	my $repos_root = $self->ra->{repos_root};
 	my $url = $self->ra->url;
-	my $new_url = $url . $branch_from;
+	my $new_url = add_path_to_url( $url, $branch_from );
 	print STDERR  "Found possible branch point: ",
 	              "$new_url => ", $self->full_url, ", $r\n"
 	              unless $::_q > 1;
@@ -1443,12 +1442,11 @@ sub find_extra_svk_parents {
 	for my $ticket ( @tickets ) {
 		my ($uuid, $path, $rev) = split /:/, $ticket;
 		if ( $uuid eq $self->ra_uuid ) {
-			my $url = $self->url;
-			my $repos_root = $url;
+			my $repos_root = $self->url;
 			my $branch_from = $path;
 			$branch_from =~ s{^/}{};
-			my $gs = $self->other_gs($repos_root."/".$branch_from,
-			                         $url,
+			my $gs = $self->other_gs(add_path_to_url( $repos_root, $branch_from ),
+			                         $repos_root,
 			                         $branch_from,
 			                         $rev,
 			                         $self->{ref_id});
@@ -1871,8 +1869,7 @@ sub make_log_entry {
 		$email ||= "$author\@$uuid";
 		$commit_email ||= "$author\@$uuid";
 	} elsif ($self->use_svnsync_props) {
-		my $full_url = $self->svnsync->{url};
-		$full_url .= "/".$self->path if length $self->path;
+		my $full_url = add_path_to_url( $self->svnsync->{url}, $self->path );
 		remove_username($full_url);
 		my $uuid = $self->svnsync->{uuid};
 		$log_entry{metadata} = "$full_url\@$rev $uuid";
diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index eee7c00..788e642 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -5,6 +5,7 @@ use warnings;
 use SVN::Client;
 use Git::SVN::Utils qw(
 	canonicalize_url
+	add_path_to_url
 );
 
 use SVN::Ra;
@@ -289,9 +290,8 @@ sub gs_do_switch {
 	my $path = $gs->path;
 	my $pool = SVN::Pool->new;
 
-	my $full_url = $self->url;
-	my $old_url = $full_url;
-	$full_url .= '/' . $path if length $path;
+	my $old_url = $self->url;
+	my $full_url = add_path_to_url( $self->url, $path );
 	my ($ra, $reparented);
 
 	if ($old_url =~ m#^svn(\+ssh)?://# ||
@@ -557,7 +557,7 @@ sub minimize_url {
 	my @components = split(m!/!, $self->{svn_path});
 	my $c = '';
 	do {
-		$url .= "/$c" if length $c;
+		$url = add_path_to_url($url, $c);
 		eval {
 			my $ra = (ref $self)->new($url);
 			my $latest = $ra->get_latest_revnum;
diff --git a/perl/Git/SVN/Utils.pm b/perl/Git/SVN/Utils.pm
index dab6e4d..3aec207 100644
--- a/perl/Git/SVN/Utils.pm
+++ b/perl/Git/SVN/Utils.pm
@@ -13,6 +13,7 @@ our @EXPORT_OK = qw(
 	canonicalize_path
 	canonicalize_url
 	join_paths
+	add_path_to_url
 );
 
 
@@ -200,4 +201,30 @@ sub join_paths {
 	return $new_path .= "/$last_path";
 }
 
+
+=head3 add_path_to_url
+
+    my $new_url = add_path_to_url($url, $path);
+
+Appends $path onto the $url.  If $path is empty, $url is returned unchanged.
+
+=cut
+
+sub add_path_to_url {
+	my($url, $path) = @_;
+
+	return $url if !defined $path or !length $path;
+
+	# Strip trailing and leading slashes so we don't
+	# wind up with http://x.com///path
+	$url  =~ s{/+$}{};
+	$path =~ s{^/+}{};
+
+	# If a path has a % in it, URI escape it so it's not
+	# mistaken for a URI escape later.
+	$path =~ s{%}{%25}g;
+
+	return join '/', $url, $path;
+}
+
 1;
diff --git a/t/Git-SVN/Utils/add_path_to_url.t b/t/Git-SVN/Utils/add_path_to_url.t
new file mode 100644
index 0000000..bfbd878
--- /dev/null
+++ b/t/Git-SVN/Utils/add_path_to_url.t
@@ -0,0 +1,27 @@
+#!/usr/bin/env perl
+
+use strict;
+use warnings;
+
+use Test::More 'no_plan';
+
+use Git::SVN::Utils qw(
+	add_path_to_url
+);
+
+# A reference cannot be a hash key, so we use an array.
+my @tests = (
+	["http://x.com", "bar"]			=> 'http://x.com/bar',
+	["http://x.com", ""]			=> 'http://x.com',
+	["http://x.com/foo/", undef]		=> 'http://x.com/foo/',
+	["http://x.com/foo/", "/bar/baz/"]	=> 'http://x.com/foo/bar/baz/',
+	["http://x.com", 'per%cent']		=> 'http://x.com/per%25cent',
+);
+
+while(@tests) {
+	my($have, $want) = splice @tests, 0, 2;
+
+	my $args = join ", ", map { qq['$_'] } map { defined($_) ? $_ : 'undef' } @$have;
+	my $name = "add_path_to_url($args) eq $want";
+	is add_path_to_url(@$have), $want, $name;
+}
-- 
1.7.11.3
