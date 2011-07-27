From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] add--interactive: add option to autosplit hunks
Date: Wed, 27 Jul 2011 02:06:01 -0600
Message-ID: <20110727080601.GE14002@sigill.intra.peff.net>
References: <20110727080303.GA8105@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 10:06:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlz85-0005Ve-Mh
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 10:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901Ab1G0IGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 04:06:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42553
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159Ab1G0IGE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 04:06:04 -0400
Received: (qmail 28470 invoked by uid 107); 27 Jul 2011 08:06:34 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Jul 2011 04:06:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2011 02:06:01 -0600
Content-Disposition: inline
In-Reply-To: <20110727080303.GA8105@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177943>

It is sometimes useful to see changes in their smallest
possible form, rather than complete hunks with overlapping
context. You can do this manually, of course, with the
's'plit hunk command. But when filtering hunks, you may want
to pre-split to give your filtering a finer granularity.

This patch adds only the perl infrastructure; to expose this
to the user, the various callers of add--interactive need to
pass the new option through to the perl script.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 917b2a9..41c7c6f 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -88,6 +88,7 @@ my $patch_mode;
 my $patch_mode_revision;
 my @patch_mode_hunk_filter;
 my $patch_mode_negate_filter;
+my $patch_mode_autosplit;
 
 sub apply_patch;
 sub apply_patch_for_checkout_commit;
@@ -1291,6 +1292,10 @@ sub patch_update_file {
 	my $path = shift;
 	my ($head, @hunk) = parse_diff($path);
 
+	if ($patch_mode_autosplit) {
+		@hunk = map { split_hunk($_->{TEXT}, $_->{DISPLAY}) } @hunk;
+	}
+
 	if (@patch_mode_hunk_filter) {
 		@hunk = grep { want_hunk($_) } @hunk;
 		return unless @hunk;
@@ -1594,6 +1599,9 @@ sub process_args {
 		elsif ($ARGV[0] eq '--negate-hunk-filter') {
 			$patch_mode_negate_filter = 1;
 		}
+		elsif ($ARGV[0] eq '--split-hunks') {
+			$patch_mode_autosplit = 1;
+		}
 		else {
 			last;
 		}
-- 
1.7.5.4.31.ge4d5e
