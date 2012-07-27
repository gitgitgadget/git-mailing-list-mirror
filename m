From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 1/5] Make Git::SVN use accessors internally for path.
Date: Fri, 27 Jul 2012 13:00:48 -0700
Message-ID: <1343419252-9447-2-git-send-email-schwern@pobox.com>
References: <1343419252-9447-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 27 22:01:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuqjC-0003Yv-OT
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 22:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686Ab2G0UBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 16:01:18 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:51730 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab2G0UBP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 16:01:15 -0400
Received: by ghrr11 with SMTP id r11so3624617ghr.19
        for <git@vger.kernel.org>; Fri, 27 Jul 2012 13:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=9zYU1f965QEjw6B70spgf0Mek6MGEng9bPTLbEzFhNo=;
        b=BlrD8o85dXZiO6qQ65I4tQyLyGB85lSFqXPKvcZrmJov0iNvlq1/P3csNH8mZxFFAR
         jaZP74EuLbph4l7wYU05AjQn7GXvgpifhHw9tkarmWzvTpPQdAW6mJc4wycdGfnoKr+H
         nASNIiX/Yo0F2l3NUJr73Hl0TxayuNkpkB2dhf4udmP0AtsnADbRP8YzXPM/18BAWePJ
         NALs63Ix9RPhWeqA+/i2sE7TzAJ+wkzuwQDs9IawLLWSKNaRLiOIVeNjkJCvnUAy5IrM
         tSiP8xG1hpMo0n4HoOA7pE1eea3UOsIQE+CCMt8m821A/FkdWoBlA7Coyq8v5QCgbKId
         FpAg==
Received: by 10.66.73.133 with SMTP id l5mr7692862pav.74.1343419274550;
        Fri, 27 Jul 2012 13:01:14 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id sk5sm2489907pbc.7.2012.07.27.13.01.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Jul 2012 13:01:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343419252-9447-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202372>

From: "Michael G. Schwern" <schwern@pobox.com>

Then later it can be canonicalized automatically rather than everywhere
its used.

Later patch will make other things use it.
---
 perl/Git/SVN.pm | 87 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 31 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index b8b3474..0aff9d0 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -314,12 +314,12 @@ sub init_remote_config {
 				print STDERR "Using higher level of URL: ",
 					     "$url => $min_url\n";
 			}
-			my $old_path = $self->{path};
-			$self->{path} = $url;
-			$self->{path} =~ s!^\Q$min_url\E(/|$)!!;
+			my $old_path = $self->path;
+			$url =~ s!^\Q$min_url\E(/|$)!!;
 			if (length $old_path) {
-				$self->{path} .= "/$old_path";
+				$url .= "/$old_path";
 			}
+			$self->path($url);
 			$url = $min_url;
 		}
 	}
@@ -343,11 +343,13 @@ sub init_remote_config {
 	unless ($no_write) {
 		command_noisy('config',
 			      "svn-remote.$self->{repo_id}.url", $url);
-		$self->{path} =~ s{^/}{};
-		$self->{path} =~ s{%([0-9A-F]{2})}{chr hex($1)}ieg;
+		my $path = $self->path;
+		$path =~ s{^/}{};
+		$path =~ s{%([0-9A-F]{2})}{chr hex($1)}ieg;
+		$self->path($path);
 		command_noisy('config', '--add',
 			      "svn-remote.$self->{repo_id}.fetch",
-			      "$self->{path}:".$self->refname);
+			      $self->path.":".$self->refname);
 	}
 	$self->{url} = $url;
 }
@@ -435,17 +437,22 @@ sub new {
 		}
 	}
 	my $self = _new($class, $repo_id, $ref_id, $path);
