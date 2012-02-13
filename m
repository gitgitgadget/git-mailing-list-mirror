From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] diff-highlight: refactor to prepare for multi-line hunks
Date: Mon, 13 Feb 2012 17:33:10 -0500
Message-ID: <20120213223310.GC19521@sigill.intra.peff.net>
References: <20120213222702.GA19393@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 23:33:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx4SU-0002el-O0
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 23:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927Ab2BMWdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 17:33:14 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34499
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754792Ab2BMWdO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 17:33:14 -0500
Received: (qmail 1922 invoked by uid 107); 13 Feb 2012 22:40:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Feb 2012 17:40:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2012 17:33:10 -0500
Content-Disposition: inline
In-Reply-To: <20120213222702.GA19393@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190684>

The current code structure assumes that we will only look at
a pair of lines at any given time, and that the end result
should always be to output that pair. However, we want to
eventually handle multi-line hunks, which will involve
collating pairs of removed/added lines. Let's refactor the
code to return highlighted pairs instead of printing them.

Signed-off-by: Jeff King <peff@peff.net>
---
You did a similar refactoring in your patch, but I found pulling it out
made the next patch a lot more readable.

 contrib/diff-highlight/diff-highlight |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index 0d8df84..279d211 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -23,7 +23,7 @@ while (<>) {
 	    $window[2] =~ /^$COLOR*\+/ &&
 	    $window[3] !~ /^$COLOR*\+/) {
 		print shift @window;
-		show_pair(shift @window, shift @window);
+		show_hunk(shift @window, shift @window);
 	}
 	else {
 		print shift @window;
@@ -48,7 +48,7 @@ if (@window == 3 &&
     $window[1] =~ /^$COLOR*-/ &&
     $window[2] =~ /^$COLOR*\+/) {
 	print shift @window;
-	show_pair(shift @window, shift @window);
+	show_hunk(shift @window, shift @window);
 }
 
 # And then flush any remaining lines.
@@ -58,7 +58,13 @@ while (@window) {
 
 exit 0;
 
-sub show_pair {
+sub show_hunk {
+	my ($a, $b) = @_;
+
+	print highlight_pair($a, $b);
+}
+
+sub highlight_pair {
 	my @a = split_line(shift);
 	my @b = split_line(shift);
 
@@ -106,12 +112,12 @@ sub show_pair {
 	}
 
 	if (is_pair_interesting(\@a, $pa, $sa, \@b, $pb, $sb)) {
-		print highlight(\@a, $pa, $sa);
-		print highlight(\@b, $pb, $sb);
+		return highlight_line(\@a, $pa, $sa),
+		       highlight_line(\@b, $pb, $sb);
 	}
 	else {
-		print join('', @a);
-		print join('', @b);
+		return join('', @a),
+		       join('', @b);
 	}
 }
 
@@ -121,7 +127,7 @@ sub split_line {
 	       split /($COLOR*)/;
 }
 
-sub highlight {
+sub highlight_line {
 	my ($line, $prefix, $suffix) = @_;
 
 	return join('',
-- 
1.7.8.4.17.g2df81
