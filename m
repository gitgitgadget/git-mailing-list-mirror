From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/3] git-add--interactive: replace hunk recounting with apply --recount
Date: Wed,  2 Jul 2008 23:59:16 +0200
Message-ID: <1215035956-26192-1-git-send-email-trast@student.ethz.ch>
References: <1215035909-26110-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 00:00:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEAMu-0001sR-RH
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 00:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122AbYGBV7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 17:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755397AbYGBV7G
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 17:59:06 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:19466 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755041AbYGBV7F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 17:59:05 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 2 Jul 2008 23:59:03 +0200
Received: from localhost.localdomain ([84.75.156.10]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 2 Jul 2008 23:59:03 +0200
X-Mailer: git-send-email 1.5.6.1.276.gde9a
In-Reply-To: <1215035909-26110-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 02 Jul 2008 21:59:03.0034 (UTC) FILETIME=[D6FB9DA0:01C8DC8E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87198>

We recounted the postimage offsets to compensate for hunks that were
not selected.  Now apply --recount can do the job for us.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-add--interactive.perl |   30 +++---------------------------
 1 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 903953e..e1964a5 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -970,39 +970,15 @@ sub patch_update_file {
 		push @result, @{$mode->{TEXT}};
 	}
 	for (@hunk) {
-		my $text = $_->{TEXT};
-		my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) =
-		    parse_hunk_header($text->[0]);
-
-		if (!$_->{USE}) {
-			# We would have added ($n_cnt - $o_cnt) lines
-			# to the postimage if we were to use this hunk,
-			# but we didn't.  So the line number that the next
-			# hunk starts at would be shifted by that much.
-			$n_lofs -= ($n_cnt - $o_cnt);
-			next;
-		}
-		else {
-			if ($n_lofs) {
-				$n_ofs += $n_lofs;
-				$text->[0] = ("@@ -$o_ofs" .
-					      (($o_cnt != 1)
-					       ? ",$o_cnt" : '') .
-					      " +$n_ofs" .
-					      (($n_cnt != 1)
-					       ? ",$n_cnt" : '') .
-					      " @@\n");
-			}
-			for (@$text) {
-				push @result, $_;
-			}
+		if ($_->{USE}) {
+			push @result, @{$_->{TEXT}};
 		}
 	}
 
 	if (@result) {
 		my $fh;
 
-		open $fh, '| git apply --cached';
+		open $fh, '| git apply --cached --recount';
 		for (@{$head->{TEXT}}, @result) {
 			print $fh $_;
 		}
-- 
1.5.6.1.276.gde9a
