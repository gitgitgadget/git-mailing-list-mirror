From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] git svn: Support multiple branch and tag paths in the svn
 repository.
Date: Tue, 23 Jun 2009 13:02:08 -0400
Message-ID: <4A410A90.1090101@xiplink.com>
References: <4A3A4945.6050307@drmicha.warpmail.net> <1245335463-4488-1-git-send-email-git@drmicha.warpmail.net> <4A3F9A44.8070805@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 23 19:03:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ9Oo-0000Sk-2k
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 19:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761292AbZFWRCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 13:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761295AbZFWRCe
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 13:02:34 -0400
Received: from smtp162.dfw.emailsrvr.com ([67.192.241.162]:50663 "EHLO
	smtp162.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758566AbZFWRCc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 13:02:32 -0400
Received: from relay6.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay6.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id F21DD3025D
	for <git@vger.kernel.org>; Tue, 23 Jun 2009 13:02:34 -0400 (EDT)
Received: by relay6.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 714DA30188;
	Tue, 23 Jun 2009 13:02:29 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <4A3F9A44.8070805@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122102>

This enables git-svn.perl to read multiple 'branches' and 'tags' entries in
svn-remote config sections.  The init and clone subcommands also support
multiple --branches and --tags arguments.

The branch (and tag) subcommand gets a new argument: --destination (or -d).
This argument is required if there are multiple branches (or tags) entries
configured for the remote Subversion repository.  The argument's value
specifies which branch (or tag) path to use to create the branch (or tag).
The specified value must match the left side (without wildcards) of one of
the branches (or tags) refspecs in the svn-remote's config.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

I got carried away making unit tests and went and implemented most of this...

I'm fairly happy with this, except for the way the branch subcommand matches
refspecs.  The patch does a simple string comparison, but it'd be better to do
an actual glob.  I just couldn't track down the right function for that, so I
left it as a strcmp and hope that a gitizen can tell me how to glob here.

(ps. I'm trying a new way to send patches -- apologies if it's mangled!)

 git-svn.perl                         |   79 +++++++++++++++++-------
 t/t9138-git-svn-multiple-branches.sh |  114 ++++++++++++++++++++++++++++++++++
 2 files changed, 171 insertions(+), 22 deletions(-)
 create mode 100755 t/t9138-git-svn-multiple-branches.sh

diff --git a/git-svn.perl b/git-svn.perl
index ef1d30d..0f2cb8d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -62,7 +62,7 @@ my ($SVN);
 $sha1 = qr/[a-f\d]{40}/;
 $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_stdin, $_help, $_edit,
-	$_message, $_file,
+	$_message, $_file, $_branch_dest,
 	$_template, $_shared,
 	$_version, $_fetch_all, $_no_rebase, $_fetch_parent,
 	$_merge, $_strategy, $_dry_run, $_local,
@@ -90,11 +90,11 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'localtime' => \$Git::SVN::_localtime,
 		%remote_opts );
 
-my ($_trunk, $_tags, $_branches, $_stdlayout);
+my ($_trunk, @_tags, @_branches, $_stdlayout);
 my %icv;
 my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
-                  'trunk|T=s' => \$_trunk, 'tags|t=s' => \$_tags,
-                  'branches|b=s' => \$_branches, 'prefix=s' => \$_prefix,
+                  'trunk|T=s' => \$_trunk, 'tags|t=s@' => \@_tags,
+                  'branches|b=s@' => \@_branches, 'prefix=s' => \$_prefix,
                   'stdlayout|s' => \$_stdlayout,
                   'minimize-url|m' => \$Git::SVN::_minimize_url,
 		  'no-metadata' => sub { $icv{noMetadata} = 1 },
