From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] git-svn: teach to create and operate on bare
	repositories
Date: Thu, 23 Apr 2009 01:36:28 +0400
Message-ID: <qxrtBtZrSZuDTP4eMtsCu+KmGTY@urRFFPz6LpPjhjTBiIOEhMtLGGg>
References: <lGoUDENjg0Z+sDE9v/txzTLyfk8@7qgLKkvX/1U6eu9avhKQpU/1pEI> <20090421180101.GA16642@dcvr.yhbt.net>
Reply-To: rea-git@codelabs.ru
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IiVenqGWf+H9Y6IX"
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 23:38:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwk8w-0005vq-RH
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 23:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977AbZDVVgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 17:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754570AbZDVVgf
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 17:36:35 -0400
Received: from 0.mx.codelabs.ru ([144.206.177.45]:53172 "EHLO 0.mx.codelabs.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959AbZDVVge (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 17:36:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender;
	b=jXmA5WKOE1Hx5iUBxPpWWIUwKK/EGnf0xLAAdVRfSqMhC5mhpf5AANhOKUxr9zV0mUHJqojgiESDGUvGphWOqxZEskfm/fztHkB3u+WCI9AIi3PqTbfrwsID56drG0MByvYDV81+hQWopfCEV4oCV+ns/kkUQ0UDu3nI+6PsX6o=;
Received: from amnesiac.at.no.dns (ppp91-77-11-103.pppoe.mtu-net.ru [91.77.11.103])
	by 0.mx.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1Lwk7L-0005pM-E5; Thu, 23 Apr 2009 01:36:32 +0400
Content-Disposition: inline
In-Reply-To: <20090421180101.GA16642@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117271>


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Eric, good day.

Tue, Apr 21, 2009 at 11:01:01AM -0700, Eric Wong wrote:
> This definitely seems useful.  I'd like a basic test to ensure it
> continues working in the future.

No problems, answers inline ;))

