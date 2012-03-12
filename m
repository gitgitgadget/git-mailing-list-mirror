From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 02/11] Introduce a performance test for git-rebase
Date: Mon, 12 Mar 2012 16:09:58 +0100
Message-ID: <e6a6af53264368a25e71719901f3227042e21f5c.1331561353.git.trast@student.ethz.ch>
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
	id 1S76u5-0002Kk-8D
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 16:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755808Ab2CLPKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 11:10:11 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:39345 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755781Ab2CLPKK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 11:10:10 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 16:10:07 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 16:10:06 +0100
X-Mailer: git-send-email 1.7.10.rc0.230.g16d90
In-Reply-To: <cover.1331561353.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192878>

The perf framework lets the user run the test in an arbitrary repo,
which makes writing a test for rebase a bit finicky.  This one uses a
perl script to determine a longest linear segment of history, that is,
a range A..B which is completely linear.  (For a full clone of
git.git, this is the (whole) 'html' branch.)  The number of commits
that are rebased is capped at 50, however.  That is, if A..B is more
than 50 commits, it uses B~50..B instead.

Having determined a suitable range, it then runs rebase with all
combinations of rerere (on/off), -i / noninteractive, and -m / normal.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/perf/p3400-rebase.sh |   91 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100755 t/perf/p3400-rebase.sh

diff --git a/t/perf/p3400-rebase.sh b/t/perf/p3400-rebase.sh
new file mode 100755
index 0000000..7155574
--- /dev/null
+++ b/t/perf/p3400-rebase.sh
@@ -0,0 +1,91 @@
+#!/bin/sh
+
+test_description="Tests git-rebase performance"
+
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_expect_success 'find a long run of linear history' '
+	git rev-list --topo-order --parents --all |
+	perl -e '\''$maxL = 0; $maxcommit = undef;
+		while (<>) {
+			chomp;
+			@parents = split;
+			$commit = shift @parents;
+			if ($L{$commit} > $maxL) {
+				$maxL = $L{$commit};
+				$maxcommit = $commit;
+			}
+			if (1 == scalar @parents
+				&& $L{$commit} >= $L{$parents[0]}) {
+				$L{$parents[0]} = $L{$commit}+1;
+				$C{$parents[0]} = $commit;
+			}
+		}
+		$cur = $maxcommit;
+		while (defined $C{$cur}) {
+			$cur = $C{$cur};
+		}
+		if ($maxL > 50) {
+			$maxL = 50;
+		}
+		print "$cur~$maxL\n$cur\n";
+	'\'' >rebase-args &&
+	base_rev=$(sed -n 1p rebase-args) &&
+	tip_rev=$(sed -n 2p rebase-args) &&
+	git checkout -f -b work $tip_rev
+'
+
+export base_rev tip_rev
+
+test_expect_success 'verify linearity' '
+	git rev-list --parents $base_rev.. >list &&
+	! grep "[0-9a-f]+ [0-9a-f]+ [0-9a-f+].*" list
+'
+
+test_expect_success 'disable rerere' '
+	git config rerere.enabled false
+'
+
+test_perf 'rebase -f (rerere off)' '
+	git rebase -f $base_rev
+'
+
+test_perf 'rebase -m -f (rerere off)' '
+	git rebase -m -f $base_rev
+'
+
+test_perf 'rebase -i -f (rerere off)' '
+	GIT_EDITOR=: git rebase -i -f $base_rev
+'
+
+test_perf 'rebase -i -m -f (rerere off)' '
+	GIT_EDITOR=: git rebase -i -m -f $base_rev
+'
+
+test_expect_success 'enable rerere and prime it' '
+	git config rerere.enabled true &&
+	git rebase -f $base_rev &&
+	git rebase -m -f $base_rev &&
+	GIT_EDITOR=: git rebase -i -f $base_rev &&
+	GIT_EDITOR=: git rebase -i -m -f $base_rev
+'
+
+test_perf 'rebase -f (rerere ON)' '
+	git rebase -f $base_rev
+'
+
+test_perf 'rebase -m -f (rerere ON)' '
+	git rebase -m -f $base_rev
+'
+
+test_perf 'rebase -i -f (rerere ON)' '
+	GIT_EDITOR=: git rebase -i -f $base_rev
+'
+
+test_perf 'rebase -i -m -f (rerere ON)' '
+	GIT_EDITOR=: git rebase -i -m -f $base_rev
+'
+
+test_done
-- 
1.7.10.rc0.230.g16d90
