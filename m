From: Mattias Nissler <mattias.nissler@gmx.de>
Subject: [PATCH 2/2] git-svn: Fix branch detection when repository root is
 inaccessible
Date: Tue, 07 Jul 2009 01:40:02 +0200
Message-ID: <1246923602.4618.18.camel@kea>
References: <20090706212742.GA8219@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jul 07 01:40:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNxn7-0005bV-Le
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 01:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbZGFXkC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 19:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753272AbZGFXkC
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 19:40:02 -0400
Received: from mail.gmx.net ([213.165.64.20]:53965 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753187AbZGFXkB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 19:40:01 -0400
Received: (qmail invoked by alias); 06 Jul 2009 23:40:03 -0000
Received: from e182067244.adsl.alicedsl.de (EHLO [192.168.1.50]) [85.182.67.244]
  by mail.gmx.net (mp012) with SMTP; 07 Jul 2009 01:40:03 +0200
X-Authenticated: #429267
X-Provags-ID: V01U2FsdGVkX184NaAMjp04WSz3O3NqY+lZUbS21L9seBy+ZF6R8G
	FdneBX2oRhB+z3
In-Reply-To: <20090706212742.GA8219@dcvr.yhbt.net>
X-Mailer: Evolution 2.26.2 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122810>

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
 git-svn.perl                         |   42 +++++++++++++---------------------
 t/t9138-git-svn-multiple-branches.sh |    8 +++---
 2 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 57d13af..cf3948c 100755
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
@@ -2545,7 +2528,7 @@ sub find_parent_branch {
 	return undef unless defined $paths;
 
 	# look for a parent from another branch:
-	my @b_path_components = split m#/#, $self->rel_path;
+	my @b_path_components = split m#/#, $self->{path};
 	my @a_path_components;
 	my $i;
 	while (@b_path_components) {
@@ -2563,11 +2546,11 @@ sub find_parent_branch {
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
@@ -2752,9 +2735,9 @@ sub parse_svn_date {
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
@@ -4436,14 +4419,20 @@ sub get_log {
 	# passed pool (instead of our temporary and quickly cleared pool in
 	# Git::SVN::Ra) does not help matters at all...
 	my $receiver = pop @args;
+	my $prefix = "/".$self->{svn_path};
+	$prefix =~ s#/+($)##;
+	my $prefix_regex = qr#^\Q$prefix\E#;
 	push(@args, sub {
 		my ($paths) = $_[0];
 		return &$receiver(@_) unless $paths;
 		$_[0] = ();
 		foreach my $p (keys %$paths) {
 			my $i = $paths->{$p};
-			my %s = map { $_ => $i->$_ }
-				      qw/copyfrom_path copyfrom_rev action/;
+			# Make path relative to our url, not repos_root
+			$p =~ s/$prefix_regex//;
+			my %s = map { $_ => $i->$_; }
+				qw/copyfrom_path copyfrom_rev action/;
+			$s{'copyfrom_path'} =~ s/$prefix_regex// if $s{'copyfrom_path'};
 			$_[0]{$p} = \%s;
 		}
 		&$receiver(@_);
@@ -4461,6 +4450,7 @@ sub get_log {
 			push(@args, sub { &$receiver(@_) if (--$limit >= 0) });
 		}
 	}
+
 	my $ret = $self->SUPER::get_log(@args, $pool);
 	$pool->clear;
 	$ret;
diff --git a/t/t9138-git-svn-multiple-branches.sh b/t/t9138-git-svn-multiple-branches.sh
index cb9a6d2..3cd0671 100755
--- a/t/t9138-git-svn-multiple-branches.sh
+++ b/t/t9138-git-svn-multiple-branches.sh
@@ -99,22 +99,22 @@ test_expect_success 'Multiple branch or tag paths require -d' '
 
 test_expect_success 'create new branches and tags' '
 	( cd git_project &&
-		git svn branch -m "New branch 1" -d project/b_one New1 ) &&
+		git svn branch -m "New branch 1" -d b_one New1 ) &&
 	( cd svn_project &&
 		svn_cmd up && test -e b_one/New1/a.file ) &&
 
 	( cd git_project &&
-		git svn branch -m "New branch 2" -d project/b_two New2 ) &&
+		git svn branch -m "New branch 2" -d b_two New2 ) &&
 	( cd svn_project &&
 		svn_cmd up && test -e b_two/New2/a.file ) &&
 
 	( cd git_project &&
-		git svn branch -t -m "New tag 1" -d project/tags_A Tag1 ) &&
+		git svn branch -t -m "New tag 1" -d tags_A Tag1 ) &&
 	( cd svn_project &&
 		svn_cmd up && test -e tags_A/Tag1/a.file ) &&
 
 	( cd git_project &&
-		git svn tag -m "New tag 2" -d project/tags_B Tag2 ) &&
+		git svn tag -m "New tag 2" -d tags_B Tag2 ) &&
 	( cd svn_project &&
 		svn_cmd up && test -e tags_B/Tag2/a.file )
 '
-- 
1.6.3.3
