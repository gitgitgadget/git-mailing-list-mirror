From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5] Make Git::SVN use accessors internally for path.
Date: Mon, 17 Sep 2012 02:04:35 -0700
Message-ID: <20120917090435.GA358@elie.Belkin>
References: <1343419252-9447-1-git-send-email-schwern@pobox.com>
 <1343419252-9447-2-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca,
	"Michael G. Schwern" <schwern@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 11:04:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDXG9-0002zp-Ji
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 11:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013Ab2IQJEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 05:04:45 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59260 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095Ab2IQJEn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 05:04:43 -0400
Received: by iahk25 with SMTP id k25so5178927iah.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 02:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sLWk+3D9luu6w7aOV3rF8W1AJMD9mOA4zlYoBoL+a6U=;
        b=NzCyuPmyVrWORL5zaWOVCTmXwjLelFyDzgndLhGntlB1aaJzx7M+VN6QIa4W+qXzni
         d/09qcQlCQQojcQG+ZClTwuUJspQ/GIDtBgn03KcH0mbzcpxZZPXvqBxz4eJEykjijg+
         gbBdYeeuXH+Fc2wjnSG9iZ1nVLwM87ueBbTDdgKDJktFAs4rbYkYUG1FWtDTxIv49M3J
         /hCIhBeoUAumSPnF16Wyluu1gOuEOMb0RGE/FMfjHt42Dw+KVf07wn1NIot+MPOv/rPS
         RrsLmuA7UVyfx/k+V9BZ4/j1BtHeXIbUhZexizzX8OJ8msFNimxqZybRTbrcT3yvO/fI
         +LhA==
Received: by 10.50.160.195 with SMTP id xm3mr5945304igb.12.1347872683156;
        Mon, 17 Sep 2012 02:04:43 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id xv8sm6904398igb.9.2012.09.17.02.04.41
        (version=SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 02:04:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343419252-9447-2-git-send-email-schwern@pobox.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205665>

Hi Eric et al,

Michael G. Schwern wrote:

> Then later it can be canonicalized automatically rather than everywhere
> its used.
>
> Later patch will make other things use it.

Wow am I slow.  I've finally got around to starting to parse these
patches to apply to a 1.7.10.y tree so they can (hopefully) be part of
Debian 7.0 when it comes out.

Do I understand correctly that this patch splits logically into the
following steps?  The result is only cosmetically different from the
original patch --- interdiff below the shortlog.

The completeness of the conversion to accessors is checked by renaming
the underlying variable in patch 5.

Jonathan Nieder (1):
  Git::SVN: rename private path field

Michael G. Schwern (4):
  Git::SVN: introduce path accessor
  Git::SVN: use accessor to read path
  Git::SVN: use accessor to write path
  Git::SVN::_new: use accessor to write path field

 git-svn.perl            |   12 +++----
 perl/Git/SVN.pm         |   84 ++++++++++++++++++++++++++++-------------------
 perl/Git/SVN/Fetcher.pm |    2 +-
 perl/Git/SVN/Ra.pm      |    8 ++---
 4 files changed, 62 insertions(+), 44 deletions(-)

---
diff --git c/git-svn.perl w/git-svn.perl
index 5711c571..af7d5308 100755
--- c/git-svn.perl
+++ w/git-svn.perl
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
diff --git c/perl/Git/SVN.pm w/perl/Git/SVN.pm
index a93ac61b..3aa20109 100644
--- c/perl/Git/SVN.pm
+++ w/perl/Git/SVN.pm
@@ -437,22 +437,19 @@ sub new {
 		}
 	}
 	my $self = _new($class, $repo_id, $ref_id, $path);
