Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D67C91F954
	for <e@80x24.org>; Fri, 17 Aug 2018 20:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbeHRABd (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 20:01:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:59280 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728368AbeHRABd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 20:01:33 -0400
Received: (qmail 8843 invoked by uid 109); 17 Aug 2018 20:56:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Aug 2018 20:56:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28510 invoked by uid 111); 17 Aug 2018 20:56:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 17 Aug 2018 16:56:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Aug 2018 16:56:37 -0400
Date:   Fri, 17 Aug 2018 16:56:37 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/6] t/perf: add infrastructure for measuring sizes
Message-ID: <20180817205637.GC20088@sigill.intra.peff.net>
References: <20180817205427.GA19580@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180817205427.GA19580@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The main objective of scripts in the perf framework is to
run "test_perf", which measures the time it takes to run
some operation. However, it can also be interesting to see
the change in the output size of certain operations.

This patch introduces test_size, which records a single
numeric output from the test and shows it in the aggregated
output (with pretty printing and relative size comparison).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/README         | 25 ++++++++++++++++++++++
 t/perf/aggregate.perl | 48 ++++++++++++++++++++++++++++++++++++++-----
 t/perf/perf-lib.sh    | 13 ++++++++++++
 3 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/t/perf/README b/t/perf/README
index 21321a0f36..be12090c38 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -168,3 +168,28 @@ that
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
+
+The item being measured (and its units) is up to the test; the context
+and the test title should make it clear to the user whether bigger or
+smaller numbers are better. Unlike test_perf, the test code will only be
+run once, since output sizes tend to be more deterministic than timings.
diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 3181b087ab..494907a892 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -13,10 +13,16 @@ sub get_times {
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
@@ -32,9 +38,15 @@ sub relative_change {
 
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
@@ -54,6 +66,25 @@ sub usage {
 	exit(1);
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
 my (@dirs, %dirnames, %dirabbrevs, %prefixes, @tests,
     $codespeed, $sortby, $subsection, $reponame);
 
@@ -184,7 +215,14 @@ sub print_default_results {
 		my $firstr;
 		for my $i (0..$#dirs) {
 			my $d = $dirs[$i];
-			$times{$prefixes{$d}.$t} = [get_times("$resultsdir/$prefixes{$d}$t.times")];
+			my $base = "$resultsdir/$prefixes{$d}$t";
+			$times{$prefixes{$d}.$t} = [];
+			foreach my $type (qw(times size)) {
+				if (-e "$base.$type") {
+					$times{$prefixes{$d}.$t} = [get_times("$base.$type")];
+					last;
+				}
+			}
 			my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
 			my $w = length format_times($r,$u,$s,$firstr);
 			$colwidth[$i] = $w if $w > $colwidth[$i];
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index a54be09516..11d1922cf5 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -231,6 +231,19 @@ test_perf () {
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
2.18.0.1205.g3878b1e64a

