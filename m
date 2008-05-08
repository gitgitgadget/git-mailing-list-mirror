From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH v2] Teach git-svn how to catch up with its tracking branches
Date: Wed, 7 May 2008 21:19:48 -0700
Message-ID: <20080508041948.GA1095@midwinter.com>
References: <20080508013956.GA24956@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 06:20:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtxcX-0004rv-R2
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 06:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbYEHETw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 00:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbYEHETw
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 00:19:52 -0400
Received: from tater.midwinter.com ([216.32.86.90]:46479 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752000AbYEHETt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 00:19:49 -0400
Received: (qmail 1224 invoked by uid 1001); 8 May 2008 04:19:48 -0000
Content-Disposition: inline
In-Reply-To: <20080508013956.GA24956@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81506>

In environments where a lot of people are sharing an svn repository using
git-svn, everyone has identical, but individually maintained, tracking
branches. If the svn repository is very active, it can take a while to
run "git svn fetch" (which has to individually construct each revision
by querying the svn server). It's much faster to run "git fetch" against
another git-svn repository to grab the exact same git revisions you'd get
from "git svn fetch". But until now, git-svn was confused by this because
it didn't know how to incrementally rebuild its map of revision IDs.
The only choice was to completely remove the map file and rebuild it
from scratch, possibly a lengthy operation when there's a lot of history.

With this change, git-svn will try to do an incremental update of its
revision map if it sees that its tracking branch has svn revisions that
aren't in the map yet.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---

	Added some documentation that I hope is comprehensive enough
	to be useful and non-misleading.

 Documentation/git-svn.txt |   72 +++++++++++++++++++++++++++++++++++++++++++-
 git-svn.perl              |   62 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 128 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index f4ba105..6bdbd51 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -511,8 +511,8 @@ inside git back upstream to SVN users.  Therefore it is advised that
 users keep history as linear as possible inside git to ease
 compatibility with SVN (see the CAVEATS section below).
 
-CAVEATS
--------
+SHARING REVISIONS WITH OTHER GIT-SVN REPOSITORIES
+-------------------------------------------------
 
 For the sake of simplicity and interoperating with a less-capable system
 (SVN), it is recommended that all git-svn users clone, fetch and dcommit
@@ -521,6 +521,74 @@ operations between git repositories and branches.  The recommended
 method of exchanging code between git branches and users is
 git-format-patch and git-am, or just dcommiting to the SVN repository.
 
+However, git-svn does have limited support for sharing the SVN history
+between git repositories. For this to work, both git repositories need
+to be using the same SVN repository via the same URL, such that the
+commits in the git-svn tracking branches (e.g., the default "git-svn"
+branch) have the same revision IDs in git.
+
+An easy way to test whether this is true is to use 'git svn find-rev'
+in both repositories and pass it a recent SVN revision number that is
+present in both repositories' history. For example, if both repositories
+contain SVN revision 97446:
+
+------------------------------------------------------------------------
+	git svn find-rev r97446
+------------------------------------------------------------------------
+
+If the 40-digit hexadecimal value shown by that command is the same in
+both repositories, their histories are compatible and the rest of this
+section applies to them. There is currently no easy way to share history
+between git repositories whose SVN tracking branches aren't identical.
+
+Assuming your two repositories match, you can use 'git fetch' in place
+of 'git svn fetch' to fetch new SVN revisions. This is often
+significantly faster than directly fetching from the svn server,
+especially if large numbers of revisions are being fetched. Note that
+this only applies to pulling changes *from* the SVN repository; you must
+still use 'git svn dcommit' to push changes *to* SVN.
+
+Here's an example of how this works.
+
+------------------------------------------------------------------------
+# Create the first git-svn clone; call it "localmirror"
+	git svn clone svn+ssh://host/svn-repo localmirror
+# Create an empty git-svn repository called "work" pointing to the same SVN repo
+# (you could also use another 'git svn clone' if preferred)
+	mkdir work
+	cd work
+	git svn init svn+ssh://host/svn-repo
+# Set up a remote so 'git fetch' in work will fetch from localmirror
+	git config remote.origin.url file://`pwd`/../localmirror
+	git config remote.origin.fetch refs/remotes/git-svn:refs/remotes/git-svn
+# Get a copy of the SVN history from localmirror
+	git fetch
+	git rebase git-svn
+
+# Some time passes...
+
+# Update localmirror with latest changes from SVN
+	cd ../localmirror
+	git svn fetch
+# And fetch those changes incrementally into work
+	cd ../work
+	git fetch
+# Incorporate the latest revisions into the current branch in work
+	git rebase git-svn
+# You can also fetch directly from SVN in work
+	git svn rebase
+# If you have local changes, you must dcommit directly to SVN
+	git svn dcommit
+------------------------------------------------------------------------
+
+In the above example, the "localmirror" repository might be set up to
+run 'git svn fetch' periodically from a cron job, so that local developers
+can always fetch recent SVN revisions without having to connect directly
+to the SVN repository.
+
+CAVEATS
+-------
+
 Running 'git-merge' or 'git-pull' is NOT recommended on a branch you
 plan to dcommit from.  Subversion does not represent merges in any
 reasonable or useful fashion; so users using Subversion cannot see any
diff --git a/git-svn.perl b/git-svn.perl
index e47b1ea..87b104b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1382,6 +1382,7 @@ sub fetch_all {
 				$base = $lr if ($lr < $base);
 			}
 			push @gs, $gs;
+			$gs->sync_rev_map_with_commits;
 		}
 	}
 
