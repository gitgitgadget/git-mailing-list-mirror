From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 08/11] perf/aggregate: optionally include a t-test score
Date: Mon, 12 Mar 2012 16:10:04 +0100
Message-ID: <8efb03c8da7e76a1fd39a3bdcfd37ea0dc9bda72.1331561353.git.trast@student.ethz.ch>
References: <cover.1331561353.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 16:10:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S76tH-0001iv-W8
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 16:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850Ab2CLPKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 11:10:18 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:39345 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755842Ab2CLPKR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 11:10:17 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 16:10:08 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192877>

Adds support for calling out to R[1] to perform a significance test on
the gathered results.

More specifically, the script's purpose was always to compare several
revisions (it still makes nice tables for single tests though ;-).
Given the first and some other column (= revision/directory), this
runs Welch's t-test[2] on the two sets of measurements to determine
whether there is a significant difference between the distributions.
It then shows the p-value in a simplified form, so that significant
differences stand out optically.

All of this is entirely optional: if R is not available, it simply
puts nothing in this field.

[1] http://www.r-project.org/
[2] http://en.wikipedia.org/wiki/Welch%27s_t-test

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/perf/aggregate.perl  |   37 +++++++++++++++++++++++++++++++------
 t/perf/t_test_score.sh |   24 ++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 6 deletions(-)
 create mode 100755 t/perf/t_test_score.sh

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index b04d3a0..4db685d 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -7,8 +7,12 @@
 	"$FindBin::Bin/../../perl/blib/arch/auto/Git";
 use Git;
 
+my $any_sign_printed = 0;
+
 sub get_times {
 	my $name = shift;
+	my $firstset = shift;
+	my $sig = "";
 	open my $fh, "<", $name or return undef;
 	my $sum_rt = 0.0;
 	my $sum_u = 0.0;
@@ -24,11 +28,21 @@ sub get_times {
 	}
 	return undef if !$n;
 	close $fh or die "cannot close $name: $!";
-	return ($sum_rt/$n, $sum_u/$n, $sum_s/$n);
+	if (defined $firstset &&
+	    open my $ph, "-|", "./t_test_score.sh $name $firstset 2>/dev/null") {
+		my $result = <$ph>;
+		close $ph or die "cannot close pipe to t_test_score.sh: $!";
+		chomp $result;
+		$sig = $result;
+		if ($sig ne "") {
+			$any_sign_printed = 1;
+		}
+	}
+	return ($sum_rt/$n, $sum_u/$n, $sum_s/$n, $sig);
 }
 
 sub format_times {
-	my ($r, $u, $s, $firstr) = @_;
+	my ($r, $u, $s, $sign, $firstr) = @_;
 	if (!defined $r) {
 		return "<missing>";
 	}
@@ -41,6 +55,7 @@ sub format_times {
 		} else {
 			$out .= " +inf";
 		}
+		$out .= $sign;
 	}
 	return $out;
 }
@@ -145,13 +160,17 @@ sub have_slash {
 }
 for my $t (@subtests) {
 	my $firstr;
+	my $firstset;
 	for my $i (0..$#dirs) {
 		my $d = $dirs[$i];
-		$times{$prefixes{$d}.$t} = [get_times("test-results/$prefixes{$d}$t.times")];
+		$times{$prefixes{$d}.$t} = [get_times("test-results/$prefixes{$d}$t.times", $firstset)];
 		my ($r,$u,$s,$sign) = @{$times{$prefixes{$d}.$t}};
 		my $w = length format_times($r,$u,$s,$sign,$firstr);
 		$colwidth[$i] = $w if $w > $colwidth[$i];
-		$firstr = $r unless defined $firstr;
+		if (!defined $firstr) {
+			$firstr = $r;
+			$firstset = "test-results/$prefixes{$d}$t.times";
+		}
 	}
 }
 my $totalwidth = 3*@dirs+$descrlen;
@@ -169,9 +188,15 @@ sub have_slash {
 	my $firstr;
 	for my $i (0..$#dirs) {
 		my $d = $dirs[$i];
-		my ($r,$u,$s) = @{$times{$prefixes{$d}.$t}};
-		printf "   %-$colwidth[$i]s", format_times($r,$u,$s,$firstr);
+		my ($r,$u,$s,$sign) = @{$times{$prefixes{$d}.$t}};
+		printf "   %-$colwidth[$i]s", format_times($r,$u,$s,$sign,$firstr);
 		$firstr = $r unless defined $firstr;
 	}
 	print "\n";
 }
+
+if ($any_sign_printed) {
+	print "-"x$totalwidth, "\n";
+	print "Significance hints:  '.' 0.1  '*' 0.05  '**' 0.01  '***' 0.001\n"
+}
+
diff --git a/t/perf/t_test_score.sh b/t/perf/t_test_score.sh
new file mode 100755
index 0000000..32353d6
--- /dev/null
+++ b/t/perf/t_test_score.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+# If the user doesn't have R, we don't care
+
+command -v R >/dev/null || exit 0
+
+# Uses R to run a t-test on the hypothesis that the elapsed time
+# values in $1 are less than the ones in $2.
+
+pvalue=$(R --no-save --slave <<-EOF
+	a <- read.table("$1")
+	b <- read.table("$2")
+	tst <- t.test(a\$V1, b\$V1)
+	p <- tst\$p.value
+	if (p<0.001) print ("***") \
+	else if (p<0.01) print ("**") \
+	else if (p<0.05) print ("*") \
+	else if (p<0.1) print (".")
+EOF
+)
+
+pvalue=${pvalue##\[1\] \"}
+pvalue=${pvalue%%\"}
+echo "$pvalue"
-- 
1.7.10.rc0.230.g16d90
