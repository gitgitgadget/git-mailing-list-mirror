From: Jeff King <peff@peff.net>
Subject: [PATCH 7/7] diff-highlight: allow configurable colors
Date: Thu, 20 Nov 2014 10:29:18 -0500
Message-ID: <20141120152918.GG23680@peff.net>
References: <20141120151418.GA23607@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Scott Baker <bakers@canbytel.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 16:29:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrTfl-0002J5-8m
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 16:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757564AbaKTP3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 10:29:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:42789 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757558AbaKTP3U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 10:29:20 -0500
Received: (qmail 12256 invoked by uid 102); 20 Nov 2014 15:29:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 09:29:20 -0600
Received: (qmail 13144 invoked by uid 107); 20 Nov 2014 15:29:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 10:29:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Nov 2014 10:29:18 -0500
Content-Disposition: inline
In-Reply-To: <20141120151418.GA23607@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Until now, the highlighting colors were hard-coded in the
script (as "reverse" and "noreverse"), and you had to edit
the script to change them. This patch teaches diff-highlight
to read from color.diff-highlight.* to set them.

In addition, it expands the possiblities considerably by
adding two features:

  1. Old/new lines can be colored independently (so you can
     use a color scheme that complements existing line
     coloring).

  2. Normal, unhighlighted parts of the lines can be colored,
     too. Technically this can be done by separately
     configuring color.diff.old/new and matching it to your
     diff-highlight colors. But you may want a different
     look for your highlighted diffs versus your regular
     diffs.

Signed-off-by: Jeff King <peff@peff.net>
---
I originally designed the (2) feature above to do the GitHub-style
background outlining that you mentioned. But it occurs to me that you
probably _do_ want to set your color.diff.old and color.diff.new
variables, as diff-highlight will only ever touch highlighted lines (so
a hunk with a single added line will not be touched at all). So I dunno.
Maybe part (2) here should be dropped, as it adds a reasonable amount of
complexity (just read the docs below to see what I mean).

I do not plan on using the feature myself. After experimenting with
several color options, I do not really like any of them, and am
perfectly happy to stick with "reverse/noreverse". :)

 contrib/diff-highlight/README         | 41 +++++++++++++++++++++++
 contrib/diff-highlight/diff-highlight | 62 +++++++++++++++++++++++++++--------
 2 files changed, 90 insertions(+), 13 deletions(-)

diff --git a/contrib/diff-highlight/README b/contrib/diff-highlight/README
index 502e03b..836b97a 100644
--- a/contrib/diff-highlight/README
+++ b/contrib/diff-highlight/README
@@ -58,6 +58,47 @@ following in your git configuration:
 	diff = diff-highlight | less
 ---------------------------------------------
 
+
+Color Config
+------------
+
+You can configure the highlight colors and attributes using git's
+config. The colors for "old" and "new" lines can be specified
+independently. There are two "modes" of configuration:
+
+  1. You can specify a "highlight" color and a matching "reset" color.
+     This will retain any existing colors in the diff, and apply the
+     "highlight" and "reset" colors before and after the highlighted
+     portion.
+
+  2. You can specify a "normal" color and a "highlight" color. In this
+     case, existing colors are dropped from that line. The non-highlighted
+     bits of the line get the "normal" color, and the highlights get the
+     "highlight" color.
+
+If no "new" colors are specified, they default to the "old" colors. If
+no "old" colors are specified, the default is to reverse the foreground
+and background for highlighted portions.
+
+Examples:
+
+---------------------------------------------
+# Underline highlighted portions
+[color "diff-highlight"]
+oldHighlight = ul
+oldReset = noul
+---------------------------------------------
+
+---------------------------------------------
+# Varying background intensities
+[color "diff-highlight"]
+oldNormal = "black #f8cbcb"
+oldHighlight = "black #ffaaaa"
+newNormal = "black #cbeecb"
+newHighlight = "black #aaffaa"
+---------------------------------------------
+
+
 Bugs
 ----
 
diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index 69a652e..08c88bb 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -5,8 +5,18 @@ use strict;
 
 # Highlight by reversing foreground and background. You could do
 # other things like bold or underline if you prefer.
-my $HIGHLIGHT   = "\x1b[7m";
-my $UNHIGHLIGHT = "\x1b[27m";
+my @OLD_HIGHLIGHT = (
+	color_config('color.diff-highlight.oldnormal'),
+	color_config('color.diff-highlight.oldhighlight', "\x1b[7m"),
+	color_config('color.diff-highlight.oldreset', "\x1b[27m")
+);
+my @NEW_HIGHLIGHT = (
+	color_config('color.diff-highlight.newnormal', $OLD_HIGHLIGHT[0]),
+	color_config('color.diff-highlight.newhighlight', $OLD_HIGHLIGHT[1]),
+	color_config('color.diff-highlight.newreset', $OLD_HIGHLIGHT[2])
+);
+
+my $RESET = "\x1b[m";
 my $COLOR = qr/\x1b\[[0-9;]*m/;
 my $BORING = qr/$COLOR|\s/;
 
@@ -57,6 +67,17 @@ show_hunk(\@removed, \@added);
 
 exit 0;
 
+# Ideally we would feed the default as a human-readable color to
+# git-config as the fallback value. But diff-highlight does
+# not otherwise depend on git at all, and there are reports
+# of it being used in other settings. Let's handle our own
+# fallback, which means we will work even if git can't be run.
+sub color_config {
+	my ($key, $default) = @_;
+	my $s = `git config --get-color $key 2>/dev/null`;
+	return length($s) ? $s : $default;
+}
+
 sub show_hunk {
 	my ($a, $b) = @_;
 
@@ -132,8 +153,8 @@ sub highlight_pair {
 	}
 
 	if (is_pair_interesting(\@a, $pa, $sa, \@b, $pb, $sb)) {
-		return highlight_line(\@a, $pa, $sa),
-		       highlight_line(\@b, $pb, $sb);
+		return highlight_line(\@a, $pa, $sa, \@OLD_HIGHLIGHT),
+		       highlight_line(\@b, $pb, $sb, \@NEW_HIGHLIGHT);
 	}
 	else {
 		return join('', @a),
@@ -148,15 +169,30 @@ sub split_line {
 }
 
 sub highlight_line {
-	my ($line, $prefix, $suffix) = @_;
-
-	return join('',
-		@{$line}[0..($prefix-1)],
-		$HIGHLIGHT,
-		@{$line}[$prefix..$suffix],
-		$UNHIGHLIGHT,
-		@{$line}[($suffix+1)..$#$line]
-	);
+	my ($line, $prefix, $suffix, $theme) = @_;
+
+	my $start = join('', @{$line}[0..($prefix-1)]);
+	my $mid = join('', @{$line}[$prefix..$suffix]);
+	my $end = join('', @{$line}[($suffix+1)..$#$line]);
+
+	# If we have a "normal" color specified, then take over the whole line.
+	# Otherwise, we try to just manipulate the highlighted bits.
+	if (defined $theme->[0]) {
+		s/$COLOR//g for ($start, $mid, $end);
+		chomp $end;
+		return join('',
+			$theme->[0], $start, $RESET,
+			$theme->[1], $mid, $RESET,
+			$theme->[0], $end, $RESET,
+			"\n"
+		);
+	} else {
+		return join('',
+			$start,
+			$theme->[1], $mid, $theme->[2],
+			$end
+		);
+	}
 }
 
 # Pairs are interesting to highlight only if we are going to end up
-- 
2.2.0.rc2.402.g4519813
