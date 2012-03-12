From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 09/11] perf/run: allow skipping some revisions
Date: Mon, 12 Mar 2012 16:10:05 +0100
Message-ID: <20160e2ec785353a5e1203a7c769b0bc5881b83d.1331561353.git.trast@student.ethz.ch>
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
	id 1S76tH-0001iv-EW
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 16:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854Ab2CLPKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 11:10:20 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:39345 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755739Ab2CLPKR (ORCPT <rfc822;git@vger.kernel.org>);
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192874>

You may want to compare two revisions/dirs A and B, but have already
tested one of them, say A.  './run A B' would re-run the tests for
both, which is very time-consuming.  You could invoke

  ./run B && ./aggregate.perl A B

but that is tedious.

Make it so that a ^ prefix means "aggregate this revision, but do not
test it"; i.e., you can say

  ./run ^A B

to achieve what you want.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/perf/aggregate.perl |    1 +
 t/perf/run            |    5 +++++
 2 files changed, 6 insertions(+)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 4db685d..747f885 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -65,6 +65,7 @@ sub format_times {
 	my $arg = $ARGV[0];
 	my $dir;
 	last if -f $arg or $arg eq "--";
+	$arg =~ s/^\^// if (! -d $arg);
 	if (! -d $arg) {
 		my $rev = Git::command_oneline(qw(rev-parse --verify), $arg."^{commit}");
 		$dir = "build/".$rev;
diff --git a/t/perf/run b/t/perf/run
index e4f9c22..bc66067 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -37,6 +37,11 @@ build_git_rev () {
 
 run_dirs_helper () {
 	mydir=${1%/}
+	case "$mydir" in
+		^*)
+			return
+			;;
+	esac
 	shift
 	while test $# -gt 0 -a "$1" != -- -a ! -f "$1"; do
 		shift
-- 
1.7.10.rc0.230.g16d90
