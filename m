From: Jonathan Lebon <jonathan.lebon@gmail.com>
Subject: [PATCH 3/4] diff-highlight: match up lines before highlighting
Date: Mon,  2 Nov 2015 21:05:33 -0500
Message-ID: <1446516334-27652-4-git-send-email-jonathan.lebon@gmail.com>
References: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
Cc: peff@peff.net, Jonathan Lebon <jonathan.lebon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 03:06:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtQzj-0003Ee-SJ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 03:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689AbbKCCG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 21:06:29 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33869 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbbKCCGW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 21:06:22 -0500
Received: by qgem9 with SMTP id m9so2314234qge.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 18:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nA8QrPqchWJXk4twrG5sUug8Gpx/9ON4SYCJKPxMnbI=;
        b=VXBAeZZMxT9GklcXyeebwGs8qgteaM0N/5KbXPmsDzL00GkPagUVb0bh80IgFiAo5r
         GVQsqiPBLi+Z2STQtem36IL3E6XU0c+/uSlqe7BJ3RsdjsTuEGtwXhx2eHygL2aVDX+d
         vFt01MP00b+oOyD+1zlPljcQSj/q3gPyNGCDfbv2Pyb/R5fdA4ICtEtYZpXDMz7K7xJg
         D6VAMQ7tHs4TqvuY1OyL5QJ81r13zkzGURr2ljcEYsTxF4cdWHj+DH4nEfLMqlVskUgT
         X7T60wkgUUrYr3jtE56d85HfoHUS21rKBzI+ea0rSGSONJt0ii8t3pGKw1UScW3GvQus
         FgQw==
X-Received: by 10.140.22.234 with SMTP id 97mr34171705qgn.55.1446516381962;
        Mon, 02 Nov 2015 18:06:21 -0800 (PST)
Received: from vostro.yyz.redhat.com ([38.104.156.250])
        by smtp.gmail.com with ESMTPSA id s21sm9013447qkl.36.2015.11.02.18.06.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2015 18:06:21 -0800 (PST)
X-Mailer: git-send-email 2.6.0
In-Reply-To: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280745>

As mentioned in the README, one of the current limitations of
diff-highlight is that it only calculates highlights when the hunk
contains the same number of removed lines as added lines.

A further limitation upon this is that diff-highlight assumes that the
first line removed matches the first line added, similarly with the
second, the third, etc... As was demonstrated in the "Bugs" section of
the README, this poses limitations since that assumption does not always
give the best result.

With this patch, we eliminate those limitations by trying to match up
the removed and added lines before highlighting them. This is done using
a recursive algorithm.

Note that I did not bother with some common optimizations such as
memoization since the usual number of removed/added lines in a single
hunk are small. In practice, I have not felt any lag at all during
paging.

Signed-off-by: Jonathan Lebon <jonathan.lebon@gmail.com>
---
 contrib/diff-highlight/README         | 61 +------------------------
 contrib/diff-highlight/diff-highlight | 83 +++++++++++++++++++++++++++++------
 2 files changed, 70 insertions(+), 74 deletions(-)

diff --git a/contrib/diff-highlight/README b/contrib/diff-highlight/README
index bbbfdda..885ff2f 100644
--- a/contrib/diff-highlight/README
+++ b/contrib/diff-highlight/README
@@ -14,17 +14,7 @@ Instead, this script post-processes the line-oriented diff, finds pairs
 of lines, and highlights the differing segments.  It's currently very
 simple and stupid about doing these tasks. In particular:
 
-  1. It will only highlight hunks in which the number of removed and
-     added lines is the same, and it will pair lines within the hunk by
-     position (so the first removed line is compared to the first added
-     line, and so forth). This is simple and tends to work well in
-     practice. More complex changes don't highlight well, so we tend to
-     exclude them due to the "same number of removed and added lines"
-     restriction. Or even if we do try to highlight them, they end up
-     not highlighting because of our "don't highlight if the whole line
-     would be highlighted" rule.
-
-  2. It will find the common prefix and suffix of two lines, and
+  1. It will find the common prefix and suffix of two lines, and
      consider everything in the middle to be "different". It could
      instead do a real diff of the characters between the two lines and
      find common subsequences. However, the point of the highlight is to
@@ -142,52 +132,3 @@ heuristics.
 -----------------------------------------------------
 
    which is less readable than the current output.
