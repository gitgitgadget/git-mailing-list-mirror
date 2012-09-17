From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [FYI/PATCH 2/5] Git::SVN: use accessor to read path
Date: Mon, 17 Sep 2012 02:09:22 -0700
Message-ID: <20120917090922.GC358@elie.Belkin>
References: <1343419252-9447-1-git-send-email-schwern@pobox.com>
 <1343419252-9447-2-git-send-email-schwern@pobox.com>
 <20120917090435.GA358@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca,
	"Michael G. Schwern" <schwern@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 11:09:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDXKi-0005B9-28
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 11:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299Ab2IQJJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 05:09:27 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36768 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096Ab2IQJJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 05:09:26 -0400
Received: by pbbrr13 with SMTP id rr13so8703370pbb.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 02:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fXXwek0MEroaETtVRE/EbPLNHN/xY89OTyplRS51REc=;
        b=rvVjhOD1h9crOUBgsxPw22+A30VitXNg6izaHMmT24ofyu83I5GnJmRwNWxw+8Q3O2
         ELlPX42Up/1W6WzT6je1Ddp5wZRbvKUJ+IS/RpmC735dy5GPsloJ1Q5PPlW/Axza+cwq
         ipWPLJ7DrcWSClPN1Bqn0Oh+KUq4GFsshr0uoAddQABW948rlK8XE8stWurFf0/tMvC1
         TQtExsCwGQ2N60C/SXGBmv3Zqtglf09vTkTJmwHa3yRjCMNKUBkqKUbG5Wn4gYMRxj+7
         5x9FweSwP8xb+1pUwNUl9YKjxjDwvqdsFYjfjdeym9HSN67HQKNy179DPhzzlqw5Dmfz
         2d7w==
