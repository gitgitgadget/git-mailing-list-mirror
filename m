From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] contrib: add diff highlight script
Date: Tue, 18 Oct 2011 00:52:20 -0400
Message-ID: <20111018045220.GA9008@sigill.intra.peff.net>
References: <20111018044955.GA8976@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 06:52:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG1f9-0002J5-K8
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 06:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab1JREwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 00:52:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34187
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793Ab1JREwW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 00:52:22 -0400
Received: (qmail 16135 invoked by uid 107); 18 Oct 2011 04:52:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Oct 2011 00:52:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Oct 2011 00:52:20 -0400
Content-Disposition: inline
In-Reply-To: <20111018044955.GA8976@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183851>

This is a simple and stupid script for highlighting
differing parts of lines in a unified diff. See the README
for a discussion of the limitations.

Signed-off-by: Jeff King <peff@peff.net>
---
I posted a similar script before, but not as a contrib patch. Many of
the comments were that this could be done more accurately inside git
itself. Undoubtedly. But this is already written, and I have found it
very useful in practice. If somebody wants to come along with an
implementation inside git-diff, I'd be happy to compare output.

 contrib/diff-highlight/README         |   57 +++++++++++++++
 contrib/diff-highlight/diff-highlight |  124 +++++++++++++++++++++++++++++++++
 2 files changed, 181 insertions(+), 0 deletions(-)
 create mode 100644 contrib/diff-highlight/README
 create mode 100755 contrib/diff-highlight/diff-highlight

