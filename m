From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: allow dcommit to retain local merge information
Date: Wed, 13 Jun 2007 02:23:28 -0700
Message-ID: <20070613092328.GA30318@muzzle>
References: <466C8B35.3020207@midwinter.com> <003401c7abba$c7574300$0e67a8c0@Jocke> <20070611042509.GA19866@muzzle> <7vir9vox5l.fsf@assigned-by-dhcp.cox.net> <20070612072035.GA29385@muzzle> <7v1wghlj7j.fsf@assigned-by-dhcp.pobox.com> <20070612083910.GA28369@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 11:23:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyP4e-0006tQ-UP
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 11:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535AbXFMJXc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 05:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754140AbXFMJXb
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 05:23:31 -0400
Received: from hand.yhbt.net ([66.150.188.102]:49819 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438AbXFMJXa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 05:23:30 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 610067DC09D;
	Wed, 13 Jun 2007 02:23:28 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 13 Jun 2007 02:23:28 -0700
Content-Disposition: inline
In-Reply-To: <20070612083910.GA28369@muzzle>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50036>

dcommit will still rewrite the HEAD commit and the history of the first
parents of each HEAD~1, HEAD~2, HEAD~3 as it always has.

However, any merge parents (HEAD^2, HEAD^^2, HEAD~2^2) will now be
preserved when the new HEAD and HEAD~[0-9]+ commits are rewritten to SVN
with dcommit.  Commits written to SVN will still not have any merge
information besides anything in the commit message.

Thanks to Joakim Tjernlund, Junio C Hamano and Steven Grimm
for explanations, feedback, examples and test case.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 This is a better patch that replaces the previous one.

 Junio:
   This one is a big change and should probably sit in pu or next
   for a bit.  Double-checking the logic in linearize_history()
   would be greatly appreciated, too.
   
   I don't think there are any regressions for the
   already-linear-history case besides slightly reduced performance for
   new calls to cat-file.

 Joakim/Steven:
   Any further testing and test cases would be appreciated.  Be very
   careful with real-world repositories, and run dcommit with the
   '-n' flag before actually committing to verify the diffs are sane.

  Thanks

 git-svn.perl                     |   72 +++++++++++++++++++++++++++----
 t/t9114-git-svn-dcommit-merge.sh |   89 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+), 9 deletions(-)
 create mode 100755 t/t9114-git-svn-dcommit-merge.sh

diff --git a/git-svn.perl b/git-svn.perl
index 0ae8d70..4290676 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -372,16 +372,9 @@ sub cmd_dcommit {
 		die "Unable to determine upstream SVN information from ",
 		    "$head history\n";
 	}
-	my $c = $refs[-1];
 	my $last_rev;
