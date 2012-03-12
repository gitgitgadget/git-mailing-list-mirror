From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 04/11] perf: display average instead of minimum time
Date: Mon, 12 Mar 2012 16:10:00 +0100
Message-ID: <ac09e8e93b110382409a8cd9d6c29189056da100.1331561353.git.trast@student.ethz.ch>
References: <cover.1331561353.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 16:11:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S76u6-0002Kk-9H
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 16:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876Ab2CLPKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 11:10:33 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:39345 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755818Ab2CLPKM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 11:10:12 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 16:10:07 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 16:10:07 +0100
X-Mailer: git-send-email 1.7.10.rc0.230.g16d90
In-Reply-To: <cover.1331561353.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192879>

The perf tests initially only saved the minimum measurement (chosen
according to wall time).  This is common for timings, as it tends to
measure the shortest time in which the machine can run the test.  It
is also a bit more forgiving for the user if he ran some other task
during one of the tests.

However, experiments with p3400-rebase.sh showed that for
longer-running tasks with a lot of kernel involvement (such as a shell
script and its constant forking) the variance is so high that the
minimum becomes extremely unstable.  The best-of-10 (!) timings
fluctuated by around 5% in extreme cases.

Switch to the average, as that tends to cancel out the variance for
sufficiently large numbers of $GIT_PERF_REPEAT_COUNT.  The catch is
that now we can no longer write off the initial (possibly) cache-cold
timing.  So the test is now run 1+n times, and the first run is
discarded.

Since we're already rewriting that paragraph, also correctly state the
default value of GIT_PERF_REPEAT_COUNT, which is 3.

The shift of the averaging logic to aggregate.perl is not, strictly
speaking, necessary.  However, min_time.perl would have had to be
renamed anyway.  It also sets the stage for the next patch.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/perf/README         |    8 +++++---
 t/perf/aggregate.perl |   25 +++++++++++++++++--------
 t/perf/min_time.perl  |   21 ---------------------
 t/perf/perf-lib.sh    |    5 +++--
 4 files changed, 25 insertions(+), 34 deletions(-)
 delete mode 100755 t/perf/min_time.perl

diff --git a/t/perf/README b/t/perf/README
index b2dbad4..fa94eb5 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -54,9 +54,11 @@ anything beforehand.
 
 You can set the following variables (also in your config.mak):
 
-    GIT_PERF_REPEAT_COUNT
-	Number of times a test should be repeated for best-of-N
-	measurements.  Defaults to 5.
+    GIT_PERF_REPEAT_COUNT='n'
+	Number of times a test should be repeated.  The test is run
+	'n+1' times: once to warm up the caches and 'n' more times to
+	gather the measurements.  The first run is discarded, and the
+	other 'n' runs are averaged.  Defaults to 3.
 
     GIT_PERF_MAKE_OPTS
 	Options to use when automatically building a git tree for
diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index c0afa0b..9c781fa 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -10,13 +10,22 @@
 sub get_times {
 	my $name = shift;
 	open my $fh, "<", $name or return undef;
-	my $line = <$fh>;
-	return undef if not defined $line;
+	my $sum_rt = 0.0;
+	my $sum_u = 0.0;
+	my $sum_s = 0.0;
+	my $n = 0;
+	while (<$fh>) {
+		/^(?:(\d+):)?(\d+):(\d+(?:\.\d+)?) (\d+(?:\.\d+)?) (\d+(?:\.\d+)?)$/
+			or die "bad input line: $_";
+		my $rt = ((defined $1 ? $1 : 0.0)*60+$2)*60+$3;
+		$sum_rt += $rt;
+		$sum_u += $4;
+		$sum_s += $5;
+		$n++;
+	}
+	return undef if !$n;
 	close $fh or die "cannot close $name: $!";
-	$line =~ /^(?:(\d+):)?(\d+):(\d+(?:\.\d+)?) (\d+(?:\.\d+)?) (\d+(?:\.\d+)?)$/
-		or die "bad input line: $line";
-	my $rt = ((defined $1 ? $1 : 0.0)*60+$2)*60+$3;
-	return ($rt, $4, $5);
+	return ($sum_rt/$n, $sum_u/$n, $sum_s/$n);
 }
 
 sub format_times {
@@ -140,8 +149,8 @@ sub have_slash {
 	for my $i (0..$#dirs) {
 		my $d = $dirs[$i];
 		$times{$prefixes{$d}.$t} = [get_times("test-results/$prefixes{$d}$t.times")];
-		my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
-		my $w = length format_times($r,$u,$s,$firstr);
+		my ($r,$u,$s,$sign) = @{$times{$prefixes{$d}.$t}};
+		my $w = length format_times($r,$u,$s,$sign,$firstr);
 		$colwidth[$i] = $w if $w > $colwidth[$i];
 		$firstr = $r unless defined $firstr;
 	}
diff --git a/t/perf/min_time.perl b/t/perf/min_time.perl
deleted file mode 100755
index c1a2717..0000000
--- a/t/perf/min_time.perl
+++ /dev/null
@@ -1,21 +0,0 @@
-#!/usr/bin/perl
-
-my $minrt = 1e100;
-my $min;
-
-while (<>) {
-	# [h:]m:s.xx U.xx S.xx
-	/^(?:(\d+):)?(\d+):(\d+(?:\.\d+)?) (\d+(?:\.\d+)?) (\d+(?:\.\d+)?)$/
-		or die "bad input line: $_";
-	my $rt = ((defined $1 ? $1 : 0.0)*60+$2)*60+$3;
-	if ($rt < $minrt) {
-		$min = $_;
-		$minrt = $rt;
-	}
-}
-
-if (!defined $min) {
-	die "no input found";
-}
-
-print $min;
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 5580c22..a13f105 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -163,7 +163,7 @@ test_perf () {
 		else
 			echo "perf $test_count - $1:"
 		fi
-		for i in $(seq 1 $GIT_PERF_REPEAT_COUNT); do
+		for i in $(seq 0 $GIT_PERF_REPEAT_COUNT); do
 			say >&3 "running: $2"
 			if test_run_perf_ "$2"
 			then
@@ -184,7 +184,8 @@ test_perf () {
 			test_ok_ "$1"
 		fi
 		base="$perf_results_dir"/"$perf_results_prefix$(basename "$0" .sh)"."$test_count"
-		"$TEST_DIRECTORY"/perf/min_time.perl test_time.* >"$base".times
+		rm test_time.0
+		cat test_time.* >"$base".times
 	fi
 	echo >&3 ""
 }
-- 
1.7.10.rc0.230.g16d90
