From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] add--interactive: allow negatation of hunk filters
Date: Wed, 27 Jul 2011 02:05:56 -0600
Message-ID: <20110727080556.GD14002@sigill.intra.peff.net>
References: <20110727080303.GA8105@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 10:06:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlz80-0005TB-C5
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 10:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898Ab1G0IF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 04:05:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42550
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753756Ab1G0IF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 04:05:59 -0400
Received: (qmail 28465 invoked by uid 107); 27 Jul 2011 08:06:29 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Jul 2011 04:06:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2011 02:05:56 -0600
Content-Disposition: inline
In-Reply-To: <20110727080303.GA8105@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177942>

This patch lets you filter out certain boring hunks, rather
than trying to match particular interesting ones (which may
be much easier, depending on your file contents).

Signed-off-by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index bb16f71..917b2a9 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -87,6 +87,7 @@ sub colored {
 my $patch_mode;
 my $patch_mode_revision;
 my @patch_mode_hunk_filter;
+my $patch_mode_negate_filter;
 
 sub apply_patch;
 sub apply_patch_for_checkout_commit;
@@ -1279,9 +1280,9 @@ sub want_hunk {
 	my $text = join('', @{$hunk->{TEXT}});
 
 	foreach my $re (@patch_mode_hunk_filter) {
-		return 1 if $text =~ $re;
+		return !$patch_mode_negate_filter if $text =~ $re;
 	}
-	return 0;
+	return $patch_mode_negate_filter;
 }
 
 sub patch_update_file {
@@ -1590,6 +1591,9 @@ sub process_args {
 				or die "malformed hunk filter $1: " . trim_error($@);
 			push @patch_mode_hunk_filter, $re;
 		}
+		elsif ($ARGV[0] eq '--negate-hunk-filter') {
+			$patch_mode_negate_filter = 1;
+		}
 		else {
 			last;
 		}
-- 
1.7.5.4.31.ge4d5e