-
-2. The multi-line matching assumes that lines in the pre- and post-image
-   match by position. This is often the case, but can be fooled when a
-   line is removed from the top and a new one added at the bottom (or
-   vice versa). Unless the lines in the middle are also changed, diffs
-   will show this as two hunks, and it will not get highlighted at all
-   (which is good). But if the lines in the middle are changed, the
-   highlighting can be misleading. Here's a pathological case:
-
------------------------------------------------------
--one
--two
--three
--four
-+two 2
-+three 3
-+four 4
-+five 5
------------------------------------------------------
-
-   which gets highlighted as:
-
------------------------------------------------------
--one
--t-{wo}
--three
--f-{our}
-+two 2
-+t+{hree 3}
-+four 4
-+f+{ive 5}
------------------------------------------------------
-
-   because it matches "two" to "three 3", and so forth. It would be
-   nicer as:
-
------------------------------------------------------
--one
--two
--three
--four
-+two +{2}
-+three +{3}
-+four +{4}
-+five 5
------------------------------------------------------
-
-   which would probably involve pre-matching the lines into pairs
-   according to some heuristic.
diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index a332f86..46556fc 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -88,24 +88,79 @@ sub show_hunk {
 		return;
 	}
 
-	# If we have mismatched numbers of lines on each side, we could try to
-	# be clever and match up similar lines. But for now we are simple and
-	# stupid, and only handle multi-line hunks that remove and add the same
-	# number of lines.
-	if (@$a != @$b) {
-		print @$a, @$b;
-		return;
-	}
-
 	my @queue;
-	for (my $i = 0; $i < @$a; $i++) {
-		my ($rm, $add) = highlight_pair($a->[$i], $b->[$i]);
-		print $rm;
-		push @queue, $add;
-	}
+	match_and_highlight_pairs($a, 0, scalar @$a, $b, 0, scalar @$b, \@queue);
 	print @queue;
 }
 
+# Here, we try to be clever and match up similar lines. I.e. we try to
+# find which lines in the `rem` lines (array a) became which other lines
+# in the `add` lines (array b). To do this, we use a recursive algorithm
+# that works as follow:
+# 	1. Find the most similar pair of lines in all possible pairs
+# 	2. Do a recursive call to find the most similar pair of lines in all
+# 	   pairs, restricted to lower indices
+# 	3. Print the `rem` line of the best pair
+# 	4. Queue the `add` line of the best pair
+# 	5. Do a recursive call to find the most similar pair of lines in all
+# 	   pairs, restricted to higher indices
+sub match_and_highlight_pairs {
+	my ($a, $a_first, $a_last, $b,  $b_first, $b_last, $queue) = @_;
+
+	# base case: no more rem or add lines to pair up
+	if ($a_first >= $a_last || $b_first >= $b_last) {
+
+		# flush out any remaining rem lines
+		for (my $i = $a_first; $i < $a_last; $i++) {
+			print $a->[$i];
+		}
+
+		# queue up any remaining add lines
+		for (my $i = $b_first; $i < $b_last; $i++) {
+			push @$queue, $b->[$i];
+		}
+
+		return;
+	}
+
+	# prime the loop
+	my ($besti, $bestj) = ($a_first, $b_first);
+	my $bestn = calculate_match($a->[$a_first], $b->[$b_first]) + 1;
+
+	for (my $i = $a_first; $i < $a_last; $i++) {
+		for (my $j = $b_first; $j < $b_last; $j++) {
+			my $n = calculate_match($a->[$i], $b->[$j]);
+			if ($n < $bestn) {
+				($besti, $bestj, $bestn) = ($i, $j, $n);
+			}
+		}
+	}
+
+	# find the best matches in the lower pairs
+	match_and_highlight_pairs($a, $a_first, $besti, $b, $b_first, $bestj, $queue);
+
+	my ($rm, $add) = highlight_pair($a->[$besti], $b->[$bestj]);
+	print $rm;
+	push @$queue, $add;
+
+	# find the best matches in the higher pairs
+	match_and_highlight_pairs($a, $besti+1, $a_last, $b, $bestj+1, $b_last, $queue);
+}
+
+# A measure of how well the two lines passed match up. The smaller the
+# returned value, the better the match. The current implementation uses
+# a simple heuristic which tries to minimize the overall diff between
+# the two lines considering only their common prefix and suffix.
+sub calculate_match {
+	my @a = split_line(shift);
+	my @b = split_line(shift);
+
+	my ($pa, $pb) = find_common_prefix(\@a, \@b);
+	my ($sa, $sb) = find_common_suffix(\@a, $pa, \@b, $pb);
+
+	return ($sa - $pa) + ($sb - $pb);
+}
+
 sub highlight_pair {
 	my @a = split_line(shift);
 	my @b = split_line(shift);
-- 
2.6.0