@@ -139,11 +139,13 @@ my %cmd = (
 	branch => [ \&cmd_branch,
 	            'Create a branch in the SVN repository',
 	            { 'message|m=s' => \$_message,
+	              'destination|d=s' => \$_branch_dest,
 	              'dry-run|n' => \$_dry_run,
 		      'tag|t' => \$_tag } ],
 	tag => [ sub { $_tag = 1; cmd_branch(@_) },
 	         'Create a tag in the SVN repository',
 	         { 'message|m=s' => \$_message,
+	           'destination|d=s' => \$_branch_dest,
 	           'dry-run|n' => \$_dry_run } ],
 	'set-tree' => [ \&cmd_set_tree,
 	                "Set an SVN repository to a git tree-ish",
@@ -353,7 +355,7 @@ sub init_subdir {
 sub cmd_clone {
 	my ($url, $path) = @_;
 	if (!defined $path &&
-	    (defined $_trunk || defined $_branches || defined $_tags ||
+	    (defined $_trunk || @_branches || @_tags ||
 	     defined $_stdlayout) &&
 	    $url !~ m#^[a-z\+]+://#) {
 		$path = $url;
@@ -366,10 +368,10 @@ sub cmd_clone {
 sub cmd_init {
 	if (defined $_stdlayout) {
 		$_trunk = 'trunk' if (!defined $_trunk);
-		$_tags = 'tags' if (!defined $_tags);
-		$_branches = 'branches' if (!defined $_branches);
+		@_tags = 'tags' if (! @_tags);
+		@_branches = 'branches' if (! @_branches);
 	}
-	if (defined $_trunk || defined $_branches || defined $_tags) {
+	if (defined $_trunk || @_branches || @_tags) {
 		return cmd_multi_init(@_);
 	}
 	my $url = shift or die "SVN repository location required ",
@@ -587,7 +589,31 @@ sub cmd_branch {
 	my ($src, $rev, undef, $gs) = working_head_info($head);
 
 	my $remote = Git::SVN::read_all_remotes()->{$gs->{repo_id}};
-	my $glob = $remote->{ $_tag ? 'tags' : 'branches' };
+	my $allglobs = $remote->{ $_tag ? 'tags' : 'branches' };
+	my $glob;
+	if ($#{$allglobs} == 0) {
+		$glob = $allglobs->[0];
+	} else {
+		unless(defined $_branch_dest) {
+			die "Multiple ",
+			    $_tag ? "tag" : "branch",
+			    " paths defined for Subversion repository.\n",
+		            "You must specify where you want to create the ",
+		            $_tag ? "tag" : "branch",
+		            " with the --destination argument.\n";
+		}
+		foreach my $g (@{$allglobs}) {
+			if ($_branch_dest eq $g->{path}->{left}) {
+				$glob = $g;
+				last;
+			}
+		}
+		unless (defined $glob) {
+			die "Unknown ",
+			    $_tag ? "tag" : "branch",
+			    " destination $_branch_dest\n";
+		}
+	}
 	my ($lft, $rgt) = @{ $glob->{path} }{qw/left right/};
 	my $dst = join '/', $remote->{url}, $lft, $branch_name, ($rgt || ());
 
@@ -794,7 +820,7 @@ sub cmd_proplist {
 
 sub cmd_multi_init {
 	my $url = shift;
-	unless (defined $_trunk || defined $_branches || defined $_tags) {
+	unless (defined $_trunk || @_branches || @_tags) {
 		usage(1);
 	}
 
@@ -819,10 +845,14 @@ sub cmd_multi_init {
 						   undef, $trunk_ref);
 		}
 	}
-	return unless defined $_branches || defined $_tags;
+	return unless @_branches || @_tags;
 	my $ra = $url ? Git::SVN::Ra->new($url) : undef;
-	complete_url_ls_init($ra, $_branches, '--branches/-b', $_prefix);
-	complete_url_ls_init($ra, $_tags, '--tags/-t', $_prefix . 'tags/');
+	foreach my $path (@_branches) {
+		complete_url_ls_init($ra, $path, '--branches/-b', $_prefix);
+	}
+	foreach my $path (@_tags) {
+		complete_url_ls_init($ra, $path, '--tags/-t', $_prefix.'tags/');
+	}
 }
 
 sub cmd_multi_fetch {
@@ -1093,6 +1123,7 @@ sub complete_url_ls_init {
 		die "--prefix='$pfx' must have a trailing slash '/'\n";
 	}
 	command_noisy('config',
+		      '--add',
 	              "svn-remote.$gs->{repo_id}.$n",
 	              "$remote_path:refs/remotes/$pfx*" .
 	                ('/*' x (($remote_path =~ tr/*/*/) - 1)) );
@@ -1548,7 +1579,9 @@ sub fetch_all {
 	# read the max revs for wildcard expansion (branches/*, tags/*)
 	foreach my $t (qw/branches tags/) {
 		defined $remote->{$t} or next;
-		push @globs, $remote->{$t};
+		foreach my $b (@{$remote->{$t}}) {
+		    push @globs, $b;
+		}
 		my $max_rev = eval { tmp_config(qw/--int --get/,
 		                         "svn-remote.$repo_id.${t}-maxRev") };
 		if (defined $max_rev && ($max_rev < $base)) {
@@ -1595,15 +1628,16 @@ sub read_all_remotes {
 		} elsif (m!^(.+)\.(branches|tags)=
 		           (.*):refs/remotes/(.+)\s*$/!x) {
 			my ($p, $g) = ($3, $4);
-			my $rs = $r->{$1}->{$2} = {
-			                  t => $2,
-					  remote => $1,
-			                  path => Git::SVN::GlobSpec->new($p),
-			                  ref => Git::SVN::GlobSpec->new($g) };
+			my $rs = {
+			    t => $2,
+			    remote => $1,
+			    path => Git::SVN::GlobSpec->new($p),
+			    ref => Git::SVN::GlobSpec->new($g) };
 			if (length($rs->{ref}->{right}) != 0) {
 				die "The '*' glob character must be the last ",
 				    "character of '$g'\n";
 			}
+			push @{ $r->{$1}->{$2} }, $rs;
 		}
 	}
 
@@ -1743,9 +1777,10 @@ sub find_by_url { # repos_root and, path are optional
 		next if defined $repos_root && $repos_root ne $u;
 
 		my $fetch = $remotes->{$repo_id}->{fetch} || {};
-		foreach (qw/branches tags/) {
-			resolve_local_globs($u, $fetch,
-			                    $remotes->{$repo_id}->{$_});
+		foreach my $t (qw/branches tags/) {
+			foreach my $globspec (@{$remotes->{$repo_id}->{$t}}) {
+				resolve_local_globs($u, $fetch, $globspec);
+			}
 		}
 		my $p = $path;
 		my $rwr = rewrite_root({repo_id => $repo_id});
diff --git a/t/t9138-git-svn-multiple-branches.sh b/t/t9138-git-svn-multiple-branches.sh
new file mode 100755
index 0000000..9725ccf
--- /dev/null
+++ b/t/t9138-git-svn-multiple-branches.sh
@@ -0,0 +1,114 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Marc Branchaud
+#
+
+test_description='git svn multiple branch and tag paths in the svn repo'
+. ./lib-git-svn.sh
+
+test_expect_success 'setup svnrepo' '
+	mkdir	project \
+		project/trunk \
+		project/b_one \
+		project/b_two \
+		project/tags_A \
+		project/tags_B &&
+	echo 1 > project/trunk/a.file &&
+	svn import -m "$test_description" project "$svnrepo/project" &&
+	rm -rf project &&
+	svn cp -m "Branch 1" "$svnrepo/project/trunk" \
+			     "$svnrepo/project/b_one/first" &&
+	svn cp -m "Tag 1" "$svnrepo/project/trunk" \
+			  "$svnrepo/project/tags_A/1.0" &&
+	svn co "$svnrepo/project" svn_project &&
+	cd svn_project &&
+		.
+		echo 2 > trunk/a.file &&
+		svn ci -m "Change 1" trunk/a.file &&
+		svn cp -m "Branch 2" "$svnrepo/project/trunk" \
+				     "$svnrepo/project/b_one/second" &&
+		svn cp -m "Tag 2" "$svnrepo/project/trunk" \
+				  "$svnrepo/project/tags_A/2.0" &&
+		echo 3 > trunk/a.file &&
+		svn ci -m "Change 2" trunk/a.file &&
+		svn cp -m "Branch 3" "$svnrepo/project/trunk" \
+				     "$svnrepo/project/b_two/1" &&
+		svn cp -m "Tag 3" "$svnrepo/project/trunk" \
+				  "$svnrepo/project/tags_A/3.0" &&
+		echo 4 > trunk/a.file &&
+		svn ci -m "Change 3" trunk/a.file &&
+		svn cp -m "Branch 4" "$svnrepo/project/trunk" \
+				     "$svnrepo/project/b_two/2" &&
+		svn cp -m "Tag 4" "$svnrepo/project/trunk" \
+				  "$svnrepo/project/tags_A/4.0" &&
+		svn up &&
+		echo 5 > b_one/first/a.file &&
+		svn ci -m "Change 4" b_one/first/a.file &&
+		svn cp -m "Tag 5" "$svnrepo/project/b_one/first" \
+				  "$svnrepo/project/tags_B/v5" &&
+		echo 6 > b_one/second/a.file &&
+		svn ci -m "Change 5" b_one/second/a.file &&
+		svn cp -m "Tag 6" "$svnrepo/project/b_one/second" \
+				  "$svnrepo/project/tags_B/v6" &&
+		echo 7 > b_two/1/a.file &&
+		svn ci -m "Change 6" b_two/1/a.file &&
+		svn cp -m "Tag 7" "$svnrepo/project/b_two/1" \
+				  "$svnrepo/project/tags_B/v7" &&
+		echo 8 > b_two/2/a.file &&
+		svn ci -m "Change 7" b_two/2/a.file &&
+		svn cp -m "Tag 8" "$svnrepo/project/b_two/2" \
+				  "$svnrepo/project/tags_B/v8" &&
+	cd ..
+	'
+
+test_expect_success 'clone multiple branch and tag paths' '
+	git svn clone -T trunk \
+		      -b b_one/* --branches b_two/* \
+		      -t tags_A/* --tags tags_B \
+		      "$svnrepo/project" git_project &&
+	cd git_project &&
+		git rev-parse refs/remotes/first &&
+		git rev-parse refs/remotes/second &&
+		git rev-parse refs/remotes/1 &&
+		git rev-parse refs/remotes/2 &&
+		git rev-parse refs/remotes/tags/1.0 &&
+		git rev-parse refs/remotes/tags/2.0 &&
+		git rev-parse refs/remotes/tags/3.0 &&
+		git rev-parse refs/remotes/tags/4.0 &&
+		git rev-parse refs/remotes/tags/v5 &&
+		git rev-parse refs/remotes/tags/v6 &&
+		git rev-parse refs/remotes/tags/v7 &&
+		git rev-parse refs/remotes/tags/v8 &&
+	cd ..
+	'
+
+test_expect_success 'Multiple branch or tag paths require -d' '
+	cd git_project &&
+		test_must_fail git svn branch -m "No new branch" Nope &&
+		test_must_fail git svn tag -m "No new tag" Tagless &&
+		test_must_fail git rev-parse refs/remotes/Nope &&
+		test_must_fail git rev-parse refs/remotes/tags/Tagless &&
+	cd ../svn_project &&
+		svn up &&
+		test_must_fail test -d b_one/Nope &&
+		test_must_fail test -d b_two/Nope &&
+		test_must_fail test -d tags_A/Tagless &&
+		test_must_fail test -d tags_B/Tagless &&
+	cd ..
+	'
+
+test_expect_success 'create new branches and tags' '
+	( cd git_project && git svn branch -m "New branch 1" -d project/b_one New1 ) &&
+	( cd svn_project && svn up && test -e b_one/New1/a.file ) &&
+
+	( cd git_project && git svn branch -m "New branch 2" -d project/b_two New2 ) &&
+	( cd svn_project && svn up && test -e b_two/New2/a.file ) &&
+
+	( cd git_project && git svn branch -t -m "New tag 1" -d project/tags_A Tag1 ) &&
+	( cd svn_project && svn up && test -e tags_A/Tag1/a.file )
+
+	( cd git_project && git svn tag -m "New tag 2" -d project/tags_B Tag2 ) &&
+	( cd svn_project && svn up && test -e tags_B/Tag2/a.file )
+	'
+
+test_done
-- 
1.6.3.3