-	if (!defined $self->path || !length $self->path) {
+	$path = $self->path;
+	if (!defined $path || !length $path) {
 		my $fetch = command_oneline('config', '--get',
 		                            "svn-remote.$repo_id.fetch",
 		                            ":$ref_id\$") or
 		     die "Failed to read \"svn-remote.$repo_id.fetch\" ",
 		         "\":$ref_id\$\" in config\n";
-		my($path) = split(/\s*:\s*/, $fetch);
-		$self->path($path);
-	}
-	{
-		my $path = $self->path;
-		$path =~ s{/+}{/}g;
-		$path =~ s{\A/}{};
-		$path =~ s{/\z}{};
-		$self->path($path);
+		($path, undef) = split(/\s*:\s*/, $fetch);
 	}
+	$path =~ s{/+}{/}g;
+	$path =~ s{\A/}{};
+	$path =~ s{/\z}{};
+	$self->path($path);
 	$self->{url} = command_oneline('config', '--get',
 	                               "svn-remote.$repo_id.url") or
                   die "Failed to read \"svn-remote.$repo_id.url\" in config\n";
@@ -1059,7 +1056,7 @@ sub match_paths {
 	if (my $path = $paths->{"/".$self->path}) {
 		return ($path->{action} eq 'D') ? 0 : 1;
 	}
-	$self->{path_regex} ||= qr{^/\Q@{[$self->path]}\E/};
+	$self->{path_regex} ||= qr/^\/\Q@{[$self->path]}\E\//;
 	if (grep /$self->{path_regex}/, keys %$paths) {
 		return 1;
 	}
@@ -1121,7 +1118,7 @@ sub find_parent_branch {
 			($base, $head) = parse_revision_argument(0, $r);
 		} else {
 			if ($r0 < $r) {
-				$gs->ra->get_log([$gs->{path}], $r0 + 1, $r, 1,
+				$gs->ra->get_log([$gs->path], $r0 + 1, $r, 1,
 					0, 1, sub { $base = $_[1] - 1 });
 			}
 		}
@@ -1143,7 +1140,7 @@ sub find_parent_branch {
 			# at the moment), so we can't rely on it
 			$self->{last_rev} = $r0;
 			$self->{last_commit} = $parent;
-			$ed = Git::SVN::Fetcher->new($self, $gs->{path});
+			$ed = Git::SVN::Fetcher->new($self, $gs->path);
 			$gs->ra->gs_do_switch($r0, $rev, $gs,
 					      $self->full_url, $ed)
 			  or die "SVN connection failed somewhere...\n";
@@ -2287,10 +2284,7 @@ sub _new {
 		ref_id => $ref_id, dir => $dir, index => "$dir/index",
 	        config => "$ENV{GIT_DIR}/svn/config",
 	        map_root => "$dir/.rev_map", repo_id => $repo_id }, $class;
-
-	# Ensure it gets canonicalized
 	$obj->path($path);
-
 	return $obj;
 }
 
diff --git c/perl/Git/SVN/Fetcher.pm w/perl/Git/SVN/Fetcher.pm
index 76fae9bc..046a7a2f 100644
--- c/perl/Git/SVN/Fetcher.pm
+++ w/perl/Git/SVN/Fetcher.pm
@@ -83,7 +83,7 @@ sub _mark_empty_symlinks {
 	chomp(my $empty_blob = `git hash-object -t blob --stdin < /dev/null`);
 	my ($ls, $ctx) = command_output_pipe(qw/ls-tree -r -z/, $cmt);
 	local $/ = "\0";
-	my $pfx = defined($switch_path) ? $switch_path : $git_svn->{path};
+	my $pfx = defined($switch_path) ? $switch_path : $git_svn->path;
 	$pfx .= '/' if length($pfx);
 	while (<$ls>) {
 		chomp;
diff --git c/perl/Git/SVN/Ra.pm w/perl/Git/SVN/Ra.pm
index 23ff43e8..64d00672 100644
--- c/perl/Git/SVN/Ra.pm
+++ w/perl/Git/SVN/Ra.pm
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
 


---
diff --git c/git-svn.perl w/git-svn.perl
index 5711c571..af7d5308 100755
--- c/git-svn.perl
+++ w/git-svn.perl
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
diff --git c/perl/Git/SVN.pm w/perl/Git/SVN.pm
index a93ac61b..3aa20109 100644
--- c/perl/Git/SVN.pm
+++ w/perl/Git/SVN.pm
@@ -437,22 +437,19 @@ sub new {
 		}
 	}
 	my $self = _new($class, $repo_id, $ref_id, $path);
-	if (!defined $self->path || !length $self->path) {
+	$path = $self->path;
+	if (!defined $path || !length $path) {
 		my $fetch = command_oneline('config', '--get',
 		                            "svn-remote.$repo_id.fetch",
 		                            ":$ref_id\$") or
 		     die "Failed to read \"svn-remote.$repo_id.fetch\" ",
 		         "\":$ref_id\$\" in config\n";
-		my($path) = split(/\s*:\s*/, $fetch);
-		$self->path($path);
-	}
-	{
-		my $path = $self->path;
-		$path =~ s{/+}{/}g;
-		$path =~ s{\A/}{};
-		$path =~ s{/\z}{};
-		$self->path($path);
+		($path, undef) = split(/\s*:\s*/, $fetch);
 	}
+	$path =~ s{/+}{/}g;
+	$path =~ s{\A/}{};
+	$path =~ s{/\z}{};
+	$self->path($path);
 	$self->{url} = command_oneline('config', '--get',
 	                               "svn-remote.$repo_id.url") or
                   die "Failed to read \"svn-remote.$repo_id.url\" in config\n";
@@ -1059,7 +1056,7 @@ sub match_paths {
 	if (my $path = $paths->{"/".$self->path}) {
 		return ($path->{action} eq 'D') ? 0 : 1;
 	}
-	$self->{path_regex} ||= qr{^/\Q@{[$self->path]}\E/};
+	$self->{path_regex} ||= qr/^\/\Q@{[$self->path]}\E\//;
 	if (grep /$self->{path_regex}/, keys %$paths) {
 		return 1;
 	}
@@ -1121,7 +1118,7 @@ sub find_parent_branch {
 			($base, $head) = parse_revision_argument(0, $r);
 		} else {
 			if ($r0 < $r) {
-				$gs->ra->get_log([$gs->{path}], $r0 + 1, $r, 1,
+				$gs->ra->get_log([$gs->path], $r0 + 1, $r, 1,
 					0, 1, sub { $base = $_[1] - 1 });
 			}
 		}
@@ -1143,7 +1140,7 @@ sub find_parent_branch {
 			# at the moment), so we can't rely on it
 			$self->{last_rev} = $r0;
 			$self->{last_commit} = $parent;
-			$ed = Git::SVN::Fetcher->new($self, $gs->{path});
+			$ed = Git::SVN::Fetcher->new($self, $gs->path);
 			$gs->ra->gs_do_switch($r0, $rev, $gs,
 					      $self->full_url, $ed)
 			  or die "SVN connection failed somewhere...\n";
@@ -2287,10 +2284,7 @@ sub _new {
 		ref_id => $ref_id, dir => $dir, index => "$dir/index",
 	        config => "$ENV{GIT_DIR}/svn/config",
 	        map_root => "$dir/.rev_map", repo_id => $repo_id }, $class;
-
-	# Ensure it gets canonicalized
 	$obj->path($path);
-
 	return $obj;
 }
 
diff --git c/perl/Git/SVN/Fetcher.pm w/perl/Git/SVN/Fetcher.pm
index 76fae9bc..046a7a2f 100644
--- c/perl/Git/SVN/Fetcher.pm
+++ w/perl/Git/SVN/Fetcher.pm
@@ -83,7 +83,7 @@ sub _mark_empty_symlinks {
 	chomp(my $empty_blob = `git hash-object -t blob --stdin < /dev/null`);
 	my ($ls, $ctx) = command_output_pipe(qw/ls-tree -r -z/, $cmt);
 	local $/ = "\0";
-	my $pfx = defined($switch_path) ? $switch_path : $git_svn->{path};
+	my $pfx = defined($switch_path) ? $switch_path : $git_svn->path;
 	$pfx .= '/' if length($pfx);
 	while (<$ls>) {
 		chomp;
diff --git c/perl/Git/SVN/Ra.pm w/perl/Git/SVN/Ra.pm
index 23ff43e8..64d00672 100644
--- c/perl/Git/SVN/Ra.pm
+++ w/perl/Git/SVN/Ra.pm
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
 
