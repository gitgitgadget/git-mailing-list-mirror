From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/13] git-svn: optimize --branch and --branch-all-ref
Date: Tue, 13 Jun 2006 11:02:05 -0700
Message-ID: <11502217393714-git-send-email-normalperson@yhbt.net>
References: <11502217352245-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 13 20:03:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqDE5-0004t6-F6
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 20:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWFMSCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 14:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWFMSCW
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 14:02:22 -0400
Received: from hand.yhbt.net ([66.150.188.102]:45253 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751130AbWFMSCV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 14:02:21 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id DC02A7DC022;
	Tue, 13 Jun 2006 11:02:19 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 13 Jun 2006 11:02:19 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11502217352245-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21801>

By breaking the pipe read once we've seen a commit twice.

This should make -B/--branch-all-ref faster and usable on a
frequent basis.

We use topological order now for calling git-rev-list, and any
commit we've seen before should imply that all parents have been
seen (at least I hope that's the case for --topo-order).

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index c91160d..d4b9323 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -1220,23 +1220,30 @@ sub check_upgrade_needed {
 # fills %tree_map with a reverse mapping of trees to commits.  Useful
 # for finding parents to commit on.
 sub map_tree_joins {
+	my %seen;
 	foreach my $br (@_branch_from) {
 		my $pid = open my $pipe, '-|';
 		defined $pid or croak $!;
 		if ($pid == 0) {
-			exec(qw(git-rev-list --pretty=raw), $br) or croak $?;
+			exec(qw(git-rev-list --topo-order --pretty=raw), $br)
+								or croak $?;
 		}
 		while (<$pipe>) {
 			if (/^commit ($sha1)$/o) {
 				my $commit = $1;
+
+				# if we've seen a commit,
+				# we've seen its parents
+				last if $seen{$commit};
 				my ($tree) = (<$pipe> =~ /^tree ($sha1)$/o);
 				unless (defined $tree) {
 					die "Failed to parse commit $commit\n";
 				}
 				push @{$tree_map{$tree}}, $commit;
+				$seen{$commit} = 1;
 			}
 		}
-		close $pipe or croak $?;
+		close $pipe; # we could be breaking the pipe early
 	}
 }
 
-- 
1.4.0
