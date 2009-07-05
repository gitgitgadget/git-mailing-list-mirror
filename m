From: Mattias Nissler <mattias.nissler@gmx.de>
Subject: [PATCH/RFC] git-svn: Fix branch detection when repository root is
 inaccessible
Date: Sun, 05 Jul 2009 13:51:45 +0200
Message-ID: <1246794706.4818.33.camel@kea>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 05 13:52:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNQGM-0002R7-Az
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 13:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754349AbZGELvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 07:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754127AbZGELvq
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 07:51:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:58742 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753145AbZGELvp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2009 07:51:45 -0400
Received: (qmail invoked by alias); 05 Jul 2009 11:51:47 -0000
Received: from e182068013.adsl.alicedsl.de (EHLO [192.168.1.50]) [85.182.68.13]
  by mail.gmx.net (mp069) with SMTP; 05 Jul 2009 13:51:47 +0200
X-Authenticated: #429267
X-Provags-ID: V01U2FsdGVkX1+SbLUYDqCSDI8sK4iZOdN/T5LKMQ1Kk4gMr/08sm
	2LNulnyRaZtfJh
X-Mailer: Evolution 2.26.2 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122739>

For the case of multiple projects sharing a single SVN repository, it is
common practice to create the standard SVN directory layout within a
subdirectory for each project. In such setups, access control is often
used to limit what projects a given user may access. git-svn failed to
detect branches (e.g. when passing --stdlayout to clone) because it
relied on having access to the root directory in the repository. This
patch solves this problem by making git-svn use paths relative to the
given repository URL instead of the repository root.

Signed-off-by: Mattias Nissler <mattias.nissler@gmx.de>
---

I've already posted this on May 31st but received no feedback, so here
is the patch again against current git.git. I'm using this at work to be
able to checkout a complete SVN project including all branches and tags
in one go without having to create an individual remote for each branch
and tag. Any chance we can get this into mainline git?

Cheers,

Mattias


 git-svn.perl |   83 +++++++++++++++++++++++++--------------------------------
 1 files changed, 36 insertions(+), 47 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index d1af1a3..cc15731 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -876,10 +876,6 @@ sub cmd_multi_init {
 		usage(1);
 	}
 
