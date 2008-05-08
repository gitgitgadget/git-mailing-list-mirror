From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] Teach git-svn how to catch up with its tracking branches
Date: Wed, 7 May 2008 18:39:56 -0700
Message-ID: <20080508013956.GA24956@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 03:40:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtv7q-0001ct-DQ
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 03:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbYEHBj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 21:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbYEHBj7
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 21:39:59 -0400
Received: from tater.midwinter.com ([216.32.86.90]:58879 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751440AbYEHBj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 21:39:57 -0400
Received: (qmail 25107 invoked by uid 1001); 8 May 2008 01:39:56 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81496>

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
 git-svn.perl |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 58 insertions(+), 4 deletions(-)

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
