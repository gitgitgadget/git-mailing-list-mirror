From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 07/11] perf: convert realtime to seconds when collecting runs
Date: Mon, 12 Mar 2012 16:10:03 +0100
Message-ID: <f9c799d3e926c1ec650ee7d414ba4d1040082f36.1331561353.git.trast@student.ethz.ch>
References: <cover.1331561353.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 16:11:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S76u5-0002Kk-OJ
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 16:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860Ab2CLPKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 11:10:32 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:39345 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755827Ab2CLPKO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 11:10:14 -0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192880>

Our use of 'time' gives results along the lines of

  0:01.04 0.67 0.02

That is, the realtime field is formatted as a H:M:S.CC time with the
hour field optional.  Use a little perl magic to convert it to
seconds, too.  This makes it easier to parse further downstream.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/perf/aggregate.perl |    9 ++++-----
 t/perf/perf-lib.sh    |    3 ++-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 4586840..b04d3a0 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -15,12 +15,11 @@ sub get_times {
 	my $sum_s = 0.0;
 	my $n = 0;
 	while (<$fh>) {
-		/^(?:(\d+):)?(\d+):(\d+(?:\.\d+)?) (\d+(?:\.\d+)?) (\d+(?:\.\d+)?)$/
+		/^(\d+(?:\.\d+)?) (\d+(?:\.\d+)?) (\d+(?:\.\d+)?)$/
 			or die "bad input line: $_";
-		my $rt = ((defined $1 ? $1 : 0.0)*60+$2)*60+$3;
-		$sum_rt += $rt;
-		$sum_u += $4;
-		$sum_s += $5;
+		$sum_rt += $1;
+		$sum_u += $2;
+		$sum_s += $3;
 		$n++;
 	}
 	return undef if !$n;
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index a13f105..bfc2926 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -185,7 +185,8 @@ test_perf () {
 		fi
 		base="$perf_results_dir"/"$perf_results_prefix$(basename "$0" .sh)"."$test_count"
 		rm test_time.0
-		cat test_time.* >"$base".times
+		perl -pe 's/(?:(\d+):)?(\d+):(\d+(?:\.\d+)?)/((defined $1?$1:0)*60+$2)*60+$3/e' \
+			test_time.* >"$base".times
 	fi
 	echo >&3 ""
 }
-- 
1.7.10.rc0.230.g16d90
