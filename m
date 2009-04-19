From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH] git-svn: teach to create and operate on bare repositories
Date: Sun, 19 Apr 2009 21:57:54 +0400
Message-ID: <lGoUDENjg0Z+sDE9v/txzTLyfk8@7qgLKkvX/1U6eu9avhKQpU/1pEI>
Reply-To: rea-git@codelabs.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Apr 19 20:20:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvbcc-0005Ab-Ku
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 20:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727AbZDSSSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 14:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754277AbZDSSSa
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 14:18:30 -0400
Received: from 0.mx.codelabs.ru ([144.206.177.45]:65307 "EHLO 0.mx.codelabs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754090AbZDSSS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 14:18:29 -0400
X-Greylist: delayed 1227 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Apr 2009 14:18:28 EDT
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:Content-Disposition:Sender;
	b=Dn7E6A2LUbGem1e6TvJAz6XN4q28RCNSHEZNkxCJADniCCGz3bs+UFCbg0OUfbwnNRjlGOWvX8Mjbiojo9p7792xKfEXEA1nwYcNEQt+5N8bDUeewhTq+T/q694sIetShp6hyetjAkjLdj/gjZMs8ePXnfHZcif9NB/4l/DJSgs=;
Received: from amnesiac.at.no.dns (ppp91-77-11-130.pppoe.mtu-net.ru [91.77.11.130])
	by 0.mx.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1LvbHC-000FTv-TI; Sun, 19 Apr 2009 21:57:59 +0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116907>

This mode is useful when we're mirrorring one-to-one Subversion and Git
repositories and then using Git as the repository to base other work on.

Bare mode is currently restricted only to init, clone, fetch, log,
find-rev, show-ignore, show-externals, create-ignore, propget, proplist
and info commands.  Others won't work at all and error message will
be produced.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 Documentation/git-svn.txt |   23 ++++++++
 git-svn.perl              |  130 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 149 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 9229d45..4749676 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -104,6 +104,10 @@ COMMANDS
 --parent;;
 	Fetch only from the SVN parent of the current HEAD.
 
+--bare;;
+	Creates bare repository without checked-out copy.  See section
+	BARE REPOSITORIES for details.
+
 This doesn't interfere with interoperating with the Subversion
 repository you cloned from, but if you wish for your local Git
 repository to be able to interoperate with someone else's local Git
@@ -537,6 +541,25 @@ and these settings should never be changed once they are set.
 Additionally, only one of these four options can be used per-svn-remote
 section because they affect the 'git-svn-id:' metadata line.
 
+BARE REPOSITORIES
+-----------------
+
+Bare repositories are most suitable for serving them via 'git-daemon',
+so they can be used when one wants to convert Subversion repository to
+Git and base the work on the created Git repository.  This was the
+initial idea of adding support for such repositories: repository is
+thought to be read-only for Git clients, but could be updated via 'git
+svn fetch' to catch changes in Subversion repository.
+
+Only subset of all 'git svn' commands are available for bare
+repositories: init, clone, fetch, log, find-rev, show-ignore,
+show-externals, create-ignore, propget, proplist and info.
+
+One certainly could push to bare repository that is maintained by
+'git-svn', but merges are not supported on the bare repositories, so it
+could be hard to recover from such push.  The bottom line: currently
+supported mode is read-only for all Git clients and only this mode is
+now tested and supported.  Git wizards are, of course, free for all.
 
 BASIC EXAMPLES
 --------------
diff --git a/git-svn.perl b/git-svn.perl
index c5965c9..4756abf 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -63,13 +63,14 @@ $sha1 = qr/[a-f\d]{40}/;
 $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_stdin, $_help, $_edit,
 	$_message, $_file,
-	$_template, $_shared,
+	$_template, $_shared, $_bare,
 	$_version, $_fetch_all, $_no_rebase, $_fetch_parent,
 	$_merge, $_strategy, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
 	$_git_format, $_commit_url, $_tag);
 $Git::SVN::_follow_parent = 1;
 $_q ||= 0;
+$_bare = 0;
 my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'config-dir=s' => \$Git::SVN::Ra::config_dir,
                     'no-auth-cache' => \$Git::SVN::Prompt::_no_auth_cache,