@@ -2114,6 +2115,44 @@ sub gc {
 	command_noisy('gc', '--auto');
 };
 
+# sync_rev_map_with_commits:
+# If are commits on the tracking branch that aren't present in our revision
+# map (e.g., because the user has done a git fetch from another git-svn repo
+# rather than a git svn fetch), bring our revision map up to date. This is
+# a no-op if the revision map is already up to date.
+sub sync_rev_map_with_commits {
+	my ($self) = @_;
+	# If we can't pull metadata out of log messages, there's nothing
+	# to import.
+	return if $self->use_svm_props || $self->no_metadata;
+	# If there isn't a revision DB yet, we'll rebuild it from scratch
+	# elsewhere, so don't do anything here.
+	return if ! -e $self->map_path || -z $self->map_path;
+	# Look at the most recent commit with a git-svn-id line.
+	my ($log, $ctx) =
+	    command_output_pipe(qw/rev-list --pretty=raw --no-color /,
+				'--grep=^ *git-svn-id:',
+				'--max-count=1',
+				$self->refname, '--');
+	my ($url, $rev, $uuid, $c);
+	while (<$log>) {
+		if ( m{^commit ($::sha1)$} ) {
+			$c = $1;
+			next;
+		}
+		next unless s{^\s*(git-svn-id:)}{$1};
+		($url, $rev, $uuid) = ::extract_metadata($_);
+	}
+	my ($rev_commit) = $self->rev_map_get($rev, $uuid);
+	if (!$rev_commit) {
+		# The most recent commit in the branch isn't in our
+		# rev map. Pull in data from the revisions between the
+		# highest commit in our map and the head of the branch.
+		my ($max_rev, $max_commit) = $self->rev_map_max(1);
+		$self->rebuild($max_commit);
+	}
+}
+
 sub do_git_commit {
 	my ($self, $log_entry) = @_;
 	my $lr = $self->last_rev;
@@ -2489,6 +2528,7 @@ sub make_log_entry {
 sub fetch {
 	my ($self, $min_rev, $max_rev, @parents) = @_;
 	my ($last_rev, $last_commit) = $self->last_rev_commit;
+	$self->sync_rev_map_with_commits;
 	my ($base, $head) = $self->get_fetch_range($min_rev, $max_rev);
 	$self->ra->gs_fetch_loop_common($base, $head, [$self]);
 }
@@ -2535,10 +2575,17 @@ sub rebuild_from_rev_db {
 	unlink $path or croak "unlink: $!";
 }
 
+# rebuild:
+# Reconstructs a revision map from the available metadata. If $min_git_rev
+# is specified, this is an incremental rebuild that should stop when it hits
+# the revision in question.
+#
+# Incremental rebuilding is only supported when commits contain git-svn
+# metadata (the default) and not with use_svm_props or no_metadata.
 sub rebuild {
-	my ($self) = @_;
+	my ($self, $min_git_rev) = @_;
 	my $map_path = $self->map_path;
-	return if (-e $map_path && ! -z $map_path);
+	return if (!defined $min_git_rev && -e $map_path && ! -z $map_path);
 	return unless ::verify_ref($self->refname.'^0');
 	if ($self->use_svm_props || $self->no_metadata) {
 		my $rev_db = $self->rev_db_path;
@@ -2550,10 +2597,17 @@ sub rebuild {
 		$self->unlink_rev_db_symlink;
 		return;
 	}
-	print "Rebuilding $map_path ...\n";
+	my $revs_to_scan;
+	if (defined $min_git_rev) {
+		print "Updating $map_path ...\n";
+		$revs_to_scan = $min_git_rev . ".." . $self->refname;
+	} else {
+		print "Rebuilding $map_path ...\n";
+		$revs_to_scan = $self->refname;
+	}
 	my ($log, $ctx) =
 	    command_output_pipe(qw/rev-list --pretty=raw --no-color --reverse/,
-	                        $self->refname, '--');
+	                        $revs_to_scan, '--');
 	my $full_url = $self->full_url;
 	remove_username($full_url);
 	my $svn_uuid = $self->ra_uuid;
-- 
1.5.5.49.gf43e2
