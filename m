From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/3] git-add--interactive: remove hunk coalescing
Date: Wed,  2 Jul 2008 23:59:44 +0200
Message-ID: <1215035984-26263-1-git-send-email-trast@student.ethz.ch>
References: <1215035956-26192-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 00:00:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEANK-00022c-HF
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 00:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755725AbYGBV7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 17:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755772AbYGBV7b
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 17:59:31 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:19505 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755688AbYGBV7b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 17:59:31 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 2 Jul 2008 23:59:30 +0200
Received: from localhost.localdomain ([84.75.156.10]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 2 Jul 2008 23:59:29 +0200
X-Mailer: git-send-email 1.5.6.1.276.gde9a
In-Reply-To: <1215035956-26192-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 02 Jul 2008 21:59:29.0659 (UTC) FILETIME=[E6DA44B0:01C8DC8E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87199>

Current git-apply has no trouble at all applying chunks that have
overlapping context, as produced by the splitting feature. So we can
drop the manual coalescing.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-add--interactive.perl |   89 ---------------------------------------------
 1 files changed, 0 insertions(+), 89 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index e1964a5..a4234d3 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -682,93 +682,6 @@ sub split_hunk {
 	return @split;
 }
 
-sub find_last_o_ctx {
-	my ($it) = @_;
-	my $text = $it->{TEXT};
-	my ($o_ofs, $o_cnt) = parse_hunk_header($text->[0]);
-	my $i = @{$text};
-	my $last_o_ctx = $o_ofs + $o_cnt;
-	while (0 < --$i) {
-		my $line = $text->[$i];
-		if ($line =~ /^ /) {
-			$last_o_ctx--;
-			next;
-		}
-		last;
-	}
-	return $last_o_ctx;
-}
-
-sub merge_hunk {
-	my ($prev, $this) = @_;
-	my ($o0_ofs, $o0_cnt, $n0_ofs, $n0_cnt) =
-	    parse_hunk_header($prev->{TEXT}[0]);
-	my ($o1_ofs, $o1_cnt, $n1_ofs, $n1_cnt) =
-	    parse_hunk_header($this->{TEXT}[0]);
-
-	my (@line, $i, $ofs, $o_cnt, $n_cnt);
-	$ofs = $o0_ofs;
-	$o_cnt = $n_cnt = 0;
-	for ($i = 1; $i < @{$prev->{TEXT}}; $i++) {
-		my $line = $prev->{TEXT}[$i];
-		if ($line =~ /^\+/) {
-			$n_cnt++;
-			push @line, $line;
-			next;
-		}
-
-		last if ($o1_ofs <= $ofs);
-
-		$o_cnt++;
-		$ofs++;
-		if ($line =~ /^ /) {
-			$n_cnt++;
-		}
-		push @line, $line;
-	}
-
-	for ($i = 1; $i < @{$this->{TEXT}}; $i++) {
-		my $line = $this->{TEXT}[$i];
-		if ($line =~ /^\+/) {
-			$n_cnt++;
-			push @line, $line;
-			next;
-		}
-		$ofs++;
-		$o_cnt++;
-		if ($line =~ /^ /) {
-			$n_cnt++;
-		}
-		push @line, $line;
-	}
-	my $head = ("@@ -$o0_ofs" .
-		    (($o_cnt != 1) ? ",$o_cnt" : '') .
-		    " +$n0_ofs" .
-		    (($n_cnt != 1) ? ",$n_cnt" : '') .
-		    " @@\n");
-	@{$prev->{TEXT}} = ($head, @line);
-}
-
-sub coalesce_overlapping_hunks {
-	my (@in) = @_;
-	my @out = ();
-
-	my ($last_o_ctx);
-
-	for (grep { $_->{USE} } @in) {
-		my $text = $_->{TEXT};
-		my ($o_ofs) = parse_hunk_header($text->[0]);
-		if (defined $last_o_ctx &&
-		    $o_ofs <= $last_o_ctx) {
-			merge_hunk($out[-1], $_);
-		}
-		else {
-			push @out, $_;
-		}
-		$last_o_ctx = find_last_o_ctx($out[-1]);
-	}
-	return @out;
-}
 
 sub help_patch_cmd {
 	print colored $help_color, <<\EOF ;
@@ -962,8 +875,6 @@ sub patch_update_file {
 		}
 	}
 
-	@hunk = coalesce_overlapping_hunks(@hunk);
-
 	my $n_lofs = 0;
 	my @result = ();
 	if ($mode->{USE}) {
-- 
1.5.6.1.276.gde9a
