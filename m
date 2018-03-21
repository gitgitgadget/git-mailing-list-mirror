Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3F271F404
	for <e@80x24.org>; Wed, 21 Mar 2018 05:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbeCUF7D (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 01:59:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:37024 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751040AbeCUF7D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 01:59:03 -0400
Received: (qmail 29597 invoked by uid 109); 21 Mar 2018 05:59:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Mar 2018 05:59:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7040 invoked by uid 111); 21 Mar 2018 05:59:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Mar 2018 01:59:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2018 01:59:01 -0400
Date:   Wed, 21 Mar 2018 01:59:01 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Brian Henderson <henderson.bj@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 7/7] diff-highlight: detect --graph by indent
Message-ID: <20180321055900.GB15674@sigill.intra.peff.net>
References: <20180321054718.GA13936@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180321054718.GA13936@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch fixes a corner case where diff-highlight may
scramble some diffs when combined with --graph.

Commit 7e4ffb4c17 (diff-highlight: add support for --graph
output, 2016-08-29) taught diff-highlight to skip past the
graph characters at the start of each line with this regex:

  ($COLOR?\|$COLOR?\s+)*

I.e., any series of pipes separated by and followed by
arbitrary whitespace.  We need to match more than just a
single space because the commit in question may be indented
to accommodate other parts of the graph drawing. E.g.:

 * commit 1234abcd
 | ...
 | diff --git ...

has only a single space, but for the last commit before a
fork:

 | | |
 | * | commit 1234abcd
 | |/  ...
 | |   diff --git

the diff lines have more spaces between the pipes and the
start of the diff.

However, when we soak up all of those spaces with the
$GRAPH regex, we may accidentally include the leading space
for a context line. That means we may consider the actual
contents of a context line as part of the diff syntax. In
other words, something like this:

   normal context line
  -old line
  +new line
   -this is a context line with a leading dash

would cause us to see that final context line as a removal
line, and we'd end up showing the hunk in the wrong order:

  normal context line
  -old line
   -this is a context line with a leading dash
  +new line

Instead, let's a be a little more clever about parsing the
graph. We'll look for the actual "*" line that marks the
start of a commit, and record the indentation we see there.
Then we can skip past that indentation when checking whether
the line is a hunk header, removal, addition, etc.

There is one tricky thing: the indentation in bytes may be
different for various lines of the graph due to coloring.
E.g., the "*" on a commit line is generally shown without
color, but on the actual diff lines, it will be replaced
with a colorized "|" character, adding several bytes. We
work around this here by counting "visible" bytes. This is
unfortunately a bit more expensive, making us about twice as
slow to handle --graph output. But since this is meant to be
used interactively anyway, it's tolerably fast (and the
non-graph case is unaffected).

One alternative would be to search for hunk header lines and
use their indentation (since they'd have the same colors as
the diff lines which follow). But that just opens up
different corner cases. If we see:

  | |    @@ 1,2 1,3 @@

we cannot know if this is a real diff that has been
indented due to the graph, or if it's a context line that
happens to look like a diff header. We can only be sure of
the indent on the "*" lines, since we know those don't
contain arbitrary data (technically the user could include a
bunch of extra indentation via --format, but that's rare
enough to disregard).

Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/diff-highlight/DiffHighlight.pm       | 78 +++++++++++++++----
 .../diff-highlight/t/t9400-diff-highlight.sh  | 28 +++++++
 2 files changed, 91 insertions(+), 15 deletions(-)

diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
index e07cd5931d..536754583b 100644
--- a/contrib/diff-highlight/DiffHighlight.pm
+++ b/contrib/diff-highlight/DiffHighlight.pm
@@ -21,34 +21,82 @@ my $RESET = "\x1b[m";
 my $COLOR = qr/\x1b\[[0-9;]*m/;
 my $BORING = qr/$COLOR|\s/;
 
-# The patch portion of git log -p --graph should only ever have preceding | and
-# not / or \ as merge history only shows up on the commit line.
-my $GRAPH = qr/$COLOR?\|$COLOR?\s+/;
-
 my @removed;
 my @added;
 my $in_hunk;
+my $graph_indent = 0;
 
 our $line_cb = sub { print @_ };
 our $flush_cb = sub { local $| = 1 };
 
-sub handle_line {
+# Count the visible width of a string, excluding any terminal color sequences.
+sub visible_width {
 	local $_ = shift;
+	my $ret = 0;
+	while (length) {
+		if (s/^$COLOR//) {
+			# skip colors
+		} elsif (s/^.//) {
+			$ret++;
+		}
+	}
+	return $ret;
+}
+
+# Return a substring of $str, omitting $len visible characters from the
+# beginning, where terminal color sequences do not count as visible.
+sub visible_substr {
+	my ($str, $len) = @_;
+	while ($len > 0) {
+		if ($str =~ s/^$COLOR//) {
+			next
+		}
+		$str =~ s/^.//;
+		$len--;
+	}
+	return $str;
+}
+
+sub handle_line {
+	my $orig = shift;
+	local $_ = $orig;
+
+	# match a graph line that begins a commit
+	if (/^(?:$COLOR?\|$COLOR?[ ])* # zero or more leading "|" with space
+	         $COLOR?\*$COLOR?[ ]   # a "*" with its trailing space
+	      (?:$COLOR?\|$COLOR?[ ])* # zero or more trailing "|"
+	                         [ ]*  # trailing whitespace for merges
+	    /x) {
+	        my $graph_prefix = $&;
+
+		# We must flush before setting graph indent, since the
+		# new commit may be indented differently from what we
+		# queued.
+		flush();
+		$graph_indent = visible_width($graph_prefix);
+
+	} elsif ($graph_indent) {
+		if (length($_) < $graph_indent) {
+			$graph_indent = 0;
+		} else {
+			$_ = visible_substr($_, $graph_indent);
+		}
+	}
 
 	if (!$in_hunk) {
-		$line_cb->($_);
-		$in_hunk = /^$GRAPH*$COLOR*\@\@ /;
+		$line_cb->($orig);
+		$in_hunk = /^$COLOR*\@\@ /;
 	}
-	elsif (/^$GRAPH*$COLOR*-/) {
-		push @removed, $_;
+	elsif (/^$COLOR*-/) {
+		push @removed, $orig;
 	}
-	elsif (/^$GRAPH*$COLOR*\+/) {
-		push @added, $_;
+	elsif (/^$COLOR*\+/) {
+		push @added, $orig;
 	}
 	else {
 		flush();
-		$line_cb->($_);
-		$in_hunk = /^$GRAPH*$COLOR*[\@ ]/;
+		$line_cb->($orig);
+		$in_hunk = /^$COLOR*[\@ ]/;
 	}
 
 	# Most of the time there is enough output to keep things streaming,
@@ -225,8 +273,8 @@ sub is_pair_interesting {
 	my $suffix_a = join('', @$a[($sa+1)..$#$a]);
 	my $suffix_b = join('', @$b[($sb+1)..$#$b]);
 
-	return $prefix_a !~ /^$GRAPH*$COLOR*-$BORING*$/ ||
-	       $prefix_b !~ /^$GRAPH*$COLOR*\+$BORING*$/ ||
+	return visible_substr($prefix_a, $graph_indent) !~ /^$COLOR*-$BORING*$/ ||
+	       visible_substr($prefix_b, $graph_indent) !~ /^$COLOR*\+$BORING*$/ ||
 	       $suffix_a !~ /^$BORING*$/ ||
 	       $suffix_b !~ /^$BORING*$/;
 }
diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index bf0c270d60..f6f5195d00 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -310,4 +310,32 @@ test_expect_success 'diff-highlight ignores combined diffs' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff-highlight handles --graph with leading dash' '
+	cat >file <<-\EOF &&
+	before
+	the old line
+	-leading dash
+	EOF
+	git add file &&
+	git commit -m before &&
+
+	sed s/old/new/ <file >file.tmp &&
+	mv file.tmp file &&
+	git add file &&
+	git commit -m after &&
+
+	cat >expect <<-EOF &&
+	--- a/file
+	+++ b/file
+	@@ -1,3 +1,3 @@
+	 before
+	-the ${CW}old${CR} line
+	+the ${CW}new${CR} line
+	 -leading dash
+	EOF
+	git log --graph -p -1 | "$DIFF_HIGHLIGHT" >actual.raw &&
+	trim_graph <actual.raw | sed -n "/^---/,\$p" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.17.0.rc0.402.ged0b3fd1ee
