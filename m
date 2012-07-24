From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-svn SVN 1.7 fix, take 2
Date: Tue, 24 Jul 2012 18:31:28 -0500
Message-ID: <20120724233128.GD16333@burratino>
References: <500F17A3.60307@pobox.com>
 <20120724220207.GA15969@burratino>
 <500F26BF.7090501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 01:31:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StoZq-0002G5-1R
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 01:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591Ab2GXXbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 19:31:36 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64834 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385Ab2GXXbe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 19:31:34 -0400
Received: by yhmm54 with SMTP id m54so129214yhm.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 16:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rT+oo0sskBcpS2SxSIjns1/eF5zoS/8GQP1y9zFmi/E=;
        b=vGGJ8UU5ZbQu7xos3OK87P3JPmcZdnHzkaBjx/hykD/dfk5ogRHl0zbHCkTWvKgseX
         0Diz4/P6UVwhuAKQZpfaRbIAdm71wa1iq6LYVA3+42K2ZnxcurbUoWfEcjjfzw5CHBju
         HCVZd4nQEfndqa8xZHQQXlDII5wryXrvs1RWuOe2K+AvpzqUP8KbFbmR6hKmQCiKaDx/
         7qI8WMny4RIouANiWkrEGgOcR8CWQvHSxaaMmadaU2TF47AWgBBBo5HVv2f1+GZzOTcW
         I3k3DHUYH9HyAs2rsO487ltYeCBdtstZSe8aClqw5Lzyrnh89P461yuVm5G6fGTsntY1
         xmqw==
Received: by 10.42.75.73 with SMTP id z9mr19237270icj.46.1343172693554;
        Tue, 24 Jul 2012 16:31:33 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id nh1sm3195920igc.11.2012.07.24.16.31.32
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 16:31:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <500F26BF.7090501@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202087>

Michael G Schwern wrote:

>   git log -p schwern/git-svn/extract-classes..schwern/git-svn/fix-canonical
>
> That should give you the information you need...

I guess so.  May we have your sign-off on these changes?  (A simple
reply of "yes" is enough, no need to resend patches to do this.)

Here it is in patch form for reviewers.  If I understand correctly,
the idea is to replace accesses to $gs->{path} with calls to a
$gs->path function that canonicalizes (and likewise for s/path/url/).

There are probably other subtleties, but that seems to be the gist.
---
 git-svn.perl                          |   96 +++++++--------------
 perl/Git/SVN.pm                       |  148 +++++++++++++++++++++------------
 perl/Git/SVN/Fetcher.pm               |    2 +-
 perl/Git/SVN/Migration.pm             |    6 +-
 perl/Git/SVN/Ra.pm                    |   96 ++++++++++++---------
 perl/Git/SVN/Utils.pm                 |  123 ++++++++++++++++++++++++++-
 t/Git-SVN/Ra/fix_dir.t                |   24 ++++++
 t/lib-git-svn.sh                      |    2 +
 t/t9118-git-svn-funky-branch-names.sh |    6 +-
 t/t9119-git-svn-info.sh               |    7 +-
 10 files changed, 341 insertions(+), 169 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 7b54f43f..74aeb4df 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -12,7 +12,12 @@ $VERSION = '@@GIT_VERSION@@';
 
 use Git::SVN;
 
