From: Jeff King <peff@peff.net>
Subject: Re: diff-highlight highlight words?
Date: Wed, 12 Nov 2014 02:56:09 -0500
Message-ID: <20141112075609.GA21485@peff.net>
References: <5462907B.1050207@canbytel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Scott Baker <bakers@canbytel.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 08:56:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoSmn-0007XE-Em
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 08:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbaKLH4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 02:56:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:39419 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751123AbaKLH4M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 02:56:12 -0500
Received: (qmail 21089 invoked by uid 102); 12 Nov 2014 07:56:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Nov 2014 01:56:12 -0600
Received: (qmail 3468 invoked by uid 107); 12 Nov 2014 07:56:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Nov 2014 02:56:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2014 02:56:09 -0500
Content-Disposition: inline
In-Reply-To: <5462907B.1050207@canbytel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc git@vger, since this may be of interest to others]

On Tue, Nov 11, 2014 at 02:40:59PM -0800, Scott Baker wrote:

> I'd like to recreate the github style diffs on the command line. It
> appears that your diff-highlight is very close. The current version only
> allows you to "invert the colors" which isn't ideal.

Yes, I never built any configurability into the script. However, you can
tweak the definitions at the top to get different effects.
Traditionally, ANSI colors on the terminal only came in two flavors:
"normal" and "bright" (which is attached to the "bold" attribute").
Instead of reversing video, you can switch on brightness like this:

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index c4404d4..c99de99 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -5,8 +5,8 @@ use strict;
 
 # Highlight by reversing foreground and background. You could do
 # other things like bold or underline if you prefer.
-my $HIGHLIGHT   = "\x1b[7m";
-my $UNHIGHLIGHT = "\x1b[27m";
+my $HIGHLIGHT   = "\x1b[1m";
+my $UNHIGHLIGHT = "\x1b[22m";
 my $COLOR = qr/\x1b\[[0-9;]*m/;
 my $BORING = qr/$COLOR|\s/;
 

However on most modern terminals the color difference between bright and
normal is very subtle, and this doesn't look good.

XTerm (and other modern terminals) has 256-color support, so you could
do better there (assuming your terminal supports it). The current code
builds on the existing colors produced by git (because the operations
are only "invert colors" and "uninvert colors"). Doing anything fancier
requires handling add/del differently.  That patch might look something
like this (which uses dark red/green for most of the line, and a much
brighter variant for the highlighted text):

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index c4404d4..4e08f3c 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -5,11 +5,16 @@ use strict;
 
 # Highlight by reversing foreground and background. You could do
 # other things like bold or underline if you prefer.
-my $HIGHLIGHT   = "\x1b[7m";
-my $UNHIGHLIGHT = "\x1b[27m";
 my $COLOR = qr/\x1b\[[0-9;]*m/;
 my $BORING = qr/$COLOR|\s/;
 
+# Elements:
+# 0 - highlighted text
+# 1 - unhighlighted text
+# 2 - reset to normal
+my @ADD_HIGHLIGHT = ("\x1b[38;2;100;255;100m", "\x1b[38;2;0;255;0m", "\x1b[30m");
+my @DEL_HIGHLIGHT = ("\x1b[38;2;255;100;100m", "\x1b[38;2;255;0;0m", "\x1b[30m");
+
 my @removed;
 my @added;
 my $in_hunk;
@@ -128,8 +133,8 @@ sub highlight_pair {
 	}
 
 	if (is_pair_interesting(\@a, $pa, $sa, \@b, $pb, $sb)) {
-		return highlight_line(\@a, $pa, $sa),
-		       highlight_line(\@b, $pb, $sb);
+		return highlight_line(\@a, $pa, $sa, @DEL_HIGHLIGHT),
+		       highlight_line(\@b, $pb, $sb, @ADD_HIGHLIGHT);
 	}
 	else {
 		return join('', @a),
@@ -144,15 +149,18 @@ sub split_line {
 }
 
 sub highlight_line {
-	my ($line, $prefix, $suffix) = @_;
+	my ($line, $prefix, $suffix, $highlight, $unhighlight, $reset) = @_;
 
-	return join('',
+	my $r = join('',
+		$unhighlight,
 		@{$line}[0..($prefix-1)],
-		$HIGHLIGHT,
+		$highlight,
 		@{$line}[$prefix..$suffix],
-		$UNHIGHLIGHT,
-		@{$line}[($suffix+1)..$#$line]
+		$unhighlight,
+		@{$line}[($suffix+1)..$#$line],
 	);
+	$r =~ s/\n$/$reset$&/;
+	return $r;
 }
 
 # Pairs are interesting to highlight only if we are going to end up


The result does not look terrible to me, though I think I find the
reverse-video more obvious when scanning the diff. To look more like
GitHub's view, you could instead set the background by doing this on
top:

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index 4e08f3c..6f98db4 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -12,8 +12,8 @@ my $BORING = qr/$COLOR|\s/;
 # 0 - highlighted text
 # 1 - unhighlighted text
 # 2 - reset to normal
-my @ADD_HIGHLIGHT = ("\x1b[38;2;100;255;100m", "\x1b[38;2;0;255;0m", "\x1b[30m");
-my @DEL_HIGHLIGHT = ("\x1b[38;2;255;100;100m", "\x1b[38;2;255;0;0m", "\x1b[30m");
+my @ADD_HIGHLIGHT = ("\x1b[30;48;2;100;255;100m", "\x1b[30;48;2;0;255;0m", "\x1b[0m");
+my @DEL_HIGHLIGHT = ("\x1b[30;48;2;255;100;100m", "\x1b[30;48;2;255;0;0m", "\x1b[0m");
 
 my @removed;
 my @added;
@@ -151,14 +151,18 @@ sub split_line {
 sub highlight_line {
 	my ($line, $prefix, $suffix, $highlight, $unhighlight, $reset) = @_;
 
+	# strip out existing colors from git, which will clash
+	# both due to contrast and because of random ANSI resets
+	# inside the content
+	my $p = join('', @{$line}[0..($prefix-1)]);
+	my $t = join('', @{$line}[$prefix..$suffix]);
+	my $s = join('', @{$line}[($suffix+1)..$#$line]);
+	s/$COLOR//g for ($p, $t, $s);
+
 	my $r = join('',
-		$unhighlight,
-		@{$line}[0..($prefix-1)],
-		$highlight,
-		@{$line}[$prefix..$suffix],
-		$unhighlight,
-		@{$line}[($suffix+1)..$#$line],
-	);
+		     $unhighlight, $p,
+		     $highlight, $t,
+		     $unhighlight, $s);
 	$r =~ s/\n$/$reset$&/;
 	return $r;
 }

I'm not wild about that either. I dunno. I still like the reverse-video
the best, but it may be that with a few tweaks somebody could make it
look less ugly.

-Peff