Received: by 10.68.134.99 with SMTP id pj3mr21504383pbb.13.1347872965961;
        Mon, 17 Sep 2012 02:09:25 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id pw9sm6606773pbb.42.2012.09.17.02.09.24
        (version=SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 02:09:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120917090435.GA358@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205667>

From: Michael G. Schwern <schwern@pobox.com>
Date: Fri, 27 Jul 2012 13:00:48 -0700

This patch only touches the simplest cases that simply read the
Git::SVN field rather than assigning to or applying a substitution to
it.

Code to change found by searching for the term {path}.

[jn: extracted from a larger patch]

Signed-off-by: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-svn.perl            |   12 ++++++------
 perl/Git/SVN.pm         |   44 ++++++++++++++++++++++----------------------
 perl/Git/SVN/Fetcher.pm |    2 +-
 perl/Git/SVN/Ra.pm      |    8 ++++----
 4 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 5711c571..af7d5308 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1195,7 +1195,7 @@ sub cmd_show_ignore {
 	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
 	$gs ||= Git::SVN->new;
 	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
-	$gs->prop_walk($gs->{path}, $r, sub {
+	$gs->prop_walk($gs->path, $r, sub {
 		my ($gs, $path, $props) = @_;
 		print STDOUT "\n# $path\n";
 		my $s = $props->{'svn:ignore'} or return;
@@ -1211,7 +1211,7 @@ sub cmd_show_externals {
 	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
 	$gs ||= Git::SVN->new;
 	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
-	$gs->prop_walk($gs->{path}, $r, sub {
+	$gs->prop_walk($gs->path, $r, sub {
 		my ($gs, $path, $props) = @_;
 		print STDOUT "\n# $path\n";
 		my $s = $props->{'svn:externals'} or return;
@@ -1226,7 +1226,7 @@ sub cmd_create_ignore {
 	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
 	$gs ||= Git::SVN->new;
 	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
-	$gs->prop_walk($gs->{path}, $r, sub {
+	$gs->prop_walk($gs->path, $r, sub {
 		my ($gs, $path, $props) = @_;
 		# $path is of the form /path/to/dir/
 		$path = '.' . $path;
@@ -1294,7 +1294,7 @@ sub get_svnprops {
 	$path = $cmd_dir_prefix . $path;
 	fatal("No such file or directory: $path") unless -e $path;
 	my $is_dir = -d $path ? 1 : 0;
-	$path = $gs->{path} . '/' . $path;
+	$path = $gs->path . '/' . $path;
 
 	# canonicalize the path (otherwise libsvn will abort or fail to
 	# find the file)
@@ -1396,7 +1396,7 @@ sub cmd_commit_diff {
 			      "the command-line\n", $usage);
 		}
 		$url = $gs->{url};
-		$svn_path = $gs->{path};
+		$svn_path = $gs->path;
 	}
 	unless (defined $_revision) {
 		fatal("-r|--revision is a required argument\n", $usage);
@@ -1670,7 +1670,7 @@ sub complete_url_ls_init {
 		    "wanted to set to: $gs->{url}\n";
 	}
 	command_oneline('config', $k, $gs->{url}) unless $orig_url;
-	my $remote_path = "$gs->{path}/$repo_path";
+	my $remote_path = $gs->path . "/$repo_path";
 	$remote_path =~ s{%([0-9A-F]{2})}{chr hex($1)}ieg;
 	$remote_path =~ s#/+#/#g;
 	$remote_path =~ s#^/##g;
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 268e0e84..02d5abc0 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -314,7 +314,7 @@ sub init_remote_config {
 				print STDERR "Using higher level of URL: ",
 					     "$url => $min_url\n";
 			}
-			my $old_path = $self->{path};
+			my $old_path = $self->path;
 			$self->{path} = $url;
 			$self->{path} =~ s!^\Q$min_url\E(/|$)!!;
 			if (length $old_path) {
@@ -347,7 +347,7 @@ sub init_remote_config {
 		$self->{path} =~ s{%([0-9A-F]{2})}{chr hex($1)}ieg;
 		command_noisy('config', '--add',
 			      "svn-remote.$self->{repo_id}.fetch",
-			      "$self->{path}:".$self->refname);
+			      $self->path.":".$self->refname);
 	}
 	$self->{url} = $url;
 }
@@ -435,7 +435,7 @@ sub new {
 		}
 	}
 	my $self = _new($class, $repo_id, $ref_id, $path);
-	if (!defined $self->{path} || !length $self->{path}) {
+	if (!defined $self->path || !length $self->path) {
 		my $fetch = command_oneline('config', '--get',
 		                            "svn-remote.$repo_id.fetch",
 		                            ":$ref_id\$") or
@@ -567,7 +567,7 @@ sub _set_svm_vars {
 	}
 
 	my $r = $ra->get_latest_revnum;
-	my $path = $self->{path};
+	my $path = $self->path;
 	my %tried;
 	while (length $path) {
 		unless ($tried{"$self->{url}/$path"}) {
@@ -728,7 +728,7 @@ sub prop_walk {
 	$path =~ s#^/*#/#g;
 	my $p = $path;
 	# Strip the irrelevant part of the path.
-	$p =~ s#^/+\Q$self->{path}\E(/|$)#/#;
+	$p =~ s#^/+\Q@{[$self->path]}\E(/|$)#/#;
 	# Ensure the path is terminated by a `/'.
 	$p =~ s#/*$#/#;
 
@@ -749,7 +749,7 @@ sub prop_walk {
 
 	foreach (sort keys %$dirent) {
 		next if $dirent->{$_}->{kind} != $SVN::Node::dir;
-		$self->prop_walk($self->{path} . $p . $_, $rev, $sub);
+		$self->prop_walk($self->path . $p . $_, $rev, $sub);
 	}
 }
 
@@ -920,19 +920,19 @@ sub rewrite_uuid {
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
@@ -1048,20 +1048,20 @@ sub do_git_commit {
 
 sub match_paths {
 	my ($self, $paths, $r) = @_;
-	return 1 if $self->{path} eq '';
-	if (my $path = $paths->{"/$self->{path}"}) {
+	return 1 if $self->path eq '';
+	if (my $path = $paths->{"/".$self->path}) {
 		return ($path->{action} eq 'D') ? 0 : 1;
 	}
-	$self->{path_regex} ||= qr/^\/\Q$self->{path}\E\//;
+	$self->{path_regex} ||= qr/^\/\Q@{[$self->path]}\E\//;
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
@@ -1075,14 +1075,14 @@ sub find_parent_branch {
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
@@ -1114,7 +1114,7 @@ sub find_parent_branch {
 			($base, $head) = parse_revision_argument(0, $r);
 		} else {
 			if ($r0 < $r) {
-				$gs->ra->get_log([$gs->{path}], $r0 + 1, $r, 1,
+				$gs->ra->get_log([$gs->path], $r0 + 1, $r, 1,
 					0, 1, sub { $base = $_[1] - 1 });
 			}
 		}
@@ -1136,7 +1136,7 @@ sub find_parent_branch {
 			# at the moment), so we can't rely on it
 			$self->{last_rev} = $r0;
 			$self->{last_commit} = $parent;
-			$ed = Git::SVN::Fetcher->new($self, $gs->{path});
+			$ed = Git::SVN::Fetcher->new($self, $gs->path);
 			$gs->ra->gs_do_switch($r0, $rev, $gs,
 					      $self->full_url, $ed)
 			  or die "SVN connection failed somewhere...\n";
@@ -1235,7 +1235,7 @@ sub mkemptydirs {
 		close $fh;
 	}
 
-	my $strip = qr/\A\Q$self->{path}\E(?:\/|$)/;
+	my $strip = qr/\A\Q@{[$self->path]}\E(?:\/|$)/;
 	foreach my $d (sort keys %empty_dirs) {
 		$d = uri_decode($d);
 		$d =~ s/$strip//;
@@ -1858,7 +1858,7 @@ sub make_log_entry {
 		$commit_email ||= "$author\@$uuid";
 	} elsif ($self->use_svnsync_props) {
 		my $full_url = $self->svnsync->{url};
-		$full_url .= "/$self->{path}" if length $self->{path};
+		$full_url .= "/".$self->path if length $self->path;
 		remove_username($full_url);
 		my $uuid = $self->svnsync->{uuid};
 		$log_entry{metadata} = "$full_url\@$rev $uuid";
@@ -1905,7 +1905,7 @@ sub set_tree {
 	                tree_b => $tree,
 	                editor_cb => sub {
 			       $self->set_tree_cb($log_entry, $tree, @_) },
-	                svn_path => $self->{path} );
+	                svn_path => $self->path );
 	if (!Git::SVN::Editor->new(\%ed_opts)->apply_diff) {
 		print "No changes\nr$self->{last_rev} = $tree\n";
 	}
diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 76fae9bc..046a7a2f 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -83,7 +83,7 @@ sub _mark_empty_symlinks {
 	chomp(my $empty_blob = `git hash-object -t blob --stdin < /dev/null`);
 	my ($ls, $ctx) = command_output_pipe(qw/ls-tree -r -z/, $cmt);
 	local $/ = "\0";
-	my $pfx = defined($switch_path) ? $switch_path : $git_svn->{path};
+	my $pfx = defined($switch_path) ? $switch_path : $git_svn->path;
 	$pfx .= '/' if length($pfx);
 	while (<$ls>) {
 		chomp;
diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 23ff43e8..64d00672 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -246,7 +246,7 @@ sub get_commit_editor {
 sub gs_do_update {
 	my ($self, $rev_a, $rev_b, $gs, $editor) = @_;
 	my $new = ($rev_a == $rev_b);
-	my $path = $gs->{path};
+	my $path = $gs->path;
 
 	if ($new && -e $gs->{index}) {
 		unlink $gs->{index} or die
@@ -282,7 +282,7 @@ sub gs_do_update {
 # svn_ra_reparent didn't work before 1.4)
 sub gs_do_switch {
 	my ($self, $rev_a, $rev_b, $gs, $url_b, $editor) = @_;
-	my $path = $gs->{path};
+	my $path = $gs->path;
 	my $pool = SVN::Pool->new;
 
 	my $full_url = $self->{url};
@@ -326,7 +326,7 @@ sub longest_common_path {
 	my $common_max = scalar @$gsv;
 
 	foreach my $gs (@$gsv) {
-		my @tmp = split m#/#, $gs->{path};
+		my @tmp = split m#/#, $gs->path;
 		my $p = '';
 		foreach (@tmp) {
 			$p .= length($p) ? "/$_" : $_;
@@ -407,7 +407,7 @@ sub gs_fetch_loop_common {
 		}
 		$SVN::Error::handler = $err_handler;
 
-		my %exists = map { $_->{path} => $_ } @$gsv;
+		my %exists = map { $_->path => $_ } @$gsv;
 		foreach my $r (sort {$a <=> $b} keys %revs) {
 			my ($paths, $logged) = @{$revs{$r}};
 
-- 
1.7.10.4