diff --git a/contrib/diff-highlight/README b/contrib/diff-highlight/README
new file mode 100644
index 0000000..1b7b6df
--- /dev/null
+++ b/contrib/diff-highlight/README
@@ -0,0 +1,57 @@
+diff-highlight
+==============
+
+Line oriented diffs are great for reviewing code, because for most
+hunks, you want to see the old and the new segments of code next to each
+other. Sometimes, though, when an old line and a new line are very
+similar, it's hard to immediately see the difference.
+
+You can use "--color-words" to highlight only the changed portions of
+lines. However, this can often be hard to read for code, as it loses
+the line structure, and you end up with oddly formatted bits.
+
+Instead, this script post-processes the line-oriented diff, finds pairs
+of lines, and highlights the differing segments.  It's currently very
+simple and stupid about doing these tasks. In particular:
+
+  1. It will only highlight a pair of lines if they are the only two
+     lines in a hunk.  It could instead try to match up "before" and
+     "after" lines for a given hunk into pairs of similar lines.
+     However, this may end up visually distracting, as the paired
+     lines would have other highlighted lines in between them. And in
+     practice, the lines which most need attention called to their
+     small, hard-to-see changes are touching only a single line.
+
+  2. It will find the common prefix and suffix of two lines, and
+     consider everything in the middle to be "different". It could
+     instead do a real diff of the characters between the two lines and
+     find common subsequences. However, the point of the highlight is to
+     call attention to a certain area. Even if some small subset of the
+     highlighted area actually didn't change, that's OK. In practice it
+     ends up being more readable to just have a single blob on the line
+     showing the interesting bit.
+
+The goal of the script is therefore not to be exact about highlighting
+changes, but to call attention to areas of interest without being
+visually distracting.  Non-diff lines and existing diff coloration is
+preserved; the intent is that the output should look exactly the same as
+the input, except for the occasional highlight.
+
+Use
+---
+
+You can try out the diff-highlight program with:
+
+---------------------------------------------
+git log -p --color | /path/to/diff-highlight
+---------------------------------------------
+
+If you want to use it all the time, drop it in your $PATH and put the
+following in your git configuration:
+
+---------------------------------------------
+[pager]
+	log = diff-highlight | less
+	show = diff-highlight | less
+	diff = diff-highlight | less
+---------------------------------------------
diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
new file mode 100755
index 0000000..d893898
--- /dev/null
+++ b/contrib/diff-highlight/diff-highlight
@@ -0,0 +1,124 @@
+#!/usr/bin/perl
+
+# Highlight by reversing foreground and background. You could do
+# other things like bold or underline if you prefer.
+my $HIGHLIGHT   = "\x1b[7m";
+my $UNHIGHLIGHT = "\x1b[27m";
+my $COLOR = qr/\x1b\[[0-9;]*m/;
+
+my @window;
+
+while (<>) {
+	# We highlight only single-line changes, so we need
+	# a 4-line window to make a decision on whether
+	# to highlight.
+	push @window, $_;
+	next if @window < 4;
+	if ($window[0] =~ /^$COLOR*(\@| )/ &&
+	    $window[1] =~ /^$COLOR*-/ &&
+	    $window[2] =~ /^$COLOR*\+/ &&
+	    $window[3] !~ /^$COLOR*\+/) {
+		print shift @window;
+		show_pair(shift @window, shift @window);
+	}
+	else {
+		print shift @window;
+	}
+
+	# Most of the time there is enough output to keep things streaming,
+	# but for something like "git log -Sfoo", you can get one early
+	# commit and then many seconds of nothing. We want to show
+	# that one commit as soon as possible.
+	#
+	# Since we can receive arbitrary input, there's no optimal
+	# place to flush. Flushing on a blank line is a heuristic that
+	# happens to match git-log output.
+	if (!length) {
+		local $| = 1;
+	}
+}
+
+# Special case a single-line hunk at the end of file.
+if (@window == 3 &&
+    $window[0] =~ /^$COLOR*(\@| )/ &&
+    $window[1] =~ /^$COLOR*-/ &&
+    $window[2] =~ /^$COLOR*\+/) {
+	print shift @window;
+	show_pair(shift @window, shift @window);
+}
+
+# And then flush any remaining lines.
+while (@window) {
+	print shift @window;
+}
+
+exit 0;
+
+sub show_pair {
+	my @a = split_line(shift);
+	my @b = split_line(shift);
+
+	# Find common prefix, taking care to skip any ansi
+	# color codes.
+	my $seen_plusminus;
+	my ($pa, $pb) = (0, 0);
+	while ($pa < @a && $pb < @b) {
+		if ($a[$pa] =~ /$COLOR/) {
+			$pa++;
+		}
+		elsif ($b[$pb] =~ /$COLOR/) {
+			$pb++;
+		}
+		elsif ($a[$pa] eq $b[$pb]) {
+			$pa++;
+			$pb++;
+		}
+		elsif (!$seen_plusminus && $a[$pa] eq '-' && $b[$pb] eq '+') {
+			$seen_plusminus = 1;
+			$pa++;
+			$pb++;
+		}
+		else {
+			last;
+		}
+	}
+
+	# Find common suffix, ignoring colors.
+	my ($sa, $sb) = ($#a, $#b);
+	while ($sa >= $pa && $sb >= $pb) {
+		if ($a[$sa] =~ /$COLOR/) {
+			$sa--;
+		}
+		elsif ($b[$sb] =~ /$COLOR/) {
+			$sb--;
+		}
+		elsif ($a[$sa] eq $b[$sb]) {
+			$sa--;
+			$sb--;
+		}
+		else {
+			last;
+		}
+	}
+
+	print highlight(\@a, $pa, $sa);
+	print highlight(\@b, $pb, $sb);
+}
+
+sub split_line {
+	local $_ = shift;
+	return map { /$COLOR/ ? $_ : (split //) }
+	       split /($COLOR*)/;
+}
+
+sub highlight {
+	my ($line, $prefix, $suffix) = @_;
+
+	return join('',
+		@{$line}[0..($prefix-1)],
+		$HIGHLIGHT,
+		@{$line}[$prefix..$suffix],
+		$UNHIGHLIGHT,
+		@{$line}[($suffix+1)..$#$line]
+	);
+}
-- 
1.7.7.rc3.37.gc4dc8