> >  sub cmd_set_tree {
> >  	my (@commits) = @_;
> > +
> > +	get_bareness();
> > +	if ($_bare) {
> > +		fatal("'set-tree' isn't supported for bare repositories.");
> > +	}
> > +
> 
> This repetition with get_bareness() and then checking for $_bare all
> over the place bothers me a bit.  I'd rather just have something like
> this:
> 
> 	fatal_if_bare('set-tree');
> 
> Or even:
> 
> 	fatal_if_bare($cmd);

Done.

> > +# Initialize bareness flag for an existing repository
> > +sub get_bareness {
> > +	return unless -d $ENV{GIT_DIR};
> > +	my $result = Git::config_bool('core.bare');
> > +	$result = 0 unless defined($result);
> > +	$_bare = $result;
> > +}
> 
> Perhaps this function can go into Git.pm since core.bare affects all
> of git, not just git-svn.  I'd also like to just use something like
> 
> 	if (Git::config_bare()) { ... }
> 
> ...rather than having to check/initialize a variable every time.
> 
> Of course, we can have config caching for platforms that really need
> it done via Sam's Git::Config module when it gets merged.

Hmm, for my needs the bare "Git::config_bool('core.bare')" is sufficient,
so I implanted it everywhere.

> >  sub extract_metadata {
> >  	my $id = shift or return (undef, undef, undef);
> >  	my ($url, $rev, $uuid) = ($id =~ /^\s*git-svn-id:\s+(.*)\@(\d+)
> > @@ -1527,6 +1588,51 @@ sub parse_revision_argument {
> >  	die "revision argument: $::_revision not understood by git-svn\n";
> >  }
> >  
> > +#
> > +# While we are fetching to bare repositories, we should update branch
> > +# heads manually, because it is not possible to do merges within bare
> > +# repositories.
> > +#
> > +# Arguments:
> > +# - name of remote branch, for example 'refs/remotes/git-svn';
> > +# - name of the corresponding local head, for example 'refs/heads/master'.
> > +#
> > +sub fast_forward_bare_fetch {
> > +	return unless defined($_bare);
> > +	return unless defined($_[0]);
> > +	return unless defined($_[1]);
> 
> Checking for arguments here seems unnecessarily defensive.

I used to this style, but OK, it was eliminated.

> 
> > +	my $remote = $_[0];
> > +	my $localhead = $_[1];
> 
> The general git-svn style is this:
> 
> 	my ($remote, $localhead) = @_;

Fixed.

> > +	# Update (fast-forward) heads for bare repository.
> > +	if (defined($_bare)) {
> > +		foreach my $gs (@gs) {
> > +			my $remote = 'refs/remotes/' . $gs->{ref_id};
> > +			my $localhead = 'refs/heads/master';
> > +			if (open(FH, "<", "HEAD")) {
> > +				chomp(my $head = <FH>);
> > +				close FH;
> > +				if ($head =~ /^ref: (.*)$/) {
> > +					$localhead = $1;
> > +				}
> > +			}
> 
> "git rev-parse --symbolic-full-name HEAD" should work better
> than parsing HEAD ourselves.

Used it.  The resulting patch is attached.

I have one question: as you can see from the above hunk, I am using HEAD
as the tip of all local branches to be fast-forwarded.  It works with
only one upstream branch, but what if there will be multiple
(disconnected) remotes we are tracking?  I had seen the words that it it
possible (in the git-svn man page), but hadn't managed to create such
repository and figure out how can I deduce the name of the local head
for the remote one.  Could you, please, enlighten me?

Thanks!
-- 
Eygene

--IiVenqGWf+H9Y6IX
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="git-svn-teach-to-create-and-operate-on-bare-repos.diff"
Content-Transfer-Encoding: quoted-printable

=46rom cc509782cfa3c17dc830015891cde2a11275a2c4 Mon Sep 17 00:00:00 2001
=46rom: Eygene Ryabinkin <rea@codelabs.ru>
Date: Thu, 16 Apr 2009 02:27:24 +0400
Subject: [PATCH] git-svn: teach to create and operate on bare repositories

This mode is useful when we're mirrorring one-to-one Subversion and Git
repositories and then using Git as the repository to base other work on.

Bare mode is currently restricted only to init, clone, fetch, log,
find-rev, show-ignore, show-externals, create-ignore, propget, proplist
and info commands.  Others won't work at all and error message will
be produced.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 Documentation/git-svn.txt |   23 +++++++++
 git-svn.perl              |  110 +++++++++++++++++++++++++++++++++++++++++=
++--
 2 files changed, 129 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 9229d45..4749676 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -104,6 +104,10 @@ COMMANDS
 --parent;;
 	Fetch only from the SVN parent of the current HEAD.
=20
+--bare;;
+	Creates bare repository without checked-out copy.  See section
+	BARE REPOSITORIES for details.
+
 This doesn't interfere with interoperating with the Subversion
 repository you cloned from, but if you wish for your local Git
 repository to be able to interoperate with someone else's local Git
@@ -537,6 +541,25 @@ and these settings should never be changed once they a=
re set.
 Additionally, only one of these four options can be used per-svn-remote
 section because they affect the 'git-svn-id:' metadata line.
=20
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
=20
 BASIC EXAMPLES
 --------------
diff --git a/git-svn.perl b/git-svn.perl
index c5965c9..db6037f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -63,13 +63,14 @@ $sha1 =3D qr/[a-f\d]{40}/;
 $sha1_short =3D qr/[a-f\d]{4,40}/;
 my ($_stdin, $_help, $_edit,
 	$_message, $_file,
-	$_template, $_shared,
+	$_template, $_shared, $_bare,
 	$_version, $_fetch_all, $_no_rebase, $_fetch_parent,
 	$_merge, $_strategy, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
 	$_git_format, $_commit_url, $_tag);
 $Git::SVN::_follow_parent =3D 1;
 $_q ||=3D 0;
+$_bare =3D 0;
 my %remote_opts =3D ( 'username=3Ds' =3D> \$Git::SVN::Prompt::_username,
                     'config-dir=3Ds' =3D> \$Git::SVN::Ra::config_dir,
                     'no-auth-cache' =3D> \$Git::SVN::Prompt::_no_auth_cach=
e,
@@ -96,6 +97,7 @@ my %init_opts =3D ( 'template=3Ds' =3D> \$_template, 'sha=
red:s' =3D> \$_shared,
                   'trunk|T=3Ds' =3D> \$_trunk, 'tags|t=3Ds' =3D> \$_tags,
                   'branches|b=3Ds' =3D> \$_branches, 'prefix=3Ds' =3D> \$_=
prefix,
                   'stdlayout|s' =3D> \$_stdlayout,
+                  'bare' =3D> \$_bare,
                   'minimize-url|m' =3D> \$Git::SVN::_minimize_url,
 		  'no-metadata' =3D> sub { $icv{noMetadata} =3D 1 },
 		  'use-svm-props' =3D> sub { $icv{useSvmProps} =3D 1 },
@@ -315,7 +317,7 @@ sub version {
 }
=20
 sub do_git_init_db {
-	unless (-d $ENV{GIT_DIR}) {
+	unless (-d $ENV{GIT_DIR} && !$_bare) {
 		my @init_db =3D ('init');
 		push @init_db, "--template=3D$_template" if defined $_template;
 		if (defined $_shared) {
@@ -325,8 +327,15 @@ sub do_git_init_db {
 				push @init_db, "--shared";
 			}
 		}
+		push @init_db, "--bare" if $_bare;
 		command_noisy(@init_db);
-		$_repository =3D Git->repository(Repository =3D> ".git");
+		if ($_bare && -d $ENV{GIT_DIR}) {
+			$_repository =3D
+			    Git->repository(Repository =3D> $ENV{GIT_DIR});
+		} else {
+			$_repository =3D
+			    Git->repository(Repository =3D> ".git");
+		}
 	}
 	command_noisy('config', 'core.autocrlf', 'false');
 	my $set;
@@ -344,9 +353,20 @@ sub do_git_init_db {
=20
 sub init_subdir {
 	my $repo_path =3D shift or return;
+	my $full_path;
+	if ($repo_path =3D~ /^\//) {
+		$full_path =3D $repo_path;
+	} else {
+		use POSIX qw(getcwd);
+		$full_path =3D POSIX::getcwd() . "/" . $repo_path;
+	}
 	mkpath([$repo_path]) unless -d $repo_path;
 	chdir $repo_path or die "Couldn't chdir to $repo_path: $!\n";
-	$ENV{GIT_DIR} =3D '.git';
+	if (!$_bare) {
+		$ENV{GIT_DIR} =3D $full_path . '/.git';
+	} else {
+		$ENV{GIT_DIR} =3D $full_path;
+	}
 	$_repository =3D Git->repository(Repository =3D> $ENV{GIT_DIR});
 }
=20
@@ -408,6 +428,9 @@ sub cmd_fetch {
=20
 sub cmd_set_tree {
 	my (@commits) =3D @_;
+
+	fatal_if_bare($cmd);
+
 	if ($_stdin || !@commits) {
 		print "Reading from stdin...\n";
 		@commits =3D ();
@@ -444,6 +467,9 @@ sub cmd_set_tree {
=20
 sub cmd_dcommit {
 	my $head =3D shift;
+
+	fatal_if_bare($cmd);
+
 	git_cmd_try { command_oneline(qw/diff-index --quiet HEAD/) }
 		'Cannot dcommit with a dirty index.  Commit your changes first, '
 		. "or stash them with `git stash'.\n";
@@ -579,6 +605,8 @@ sub cmd_dcommit {
 sub cmd_branch {
 	my ($branch_name, $head) =3D @_;
=20
+	fatal_if_bare($cmd);
+
 	unless (defined $branch_name && length $branch_name) {
 		die(($_tag ? "tag" : "branch") . " name required\n");
 	}
@@ -635,6 +663,8 @@ sub cmd_find_rev {
 }
=20
 sub cmd_rebase {
+	fatal_if_bare($cmd);
+
 	command_noisy(qw/update-index --refresh/);
 	my ($url, $rev, $uuid, $gs) =3D working_head_info('HEAD');
 	unless ($gs) {
@@ -793,6 +823,8 @@ sub cmd_proplist {
 }
=20
 sub cmd_multi_init {
+	fatal_if_bare($cmd);
+
 	my $url =3D shift;
 	unless (defined $_trunk || defined $_branches || defined $_tags) {
 		usage(1);
@@ -836,6 +868,8 @@ sub cmd_multi_fetch {
=20
 # this command is special because it requires no metadata
 sub cmd_commit_diff {
+	fatal_if_bare($cmd);
+
 	my ($ta, $tb, $url) =3D @_;
 	my $usage =3D "Usage: $0 commit-diff -r<revision> ".
 	            "<tree-ish> <tree-ish> [<URL>]";
@@ -1527,6 +1561,57 @@ sub parse_revision_argument {
 	die "revision argument: $::_revision not understood by git-svn\n";
 }
=20
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
+	return unless Git::config_bool('core.bare');
+	my ($remote, $localhead) =3D @_;
+
+	# Gather current SHA1 codes for both objects.
+	my $new_sha1ref =3D eval {
+		command_oneline(qw/show-ref --hash/, $remote)
+	};
+	return unless length($new_sha1ref);
+	my $current_sha1ref =3D eval {
+		command_oneline(qw/show-ref --hash/, $localhead)
+	};
+	return unless length($current_sha1ref);
+
+	# Same?  Nothing to do.
+	return if $new_sha1ref eq $current_sha1ref;
+
+	# Update SHA1 for local head and verify new value.
+	command_noisy('update-ref', $localhead, $new_sha1ref);
+	$current_sha1ref =3D eval {
+		command_oneline(qw/show-ref --hash/, $localhead)
+	};
+	if ($current_sha1ref eq $new_sha1ref) {
+		unless ($::_q > 1) {
+			printf "Fast-forwarded %s to %s.\n",
+			  $localhead, $new_sha1ref;
+		}
+	} else {
+		printf "Error fast forwarding %s to %s.\n",
+		  $localhead, $new_sha1ref;
+	}
+}
+
+sub fatal_if_bare {
+	my ($cmd) =3D @_;
+
+	if (!Git::config_bool('core.bare')) {
+		fatal(sprintf("'%s' isn't supported for bare repositories.",
+		  $cmd));
+	}
+}
+
 sub fetch_all {
 	my ($repo_id, $remotes) =3D @_;
 	if (ref $repo_id) {
@@ -1571,6 +1656,23 @@ sub fetch_all {
=20
 	($base, $head) =3D parse_revision_argument($base, $head);
 	$ra->gs_fetch_loop_common($base, $head, \@gs, \@globs);
+
+	# Update (fast-forward) heads for bare repository.
+	if (Git::config_bool('core.bare')) {
+		foreach my $gs (@gs) {
+			my $remote =3D 'refs/remotes/' . $gs->{ref_id};
+			my $localhead =3D eval {
+			  command_oneline(qw/rev-parse
+			  --symbolic-full-name HEAD/)
+			};
+			if (length($localhead) =3D=3D 0 ||
+			    $localhead eq "HEAD") {
+				die(sprintf("Unable to dereference HEAD " .
+				  "for %s"), $remote);
+			}
+			fast_forward_bare_fetch($remote, $localhead);
+		}
+	}
 }
=20
 sub read_all_remotes {
--=20
1.6.2.4


--IiVenqGWf+H9Y6IX--
