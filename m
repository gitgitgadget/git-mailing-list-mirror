From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] add--interactive: allow hunk filtering on command line
Date: Wed, 27 Jul 2011 02:05:49 -0600
Message-ID: <20110727080548.GC14002@sigill.intra.peff.net>
References: <20110727080303.GA8105@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 10:05:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlz7t-0005R8-OI
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 10:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626Ab1G0IFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 04:05:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42547
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959Ab1G0IFw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 04:05:52 -0400
Received: (qmail 28436 invoked by uid 107); 27 Jul 2011 08:06:23 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Jul 2011 04:06:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2011 02:05:49 -0600
Content-Disposition: inline
In-Reply-To: <20110727080303.GA8105@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177941>

If you have a lot of uninteresting hunks (e.g., because you
have a file with boilerplate that changed, but you want to
add only the interesting bits and discard the rest), it can
be cumbersome to sift through the boring hunks.

This patch provides an option to match hunks by regular
expression, pretending as if the non-matching changes do not
exist at all (similar to how path-limiting ignores
non-matching paths entirely).

There are two special case pseudo-hunks to consider in the
code: mode hunks and deletion hunks.

  - If a filter is given, this patch will never include mode
    hunks, since the user has asked for a specific subset of
    hunks, and the mode has no text to match.

  - Deletion hunks actually require no special care. In a
    deletion there will be only a single giant diff hunk of
    deleted content. If it matches the filter, then the
    deletion can be presented as normal. If it doesn't
    match, then we exit early from patch_update_file and
    never consider showing the deletion at all (since there
    is nothing to delete).

This patch provides only the perl portion; it is up to
individual callers of add--interactive to pass the option
through to the perl code.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 3e4c8a4..bb16f71 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -86,6 +86,7 @@ sub colored {
 # command line options
 my $patch_mode;
 my $patch_mode_revision;
+my @patch_mode_hunk_filter;
 
 sub apply_patch;
 sub apply_patch_for_checkout_commit;
@@ -1273,17 +1274,33 @@ sub trim_error {
 	return $_;
 }
 
+sub want_hunk {
+	my $hunk = shift;
+	my $text = join('', @{$hunk->{TEXT}});
+
+	foreach my $re (@patch_mode_hunk_filter) {
+		return 1 if $text =~ $re;
+	}
+	return 0;
+}
+
 sub patch_update_file {
 	my $quit = 0;
 	my ($ix, $num);
 	my $path = shift;
 	my ($head, @hunk) = parse_diff($path);
+
+	if (@patch_mode_hunk_filter) {
+		@hunk = grep { want_hunk($_) } @hunk;
+		return unless @hunk;
+	}
+
 	($head, my $mode, my $deletion) = parse_diff_header($head);
 	for (@{$head->{DISPLAY}}) {
 		print;
 	}
 
-	if (@{$mode->{TEXT}}) {
+	if (@{$mode->{TEXT}} && !@patch_mode_hunk_filter) {
 		unshift @hunk, $mode;
 	}
 	if (@{$deletion->{TEXT}}) {
@@ -1568,6 +1585,11 @@ sub process_args {
 		if ($ARGV[0] =~ /--patch(?:=(.*))?/) {
 			$patch_mode = defined $1 ? $1 : 'stage';
 		}
+		elsif ($ARGV[0] =~ /--hunk-filter=(.*)/) {
+			my $re = eval { qr{$1}m }
+				or die "malformed hunk filter $1: " . trim_error($@);
+			push @patch_mode_hunk_filter, $re;
+		}
 		else {
 			last;
 		}
-- 
1.7.5.4.31.ge4d5e
