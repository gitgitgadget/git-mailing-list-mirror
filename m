From: Jeff King <peff@peff.net>
Subject: [PATCH] add--interactive: handle initial commit better
Date: Wed, 13 Feb 2008 05:50:51 -0500
Message-ID: <20080213105051.GA26522@coredump.intra.peff.net>
References: <C50196C5-B0C5-4536-AD4A-0F9C553782EE@gmail.com> <20080213101649.GA18444@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Rhodes, Kate" <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 11:52:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPFDb-0004L6-9K
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 11:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbYBMKu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 05:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755419AbYBMKu4
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 05:50:56 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2733 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752294AbYBMKuz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 05:50:55 -0500
Received: (qmail 13739 invoked by uid 111); 13 Feb 2008 10:50:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 13 Feb 2008 05:50:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Feb 2008 05:50:51 -0500
Content-Disposition: inline
In-Reply-To: <20080213101649.GA18444@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73771>

On Wed, Feb 13, 2008 at 05:16:49AM -0500, Jeff King wrote:

> However, I wonder if this is the best approach. It would be nice if
> there were a shorthand for "the empty tree" for diffing, so you could
> just diff against that rather than HEAD, and have the regular plumbing
> generate.
> 
> I suppose we could just create that tree object, though it adds a slight
> amount of cruft to the object database.

And here it is. I think this is a more sane approach in general than the
last patch. The only ugly thing is the empty tree hack, but that can be
addressed with a patch to allow referencing the empty tree without it
existing in the object db.

-- >8 --

There were several points where we looked at the HEAD
commit; for initial commits, this is meaningless. So instead
we:

  - show staged status data as a diff against the empty tree
    instead of HEAD
  - show file diffs as creation events
  - use "git rm --cached" to revert instead of going back to
    the HEAD commit

The empty tree diff is a little hack-ish. We actually write
the empty tree object from a fake index using "git
write-tree". This would be a bit cleaner if we could
magically reference the empty tree.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl |   64 +++++++++++++++++++++++++++++++++-----------
 1 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 17ca5b8..bae631e 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -82,6 +82,28 @@ sub list_untracked {
 my $status_fmt = '%12s %12s %s';
 my $status_head = sprintf($status_fmt, 'staged', 'unstaged', 'path');
 
+{
+	my $initial;
+	sub is_initial_commit {
+		$initial = system('git rev-parse HEAD -- >/dev/null 2>&1') != 0
+			unless defined $initial;
+		return $initial;
+	}
+}
+
+{
+	my $sha1;
+	sub get_empty_tree {
+		if (!$sha1) {
+			local $ENV{GIT_INDEX_FILE} = "$GIT_DIR/empty_index";
+			$sha1 = run_cmd_pipe(qw(git write-tree));
+			chomp $sha1;
+			unlink($ENV{GIT_INDEX_FILE});
+		}
+		return $sha1;
+	}
+}
+
 # Returns list of hashes, contents of each of which are:
 # VALUE:	pathname
 # BINARY:	is a binary path
@@ -103,8 +125,10 @@ sub list_modified {
 		return if (!@tracked);
 	}
 
+	my $reference = is_initial_commit() ? get_empty_tree() : 'HEAD';
 	for (run_cmd_pipe(qw(git diff-index --cached
-			     --numstat --summary HEAD --), @tracked)) {
+			     --numstat --summary), $reference,
+			     '--', @tracked)) {
 		if (($add, $del, $file) =
 		    /^([-\d]+)	([-\d]+)	(.*)/) {
 			my ($change, $bin);
@@ -476,21 +500,27 @@ sub revert_cmd {
 				       HEADER => $status_head, },
 				     list_modified());
 	if (@update) {
-		my @lines = run_cmd_pipe(qw(git ls-tree HEAD --),
-					 map { $_->{VALUE} } @update);
-		my $fh;
-		open $fh, '| git update-index --index-info'
-		    or die;
-		for (@lines) {
-			print $fh $_;
+		if (is_initial_commit()) {
+			system(qw(git rm --cached),
+				map { $_->{VALUE} } @update);
 		}
-		close($fh);
-		for (@update) {
-			if ($_->{INDEX_ADDDEL} &&
-			    $_->{INDEX_ADDDEL} eq 'create') {
-				system(qw(git update-index --force-remove --),
-				       $_->{VALUE});
-				print "note: $_->{VALUE} is untracked now.\n";
+		else {
+			my @lines = run_cmd_pipe(qw(git ls-tree HEAD --),
+						 map { $_->{VALUE} } @update);
+			my $fh;
+			open $fh, '| git update-index --index-info'
+			    or die;
+			for (@lines) {
+				print $fh $_;
+			}
+			close($fh);
+			for (@update) {
+				if ($_->{INDEX_ADDDEL} &&
+				    $_->{INDEX_ADDDEL} eq 'create') {
+					system(qw(git update-index --force-remove --),
+					       $_->{VALUE});
+					print "note: $_->{VALUE} is untracked now.\n";
+				}
 			}
 		}
 		refresh();
@@ -956,7 +986,9 @@ sub diff_cmd {
 				     HEADER => $status_head, },
 				   @mods);
 	return if (!@them);
-	system(qw(git diff -p --cached HEAD --), map { $_->{VALUE} } @them);
+	my $reference = is_initial_commit() ? get_empty_tree() : 'HEAD';
+	system(qw(git diff -p --cached), $reference, '--',
+		map { $_->{VALUE} } @them);
 }
 
 sub quit_cmd {
-- 
1.5.4.1.1296.g34f89-dirty
