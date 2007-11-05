From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/2] git-svn: fix dcommit clobbering when committing a series of diffs
Date: Mon,  5 Nov 2007 03:21:47 -0800
Message-ID: <1194261708-32256-1-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 12:22:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip01v-0006xA-66
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 12:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbXKELVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 06:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754014AbXKELVv
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 06:21:51 -0500
Received: from hand.yhbt.net ([66.150.188.102]:51090 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753519AbXKELVu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 06:21:50 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id AF3107DC0FE;
	Mon,  5 Nov 2007 03:21:48 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 05 Nov 2007 03:21:48 -0800
X-Mailer: git-send-email 1.5.3.5.566.gc207
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63496>

Our revision number sent to SVN is set to the last revision we
committed if we've made any previous commits in a dcommit
invocation.

Although our SVN Editor code uses the delta of two (old) trees
to generate information to send upstream, it'll still send
complete resultant files upstream; even if the tree they're
based against is out-of-date.

The combination of sending a file that does not include the
latest changes, but set with a revision number of a commit we
just made will cause SVN to accept the resultant file even if it
was generated against an old tree.

More trouble was caused when fixing this because we were
rebasing uncessarily at times.  We used git-diff-tree to check
the imported SVN revision against our HEAD, not the last tree we
committed to SVN.  The unnecessary rebasing caused merge commits
upstream to SVN to fail.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 Junio: please apply this to maint, thanks.

 git-svn.perl                              |   47 ++++++++++++++++++++++--
 t/t9106-git-svn-dcommit-clobber-series.sh |   56 +++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 4 deletions(-)
 create mode 100755 t/t9106-git-svn-dcommit-clobber-series.sh

diff --git a/git-svn.perl b/git-svn.perl
index 4900f57..62a4a69 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -406,7 +406,8 @@ sub cmd_dcommit {
 		     "If these changes depend on each other, re-running ",
 		     "without --no-rebase will be required."
 	}
-	foreach my $d (@$linear_refs) {
+	while (1) {
+		my $d = shift @$linear_refs or last;
 		unless (defined $last_rev) {
 			(undef, $last_rev, undef) = cmt_metadata("$d~1");
 			unless (defined $last_rev) {
@@ -439,14 +440,14 @@ sub cmd_dcommit {
 
 			# we always want to rebase against the current HEAD,
 			# not any head that was passed to us
-			my @diff = command('diff-tree', 'HEAD',
+			my @diff = command('diff-tree', $d,
 			                   $gs->refname, '--');
 			my @finish;
 			if (@diff) {
 				@finish = rebase_cmd();
-				print STDERR "W: HEAD and ", $gs->refname,
+				print STDERR "W: $d and ", $gs->refname,
 				             " differ, using @finish:\n",
-				             "@diff";
+				             join("\n", @diff), "\n";
 			} else {
 				print "No changes between current HEAD and ",
 				      $gs->refname,
@@ -455,6 +456,45 @@ sub cmd_dcommit {
 				@finish = qw/reset --mixed/;
 			}
 			command_noisy(@finish, $gs->refname);
+			if (@diff) {
+				@refs = ();
+				my ($url_, $rev_, $uuid_, $gs_) =
+				              working_head_info($head, \@refs);
+				my ($linear_refs_, $parents_) =
+				              linearize_history($gs_, \@refs);
+				if (scalar(@$linear_refs) !=
+				    scalar(@$linear_refs_)) {
+					fatal "# of revisions changed ",
+					  "\nbefore:\n",
+					  join("\n", @$linear_refs),
+					  "\n\nafter:\n",
+					  join("\n", @$linear_refs_), "\n",
+					  'If you are attempting to commit ',
+					  "merges, try running:\n\t",
+					  'git rebase --interactive',
+					  '--preserve-merges ',
+					  $gs->refname,
+					  "\nBefore dcommitting";
+				}
+				if ($url_ ne $url) {
+					fatal "URL mismatch after rebase: ",
+					      "$url_ != $url";
+				}
+				if ($uuid_ ne $uuid) {
+					fatal "uuid mismatch after rebase: ",
+					      "$uuid_ != $uuid";
+				}
+				# remap parents
+				my (%p, @l, $i);
+				for ($i = 0; $i < scalar @$linear_refs; $i++) {
+					my $new = $linear_refs_->[$i] or next;
+					$p{$new} =
+						$parents->{$linear_refs->[$i]};
+					push @l, $new;
+				}
+				$parents = \%p;
+				$linear_refs = \@l;
+			}
 			$last_rev = $cmt_rev;
 		}
 	}
diff --git a/t/t9106-git-svn-dcommit-clobber-series.sh b/t/t9106-git-svn-dcommit-clobber-series.sh
new file mode 100755
index 0000000..4216a88
--- /dev/null
+++ b/t/t9106-git-svn-dcommit-clobber-series.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Eric Wong
+test_description='git-svn dcommit clobber series'
+. ./lib-git-svn.sh
+
+test_expect_success 'initialize repo' "
+	mkdir import &&
+	cd import &&
+	awk 'BEGIN { for (i = 1; i < 64; i++) { print i } }' > file
+	svn import -m 'initial' . $svnrepo &&
+	cd .. &&
+	git svn init $svnrepo &&
+	git svn fetch &&
+	test -e file
+	"
+
+test_expect_success '(supposedly) non-conflicting change from SVN' "
+	test x\"\`sed -n -e 58p < file\`\" = x58 &&
+	test x\"\`sed -n -e 61p < file\`\" = x61 &&
+	svn co $svnrepo tmp &&
+	cd tmp &&
+		perl -i -p -e 's/^58\$/5588/' file &&
+		perl -i -p -e 's/^61\$/6611/' file &&
+		test x\"\`sed -n -e 58p < file\`\" = x5588 &&
+		test x\"\`sed -n -e 61p < file\`\" = x6611 &&
+		svn commit -m '58 => 5588, 61 => 6611' &&
+		cd ..
+	"
+
+test_expect_success 'unrelated some unrelated changes to git' "
+	echo hi > life &&
+	git update-index --add life &&
+	git commit -m hi-life &&
+	echo bye >> life &&
+	git commit -m bye-life life
+	"
+
+test_expect_success 'change file but in unrelated area' "
+	test x\"\`sed -n -e 4p < file\`\" = x4 &&
+	test x\"\`sed -n -e 7p < file\`\" = x7 &&
+	perl -i -p -e 's/^4\$/4444/' file &&
+	perl -i -p -e 's/^7\$/7777/' file &&
+	test x\"\`sed -n -e 4p < file\`\" = x4444 &&
+	test x\"\`sed -n -e 7p < file\`\" = x7777 &&
+	git commit -m '4 => 4444, 7 => 7777' file &&
+	git svn dcommit &&
+	svn up tmp &&
+	cd tmp &&
+		test x\"\`sed -n -e 4p < file\`\" = x4444 &&
+		test x\"\`sed -n -e 7p < file\`\" = x7777 &&
+		test x\"\`sed -n -e 58p < file\`\" = x5588 &&
+		test x\"\`sed -n -e 61p < file\`\" = x6611
+	"
+
+test_done
-- 
1.5.3.5.566.gc207