-use Git::SVN::Utils qw(fatal can_compress);
+use Git::SVN::Utils qw(
+    fatal
+    can_compress
+    canonicalize_path
+    canonicalize_url
+);
 
 # From which subdir have we been invoked?
 my $cmd_dir_prefix = eval {
@@ -100,8 +105,6 @@ BEGIN {
 	Memoize::memoize 'Git::config_bool';
 }
 
-my ($SVN);
-
 $sha1 = qr/[a-f\d]{40}/;
 $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_stdin, $_help, $_edit,
@@ -518,7 +521,6 @@ sub cmd_init {
 	}
 	my $url = shift or die "SVN repository location required ",
 	                       "as a command-line argument\n";
-	$url = canonicalize_url($url);
 	init_subdir(@_);
 	do_git_init_db();
 
@@ -1199,7 +1201,7 @@ sub cmd_show_ignore {
 	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
 	$gs ||= Git::SVN->new;
 	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
-	$gs->prop_walk($gs->{path}, $r, sub {
+	$gs->prop_walk($gs->path, $r, sub {
 		my ($gs, $path, $props) = @_;
 		print STDOUT "\n# $path\n";
 		my $s = $props->{'svn:ignore'} or return;
@@ -1215,7 +1217,7 @@ sub cmd_show_externals {
 	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
 	$gs ||= Git::SVN->new;
 	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
-	$gs->prop_walk($gs->{path}, $r, sub {
+	$gs->prop_walk($gs->path, $r, sub {
 		my ($gs, $path, $props) = @_;
 		print STDOUT "\n# $path\n";
 		my $s = $props->{'svn:externals'} or return;
@@ -1230,7 +1232,7 @@ sub cmd_create_ignore {
 	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
 	$gs ||= Git::SVN->new;
 	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
-	$gs->prop_walk($gs->{path}, $r, sub {
+	$gs->prop_walk($gs->path, $r, sub {
 		my ($gs, $path, $props) = @_;
 		# $path is of the form /path/to/dir/
 		$path = '.' . $path;
@@ -1260,36 +1262,12 @@ sub cmd_mkdirs {
 	$gs->mkemptydirs($_revision);
 }
 
-sub canonicalize_path {
-	my ($path) = @_;
-	my $dot_slash_added = 0;
-	if (substr($path, 0, 1) ne "/") {
-		$path = "./" . $path;
-		$dot_slash_added = 1;
-	}
-	# File::Spec->canonpath doesn't collapse x/../y into y (for a
-	# good reason), so let's do this manually.
-	$path =~ s#/+#/#g;
-	$path =~ s#/\.(?:/|$)#/#g;
-	$path =~ s#/[^/]+/\.\.##g;
-	$path =~ s#/$##g;
-	$path =~ s#^\./## if $dot_slash_added;
-	$path =~ s#^/##;
-	$path =~ s#^\.$##;
-	return $path;
-}
-
-sub canonicalize_url {
-	my ($url) = @_;
-	$url =~ s#^([^:]+://[^/]*/)(.*)$#$1 . canonicalize_path($2)#e;
-	return $url;
-}
-
 # get_svnprops(PATH)
 # ------------------
 # Helper for cmd_propget and cmd_proplist below.
 sub get_svnprops {
 	my $path = shift;
+
 	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
 	$gs ||= Git::SVN->new;
 
@@ -1298,7 +1276,8 @@ sub get_svnprops {
 	$path = $cmd_dir_prefix . $path;
 	fatal("No such file or directory: $path") unless -e $path;
 	my $is_dir = -d $path ? 1 : 0;
-	$path = $gs->{path} . '/' . $path;
+
+	$path = $gs->path . '/' . $path if $gs->path;
 
 	# canonicalize the path (otherwise libsvn will abort or fail to
 	# find the file)
@@ -1399,8 +1378,8 @@ sub cmd_commit_diff {
 			fatal("Needed URL or usable git-svn --id in ",
 			      "the command-line\n", $usage);
 		}
-		$url = $gs->{url};
-		$svn_path = $gs->{path};
+		$url = $gs->url;
+		$svn_path = $gs->path;
 	}
 	unless (defined $_revision) {
 		fatal("-r|--revision is a required argument\n", $usage);
@@ -1434,25 +1413,6 @@ sub cmd_commit_diff {
 	}
 }
 
-sub escape_uri_only {
-	my ($uri) = @_;
-	my @tmp;
-	foreach (split m{/}, $uri) {
-		s/([^~\w.%+-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
-		push @tmp, $_;
-	}
-	join('/', @tmp);
-}
-
-sub escape_url {
-	my ($url) = @_;
-	if ($url =~ m#^([^:]+)://([^/]*)(.*)$#) {
-		my ($scheme, $domain, $uri) = ($1, $2, escape_uri_only($3));
-		$url = "$scheme://$domain$uri";
-	}
-	$url;
-}
-
 sub cmd_info {
 	my $path = canonicalize_path(defined($_[0]) ? $_[0] : ".");
 	my $fullpath = canonicalize_path($cmd_dir_prefix . $path);
@@ -1476,21 +1436,21 @@ sub cmd_info {
 	# canonicalize_path() will return "" to make libsvn 1.5.x happy,
 	$path = "." if $path eq "";
 
-	my $full_url = $url . ($fullpath eq "" ? "" : "/$fullpath");
+	my $full_url = canonicalize_url( $url . ($fullpath eq "" ? "" : "/$fullpath") );
 
 	if ($_url) {
-		print escape_url($full_url), "\n";
+		print $full_url, "\n";
 		return;
 	}
 
 	my $result = "Path: $path\n";
 	$result .= "Name: " . basename($path) . "\n" if $file_type ne "dir";
-	$result .= "URL: " . escape_url($full_url) . "\n";
+	$result .= "URL: $full_url\n";
 
 	eval {
 		my $repos_root = $gs->repos_root;
 		Git::SVN::remove_username($repos_root);
-		$result .= "Repository Root: " . escape_url($repos_root) . "\n";
+		$result .= "Repository Root: " . canonicalize_url($repos_root) . "\n";
 	};
 	if ($@) {
 		$result .= "Repository Root: (offline)\n";
@@ -1638,7 +1598,10 @@ sub post_fetch_checkout {
 
 sub complete_svn_url {
 	my ($url, $path) = @_;
-	$path =~ s#/+$##;
+
+	$path = canonicalize_path($path);
+
+	# The path is not a URL
 	if ($path !~ m#^[a-z\+]+://#) {
 		if (!defined $url || $url !~ m#^[a-z\+]+://#) {
 			fatal("E: '$path' is not a complete URL ",
@@ -1655,7 +1618,8 @@ sub complete_url_ls_init {
 		print STDERR "W: $switch not specified\n";
 		return;
 	}
-	$repo_path =~ s#/+$##;
+
+	$repo_path = canonicalize_path($repo_path);
 	if ($repo_path =~ m#^[a-z\+]+://#) {
 		$ra = Git::SVN::Ra->new($repo_path);
 		$repo_path = '';
@@ -1666,18 +1630,18 @@ sub complete_url_ls_init {
 			      "and a separate URL is not specified");
 		}
 	}
-	my $url = $ra->{url};
+	my $url = $ra->url;
 	my $gs = Git::SVN->init($url, undef, undef, undef, 1);
 	my $k = "svn-remote.$gs->{repo_id}.url";
 	my $orig_url = eval { command_oneline(qw/config --get/, $k) };
-	if ($orig_url && ($orig_url ne $gs->{url})) {
+	if ($orig_url && ($orig_url ne $gs->url)) {
 		die "$k already set: $orig_url\n",
-		    "wanted to set to: $gs->{url}\n";
+		    "wanted to set to: $gs->url\n";
 	}
-	command_oneline('config', $k, $gs->{url}) unless $orig_url;
-	my $remote_path = "$gs->{path}/$repo_path";
+	command_oneline('config', $k, $gs->url) unless $orig_url;
+
+	my $remote_path = canonicalize_path($gs->path . "/$repo_path");
 	$remote_path =~ s{%([0-9A-F]{2})}{chr hex($1)}ieg;
-	$remote_path =~ s#/+#/#g;
 	$remote_path =~ s#^/##g;
 	$remote_path .= "/*" if $remote_path !~ /\*/;
 	my ($n) = ($switch =~ /^--(\w+)/);
diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 247ee1d0..ebfa8da5 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -23,7 +23,12 @@ BEGIN {
 }
 
 use Git qw(command command_oneline command_noisy command_output_pipe command_close_pipe);
-use Git::SVN::Utils qw(fatal can_compress);
+use Git::SVN::Utils qw(
+    fatal
+    can_compress
+    canonicalize_url
+    canonicalize_path
+);
 
 our $_follow_parent  = 1;
 our $_minimize_url   = 'unset';
@@ -310,12 +315,12 @@ sub init_remote_config {
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
@@ -339,13 +344,15 @@ sub init_remote_config {
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
-	$self->{url} = $url;
+	$self->url($url);
 }
 
 sub find_by_url { # repos_root and, path are optional
@@ -431,20 +438,19 @@ sub new {
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
 	}
-	$self->{path} =~ s{/+}{/}g;
-	$self->{path} =~ s{\A/}{};
-	$self->{path} =~ s{/\z}{};
-	$self->{url} = command_oneline('config', '--get',
-	                               "svn-remote.$repo_id.url") or
+	my $url = command_oneline('config', '--get',
+	                          "svn-remote.$repo_id.url") or
                   die "Failed to read \"svn-remote.$repo_id.url\" in config\n";
+	$self->url($url);
 	$self->{pushurl} = eval { command_oneline('config', '--get',
 	                          "svn-remote.$repo_id.pushurl") };
 	$self->rebuild;
@@ -548,7 +554,7 @@ sub _set_svm_vars {
 		# username is of no interest
 		$src =~ s{(^[a-z\+]*://)[^/@]*@}{$1};
 
-		my $replace = $ra->{url};
+		my $replace = $ra->url;
 		$replace .= "/$path" if length $path;
 
 		my $section = "svn-remote.$self->{repo_id}";
@@ -563,20 +569,21 @@ sub _set_svm_vars {
 	}
 
 	my $r = $ra->get_latest_revnum;
-	my $path = $self->{path};
+	my $path = $self->path;
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
 
@@ -586,20 +593,21 @@ sub _set_svm_vars {
 	$path = $ra->{svn_path};
 	$ra = Git::SVN::Ra->new($ra->{repos_root});
 	while (length $path) {
-		unless ($tried{"$ra->{url}/$path"}) {
+		my $try = $ra->url ."/$path";
+		unless ($tried{$try}) {
 			$ok = $self->read_svm_props($ra, $path, $r);
 			last if $ok;
-			$tried{"$ra->{url}/$path"} = 1;
+			$tried{$try} = 1;
 		}
 		$path =~ s#/?[^/]+$##;
 	}
 	die "Path: '$path' should be ''\n" if $path ne '';
 	$ok ||= $self->read_svm_props($ra, $path, $r);
-	$tried{"$ra->{url}/$path"} = 1;
+	$tried{$ra->url ."/$path"} = 1;
 	if (!$ok) {
 		die @err, (map { "  $_\n" } keys %tried), "\n";
 	}
-	Git::SVN::Ra->new($self->{url});
+	Git::SVN::Ra->new($self->url);
 }
 
 sub svnsync {
@@ -666,7 +674,7 @@ sub ra_uuid {
 		if (!$@ && $uuid && $uuid =~ /^([a-f\d\-]{30,})$/i) {
 			$self->{ra_uuid} = $uuid;
 		} else {
-			die "ra_uuid called without URL\n" unless $self->{url};
+			die "ra_uuid called without URL\n" unless $self->url;
 			$self->{ra_uuid} = $self->ra->get_uuid;
 			tmp_config('--add', $key, $self->{ra_uuid});
 		}
@@ -690,7 +698,7 @@ sub repos_root {
 
 sub ra {
 	my ($self) = shift;
-	my $ra = Git::SVN::Ra->new($self->{url});
+	my $ra = Git::SVN::Ra->new($self->url);
 	$self->_set_repos_root($ra->{repos_root});
 	if ($self->use_svm_props && !$self->{svm}) {
 		if ($self->no_metadata) {
@@ -724,7 +732,7 @@ sub prop_walk {
 	$path =~ s#^/*#/#g;
 	my $p = $path;
 	# Strip the irrelevant part of the path.
-	$p =~ s#^/+\Q$self->{path}\E(/|$)#/#;
+	$p =~ s#^/+\Q@{[$self->path]}\E(/|$)#/#;
 	# Ensure the path is terminated by a `/'.
 	$p =~ s#/*$#/#;
 
@@ -745,7 +753,7 @@ sub prop_walk {
 
 	foreach (sort keys %$dirent) {
 		next if $dirent->{$_}->{kind} != $SVN::Node::dir;
-		$self->prop_walk($self->{path} . $p . $_, $rev, $sub);
+		$self->prop_walk($self->path . $p . $_, $rev, $sub);
 	}
 }
 
@@ -915,20 +923,20 @@ sub rewrite_uuid {
 
 sub metadata_url {
 	my ($self) = @_;
-	($self->rewrite_root || $self->{url}) .
-	   (length $self->{path} ? '/' . $self->{path} : '');
+	($self->rewrite_root || $self->url) .
+	   (length $self->path ? '/' . $self->path : '');
 }
 
 sub full_url {
 	my ($self) = @_;
-	$self->{url} . (length $self->{path} ? '/' . $self->{path} : '');
+	return canonicalize_url( $self->url . (length $self->path ? '/' . $self->path : '') );
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
@@ -1044,20 +1052,20 @@ sub do_git_commit {
 
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
@@ -1071,14 +1079,14 @@ sub find_parent_branch {
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
@@ -1089,14 +1097,12 @@ sub find_parent_branch {
 	return undef unless defined $i && defined $i->{copyfrom_path};
 	my $branch_from = $i->{copyfrom_path};
 	if (@a_path_components) {
-		print STDERR "branch_from: $branch_from => ";
 		$branch_from .= '/'.join('/', @a_path_components);
-		print STDERR $branch_from, "\n";
 	}
 	my $r = $i->{copyfrom_rev};
 	my $repos_root = $self->ra->{repos_root};
-	my $url = $self->ra->{url};
-	my $new_url = $url . $branch_from;
+	my $url = $self->ra->url;
+	my $new_url = canonicalize_url($url . $branch_from);
 	print STDERR  "Found possible branch point: ",
 	              "$new_url => ", $self->full_url, ", $r\n"
 	              unless $::_q > 1;
@@ -1110,7 +1116,7 @@ sub find_parent_branch {
 			($base, $head) = parse_revision_argument(0, $r);
 		} else {
 			if ($r0 < $r) {
-				$gs->ra->get_log([$gs->{path}], $r0 + 1, $r, 1,
+				$gs->ra->get_log([$gs->path], $r0 + 1, $r, 1,
 					0, 1, sub { $base = $_[1] - 1 });
 			}
 		}
@@ -1132,7 +1138,7 @@ sub find_parent_branch {
 			# at the moment), so we can't rely on it
 			$self->{last_rev} = $r0;
 			$self->{last_commit} = $parent;
-			$ed = Git::SVN::Fetcher->new($self, $gs->{path});
+			$ed = Git::SVN::Fetcher->new($self, $gs->path);
 			$gs->ra->gs_do_switch($r0, $rev, $gs,
 					      $self->full_url, $ed)
 			  or die "SVN connection failed somewhere...\n";
@@ -1231,7 +1237,7 @@ sub mkemptydirs {
 		close $fh;
 	}
 
-	my $strip = qr/\A\Q$self->{path}\E(?:\/|$)/;
+	my $strip = qr/\A\Q@{[$self->path]}\E(?:\/|$)/;
 	foreach my $d (sort keys %empty_dirs) {
 		$d = uri_decode($d);
 		$d =~ s/$strip//;
@@ -1425,7 +1431,7 @@ sub find_extra_svk_parents {
 	for my $ticket ( @tickets ) {
 		my ($uuid, $path, $rev) = split /:/, $ticket;
 		if ( $uuid eq $self->ra_uuid ) {
-			my $url = $self->{url};
+			my $url = $self->url;
 			my $repos_root = $url;
 			my $branch_from = $path;
 			$branch_from =~ s{^/}{};
@@ -1671,7 +1677,7 @@ sub find_extra_svn_parents {
 	# are now marked as merge, we can add the tip as a parent.
 	my @merges = split "\n", $mergeinfo;
 	my @merge_tips;
-	my $url = $self->{url};
+	my $url = $self->url;
 	my $uuid = $self->ra_uuid;
 	my %ranges;
 	for my $merge ( @merges ) {
@@ -1854,7 +1860,7 @@ sub make_log_entry {
 		$commit_email ||= "$author\@$uuid";
 	} elsif ($self->use_svnsync_props) {
 		my $full_url = $self->svnsync->{url};
-		$full_url .= "/$self->{path}" if length $self->{path};
+		$full_url .= "/".$self->path if length $self->path;
 		remove_username($full_url);
 		my $uuid = $self->svnsync->{uuid};
 		$log_entry{metadata} = "$full_url\@$rev $uuid";
@@ -1901,7 +1907,7 @@ sub set_tree {
 	                tree_b => $tree,
 	                editor_cb => sub {
 			       $self->set_tree_cb($log_entry, $tree, @_) },
-	                svn_path => $self->{path} );
+	                svn_path => $self->path );
 	if (!Git::SVN::Editor->new(\%ed_opts)->apply_diff) {
 		print "No changes\nr$self->{last_rev} = $tree\n";
 	}
@@ -2272,12 +2278,44 @@ sub _new {
 
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
+        $self->{path} = canonicalize_path($path);
+        return;
+    }
+
+    return $self->{path};
 }
 
+
+sub url {
+    my $self = shift;
+
+    if( @_ ) {
+        my $url = shift;
+        $self->{url} = canonicalize_url($url);
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
diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
index 69486efe..b606fe5a 100644
--- a/perl/Git/SVN/Fetcher.pm
+++ b/perl/Git/SVN/Fetcher.pm
@@ -84,7 +84,7 @@ sub _mark_empty_symlinks {
 	chomp(my $empty_blob = `git hash-object -t blob --stdin < /dev/null`);
 	my ($ls, $ctx) = command_output_pipe(qw/ls-tree -r -z/, $cmt);
 	local $/ = "\0";
-	my $pfx = defined($switch_path) ? $switch_path : $git_svn->{path};
+	my $pfx = defined($switch_path) ? $switch_path : $git_svn->path;
 	$pfx .= '/' if length($pfx);
 	while (<$ls>) {
 		chomp;
diff --git a/perl/Git/SVN/Migration.pm b/perl/Git/SVN/Migration.pm
index b17fe003..5a9d3c71 100644
--- a/perl/Git/SVN/Migration.pm
+++ b/perl/Git/SVN/Migration.pm
@@ -180,14 +180,14 @@ sub minimize_connections {
 		my $ra = Git::SVN::Ra->new($url);
 
 		# skip existing cases where we already connect to the root
-		if (($ra->{url} eq $ra->{repos_root}) ||
+		if (($ra->url eq $ra->{repos_root}) ||
 		    ($ra->{repos_root} eq $repo_id)) {
-			$root_repos->{$ra->{url}} = $repo_id;
+			$root_repos->{$ra->url} = $repo_id;
 			next;
 		}
 
 		my $root_ra = Git::SVN::Ra->new($ra->{repos_root});
-		my $root_path = $ra->{url};
+		my $root_path = $ra->url;
 		$root_path =~ s#^\Q$ra->{repos_root}\E(/|$)##;
 		foreach my $path (keys %$fetch) {
 			my $ref_id = $fetch->{$path};
diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 23ff43e8..7bd6db6f 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -8,6 +8,11 @@ BEGIN {
 	@ISA = qw(SVN::Ra);
 }
 
+use Git::SVN::Utils qw(
+    canonicalize_url
+    canonicalize_path
+);
+
 my ($ra_invalid, $can_do_switch, %ignored_err, $RA);
 
 BEGIN {
@@ -62,29 +67,10 @@ sub _auth_providers () {
 	\@rv;
 }
 
-sub escape_uri_only {
-	my ($uri) = @_;
-	my @tmp;
-	foreach (split m{/}, $uri) {
-		s/([^~\w.%+-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
-		push @tmp, $_;
-	}
-	join('/', @tmp);
-}
-
-sub escape_url {
-	my ($url) = @_;
-	if ($url =~ m#^(https?)://([^/]+)(.*)$#) {
-		my ($scheme, $domain, $uri) = ($1, $2, escape_uri_only($3));
-		$url = "$scheme://$domain$uri";
-	}
-	$url;
-}
-
 sub new {
 	my ($class, $url) = @_;
 	$url =~ s!/+$!!;
-	return $RA if ($RA && $RA->{url} eq $url);
+	return $RA if ($RA && $RA->url eq $url);
 
 	::_req_svn();
 
@@ -115,19 +101,37 @@ sub new {
 			$Git::SVN::Prompt::_no_auth_cache = 1;
 		}
 	} # no warnings 'once'
-	my $self = SVN::Ra->new(url => escape_url($url), auth => $baton,
+	my $self = SVN::Ra->new(url => canonicalize_url($url), auth => $baton,
 	                      config => $config,
 			      pool => SVN::Pool->new,
 	                      auth_provider_callbacks => $callbacks);
-	$self->{url} = $url;
+	$RA = bless $self, $class;
+
+	# Make sure its canonicalized
+	$self->url($url);
 	$self->{svn_path} = $url;
 	$self->{repos_root} = $self->get_repos_root;
 	$self->{svn_path} =~ s#^\Q$self->{repos_root}\E(/|$)##;
 	$self->{cache} = { check_path => { r => 0, data => {} },
 	                   get_dir => { r => 0, data => {} } };
-	$RA = bless $self, $class;
+
+	return $RA;
 }
 
+
+sub url {
+    my $self = shift;
+
+    if( @_ ) {
+        my $url = shift;
+        $self->{url} = canonicalize_url($url);
+        return;
+    }
+
+    return $self->{url};
+}
+
+
 sub check_path {
 	my ($self, $path, $r) = @_;
 	my $cache = $self->{cache}->{check_path};
@@ -146,6 +150,9 @@ sub check_path {
 
 sub get_dir {
 	my ($self, $dir, $r) = @_;
+
+        $dir = $self->fix_dir($dir);
+
 	my $cache = $self->{cache}->{get_dir};
 	if ($r == $cache->{r}) {
 		if (my $x = $cache->{data}->{$dir}) {
@@ -164,6 +171,20 @@ sub get_dir {
 	wantarray ? (\%dirents, $r, $props) : \%dirents;
 }
 
+sub fix_dir {
+    my $self = shift;
+    my $dir = shift;
+
+    # SVN::Ra->get_dir will fail if given foo/.. and the
+    # canonicalize functions will not fix that.
+    $dir =~ s{[^/]+/\.\./?}{}g;
+
+    # It also doesn't like a single dot.
+    $dir =~ s{^\.$}{};
+
+    return $dir;
+}
+
 sub DESTROY {
 	# do not call the real DESTROY since we store ourselves in $RA
 }
@@ -195,6 +216,7 @@ sub get_log {
 				qw/copyfrom_path copyfrom_rev action/;
 			if ($s{'copyfrom_path'}) {
 				$s{'copyfrom_path'} =~ s/$prefix_regex//;
+				$s{'copyfrom_path'} = canonicalize_path($s{'copyfrom_path'});
 			}
 			$_[0]{$p} = \%s;
 		}
@@ -246,7 +268,7 @@ sub get_commit_editor {
 sub gs_do_update {
 	my ($self, $rev_a, $rev_b, $gs, $editor) = @_;
 	my $new = ($rev_a == $rev_b);
-	my $path = $gs->{path};
+	my $path = $gs->path;
 
 	if ($new && -e $gs->{index}) {
 		unlink $gs->{index} or die
@@ -282,17 +304,17 @@ sub gs_do_update {
 # svn_ra_reparent didn't work before 1.4)
 sub gs_do_switch {
 	my ($self, $rev_a, $rev_b, $gs, $url_b, $editor) = @_;
-	my $path = $gs->{path};
+	my $path = $gs->path;
 	my $pool = SVN::Pool->new;
 
-	my $full_url = $self->{url};
+	my $full_url = $self->url;
 	my $old_url = $full_url;
-	$full_url .= '/' . $path if length $path;
+	$full_url = canonicalize_url( $full_url . '/' . $path ) if length $path;
 	my ($ra, $reparented);
 
 	if ($old_url =~ m#^svn(\+ssh)?://# ||
 	    ($full_url =~ m#^https?://# &&
-	     escape_url($full_url) ne $full_url)) {
+	     $full_url ne $full_url)) {
 		$_[0] = undef;
 		$self = undef;
 		$RA = undef;
@@ -300,12 +322,12 @@ sub gs_do_switch {
 		$ra_invalid = 1;
 	} elsif ($old_url ne $full_url) {
 		SVN::_Ra::svn_ra_reparent($self->{session}, $full_url, $pool);
-		$self->{url} = $full_url;
+		$self->url($full_url);
 		$reparented = 1;
 	}
 
 	$ra ||= $self;
-	$url_b = escape_url($url_b);
+	$url_b = canonicalize_url($url_b);
 	my $reporter = $ra->do_switch($rev_b, '', 1, $url_b, $editor, $pool);
 	my @lock = (::compare_svn_version('1.2.0') >= 0) ? (undef) : ();
 	$reporter->set_path('', $rev_a, 0, @lock, $pool);
@@ -313,7 +335,7 @@ sub gs_do_switch {
 
 	if ($reparented) {
 		SVN::_Ra::svn_ra_reparent($self->{session}, $old_url, $pool);
-		$self->{url} = $old_url;
+		$self->url($old_url);
 	}
 
 	$pool->clear;
@@ -326,7 +348,7 @@ sub longest_common_path {
 	my $common_max = scalar @$gsv;
 
 	foreach my $gs (@$gsv) {
-		my @tmp = split m#/#, $gs->{path};
+		my @tmp = split m#/#, $gs->path;
 		my $p = '';
 		foreach (@tmp) {
 			$p .= length($p) ? "/$_" : $_;
@@ -362,7 +384,7 @@ sub gs_fetch_loop_common {
 	my $inc = $_log_window_size;
 	my ($min, $max) = ($base, $head < $base + $inc ? $head : $base + $inc);
 	my $longest_path = longest_common_path($gsv, $globs);
-	my $ra_url = $self->{url};
+	my $ra_url = $self->url;
 	my $find_trailing_edge;
 	while (1) {
 		my %revs;
@@ -508,7 +530,7 @@ sub match_globs {
 				 ($self->check_path($p, $r) !=
 				  $SVN::Node::dir));
 			next unless $p =~ /$g->{path}->{regex}/;
-			$exists->{$p} = Git::SVN->init($self->{url}, $p, undef,
+			$exists->{$p} = Git::SVN->init($self->url, $p, undef,
 					 $g->{ref}->full_path($de), 1);
 		}
 	}
@@ -532,7 +554,7 @@ sub match_globs {
 			next if ($self->check_path($pathname, $r) !=
 			         $SVN::Node::dir);
 			$exists->{$pathname} = Git::SVN->init(
-			                      $self->{url}, $pathname, undef,
+			                      $self->url, $pathname, undef,
 			                      $g->{ref}->full_path($p), 1);
 		}
 		my $c = '';
@@ -548,7 +570,7 @@ sub match_globs {
 
 sub minimize_url {
 	my ($self) = @_;
-	return $self->{url} if ($self->{url} eq $self->{repos_root});
+	return $self->url if ($self->url eq $self->{repos_root});
 	my $url = $self->{repos_root};
 	my @components = split(m!/!, $self->{svn_path});
 	my $c = '';
@@ -568,7 +590,7 @@ sub can_do_switch {
 	unless (defined $can_do_switch) {
 		my $pool = SVN::Pool->new;
 		my $rep = eval {
-			$self->do_switch(1, '', 0, $self->{url},
+			$self->do_switch(1, '', 0, $self->url,
 			                 SVN::Delta::Editor->new, $pool);
 		};
 		if ($@) {
diff --git a/perl/Git/SVN/Utils.pm b/perl/Git/SVN/Utils.pm
index d8f63e68..e7087435 100644
--- a/perl/Git/SVN/Utils.pm
+++ b/perl/Git/SVN/Utils.pm
@@ -5,10 +5,54 @@ use warnings;
 
 use base qw(Exporter);
 
-our @EXPORT_OK = qw(fatal can_compress);
+our @EXPORT_OK = qw(
+    fatal
+    can_compress
+    canonicalize_path
+    canonicalize_url
+);
 
+
+=head1 NAME
+
+Git::SVN::Utils - utility functions used across Git::SVN
+
+=head1 SYNOPSIS
+
+    use Git::SVN::Utils qw(functions to import);
+
+=head1 DESCRIPTION
+
+This module contains functions which are useful across many different
+parts of Git::SVN.  Mostly it's a place to put utility functions
+rather than duplicate the code or have classes grabbing at other
+classes.
+
+=head1 FUNCTIONS
+
+All functions can be imported only on request.
+
+=head3 fatal
+
+    fatal(@message);
+
+Display a message and exit with a fatal error code.
+
+=cut
+
+# Note: not certain why this is in use instead of die.  Probably because
+# the exit code of die is 255?  Doesn't appear to be used consistently.
 sub fatal (@) { print STDERR "@_\n"; exit 1 }
 
+
+=head3 can_compress
+
+    my $can_compress = can_compress;
+
+Returns true if Compress::Zlib is available, false otherwise.
+
+=cut
+
 my $can_compress;
 sub can_compress {
     return $can_compress if defined $can_compress;
@@ -16,4 +60,81 @@ sub can_compress {
     return $can_compress = eval { require Compress::Zlib; } ? 1 : 0;
 }
 
+
+=head3 canonicalize_path
+
+    my $canonical_path = canonicalize_path($path);
+
+Cleans up the $path so its acceptable to the SVN API's strict idea of
+what a path should look like.
+
+=cut
+
+# SVN 1.7 changed its canonicalization API, so decide on the best way to handle the problem.
+sub canonicalize_path {
+    my $path = shift;
+
+    # The 1.7 way to do it
+    if( defined &SVN::_Core::svn_dirent_canonicalize ) {
+        return SVN::_Core::svn_dirent_canonicalize($path);
+    }
+    # The 1.6 way to do it
+    elsif( defined &SVN::_Core::svn_path_canonicalize ) {
+        return SVN::_Core::svn_path_canonicalize($path);
+    }
+    # No SVN API canonicalization is available, do it ourselves
+    else {
+        return _canonicalize_path_ourselves($path);
+    }
+}
+
+
+# A pure Perl implementation of path canonicalization in case the SVN
+# API ones are unavailable.
+sub _canonicalize_path_ourselves {
+	my ($path) = @_;
+	my $dot_slash_added = 0;
+	if (substr($path, 0, 1) ne "/") {
+		$path = "./" . $path;
+		$dot_slash_added = 1;
+	}
+	# File::Spec->canonpath doesn't collapse x/../y into y (for a
+	# good reason), so let's do this manually.
+	$path =~ s#/+#/#g;
+	$path =~ s#/\.(?:/|$)#/#g;
+	$path =~ s#/[^/]+/\.\.##g;
+	$path =~ s#/$##g;
+	$path =~ s#^\./## if $dot_slash_added;
+	$path =~ s#^/##;
+	$path =~ s#^\.$##;
+	return $path;
+}
+
+
+=head3 canonicalize_url
+
+    my $canonical_url = canonicalize_url($url);
+
+Cleans up the $url so its acceptable to the SVN API's strict idea of
+what a URL should look like.
+
+=cut
+
+# SVN 1.7 changed its canonicalization API, so decide on the best way to handle the problem.
+sub canonicalize_url {
+    my $url = shift;
+
+    # The 1.7 way to do it
+    if( defined &SVN::_Core::svn_uri_canonicalize ) {
+        $url = SVN::_Core::svn_uri_canonicalize($url);
+    }
+    # There wasn't a 1.6 way to do it, so we do it ourself.
+    else {
+        $url =~ s#^([^:]+://[^/]*/)(.*)$#$1 . canonicalize_path($2)#e;
+    }
+
+    return $url;
+}
+
+
 1;
diff --git a/t/Git-SVN/Ra/fix_dir.t b/t/Git-SVN/Ra/fix_dir.t
new file mode 100644
index 00000000..ec0c858a
--- /dev/null
+++ b/t/Git-SVN/Ra/fix_dir.t
@@ -0,0 +1,24 @@
+#!/usr/bin/env perl
+
+use strict;
+use warnings;
+
+use Test::More 'no_plan';
+
+my $CLASS = 'Git::SVN::Ra';
+require_ok $CLASS;
+
+my %tests = (
+    "foo/.."            => "",
+    "/foo/.."           => "/",
+    "."                 => "",
+    "foo/../"           => "",
+    "foo/bar/baz"       => "foo/bar/baz",
+    "foo/bar/../baz"    => "foo/baz",
+);
+
+for my $have (keys %tests) {
+    my $want = $tests{$have};
+
+    is $CLASS->fix_dir($have), $want, "fix_dir $have => $want";
+}
diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 199f22c2..c6911cdf 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -68,6 +68,8 @@ svn_cmd () {
 	svn "$orig_svncmd" --config-dir "$svnconf" "$@"
 }
 
+SVN_VERSION=`svn_cmd --version | sed -n -e 's/^svn, version \(1\.[0-9]*\.[0-9]*\).*$/\1/p'`
+
 prepare_httpd () {
 	for d in \
 		"$SVN_HTTPD_PATH" \
diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index 63fc982c..66787acc 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -32,6 +32,10 @@ test_expect_success 'setup svnrepo' '
 	start_httpd
 	'
 
+# SVN 1.7 will truncate "not-a%40{0]" to just "not-a".
+# Look at what SVN wound up naming the branch and use that.
+non_reflog=`svn_cmd ls "$svnrepo/pr ject/branches" | grep not-a | sed 's/\///'`
+
 test_expect_success 'test clone with funky branch names' '
 	git svn clone -s "$svnrepo/pr ject" project &&
 	(
@@ -42,7 +46,7 @@ test_expect_success 'test clone with funky branch names' '
 		git rev-parse "refs/remotes/%2Eleading_dot" &&
 		git rev-parse "refs/remotes/trailing_dot%2E" &&
 		git rev-parse "refs/remotes/trailing_dotlock%2Elock" &&
-		git rev-parse "refs/remotes/not-a%40{0}reflog"
+		git rev-parse "refs/remotes/$non_reflog"
 	)
 	'
 
diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index ff19695e..9b6075c6 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -6,14 +6,11 @@ test_description='git svn info'
 
 . ./lib-git-svn.sh
 
-# Tested with: svn, version 1.4.4 (r25188)
-# Tested with: svn, version 1.6.[12345689]
-v=`svn_cmd --version | sed -n -e 's/^svn, version \(1\.[0-9]*\.[0-9]*\).*$/\1/p'`
-case $v in
+case $SVN_VERSION in
 1.[456].*)
 	;;
 *)
-	skip_all="skipping svn-info test (SVN version: $v not supported)"
+	skip_all="skipping svn-info test (SVN version: $SVN_VERSION not supported)"
 	test_done
 	;;
 esac
