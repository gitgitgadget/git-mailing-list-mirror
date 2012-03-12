From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 11/11] perf: add a bisection tool
Date: Mon, 12 Mar 2012 17:27:29 +0100
Message-ID: <4d8e9b13f6fe755ed16c3f8f180a8f4cf4ec7199.1331561353.git.trast@student.ethz.ch>
References: <cover.1331561353.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 17:27:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S785z-0006I3-SN
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 17:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286Ab2CLQ1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 12:27:37 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:45500 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081Ab2CLQ1d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 12:27:33 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 17:27:31 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 17:27:30 +0100
X-Mailer: git-send-email 1.7.10.rc0.230.g16d90
In-Reply-To: <cover.1331561353.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192892>

Using the perf suite for bisection is not hard with all the features
recently added; you can say

  git bisect start --no-checkout
  git bisect bad BAD
  git bisect good GOOD

  # repeat until done:
  ./run BISECT_HEAD ^BAD ^GOOD
  git bisect {good|bad}

This script does the bulk of the work for the user.  You can for
example say

  ./bisect_slowdown p4000.3 v1.7.0 v1.7.10-rc0

to bisect the ~5% performance hit incurred by 3e5a188 (diff.c: Ensure
"index $from..$to" line contains unambiguous SHA1s, 2010-05-30).  The
main output is quite noisy, but you can follow test-results/bisect.log
for a more concise summary of the results and decisions taken.

The heuristic applied is that if the result for BISECT_HEAD is scaled
between GOOD and BAD, then anything <0.25 must be good and >0.75 must
be bad.  Put in terms of differences towards the good and bad sides,
it decides in favor of the smaller one if they are at least a factor
of 3 apart.

Anything in the middle punts and asks for help.  You may then for
example re-run with more iterations to improve the measurements, or
manually edit the test script to make it more expensive (but remember
that you also need to re-test BAD and GOOD in this case!).  Once you
have told git-bisect your decision, you can restart the script to let
it continue the search.

Points of note:

* Performance regressions are not a binary event, so the search may
  not find anything reasonable.  For example, there is a ~6% hit in
  p3400.4 between adc3b2b27..a9f578685, but because it is spread
  across 13 commits, a bisection can only determine the general area.

* The default settings do not have high enough S/N in the timings to
  give good results.  Try setting GIT_PERF_REPEAT_COUNT to around 8.

* Many CPUs have a dynamic overclocking feature (such as Intel Turbo
  Boost) that helps single-process performance.  Running other things
  in parallel may prevent it from working.  The difference may be
  larger than 20% and will usually drown out the performance hit you
  are bisecting for.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/perf/bisect_slowdown |   88 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100755 t/perf/bisect_slowdown

diff --git a/t/perf/bisect_slowdown b/t/perf/bisect_slowdown
new file mode 100755
index 0000000..8b58b8d
--- /dev/null
+++ b/t/perf/bisect_slowdown
@@ -0,0 +1,88 @@
+#!/bin/sh
+
+test=$1
+good=$2
+bad=$3
+
+subtest=${test#p????.}
+maintest=${test%%.*}
+
+export subtest maintest
+
+export GIT_PERF_TEST_ONLY=$test
+
+goodrev=$(git rev-parse "$good^{commit}")
+badrev=$(git rev-parse "$bad^{commit}")
+
+git_dir=$(git rev-parse --git-dir)
+perfdir=$(cd "$(dirname "$0")" && pwd)
+log="$perfdir/test-results/bisect.log"
+
+export good bad goodrev badrev perfdir log
+
+if ! test -s "$git_dir/BISECT_LOG"; then
+	# Establish initial timings for the endpoints
+	echo "## Before bisection: comparing $good (good) and $bad (bad)" >"$log"
+	GIT_PERF_AGGREGATING_LATER=t ./run "$good" "$bad" -- "$maintest"*.sh
+	./aggregate.perl "$good" "$bad" -- "$maintest"*.sh | tee -a "$log"
+
+	cd "$perfdir/../.."
+
+	echo "## Starting bisection between $good (good) and $bad (bad)" >>"$log"
+	git bisect start --no-checkout
+	git bisect good "$good"
+	git bisect bad "$bad"
+else
+	cd "$perfdir/../.."
+fi
+
+git bisect run sh -c '
+	cd "$perfdir"
+	echo "## Testing $(git log --no-walk --format="%h %s" BISECT_HEAD)" >>"$log"
+	GIT_PERF_AGGREGATING_LATER=t ./run BISECT_HEAD -- "$maintest"*.sh
+	./aggregate.perl BISECT_HEAD "$good" "$bad" -- "$maintest"*.sh | tee -a "$log"
+	tested=$(git rev-parse BISECT_HEAD)
+	perl -e '\''
+		open STDOUT, "|-", "tee", "-a", "'"$log"'" or die "failed to spawn tee: $!";
+		sub avg {
+			open my $fp, "<$_" or die "cannot open $_: $!";
+			my $s = 0;
+			my $n = 0;
+			while (<$fp>) {
+				if (/^(\d+\.\d+)/) {
+					$s += $1;
+					$n++;
+				}
+			}
+			close $fp or die "cannot close: $!";
+			return $s/$n;
+		}
+		my ($good,$bad,$test) = map { avg $_ } @ARGV;
+		if ($good == $bad) { die "good = bad?" };
+		my $ratio = ($test-$good)/($bad-$good);
+		if ($ratio < 0.25) {
+			print "# Result: GOOD!\n";
+			exit 0;
+		} elsif ($ratio > 0.75) {
+			print "# Result: BAD!\n";
+			exit 42;
+		} else {
+			print "# INCONCLUSIVE.\n";
+			print "# Please check manually, say git bisect good/bad, and restart me!\n";
+			exit 1;
+		}
+	'\'' \
+		test-results/build_"$goodrev"."$maintest"*."$subtest".times \
+		test-results/build_"$badrev"."$maintest"*."$subtest".times \
+		test-results/build_"$tested"."$maintest"*."$subtest".times
+	ret=$?
+	test $ret = 0 && exit 0
+	test $ret = 42 && exit 1
+	exit 255
+' || exit $?
+
+cd "$perfdir"
+echo "## Double-checking $(git log --no-walk --format="%h %s" bisect/bad)" >>"$log"
+GIT_PERF_AGGREGATING_LATER=t ./run bisect/bad^ bisect/bad -- "$maintest"*.sh
+git show bisect/bad
+./aggregate.perl bisect/bad^ bisect/bad -- "$maintest"*.sh | tee -a "$log"
-- 
1.7.10.rc0.230.g16d90