@@ -96,6 +97,7 @@ my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
                   'trunk|T=s' => \$_trunk, 'tags|t=s' => \$_tags,
                   'branches|b=s' => \$_branches, 'prefix=s' => \$_prefix,
                   'stdlayout|s' => \$_stdlayout,
+                  'bare' => \$_bare,
                   'minimize-url|m' => \$Git::SVN::_minimize_url,
 		  'no-metadata' => sub { $icv{noMetadata} = 1 },
 		  'use-svm-props' => sub { $icv{useSvmProps} = 1 },
@@ -315,7 +317,7 @@ sub version {
 }
 
 sub do_git_init_db {
-	unless (-d $ENV{GIT_DIR}) {
+	unless (-d $ENV{GIT_DIR} && !$_bare) {
 		my @init_db = ('init');
 		push @init_db, "--template=$_template" if defined $_template;
 		if (defined $_shared) {
@@ -325,8 +327,15 @@ sub do_git_init_db {
 				push @init_db, "--shared";
 			}
 		}
+		push @init_db, "--bare" if $_bare;
 		command_noisy(@init_db);
-		$_repository = Git->repository(Repository => ".git");
+		if ($_bare && -d $ENV{GIT_DIR}) {
+			$_repository =
+			    Git->repository(Repository => $ENV{GIT_DIR});
+		} else {
+			$_repository =
+			    Git->repository(Repository => ".git");
+		}
 	}
 	command_noisy('config', 'core.autocrlf', 'false');
 	my $set;
@@ -344,9 +353,20 @@ sub do_git_init_db {
 
 sub init_subdir {
 	my $repo_path = shift or return;
+	my $full_path;
+	if ($repo_path =~ /^\//) {
+		$full_path = $repo_path;
+	} else {
+		use POSIX qw(getcwd);
+		$full_path = POSIX::getcwd() . "/" . $repo_path;
+	}
 	mkpath([$repo_path]) unless -d $repo_path;
 	chdir $repo_path or die "Couldn't chdir to $repo_path: $!\n";
-	$ENV{GIT_DIR} = '.git';
+	if (!$_bare) {
+		$ENV{GIT_DIR} = $full_path . '/.git';
+	} else {
+		$ENV{GIT_DIR} = $full_path;
+	}
 	$_repository = Git->repository(Repository => $ENV{GIT_DIR});
 }
 
@@ -389,6 +409,7 @@ sub cmd_fetch {
 	if (@_ > 1) {
 		die "Usage: $0 fetch [--all] [--parent] [svn-remote]\n";
 	}
+	get_bareness();
 	if ($_fetch_parent) {
 		my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
 		unless ($gs) {
@@ -408,6 +429,12 @@ sub cmd_fetch {
 
 sub cmd_set_tree {
 	my (@commits) = @_;
+
+	get_bareness();
+	if ($_bare) {
+		fatal("'set-tree' isn't supported for bare repositories.");
+	}
+
 	if ($_stdin || !@commits) {
 		print "Reading from stdin...\n";
 		@commits = ();
@@ -444,6 +471,12 @@ sub cmd_set_tree {
 
 sub cmd_dcommit {
 	my $head = shift;
+
+	get_bareness();
+	if ($_bare) {
+		fatal("'dcommit' isn't supported for bare repositories.");
+	}
+
 	git_cmd_try { command_oneline(qw/diff-index --quiet HEAD/) }
 		'Cannot dcommit with a dirty index.  Commit your changes first, '
 		. "or stash them with `git stash'.\n";
@@ -579,6 +612,11 @@ sub cmd_dcommit {
 sub cmd_branch {
 	my ($branch_name, $head) = @_;
 
+	get_bareness();
+	if ($_bare) {
+		fatal("'branch' isn't supported for bare repositories.");
+	}
+
 	unless (defined $branch_name && length $branch_name) {
 		die(($_tag ? "tag" : "branch") . " name required\n");
 	}
@@ -635,6 +673,11 @@ sub cmd_find_rev {
 }
 
 sub cmd_rebase {
+	get_bareness();
+	if ($_bare) {
+		fatal("'rebase' isn't supported for bare repositories.");
+	}
+
 	command_noisy(qw/update-index --refresh/);
 	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
 	unless ($gs) {
@@ -793,6 +836,11 @@ sub cmd_proplist {
 }
 
 sub cmd_multi_init {
+	get_bareness();
+	if ($_bare) {
+		fatal("'multi-init' isn't supported for bare repositories.");
+	}
+
 	my $url = shift;
 	unless (defined $_trunk || defined $_branches || defined $_tags) {
 		usage(1);
@@ -836,6 +884,11 @@ sub cmd_multi_fetch {
 
 # this command is special because it requires no metadata
 sub cmd_commit_diff {
+	get_bareness();
+	if ($_bare) {
+		fatal("'commit-diff' isn't supported for bare repositories.");
+	}
+
 	my ($ta, $tb, $url) = @_;
 	my $usage = "Usage: $0 commit-diff -r<revision> ".
 	            "<tree-ish> <tree-ish> [<URL>]";
@@ -1252,6 +1305,14 @@ sub read_repo_config {
 	delete @$opts{@config_only} if @config_only;
 }
 
+# Initialize bareness flag for an existing repository
+sub get_bareness {
+	return unless -d $ENV{GIT_DIR};
+	my $result = Git::config_bool('core.bare');
+	$result = 0 unless defined($result);
+	$_bare = $result;
+}
+
 sub extract_metadata {
 	my $id = shift or return (undef, undef, undef);
 	my ($url, $rev, $uuid) = ($id =~ /^\s*git-svn-id:\s+(.*)\@(\d+)
@@ -1527,6 +1588,51 @@ sub parse_revision_argument {
 	die "revision argument: $::_revision not understood by git-svn\n";
 }
 
+#
+# While we are fetching to bare repositories, we should update branch
+# heads manually, because it is not possible to do merges within bare
+# repositories.
+#
+# Arguments:
+# - name of remote branch, for example 'refs/remotes/git-svn';
+# - name of the corresponding local head, for example 'refs/heads/master'.
+#
+sub fast_forward_bare_fetch {
+	return unless defined($_bare);
+	return unless defined($_[0]);
+	return unless defined($_[1]);
+	my $remote = $_[0];
+	my $localhead = $_[1];
+
+	# Gather current SHA1 codes for both objects.
+	my $new_sha1ref = eval {
+		command_oneline(qw/show-ref --hash/, $remote)
+	};
+	return unless length($new_sha1ref);
+	my $current_sha1ref = eval {
+		command_oneline(qw/show-ref --hash/, $localhead)
+	};
+	return unless length($current_sha1ref);
+
+	# Same?  Nothing to do.
+	return if $new_sha1ref eq $current_sha1ref;
+
+	# Update SHA1 for local head and verify new value.
+	command_noisy('update-ref', $localhead, $new_sha1ref);
+	$current_sha1ref = eval {
+		command_oneline(qw/show-ref --hash/, $localhead)
+	};
+	if ($current_sha1ref eq $new_sha1ref) {
+		unless ($::_q > 1) {
+			printf "Fast-forwarded %s to %s.\n",
+		  	  $localhead, $new_sha1ref;
+		}
+	} else {
+		printf "Error fast forwarding %s to %s.\n",
+		  $localhead, $new_sha1ref;
+	}
+}
+
 sub fetch_all {
 	my ($repo_id, $remotes) = @_;
 	if (ref $repo_id) {
@@ -1571,6 +1677,22 @@ sub fetch_all {
 
 	($base, $head) = parse_revision_argument($base, $head);
 	$ra->gs_fetch_loop_common($base, $head, \@gs, \@globs);
+
+	# Update (fast-forward) heads for bare repository.
+	if (defined($_bare)) {
+		foreach my $gs (@gs) {
+			my $remote = 'refs/remotes/' . $gs->{ref_id};
+			my $localhead = 'refs/heads/master';
+			if (open(FH, "<", "HEAD")) {
+				chomp(my $head = <FH>);
+				close FH;
+				if ($head =~ /^ref: (.*)$/) {
+					$localhead = $1;
+				}
+			}
+			fast_forward_bare_fetch($remote, $localhead);
+		}
+	}
 }
 
 sub read_all_remotes {
-- 
1.6.1.3
