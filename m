From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 5/5] git-svn: detect cherry-picks correctly.
Date: Sun, 20 Dec 2009 05:33:55 +1300
Message-ID: <1261240435-8948-6-git-send-email-sam@vilain.net>
References: <1261240435-8948-1-git-send-email-sam@vilain.net>
 <1261240435-8948-2-git-send-email-sam@vilain.net>
 <1261240435-8948-3-git-send-email-sam@vilain.net>
 <1261240435-8948-4-git-send-email-sam@vilain.net>
 <1261240435-8948-5-git-send-email-sam@vilain.net>
Cc: Eric Wong <normalperson@yhbt.net>,
	Andrew Myrick <amyrick@gmail.com>, Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 17:34:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM2GJ-000123-GF
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 17:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbZLSQe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 11:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbZLSQe1
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 11:34:27 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:52473 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752827AbZLSQeY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 11:34:24 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 3FDFE21C475; Sun, 20 Dec 2009 05:34:23 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from denix (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 97EB521C56C;
	Sun, 20 Dec 2009 05:34:14 +1300 (NZDT)
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by denix with esmtp (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1NM2G0-0002Lt-3Q; Sun, 20 Dec 2009 05:34:16 +1300
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1261240435-8948-5-git-send-email-sam@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135490>

The old function was incorrect; in some instances it marks a cherry picked
range as a merged branch (because of an incorrect assumption that
'rev-list COMMIT --not RANGE' would work).  This is replaced with a
function which should detect them correctly, memoized to limit the expense
of dealing with branches with many cherry picks to one 'merge-base' call
per merge, per branch which used cherry picking.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 git-svn.perl             |   87 +++++++++++++++++++++++++++++++++------------
 t/t9151-svn-mergeinfo.sh |    4 +-
 2 files changed, 66 insertions(+), 25 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 7a790d7..f06e535 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3007,8 +3007,35 @@ sub lookup_svn_merge {
 	}
 	return ($tip_commit, @merged_commit_ranges);
 }
+
+sub _rev_list {
+	my ($msg_fh, $ctx) = command_output_pipe(
+		"rev-list", @_,
+	       );
+	my @rv;
+	while ( <$msg_fh> ) {
+		chomp;
+		push @rv, $_;
+	}
+	command_close_pipe($msg_fh, $ctx);
+	@rv;
+}
+
+sub check_cherry_pick {
+	my $base = shift;
+	my $tip = shift;
+	my @ranges = @_;
+	my %commits = map { $_ => 1 }
+		_rev_list("--no-merges", $tip, "--not", $base);
+	for my $range ( @ranges ) {
+		delete @commits{_rev_list($range)};
+	}
+	return (keys %commits);
+}
+
 BEGIN {
 	memoize 'lookup_svn_merge';
+	memoize 'check_cherry_pick';
 }
 
 sub parents_exclude {
@@ -3084,32 +3111,46 @@ sub find_extra_svn_parents {
 
 		my $ranges = $ranges{$merge_tip};
 
-		my @cmd = ('rev-list', "-1", $merge_tip,
-			   "--not", @$parents );
-		my ($msg_fh, $ctx) = command_output_pipe(@cmd);
-		my $new;
-		while ( <$msg_fh> ) {
-			$new=1;last;
-		}
-		command_close_pipe($msg_fh, $ctx);
-		if ( $new ) {
-			push @cmd, @$ranges;
-			my ($msg_fh, $ctx) = command_output_pipe(@cmd);
-			my $unmerged;
-			while ( <$msg_fh> ) {
-				$unmerged=1;last;
-			}
-			command_close_pipe($msg_fh, $ctx);
-			if ( $unmerged ) {
-				warn "W:svn cherry-pick ignored ($spec)\n";
-			} else {
-				warn
-				  "Found merge parent (svn:mergeinfo prop): ",
-				  $merge_tip, "\n";
-				push @$parents, $merge_tip;
+		# check out 'new' tips
+		my $merge_base = command_oneline(
+			"merge-base",
+			@$parents, $merge_tip,
+		       );
+
+		# double check that there are no missing non-merge commits
+		my (@incomplete) = check_cherry_pick(
+			$merge_base, $merge_tip,
+			@$ranges,
+		       );
+
+		if ( @incomplete ) {
+			warn "W:svn cherry-pick ignored ($spec) - missing "
+				.@incomplete." commit(s) (eg $incomplete[0])\n";
+		} else {
+			warn
+				"Found merge parent (svn:mergeinfo prop): ",
+					$merge_tip, "\n";
+			push @new_parents, $merge_tip;
+		}
+	}
+
+	# cater for merges which merge commits from multiple branches
+	if ( @new_parents > 1 ) {
+		for ( my $i = 0; $i <= $#new_parents; $i++ ) {
+			for ( my $j = 0; $j <= $#new_parents; $j++ ) {
+				next if $i == $j;
+				next unless $new_parents[$i];
+				next unless $new_parents[$j];
+				my $revs = command_oneline(
+					"rev-list", "-1", "$i..$j",
+				       );
+				if ( !$revs ) {
+					undef($new_parents[$i]);
+				}
 			}
 		}
 	}
+	push @$parents, grep { defined } @new_parents;
 }
 
 sub make_log_entry {
diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index f6e00ea..359eeaa 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -15,13 +15,13 @@ test_expect_success 'load svn dump' "
 	git svn fetch --all
 	"
 
-test_expect_failure 'all svn merges became git merge commits' '
+test_expect_success 'all svn merges became git merge commits' '
 	unmarked=$(git rev-list --parents --all --grep=Merge |
 		grep -v " .* " | cut -f1 -d" ")
 	[ -z "$unmarked" ]
 	'
 
-test_expect_failure 'cherry picks did not become git merge commits' '
+test_expect_success 'cherry picks did not become git merge commits' '
 	bad_cherries=$(git rev-list --parents --all --grep=Cherry |
 		grep " .* " | cut -f1 -d" ")
 	[ -z "$bad_cherries" ]
-- 
1.6.3.3
