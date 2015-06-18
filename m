From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Improve contrib/diff-highlight to highlight
 unevenly-sized hunks
Date: Thu, 18 Jun 2015 17:23:56 -0400
Message-ID: <20150618212356.GA20271@peff.net>
References: <1434388853-23915-1-git-send-email-patrick@parcs.ath.cx>
 <xmqqwpz1f22b.fsf@gitster.dls.corp.google.com>
 <CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com>
 <xmqq1th8ga9b.fsf@gitster.dls.corp.google.com>
 <20150618190417.GA12769@peff.net>
 <alpine.DEB.2.20.8.1506181536070.4322@idea>
 <20150618204505.GD14550@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Patrick Palka <patrick@parcs.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jun 18 23:24:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5hID-0003ut-A8
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 23:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbbFRVYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 17:24:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:48492 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752012AbbFRVYA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 17:24:00 -0400
Received: (qmail 27966 invoked by uid 102); 18 Jun 2015 21:23:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Jun 2015 16:23:59 -0500
Received: (qmail 8952 invoked by uid 107); 18 Jun 2015 21:23:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Jun 2015 17:23:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Jun 2015 17:23:56 -0400
Content-Disposition: inline
In-Reply-To: <20150618204505.GD14550@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272077>

On Thu, Jun 18, 2015 at 04:45:05PM -0400, Jeff King wrote:

> Still, I think this is probably a minority case, and it may be
> outweighed by the improvements. The "real" solution is to consider the
> hunk as a whole and do an LCS diff on it, which would show that yes,
> it's worth highlighting both of those spots, as they are a small
> percentage of the total hunk.

I've been meaning to play with this for years, so I took the opportunity
to spend a little time on it. :)

Below is a (slightly hacky) patch I came up with. It seems to work, and
produces really great output in some cases. For instance, in 99a2cfb, it
produces (I put highlighted bits in angle brackets):

  -               <hash>cpy(peeled, <sha1>);
  +               <oid>cpy(<&>peeled, <oid>);

It also produces nonsense like:

  -       <un>s<ign>ed <char >peeled<[20]>;
  +       s<truct obj>e<ct_i>d peeled;

but I think that is simply because my splitting function is terrible (it
splits each byte, whereas we'd probably want to use whitespace and
punctuation, or something content-specific).

---
diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index ffefc31..7165518 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -3,6 +3,7 @@
 use 5.008;
 use warnings FATAL => 'all';
 use strict;
+use Algorithm::Diff;
 
 # Highlight by reversing foreground and background. You could do
 # other things like bold or underline if you prefer.
@@ -88,131 +89,54 @@ sub show_hunk {
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
-	my @queue;
-	for (my $i = 0; $i < @$a; $i++) {
-		my ($rm, $add) = highlight_pair($a->[$i], $b->[$i]);
-		print $rm;
-		push @queue, $add;
-	}
-	print @queue;
-}
-
-sub highlight_pair {
-	my @a = split_line(shift);
-	my @b = split_line(shift);
+	my ($prefix_a, $suffix_a, @hunk_a) = split_hunk(@$a);
+	my ($prefix_b, $suffix_b, @hunk_b) = split_hunk(@$b);
 
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
-		}
-	}
+	my $diff = Algorithm::Diff->new(\@hunk_a, \@hunk_b);
+	my (@out_a, @out_b);
+	while ($diff->Next()) {
+		my $bits = $diff->Diff();
 
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
+		push @out_a, $OLD_HIGHLIGHT[1] if $bits & 1;
+		push @out_a, $diff->Items(1);
+		push @out_a, $OLD_HIGHLIGHT[2] if $bits & 1;
 
-	if (is_pair_interesting(\@a, $pa, $sa, \@b, $pb, $sb)) {
-		return highlight_line(\@a, $pa, $sa, \@OLD_HIGHLIGHT),
-		       highlight_line(\@b, $pb, $sb, \@NEW_HIGHLIGHT);
-	}
-	else {
-		return join('', @a),
-		       join('', @b);
+		push @out_b, $NEW_HIGHLIGHT[1] if $bits & 2;
+		push @out_b, $diff->Items(2);
+		push @out_b, $NEW_HIGHLIGHT[2] if $bits & 2;
 	}
-}
 
-sub split_line {
-	local $_ = shift;
-	return utf8::decode($_) ?
-		map { utf8::encode($_); $_ }
-			map { /$COLOR/ ? $_ : (split //) }
-			split /($COLOR+)/ :
-		map { /$COLOR/ ? $_ : (split //) }
-		split /($COLOR+)/;
+	output_split_hunk($prefix_a, $suffix_a, @out_a);
+	output_split_hunk($prefix_b, $suffix_b, @out_b);
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
+# Return the individual diff-able items of the hunk, but with any
+# diff or color prefix/suffix for each line split out (we assume that the
+# prefix/suffix for each line will be the same).
+sub split_hunk {
+	my ($prefix, $suffix, @r);
+	foreach my $line (@_) {
+		$line =~ /^($COLOR*[+-]$COLOR*)(.*)($COLOR*)/
+			or die "eh, this is supposed to match everything!";
+
+		# overwrite the old values; we assume they're all the same
+		# anyway
+		$prefix = $1;
+		$suffix = $3;
+
+		# do a straight character split. This almost certainly isn't
+		# ideal, but it's a good starting point. We should at the very
+		# least be utf8-aware, and probably use color-words regexes.
+		push @r, split(//, $2), "\n";
 	}
+	return ($prefix, $suffix, @r);
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
+sub output_split_hunk {
+	my $prefix = shift;
+	my $suffix = shift;
+	my $str = join('', @_);
+	$str =~ s/^/$prefix/mg;
+	$str =~ s/$/$suffix/mg;
+	print $str;
 }
