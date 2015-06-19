From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improve contrib/diff-highlight to highlight
 unevenly-sized hunks
Date: Fri, 19 Jun 2015 03:34:55 -0400
Message-ID: <20150619073455.GA29109@peff.net>
References: <xmqqwpz1f22b.fsf@gitster.dls.corp.google.com>
 <CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com>
 <xmqq1th8ga9b.fsf@gitster.dls.corp.google.com>
 <20150618190417.GA12769@peff.net>
 <alpine.DEB.2.20.8.1506181536070.4322@idea>
 <20150618204505.GD14550@peff.net>
 <20150618212356.GA20271@peff.net>
 <20150619035408.GA23679@peff.net>
 <xmqqmvzwb8vk.fsf@gitster.dls.corp.google.com>
 <20150619053223.GA27241@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Patrick Palka <patrick@parcs.ath.cx>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 09:35:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5qpM-0004cl-6I
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 09:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbbFSHe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 03:34:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:48646 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753451AbbFSHe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 03:34:58 -0400
Received: (qmail 30542 invoked by uid 102); 19 Jun 2015 07:34:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Jun 2015 02:34:58 -0500
Received: (qmail 12910 invoked by uid 107); 19 Jun 2015 07:34:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Jun 2015 03:34:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jun 2015 03:34:55 -0400
Content-Disposition: inline
In-Reply-To: <20150619053223.GA27241@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272106>

On Fri, Jun 19, 2015 at 01:32:23AM -0400, Jeff King wrote:

> The least-work thing may actually be teaching the separate
> diff-highlight script to strip out the colorizing and re-add it by
> offset.

OK, here is that patch. It seems to work OK, and should preserve
existing colors produced by git anywhere within the input.

It should also serve as a stepping stone to using the same technique
inside git itself. I am not planning to do that anytime soon, though. I
took a look at the word-diff code earlier today, and my brain partially
melted. I'm sure it's possible, but I've already spent enough time and
brain cells on this for now.

I think this patch does need some more polishing, or more heuristics,
though. Some of the output is really fantastic. Here's a simple one from
69f9a6e54:

  -* link:v2.4.<2>/git.html[documentation for release 2.4.<2>]
  +* link:v2.4.<3>/git.html[documentation for release 2.4.<3>]

The angle brackets show what is highlighted, but that really doesn't do
it justice. I encourage people to apply the patch and

  git show --color $commit |
  contrib/diff-highlight/diff-highlight

to see for yourselves (I'm hesitant to assume that sending ANSI color
codes via email will end up readable for anyone).

What's interesting about that example (that didn't work before) is that
we can find multiple changes and highlight them independently (whereas
before, we would have highlighted everything between them, too).

Here's a better code example from 9cc2b07a7:

  -int parse_commit(struct commit *item)
  +int parse_commit<_gently>(struct commit *item<, int quiet_on_missing>)

It highlights the change in the function name and the matching change to
the parameter list. And from a few lines below in the same diff:

  -               return error("Could not read %s",
  +               return <quiet_on_missing ? -1 :>
  +                       error("Could not read %s",

This demonstrates it working on multiple lines, and in particular one
where the matching content actually crosses a line boundary.

So that's all the good news. Here's some bad news, from f0e7f11d054:

  -       return offset1 - offset2;
  +       return offset1 < offset2 ? -1 :
  +              offset1 > offset2 ?  1 :
  +              0;

I don't think adding angle brackets to this one would do it justice, but
you can look for yourself. What happens is that we match offset1, but
then the "-" from the pre-image matches the first character of "-1" from
the post-image. And all of "< offset2 ? " is highlighted, then not "-",
then "1 :", and so on. The result is rather confusing to read.

I think that can probably be fixed by smarter tokenizing of what we feed
to the per-hunk diff (i.e., "-1" should be a full token).

It also does a weird thing where the "offset1" from the second
post-image line is _not_ highlighted, and it should be (even though it's
ugly, it is the correct thing to do). I think what is happening is that
git's existing colorizing is getting in the way. It does not say "turn
on green; OK, now turn off green". It says "turn on green; OK, now
reset all colors". So at the beginning of each post-image line, we will
accidentally turn off any highlighting carried over from the previous
line. That's probably OK in general, because highlighting across lines
is a good indication that it's not helpful. But it is a little hacky.

And here's some more bad news. If you look at the diff for this
patch itself, it's terribly unreadable (the regular diff already is
pretty bad, but the highlights make it much worse). There are big chunks
where we take away 5 or 10 lines from the old code, and replace them
with totally unrelated lines. We end up highlighting almost the entire
thing, except for spaces and punctuation.

We might be able to solve this with a percentage heuristic similar to
the one Patrick proposed. It's not really interesting to highlight
unless we're doing it on probably 20% or less of the diff (where 20% is
a number I just made up).