-	# there are currently some bugs that prevent multi-init/multi-fetch
-	# setups from working well without this.
-	$Git::SVN::_minimize_url = 1;
-
 	$_prefix = '' unless defined $_prefix;
 	if (defined $url) {
 		$url = canonicalize_url($url);
@@ -1180,7 +1176,7 @@ sub complete_url_ls_init {
 		    "wanted to set to: $gs->{url}\n";
 	}
 	command_oneline('config', $k, $gs->{url}) unless $orig_url;
-	my $remote_path = "$ra->{svn_path}/$repo_path";
+	my $remote_path = "$gs->{path}/$repo_path";
 	$remote_path =~ s#/+#/#g;
 	$remote_path =~ s#^/##g;
 	$remote_path .= "/*" if $remote_path !~ /\*/;
@@ -2177,16 +2173,6 @@ sub ra {
 	$ra;
 }
 
-sub rel_path {
-	my ($self) = @_;
-	my $repos_root = $self->ra->{repos_root};
-	return $self->{path} if ($self->{url} eq $repos_root);
-	my $url = $self->{url} .
-	          (length $self->{path} ? "/$self->{path}" : $self->{path});
-	$url =~ s!^\Q$repos_root\E(?:/+|$)!!g;
-	$url;
-}
-
 # prop_walk(PATH, REV, SUB)
 # -------------------------
 # Recursively traverse PATH at revision REV and invoke SUB for each
@@ -2512,10 +2498,7 @@ sub match_paths {
 	if (my $path = $paths->{"/$self->{path}"}) {
 		return ($path->{action} eq 'D') ? 0 : 1;
 	}
-	my $repos_root = $self->ra->{repos_root};
-	my $extended_path = $self->{url} . '/' . $self->{path};
-	$extended_path =~ s#^\Q$repos_root\E(/|$)##;
-	$self->{path_regex} ||= qr/^\/\Q$extended_path\E\//;
+	$self->{path_regex} ||= qr/^\/\Q$self->{path}\E\//;
 	if (grep /$self->{path_regex}/, keys %$paths) {
 		return 1;
 	}
@@ -2538,15 +2521,14 @@ sub find_parent_branch {
 	unless (defined $paths) {
 		my $err_handler = $SVN::Error::handler;
 		$SVN::Error::handler = \&Git::SVN::Ra::skip_unknown_revs;
-		$self->ra->get_log([$self->{path}], $rev, $rev, 0, 1, 1, sub {
-		                   $paths =
-				      Git::SVN::Ra::dup_changed_paths($_[0]) });
+		$self->ra->get_log([$self->{path}], $rev, $rev, 0, 1, 1,
+			sub { $paths = $_[0] });
 		$SVN::Error::handler = $err_handler;
 	}
 	return undef unless defined $paths;
 
 	# look for a parent from another branch:
-	my @b_path_components = split m#/#, $self->rel_path;
+	my @b_path_components = split m#/#, $self->{path};
 	my @a_path_components;
 	my $i;
 	while (@b_path_components) {
@@ -2564,11 +2546,11 @@ sub find_parent_branch {
 	my $r = $i->{copyfrom_rev};
 	my $repos_root = $self->ra->{repos_root};
 	my $url = $self->ra->{url};
-	my $new_url = $repos_root . $branch_from;
+	my $new_url = $url . $branch_from;
 	print STDERR  "Found possible branch point: ",
 	              "$new_url => ", $self->full_url, ", $r\n";
 	$branch_from =~ s#^/##;
-	my $gs = $self->other_gs($new_url, $url, $repos_root,
+	my $gs = $self->other_gs($new_url, $url,
 		                 $branch_from, $r, $self->{ref_id});
 	my ($r0, $parent) = $gs->find_rev_before($r, 1);
 	{
@@ -2753,9 +2735,9 @@ sub parse_svn_date {
 }
 
 sub other_gs {
-	my ($self, $new_url, $url, $repos_root,
+	my ($self, $new_url, $url,
 	    $branch_from, $r, $old_ref_id) = @_;
-	my $gs = Git::SVN->find_by_url($new_url, $repos_root, $branch_from);
+	my $gs = Git::SVN->find_by_url($new_url, $url, $branch_from);
 	unless ($gs) {
 		my $ref_id = $old_ref_id;
 		$ref_id =~ s/\@\d+$//;
@@ -4431,6 +4413,31 @@ sub get_log {
 	my ($self, @args) = @_;
 	my $pool = SVN::Pool->new;
 
+	# svn_log_changed_path_t objects passed to get_log are likely to be
+	# overwritten even if only the refs are copied to an external variable,
+	# so we should dup the structures in their entirety.  Using an
+	# externally passed pool (instead of our temporary and quickly cleared
+	# pool in Git::SVN::Ra) does not help matters at all...
+	my $receiver = pop @args;
+	my $prefix = "/".$self->{svn_path};
+	$prefix =~ s#/+($)##;
+	my $prefix_regex = qr#^\Q$prefix\E#;
+	push(@args, sub {
+		my ($paths) = $_[0];
+		return &$receiver(@_) unless $paths;
+		$_[0] = ();
+		foreach my $p (keys %$paths) {
+			my $i = $paths->{$p};
+			# Make path relative to our url, not repos_root
+			$p =~ s/$prefix_regex//;
+			my %s = map { $_ => $i->$_; }
+				qw/copyfrom_path copyfrom_rev action/;
+			$s{'copyfrom_path'} =~ s/$prefix_regex// if $s{'copyfrom_path'};
+			$_[0]{$p} = \%s;
+		}
+		&$receiver(@_);
+	});
+
 	# the limit parameter was not supported in SVN 1.1.x, so we
 	# drop it.  Therefore, the receiver callback passed to it
 	# is made aware of this limitation by being wrapped if
@@ -4442,6 +4449,7 @@ sub get_log {
 			push(@args, sub { &$receiver(@_) if (--$limit >= 0) });
 		}
 	}
+
 	my $ret = $self->SUPER::get_log(@args, $pool);
 	$pool->clear;
 	$ret;
@@ -4600,8 +4608,7 @@ sub gs_fetch_loop_common {
 		};
 		sub _cb {
 			my ($paths, $r, $author, $date, $log) = @_;
-			[ dup_changed_paths($paths),
-			  { author => $author, date => $date, log => $log } ];
+			[ $paths, { author => $author, date => $date, log => $log } ];
 		}
 		$self->get_log([$longest_path], $min, $max, 0, 1, 1,
 		               sub { $revs{$_[1]} = _cb(@_) });
@@ -4823,24 +4830,6 @@ sub skip_unknown_revs {
 	die "Error from SVN, ($errno): ", $err->expanded_message,"\n";
 }
 
-# svn_log_changed_path_t objects passed to get_log are likely to be
-# overwritten even if only the refs are copied to an external variable,
-# so we should dup the structures in their entirety.  Using an externally
-# passed pool (instead of our temporary and quickly cleared pool in
-# Git::SVN::Ra) does not help matters at all...
-sub dup_changed_paths {
-	my ($paths) = @_;
-	return undef unless $paths;
-	my %ret;
-	foreach my $p (keys %$paths) {
-		my $i = $paths->{$p};
-		my %s = map { $_ => $i->$_ }
-		              qw/copyfrom_path copyfrom_rev action/;
-		$ret{$p} = \%s;
-	}
-	\%ret;
-}
-
 package Git::SVN::Log;
 use strict;
 use warnings;
-- 
1.6.3.3
