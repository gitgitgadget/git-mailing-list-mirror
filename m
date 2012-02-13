From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] diff-highlight: match multi-line hunks
Date: Mon, 13 Feb 2012 17:36:36 -0500
Message-ID: <20120213223636.GD19521@sigill.intra.peff.net>
References: <20120213222702.GA19393@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 23:36:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx4Vs-0006Bv-M6
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 23:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757969Ab2BMWgl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 17:36:41 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34502
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757923Ab2BMWgj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 17:36:39 -0500
Received: (qmail 1952 invoked by uid 107); 13 Feb 2012 22:43:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Feb 2012 17:43:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2012 17:36:36 -0500
Content-Disposition: inline
In-Reply-To: <20120213222702.GA19393@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190685>

Currently we only bother highlighting single-line hunks. The
rationale was that the purpose of highlighting is to point
out small changes between two similar lines that are
otherwise hard to see. However, that meant we missed similar
cases where two lines were changed together, like:

   -foo(buf);
   -bar(buf);
   +foo(obj->buf);
   +bar(obj->buf);

Each of those changes is simple, and would benefit from
highlighting (the "obj->" parts in this case).

This patch considers whole hunks at a time. For now, we
consider only the case where the hunk has the same number of
removed and added lines, and assume that the lines from each
segment correspond one-to-one. While this is just a
heuristic, in practice it seems to generate sensible
results (especially because we now omit highlighting on
completely-changed lines, so when our heuristic is wrong, we
tend to avoid highlighting at all).

Based on an original idea and implementation by Micha=C5=82
Kiedrowicz.

Signed-off-by: Jeff King <peff@peff.net>
---
Same attribution statement applies as to patch 2 (in fact, patches 1 an=
d
3 could be attributed to you, too).

This version has the missing documentation fixes.  The implementation i=
s
a little different than yours. I rearranged the parsing in a manner tha=
t
was a little more obvious to me, and I pulled out the "don't highlight
if the number of lines don't match" case into its own conditional, whic=
h
makes it more obvious where to work if somebody wants to try doing
something fancier.

 contrib/diff-highlight/README         |   16 ++++---
 contrib/diff-highlight/diff-highlight |   70 ++++++++++++++++++++-----=
--------
 2 files changed, 52 insertions(+), 34 deletions(-)

diff --git a/contrib/diff-highlight/README b/contrib/diff-highlight/REA=
DME
index 1b7b6df..4a58579 100644
--- a/contrib/diff-highlight/README
+++ b/contrib/diff-highlight/README
@@ -14,13 +14,15 @@ Instead, this script post-processes the line-orient=
ed diff, finds pairs
 of lines, and highlights the differing segments.  It's currently very
 simple and stupid about doing these tasks. In particular:
=20
-  1. It will only highlight a pair of lines if they are the only two
-     lines in a hunk.  It could instead try to match up "before" and
-     "after" lines for a given hunk into pairs of similar lines.
-     However, this may end up visually distracting, as the paired
-     lines would have other highlighted lines in between them. And in
-     practice, the lines which most need attention called to their
-     small, hard-to-see changes are touching only a single line.
+  1. It will only highlight hunks in which the number of removed and
+     added lines is the same, and it will pair lines within the hunk b=
y
+     position (so the first removed line is compared to the first adde=
d
+     line, and so forth). This is simple and tends to work well in
+     practice. More complex changes don't highlight well, so we tend t=
o
+     exclude them due to the "same number of removed and added lines"
+     restriction. Or even if we do try to highlight them, they end up
+     not highlighting because of our "don't highlight if the whole lin=
e
+     would be highlighted" rule.
=20
   2. It will find the common prefix and suffix of two lines, and
      consider everything in the middle to be "different". It could
diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highl=
ight/diff-highlight
index 279d211..c4404d4 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -10,23 +10,28 @@ my $UNHIGHLIGHT =3D "\x1b[27m";
 my $COLOR =3D qr/\x1b\[[0-9;]*m/;
 my $BORING =3D qr/$COLOR|\s/;
=20
-my @window;
+my @removed;
+my @added;
+my $in_hunk;
=20
 while (<>) {
-	# We highlight only single-line changes, so we need
-	# a 4-line window to make a decision on whether
-	# to highlight.
-	push @window, $_;
-	next if @window < 4;
-	if ($window[0] =3D~ /^$COLOR*(\@| )/ &&
-	    $window[1] =3D~ /^$COLOR*-/ &&
-	    $window[2] =3D~ /^$COLOR*\+/ &&
-	    $window[3] !~ /^$COLOR*\+/) {
-		print shift @window;
-		show_hunk(shift @window, shift @window);
+	if (!$in_hunk) {
+		print;
+		$in_hunk =3D /^$COLOR*\@/;
+	}
+	elsif (/^$COLOR*-/) {
+		push @removed, $_;
+	}
+	elsif (/^$COLOR*\+/) {
+		push @added, $_;
 	}
 	else {
-		print shift @window;
+		show_hunk(\@removed, \@added);
+		@removed =3D ();
+		@added =3D ();
+
+		print;
+		$in_hunk =3D /^$COLOR*[\@ ]/;
 	}
=20
 	# Most of the time there is enough output to keep things streaming,
@@ -42,26 +47,37 @@ while (<>) {
 	}
 }
=20
-# Special case a single-line hunk at the end of file.
-if (@window =3D=3D 3 &&
-    $window[0] =3D~ /^$COLOR*(\@| )/ &&
-    $window[1] =3D~ /^$COLOR*-/ &&
-    $window[2] =3D~ /^$COLOR*\+/) {
-	print shift @window;
-	show_hunk(shift @window, shift @window);
-}
-
-# And then flush any remaining lines.
-while (@window) {
-	print shift @window;
-}
+# Flush any queued hunk (this can happen when there is no trailing con=
text in
+# the final diff of the input).
+show_hunk(\@removed, \@added);
=20
 exit 0;
=20
 sub show_hunk {
 	my ($a, $b) =3D @_;
=20
-	print highlight_pair($a, $b);
+	# If one side is empty, then there is nothing to compare or highlight=
=2E
+	if (!@$a || !@$b) {
+		print @$a, @$b;
+		return;
+	}
+
+	# If we have mismatched numbers of lines on each side, we could try t=
o
+	# be clever and match up similar lines. But for now we are simple and
+	# stupid, and only handle multi-line hunks that remove and add the sa=
me
+	# number of lines.
+	if (@$a !=3D @$b) {
+		print @$a, @$b;
+		return;
+	}
+
+	my @queue;
+	for (my $i =3D 0; $i < @$a; $i++) {
+		my ($rm, $add) =3D highlight_pair($a->[$i], $b->[$i]);
+		print $rm;
+		push @queue, $add;
+	}
+	print @queue;
 }
=20
 sub highlight_pair {
--=20
1.7.8.4.17.g2df81
