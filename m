From: Jeff King <peff@peff.net>
Subject: [PATCH 3/6] t/perf: add infrastructure for measuring sizes
Date: Wed, 26 Mar 2014 03:22:41 -0400
Message-ID: <20140326072241.GC32193@sigill.intra.peff.net>
References: <20140326072215.GA31739@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Maurer <bmaurer@fb.com>, Siddharth Agarwal <sid0@fb.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 08:22:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSiAj-0005He-Om
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 08:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbaCZHWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 03:22:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:47389 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751394AbaCZHWn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 03:22:43 -0400
Received: (qmail 14500 invoked by uid 102); 26 Mar 2014 07:22:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Mar 2014 02:22:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2014 03:22:41 -0400
Content-Disposition: inline
In-Reply-To: <20140326072215.GA31739@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245164>

The main objective of scripts in the perf framework is to
run "test_perf", which measures the time it takes to run
some operation. However, it can also be interesting to see
the change in the output size of certain operations.

This patch introduces test_size, which records a single
numeric output from the test and shows it in the aggregated
output (with pretty printing and relative size comparison).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/README         | 20 ++++++++++++++++++++
 t/perf/aggregate.perl | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 t/perf/perf-lib.sh    | 13 +++++++++++++
 3 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/t/perf/README b/t/perf/README
index 8848c14..09c400f 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -144,3 +144,23 @@ that
   While we have tried to make sure that it can cope with embedded
   whitespace and other special characters, it will not work with
   multi-line data.
+
+Rather than tracking the performance by run-time as `test_perf` does, you
+may also track output size by using `test_size`. The stdout of the
+function should be a single numeric value, which will be captured and
+shown in the aggregated output. For example:
+
+	test_perf 'time foo' '
+		./foo >foo.out
+	'
+
+	test_size 'output size'
+		wc -c <foo.out
+	'
+
+might produce output like:
+
+	Test                origin           HEAD
+	-------------------------------------------------------------
+	1234.1 time foo     0.37(0.79+0.02)  0.26(0.51+0.02) -29.7%
+	1234.2 output size             4.3M             3.6M -14.7%
diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 690cd8c..42739a5 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -10,10 +10,16 @@ sub get_times {
 	my $line = <$fh>;
 	return undef if not defined $line;
 	close $fh or die "cannot close $name: $!";
-	$line =~ /^(?:(\d+):)?(\d+):(\d+(?:\.\d+)?) (\d+(?:\.\d+)?) (\d+(?:\.\d+)?)$/
-		or die "bad input line: $line";
-	my $rt = ((defined $1 ? $1 : 0.0)*60+$2)*60+$3;
-	return ($rt, $4, $5);
+	# times
+	if ($line =~ /^(?:(\d+):)?(\d+):(\d+(?:\.\d+)?) (\d+(?:\.\d+)?) (\d+(?:\.\d+)?)$/) {
+		my $rt = ((defined $1 ? $1 : 0.0)*60+$2)*60+$3;
+		return ($rt, $4, $5);
+	# size
+	} elsif ($line =~ /^\d+$/) {
+		return $&;
+	} else {
+		die "bad input line: $line";
+	}
 }
 
 sub relative_change {
@@ -29,14 +35,39 @@ sub relative_change {
 
 sub format_times {
 	my ($r, $u, $s, $firstr) = @_;
+	# no value means we did not finish the test
 	if (!defined $r) {
 		return "<missing>";
 	}
+	# a single value means we have a size, not times
+	if (!defined $u) {
+		return format_size($r, $firstr);
+	}
+	# otherwise, we have real/user/system times
 	my $out = sprintf "%.2f(%.2f+%.2f)", $r, $u, $s;
 	$out .= ' ' . relative_change($r, $firstr) if defined $firstr;
 	return $out;
 }
 
+sub human_size {
+	my $n = shift;
+	my @units = ('', qw(K M G));
+	while ($n > 900 && @units > 1) {
+		$n /= 1000;
+		shift @units;
+	}
+	return $n unless length $units[0];
+	return sprintf '%.1f%s', $n, $units[0];
+}
+
+sub format_size {
+	my ($size, $first) = @_;
+	# match the width of a time: 0.00(0.00+0.00)
+	my $out = sprintf '%15s', human_size($size);
+	$out .= ' ' . relative_change($size, $first) if defined $first;
+	return $out;
+}
+
 my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests);
 while (scalar @ARGV) {
 	my $arg = $ARGV[0];
@@ -139,7 +170,14 @@ sub have_slash {
 	my $firstr;
 	for my $i (0..$#dirs) {
 		my $d = $dirs[$i];
-		$times{$prefixes{$d}.$t} = [get_times("test-results/$prefixes{$d}$t.times")];
+		my $base = "test-results/$prefixes{$d}$t";
+		$times{$prefixes{$d}.$t} = [];
+		foreach my $type (qw(times size)) {
+			if (-e "$base.$type") {
+				$times{$prefixes{$d}.$t} = [get_times("$base.$type")];
+				last;
+			}
+		}
 		my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
 		my $w = length format_times($r,$u,$s,$firstr);
 		$colwidth[$i] = $w if $w > $colwidth[$i];
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 20f306a..fb8e017 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -202,6 +202,19 @@ test_perf () {
 	test_wrapper_ test_perf_ "$@"
 }
 
+test_size_ () {
+	say >&3 "running: $2"
+	if test_eval_ "$2" 3>"$base".size; then
+		test_ok_ "$1"
+	else
+		test_failure_ "$@"
+	fi
+}
+
+test_size () {
+	test_wrapper_ test_size_ "$@"
+}
+
 # We extend test_done to print timings at the end (./run disables this
 # and does it after running everything)
 test_at_end_hook_ () {
-- 
1.9.1.601.g7ec968e