-	foreach my $d (@refs) {
-		if (!verify_ref("$d~1")) {
-			fatal "Commit $d\n",
-			      "has no parent commit, and therefore ",
-			      "nothing to diff against.\n",
-			      "You should be working from a repository ",
-			      "originally created by git-svn\n";
-		}
+	my ($linear_refs, $parents) = linearize_history($gs, \@refs);
+	foreach my $d (@$linear_refs) {
 		unless (defined $last_rev) {
 			(undef, $last_rev, undef) = cmt_metadata("$d~1");
 			unless (defined $last_rev) {
@@ -403,6 +396,9 @@ sub cmd_dcommit {
 			                svn_path => '');
 			if (!SVN::Git::Editor->new(\%ed_opts)->apply_diff) {
 				print "No changes\n$d~1 == $d\n";
+			} elsif ($parents->{$d} && @{$parents->{$d}}) {
+				$gs->{inject_parents_dcommit}->{$last_rev} =
+				                               $parents->{$d};
 			}
 		}
 	}
@@ -821,6 +817,59 @@ sub working_head_info {
 	(undef, undef, undef, undef);
 }
 
+sub read_commit_parents {
+	my ($parents, $c) = @_;
+	my ($fh, $ctx) = command_output_pipe(qw/cat-file commit/, $c);
+	while (<$fh>) {
+		chomp;
+		last if '';
+		/^parent ($sha1)/ or next;
+		push @{$parents->{$c}}, $1;
+	}
+	close $fh; # break the pipe
+}
+
+sub linearize_history {
+	my ($gs, $refs) = @_;
+	my %parents;
+	foreach my $c (@$refs) {
+		read_commit_parents(\%parents, $c);
+	}
+
+	my @linear_refs;
+	my %skip = ();
+	my $last_svn_commit = $gs->last_commit;
+	foreach my $c (reverse @$refs) {
+		next if $c eq $last_svn_commit;
+		last if $skip{$c};
+
+		unshift @linear_refs, $c;
+		$skip{$c} = 1;
+
+		# we only want the first parent to diff against for linear
+		# history, we save the rest to inject when we finalize the
+		# svn commit
+		my $fp_a = verify_ref("$c~1");
+		my $fp_b = shift @{$parents{$c}} if $parents{$c};
+		if (!$fp_a || !$fp_b) {
+			die "Commit $c\n",
+			    "has no parent commit, and therefore ",
+			    "nothing to diff against.\n",
+			    "You should be working from a repository ",
+			    "originally created by git-svn\n";
+		}
+		if ($fp_a ne $fp_b) {
+			die "$c~1 = $fp_a, however parsing commit $c ",
+			    "revealed that:\n$c~1 = $fp_b\nBUG!\n";
+		}
+
+		foreach my $p (@{$parents{$c}}) {
+			$skip{$p} = 1;
+		}
+	}
+	(\@linear_refs, \%parents);
+}
+
 package Git::SVN;
 use strict;
 use warnings;
@@ -1541,6 +1590,11 @@ sub get_commit_parents {
 	if (my $cur = ::verify_ref($self->refname.'^0')) {
 		push @tmp, $cur;
 	}
+	if (my $ipd = $self->{inject_parents_dcommit}) {
+		if (my $commit = delete $ipd->{$log_entry->{revision}}) {
+			push @tmp, @$commit;
+		}
+	}
 	push @tmp, $_ foreach (@{$log_entry->{parents}}, @tmp);
 	while (my $p = shift @tmp) {
 		next if $seen{$p};
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
new file mode 100755
index 0000000..d6ca955
--- /dev/null
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -0,0 +1,89 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Eric Wong
+# Based on a script by Joakim Tjernlund <joakim.tjernlund@transmode.se>
+
+test_description='git-svn dcommit handles merges'
+
+. ./lib-git-svn.sh
+
+big_text_block () {
+cat << EOF
+#
+# (C) Copyright 2000 - 2005
+# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+#
+# See file CREDITS for list of people who contributed to this
+# project.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+# MA 02111-1307 USA
+#
+EOF
+}
+
+test_expect_success 'setup svn repository' "
+	svn co $svnrepo mysvnwork &&
+	mkdir -p mysvnwork/trunk &&
+	cd mysvnwork &&
+		big_text_block >> trunk/README &&
+		svn add trunk &&
+		svn ci -m 'first commit' trunk &&
+		cd ..
+	"
+
+test_expect_success 'setup git mirror and merge' "
+	git svn init $svnrepo -t tags -T trunk -b branches &&
+	git svn fetch &&
+	git checkout --track -b svn remotes/trunk &&
+	git checkout -b merge &&
+	echo new file > new_file &&
+	git add new_file &&
+	git commit -a -m 'New file' &&
+	echo hello >> README &&
+	git commit -a -m 'hello' &&
+	echo add some stuff >> new_file &&
+	git commit -a -m 'add some stuff' &&
+	git checkout svn &&
+	mv -f README tmp &&
+	echo friend > README &&
+	cat tmp >> README &&
+	git commit -a -m 'friend' &&
+	git pull . merge
+	"
+
+test_debug 'gitk --all & sleep 1'
+
+test_expect_success 'verify pre-merge ancestry' "
+	test x\`git rev-parse --verify refs/heads/svn^2\` = \
+	     x\`git rev-parse --verify refs/heads/merge\` &&
+	git cat-file commit refs/heads/svn^ | grep '^friend$'
+	"
+
+test_expect_success 'git svn dcommit merges' "
+	git svn dcommit
+	"
+
+test_debug 'gitk --all & sleep 1'
+
+test_expect_success 'verify post-merge ancestry' "
+	test x\`git rev-parse --verify refs/heads/svn\` = \
+	     x\`git rev-parse --verify refs/remotes/trunk \` &&
+	test x\`git rev-parse --verify refs/heads/svn^2\` = \
+	     x\`git rev-parse --verify refs/heads/merge\` &&
+	git cat-file commit refs/heads/svn^ | grep '^friend$'
+	"
+
+test_done
-- 
Eric Wong