I also have a feeling that we might get better results if we don't feed
the delimiters into the diff algorithm. I think the word-diff code
actually tokenizes "foo bar baz" into the list (foo, bar, baz) and diffs
only that. I think it then _loses_ the original whitespace, but here we
would need to record and restore it. We might be able to use the same
mechanism as for stripping and restoring the colors. I'm not sure.

Anyway, here's the patch. It's rather messy, so I'd recommend just
reading the resulting code; I wish there was a good way to convince the
diff engine to produce larger hunks.

---
 contrib/diff-highlight/diff-highlight | 202 +++++++++++++++-------------------
 1 file changed, 86 insertions(+), 116 deletions(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index ffefc31..1525ccc 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -3,6 +3,7 @@
 use 5.008;
 use warnings FATAL => 'all';
 use strict;
+use Algorithm::Diff;
 
 # Highlight by reversing foreground and background. You could do
 # other things like bold or underline if you prefer.
@@ -80,139 +81,108 @@ sub color_config {
 }
 
 sub show_hunk {
-	my ($a, $b) = @_;
+	my ($lines_a, $lines_b) = @_;
 
 	# If one side is empty, then there is nothing to compare or highlight.
-	if (!@$a || !@$b) {
-		print @$a, @$b;
+	if (!@$lines_a || !@$lines_b) {
+		print @$lines_a, @$lines_b;
 		return;
 	}
 
-	# If we have mismatched numbers of lines on each side, we could try to
-	# be clever and match up similar lines. But for now we are simple and
-	# stupid, and only handle multi-line hunks that remove and add the same
-	# number of lines.
-	if (@$a != @$b) {
-		print @$a, @$b;
-		return;
+	# Strip out any cruft so we can do the real diff on $a and $b.
+	my ($a, @stripped_a) = strip_image(@$lines_a);
+	my ($b, @stripped_b) = strip_image(@$lines_b);
+
+	# Now we do the actual diff. Our highlight list is in the same
+	# annotation format as the @stripped data.
+	my $diff = Algorithm::Diff->new([split_image($a)], [split_image($b)]);
+	my ($offset_a, $offset_b) = (0, 0);
+	my (@highlight_a, @highlight_b);
+	while ($diff->Next()) {
+		my $bits = $diff->Diff();
+
+		push @highlight_a, [$offset_a, $OLD_HIGHLIGHT[1]]
+			if $bits & 1;
+		$offset_a += length($_) for $diff->Items(1);
+		push @highlight_a, [$offset_a, $OLD_HIGHLIGHT[2]]
+			if $bits & 1;
+
+		push @highlight_b, [$offset_b, $NEW_HIGHLIGHT[1]]
+			if $bits & 2;
+		$offset_b += length($_) for $diff->Items(2);
+		push @highlight_b, [$offset_b, $NEW_HIGHLIGHT[2]]
+			if $bits & 2;
 	}
 
-	my @queue;
-	for (my $i = 0; $i < @$a; $i++) {
-		my ($rm, $add) = highlight_pair($a->[$i], $b->[$i]);
-		print $rm;
-		push @queue, $add;
-	}
-	print @queue;
+	# And now show the output both with the original stripped annotations,
+	# as well as our new highlights.
+	show_image($a, [merge_annotations(\@stripped_a, \@highlight_a)]);
+	show_image($b, [merge_annotations(\@stripped_b, \@highlight_b)]);
 }
 
-sub highlight_pair {
-	my @a = split_line(shift);
-	my @b = split_line(shift);
-
-	# Find common prefix, taking care to skip any ansi
-	# color codes.
-	my $seen_plusminus;
-	my ($pa, $pb) = (0, 0);
-	while ($pa < @a && $pb < @b) {
-		if ($a[$pa] =~ /$COLOR/) {
-			$pa++;
-		}
-		elsif ($b[$pb] =~ /$COLOR/) {
-			$pb++;
-		}
-		elsif ($a[$pa] eq $b[$pb]) {
-			$pa++;
-			$pb++;
-		}
-		elsif (!$seen_plusminus && $a[$pa] eq '-' && $b[$pb] eq '+') {
-			$seen_plusminus = 1;
-			$pa++;
-			$pb++;
-		}
-		else {
-			last;
+# Strip out any diff syntax (i.e., leading +/-), along with any ANSI color
+# codes from the pre- or post-image of a hunk. The result is a string of text
+# suitable for diffing against the other side of the hunk.
+#
+# In addition to returning the hunk itself, we also return an arrayref that
+# contains the stripped data.  Each element is itself an arrayref containing
+# the offset into the stripped hunk, along with the stripped data that belongs
+# there.
+sub strip_image {
+	my $image = '';
+	my @stripped;
+	foreach my $line (@_) {
+		$line =~ s/^$COLOR*[+-]$COLOR*//
+			or die "BUG: line was not +/-: $line";
+		push @stripped, [length($image), $&];
+
+		while (length($line)) {
+			if ($line =~ s/^$COLOR+//) {
+				push @stripped, [length($image), $&];
+			} elsif ($line =~ s/^(.+?)($COLOR|$)/$2/s) {
+				$image .= $1;
+			} else {
+				die "BUG: we should have matched _something_";
+			}
 		}
 	}
 
-	# Find common suffix, ignoring colors.
-	my ($sa, $sb) = ($#a, $#b);
-	while ($sa >= $pa && $sb >= $pb) {
-		if ($a[$sa] =~ /$COLOR/) {
-			$sa--;
-		}
-		elsif ($b[$sb] =~ /$COLOR/) {
-			$sb--;
-		}
-		elsif ($a[$sa] eq $b[$sb]) {
-			$sa--;
-			$sb--;
-		}
-		else {
-			last;
-		}
-	}
-
-	if (is_pair_interesting(\@a, $pa, $sa, \@b, $pb, $sb)) {
-		return highlight_line(\@a, $pa, $sa, \@OLD_HIGHLIGHT),
-		       highlight_line(\@b, $pb, $sb, \@NEW_HIGHLIGHT);
-	}
-	else {
-		return join('', @a),
-		       join('', @b);
-	}
+	return $image, @stripped;
 }
 
-sub split_line {
-	local $_ = shift;
-	return utf8::decode($_) ?
-		map { utf8::encode($_); $_ }
-			map { /$COLOR/ ? $_ : (split //) }
-			split /($COLOR+)/ :
-		map { /$COLOR/ ? $_ : (split //) }
-		split /($COLOR+)/;
+# Split the pre- or post-image into diffable elements. Returns
+sub split_image {
+	return split(/([[:space:]]+|[[:punct:]]+)/, shift);
 }
 
-sub highlight_line {
-	my ($line, $prefix, $suffix, $theme) = @_;
-
-	my $start = join('', @{$line}[0..($prefix-1)]);
-	my $mid = join('', @{$line}[$prefix..$suffix]);
-	my $end = join('', @{$line}[($suffix+1)..$#$line]);
-
-	# If we have a "normal" color specified, then take over the whole line.
-	# Otherwise, we try to just manipulate the highlighted bits.
-	if (defined $theme->[0]) {
-		s/$COLOR//g for ($start, $mid, $end);
-		chomp $end;
-		return join('',
-			$theme->[0], $start, $RESET,
-			$theme->[1], $mid, $RESET,
-			$theme->[0], $end, $RESET,
-			"\n"
-		);
-	} else {
-		return join('',
-			$start,
-			$theme->[1], $mid, $theme->[2],
-			$end
-		);
+sub merge_annotations {
+	my ($a, $b) = @_;
+	my @r;
+	while (@$a && @$b) {
+		if ($a->[0]->[0] <= $b->[0]->[0]) {
+			push @r, shift @$a;
+		} else {
+			push @r, shift @$b;
+		}
 	}
+	push @r, @$a;
+	push @r, @$b;
+	return @r;
 }
 
-# Pairs are interesting to highlight only if we are going to end up
-# highlighting a subset (i.e., not the whole line). Otherwise, the highlighting
-# is just useless noise. We can detect this by finding either a matching prefix
-# or suffix (disregarding boring bits like whitespace and colorization).
-sub is_pair_interesting {
-	my ($a, $pa, $sa, $b, $pb, $sb) = @_;
-	my $prefix_a = join('', @$a[0..($pa-1)]);
-	my $prefix_b = join('', @$b[0..($pb-1)]);
-	my $suffix_a = join('', @$a[($sa+1)..$#$a]);
-	my $suffix_b = join('', @$b[($sb+1)..$#$b]);
-
-	return $prefix_a !~ /^$COLOR*-$BORING*$/ ||
-	       $prefix_b !~ /^$COLOR*\+$BORING*$/ ||
-	       $suffix_a !~ /^$BORING*$/ ||
-	       $suffix_b !~ /^$BORING*$/;
+sub show_image {
+	my ($image, $annotations) = @_;
+	my $pos = 0;
+
+	foreach my $an (@$annotations) {
+		if ($pos < $an->[0]) {
+			print substr($image, $pos, $an->[0] - $pos);
+			$pos = $an->[0];
+		}
+		print $an->[1];
+	}
+
+	if ($pos < length($image)) {
+		print substr($image, $pos);
+	}
 }
-- 
2.4.4.719.g3984bc6
