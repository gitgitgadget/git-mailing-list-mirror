From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 4/5] git-svn: exclude already merged tips using one rev-list call
Date: Sun, 20 Dec 2009 05:33:54 +1300
Message-ID: <1261240435-8948-5-git-send-email-sam@vilain.net>
References: <1261240435-8948-1-git-send-email-sam@vilain.net>
 <1261240435-8948-2-git-send-email-sam@vilain.net>
 <1261240435-8948-3-git-send-email-sam@vilain.net>
 <1261240435-8948-4-git-send-email-sam@vilain.net>
Cc: Eric Wong <normalperson@yhbt.net>,
	Andrew Myrick <amyrick@gmail.com>, Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 17:34:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM2Gb-00019m-K3
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 17:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbZLSQeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 11:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831AbZLSQeZ
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 11:34:25 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:52462 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825AbZLSQeX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 11:34:23 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 6F17521C38F; Sun, 20 Dec 2009 05:34:22 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from denix (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id D7D1421C4FF;
	Sun, 20 Dec 2009 05:34:13 +1300 (NZDT)
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by denix with esmtp (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1NM2Fz-0002Lt-Bg; Sun, 20 Dec 2009 05:34:15 +1300
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1261240435-8948-4-git-send-email-sam@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135491>

The old function would have to check all mentioned merge tips, every time
that the mergeinfo ticket changed.  This involved 1-2 rev-list operation
for each listed mergeinfo line.  If there are a lot of feature branches
being merged into a trunk, this makes for a very expensive operation for
detecting the new parents on every merge.

This new version first uses a single 'rev-list' to figure out which commit
ranges are already reachable from the parents.  This is used to eliminate
the already merged branches from the list.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 git-svn.perl |   52 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 9cf4a3e..7a790d7 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3011,6 +3011,41 @@ BEGIN {
 	memoize 'lookup_svn_merge';
 }
 
+sub parents_exclude {
+	my $parents = shift;
+	my @commits = @_;
+	return unless @commits;
+
+	my @excluded;
+	my $excluded;
+	do {
+		my @cmd = ('rev-list', "-1", @commits, "--not", @$parents );
+		$excluded = command_oneline(@cmd);
+		if ( $excluded ) {
+			my @new;
+			my $found;
+			for my $commit ( @commits ) {
+				if ( $commit eq $excluded ) {
+					push @excluded, $commit;
+					$found++;
+					last;
+				}
+				else {
+					push @new, $commit;
+				}
+			}
+			die "saw commit '$excluded' in rev-list output, "
+				."but we didn't ask for that commit (wanted: @commits --not @$parents)"
+					unless $found;
+			@commits = @new;
+		}
+	}
+		while ($excluded and @commits);
+
+	return @excluded;
+}
+
+
 # note: this function should only be called if the various dirprops
 # have actually changed
 sub find_extra_svn_parents {
@@ -3023,23 +3058,32 @@ sub find_extra_svn_parents {
 	# are now marked as merge, we can add the tip as a parent.
 	my @merges = split "\n", $mergeinfo;
 	my @merge_tips;
-	my @merged_commit_ranges;
 	my $url = $self->rewrite_root || $self->{url};
 	my $uuid = $self->ra_uuid;
+	my %ranges;
 	for my $merge ( @merges ) {
 		my ($tip_commit, @ranges) =
 			lookup_svn_merge( $uuid, $url, $merge );
-		push @merged_commit_ranges, @ranges;
 		unless (!$tip_commit or
 				grep { $_ eq $tip_commit } @$parents ) {
 			push @merge_tips, $tip_commit;
+			$ranges{$tip_commit} = \@ranges;
 		} else {
 			push @merge_tips, undef;
 		}
 	}
+
+	my %excluded = map { $_ => 1 }
+		parents_exclude($parents, grep { defined } @merge_tips);
+
+	# check merge tips for new parents
+	my @new_parents;
 	for my $merge_tip ( @merge_tips ) {
 		my $spec = shift @merges;
-		next unless $merge_tip;
+		next unless $merge_tip and $excluded{$merge_tip};
+
+		my $ranges = $ranges{$merge_tip};
+
 		my @cmd = ('rev-list', "-1", $merge_tip,
 			   "--not", @$parents );
 		my ($msg_fh, $ctx) = command_output_pipe(@cmd);
@@ -3049,7 +3093,7 @@ sub find_extra_svn_parents {
 		}
 		command_close_pipe($msg_fh, $ctx);
 		if ( $new ) {
-			push @cmd, @merged_commit_ranges;
+			push @cmd, @$ranges;
 			my ($msg_fh, $ctx) = command_output_pipe(@cmd);
 			my $unmerged;
 			while ( <$msg_fh> ) {
-- 
1.6.3.3
