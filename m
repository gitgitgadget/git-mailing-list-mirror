From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] add--interactive: handle initial commit better
Date: Thu, 14 Feb 2008 05:34:40 -0500
Message-ID: <20080214103440.GB17951@coredump.intra.peff.net>
References: <f20febf5dbdc5d3af69bccff8be8e3e2bcec0a90.1202985100.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kate Rhodes <masukomi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 11:35:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPbQz-0004lN-QL
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 11:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981AbYBNKen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 05:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752387AbYBNKen
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 05:34:43 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4073 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbYBNKem (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 05:34:42 -0500
Received: (qmail 4184 invoked by uid 111); 14 Feb 2008 10:34:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 14 Feb 2008 05:34:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2008 05:34:40 -0500
Content-Disposition: inline
In-Reply-To: <f20febf5dbdc5d3af69bccff8be8e3e2bcec0a90.1202985100.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73871>

There were several points where we looked at the HEAD
commit; for initial commits, this is meaningless. So instead
we:

  - show staged status data as a diff against the empty tree
    instead of HEAD
  - show file diffs as creation events
  - use "git rm --cached" to revert instead of going back to
    the HEAD commit

Signed-off-by: Jeff King <peff@peff.net>
---
This is close to what is in pu, but using '{}' instead of the raw sha1,
and adding some tests.

 git-add--interactive.perl  |   51 ++++++++++++++++++++++----------
 t/t3701-add-interactive.sh |   69 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 16 deletions(-)
 create mode 100755 t/t3701-add-interactive.sh

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 17ca5b8..130bc30 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -82,6 +82,15 @@ sub list_untracked {
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
 # Returns list of hashes, contents of each of which are:
 # VALUE:	pathname
 # BINARY:	is a binary path
@@ -103,8 +112,10 @@ sub list_modified {
 		return if (!@tracked);
 	}
 
+	my $reference = is_initial_commit() ? '{}' : 'HEAD';
 	for (run_cmd_pipe(qw(git diff-index --cached
-			     --numstat --summary HEAD --), @tracked)) {
+			     --numstat --summary), $reference,
+			     '--', @tracked)) {
 		if (($add, $del, $file) =
 		    /^([-\d]+)	([-\d]+)	(.*)/) {
 			my ($change, $bin);
@@ -476,21 +487,27 @@ sub revert_cmd {
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
@@ -956,7 +973,9 @@ sub diff_cmd {
 				     HEADER => $status_head, },
 				   @mods);
 	return if (!@them);
-	system(qw(git diff -p --cached HEAD --), map { $_->{VALUE} } @them);
+	my $reference = is_initial_commit() ? '{}' : 'HEAD';
+	system(qw(git diff -p --cached), $reference, '--',
+		map { $_->{VALUE} } @them);
 }
 
 sub quit_cmd {
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
new file mode 100755
index 0000000..c8dc1ac
--- /dev/null
+++ b/t/t3701-add-interactive.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+
+test_description='add -i basic tests'
+. ./test-lib.sh
+
+test_expect_success 'setup (initial)' '
+	echo content >file &&
+	git add file &&
+	echo more >>file &&
+	echo lines >>file
+'
+test_expect_success 'status works (initial)' '
+	git add -i </dev/null >output &&
+	grep "+1/-0 *+2/-0 file" output
+'
+cat >expected <<EOF
+new file mode 100644
+index 0000000..d95f3ad
+--- /dev/null
++++ b/file
+@@ -0,0 +1 @@
++content
+EOF
+test_expect_success 'diff works (initial)' '
+	(echo d; echo 1) | git add -i >output &&
+	sed -ne "/new file/,/content/p" <output >diff &&
+	diff -u expected diff
+'
+test_expect_success 'revert works (initial)' '
+	git add file &&
+	(echo r; echo 1) | git add -i &&
+	git ls-files >output &&
+	! grep . output
+'
+
+test_expect_success 'setup (commit)' '
+	echo baseline >file &&
+	git add file &&
+	git commit -m commit &&
+	echo content >>file &&
+	git add file &&
+	echo more >>file &&
+	echo lines >>file
+'
+test_expect_success 'status works (commit)' '
+	git add -i </dev/null >output &&
+	grep "+1/-0 *+2/-0 file" output
+'
+cat >expected <<EOF
+index 180b47c..b6f2c08 100644
+--- a/file
++++ b/file
+@@ -1 +1,2 @@
+ baseline
++content
+EOF
+test_expect_success 'diff works (commit)' '
+	(echo d; echo 1) | git add -i >output &&
+	sed -ne "/^index/,/content/p" <output >diff &&
+	diff -u expected diff
+'
+test_expect_success 'revert works (commit)' '
+	git add file &&
+	(echo r; echo 1) | git add -i &&
+	git add -i </dev/null >output &&
+	grep "unchanged *+3/-0 file" output
+'
+
+test_done
-- 
1.5.4.1.123.ge4e8d-dirty