-	if (!defined $self->{path} || !length $self->{path}) {
+	if (!defined $self->path || !length $self->path) {
 		my $fetch = command_oneline('config', '--get',
 		                            "svn-remote.$repo_id.fetch",
 		                            ":$ref_id\$") or
 		     die "Failed to read \"svn-remote.$repo_id.fetch\" ",
 		         "\":$ref_id\$\" in config\n";
-		($self->{path}, undef) = split(/\s*:\s*/, $fetch);
+		my($path) = split(/\s*:\s*/, $fetch);
+		$self->path($path);
+	}
+	{
+		my $path = $self->path;
+		$path =~ s{/+}{/}g;
+		$path =~ s{\A/}{};
+		$path =~ s{/\z}{};
+		$self->path($path);
 	}
-	$self->{path} =~ s{/+}{/}g;
-	$self->{path} =~ s{\A/}{};
-	$self->{path} =~ s{/\z}{};
 	$self->{url} = command_oneline('config', '--get',
 	                               "svn-remote.$repo_id.url") or
                   die "Failed to read \"svn-remote.$repo_id.url\" in config\n";
@@ -567,7 +574,7 @@ sub _set_svm_vars {
 	}
 
 	my $r = $ra->get_latest_revnum;
-	my $path = $self->{path};
+	my $path = $self->path;
 	my %tried;
 	while (length $path) {
 		unless ($tried{"$self->{url}/$path"}) {
@@ -728,7 +735,7 @@ sub prop_walk {
 	$path =~ s#^/*#/#g;
 	my $p = $path;
 	# Strip the irrelevant part of the path.
-	$p =~ s#^/+\Q$self->{path}\E(/|$)#/#;
+	$p =~ s#^/+\Q@{[$self->path]}\E(/|$)#/#;
 	# Ensure the path is terminated by a `/'.
 	$p =~ s#/*$#/#;
 
@@ -749,7 +756,7 @@ sub prop_walk {
 
 	foreach (sort keys %$dirent) {
 		next if $dirent->{$_}->{kind} != $SVN::Node::dir;
-		$self->prop_walk($self->{path} . $p . $_, $rev, $sub);
+		$self->prop_walk($self->path . $p . $_, $rev, $sub);
 	}
 }
 
@@ -920,19 +927,19 @@ sub rewrite_uuid {
 sub metadata_url {
 	my ($self) = @_;
 	($self->rewrite_root || $self->{url}) .
-	   (length $self->{path} ? '/' . $self->{path} : '');
+	   (length $self->path ? '/' . $self->path : '');
 }
 
 sub full_url {
 	my ($self) = @_;
-	$self->{url} . (length $self->{path} ? '/' . $self->{path} : '');
+	$self->{url} . (length $self->path ? '/' . $self->path : '');
 }
 
 sub full_pushurl {
 	my ($self) = @_;
 	if ($self->{pushurl}) {
-		return $self->{pushurl} . (length $self->{path} ? '/' .
-		       $self->{path} : '');
+		return $self->{pushurl} . (length $self->path ? '/' .
+		       $self->path : '');
 	} else {
 		return $self->full_url;
 	}
@@ -1048,20 +1055,20 @@ sub do_git_commit {
 
 sub match_paths {
 	my ($self, $paths, $r) = @_;
-	return 1 if $self->{path} eq '';
-	if (my $path = $paths->{"/$self->{path}"}) {
+	return 1 if $self->path eq '';
+	if (my $path = $paths->{"/".$self->path}) {
 		return ($path->{action} eq 'D') ? 0 : 1;
 	}
-	$self->{path_regex} ||= qr/^\/\Q$self->{path}\E\//;
+	$self->{path_regex} ||= qr{^/\Q@{[$self->path]}\E/};
 	if (grep /$self->{path_regex}/, keys %$paths) {
 		return 1;
 	}
 	my $c = '';
-	foreach (split m#/#, $self->{path}) {
+	foreach (split m#/#, $self->path) {
 		$c .= "/$_";
 		next unless ($paths->{$c} &&
 		             ($paths->{$c}->{action} =~ /^[AR]$/));
-		if ($self->ra->check_path($self->{path}, $r) ==
+		if ($self->ra->check_path($self->path, $r) ==
 		    $SVN::Node::dir) {
 			return 1;
 		}
@@ -1075,14 +1082,14 @@ sub find_parent_branch {
 	unless (defined $paths) {
 		my $err_handler = $SVN::Error::handler;
 		$SVN::Error::handler = \&Git::SVN::Ra::skip_unknown_revs;
-		$self->ra->get_log([$self->{path}], $rev, $rev, 0, 1, 1,
+		$self->ra->get_log([$self->path], $rev, $rev, 0, 1, 1,
 				   sub { $paths = $_[0] });
 		$SVN::Error::handler = $err_handler;
 	}
 	return undef unless defined $paths;
 
 	# look for a parent from another branch:
-	my @b_path_components = split m#/#, $self->{path};
+	my @b_path_components = split m#/#, $self->path;
 	my @a_path_components;
 	my $i;
 	while (@b_path_components) {
@@ -1235,7 +1242,7 @@ sub mkemptydirs {
 		close $fh;
 	}
 
-	my $strip = qr/\A\Q$self->{path}\E(?:\/|$)/;
+	my $strip = qr/\A\Q@{[$self->path]}\E(?:\/|$)/;
 	foreach my $d (sort keys %empty_dirs) {
 		$d = uri_decode($d);
 		$d =~ s/$strip//;
@@ -1858,7 +1865,7 @@ sub make_log_entry {
 		$commit_email ||= "$author\@$uuid";
 	} elsif ($self->use_svnsync_props) {
 		my $full_url = $self->svnsync->{url};
-		$full_url .= "/$self->{path}" if length $self->{path};
+		$full_url .= "/".$self->path if length $self->path;
 		remove_username($full_url);
 		my $uuid = $self->svnsync->{uuid};
 		$log_entry{metadata} = "$full_url\@$rev $uuid";
@@ -1905,7 +1912,7 @@ sub set_tree {
 	                tree_b => $tree,
 	                editor_cb => sub {
 			       $self->set_tree_cb($log_entry, $tree, @_) },
-	                svn_path => $self->{path} );
+	                svn_path => $self->path );
 	if (!Git::SVN::Editor->new(\%ed_opts)->apply_diff) {
 		print "No changes\nr$self->{last_rev} = $tree\n";
 	}
@@ -2276,10 +2283,28 @@ sub _new {
 
 	$_[3] = $path = '' unless (defined $path);
 	mkpath([$dir]);
-	bless {
+	my $obj = bless {
 		ref_id => $ref_id, dir => $dir, index => "$dir/index",
-	        path => $path, config => "$ENV{GIT_DIR}/svn/config",
+	        config => "$ENV{GIT_DIR}/svn/config",
 	        map_root => "$dir/.rev_map", repo_id => $repo_id }, $class;
+
+	# Ensure it gets canonicalized
+	$obj->path($path);
+
+	return $obj;
+}
+
+
+sub path {
+    my $self = shift;
+
+    if( @_ ) {
+        my $path = shift;
+        $self->{path} = $path;
+        return;
+    }
+
+    return $self->{path};
 }
 
 # for read-only access of old .rev_db formats
-- 
1.7.11.3
