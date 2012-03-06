From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/2] perf: compare diff algorithms
Date: Tue, 6 Mar 2012 14:15:01 +0100
Message-ID: <f113867bcf2fec3210cd1a997e1398903b3bdd76.1331039505.git.trast@student.ethz.ch>
References: <87pqcp6fyh.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Michal Privoznik <mprivozn@redhat.com>,
	Jeff King <peff@peff.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 14:15:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4uEU-0007Wl-RL
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 14:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758453Ab2CFNPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 08:15:08 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:27277 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264Ab2CFNPG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 08:15:06 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 14:15:03 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 14:15:03 +0100
X-Mailer: git-send-email 1.7.9.2.467.g7fee4
In-Reply-To: <87pqcp6fyh.fsf@thomas.inf.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192343>

8c912ee (teach --histogram to diff, 2011-07-12) claimed histogram diff
was faster than both Myers and patience.

We have since incorporated a performance testing framework, so add a
test that compares the various diff tasks performed in a real 'log -p'
workload.  This does indeed show that histogram diff slightly beats
Myers, while patience is much slower than the others.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

The 3000 is pretty arbitrary but makes for a nice test duration.

I'm reluctant to put numbers into the message, since the whole point
of the perf test framework is that you can easily get them too.  But
here's what I'm seeing:

  4000.1: log -3000 (baseline)          0.04(0.02+0.01)                                                     
  4000.2: log --raw -3000 (tree-only)   0.49(0.38+0.09)                                                     
  4000.3: log -p -3000 (Myers)          1.93(1.75+0.17)
  4000.4: log -p -3000 --histogram      1.90(1.74+0.15)
  4000.5: log -p -3000 --patience       2.25(2.07+0.16)

 t/perf/p4000-diff-algorithms.sh |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100755 t/perf/p4000-diff-algorithms.sh

diff --git a/t/perf/p4000-diff-algorithms.sh b/t/perf/p4000-diff-algorithms.sh
new file mode 100755
index 0000000..d6e505c
--- /dev/null
+++ b/t/perf/p4000-diff-algorithms.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description="Tests diff generation performance"
+
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_perf 'log -3000 (baseline)' '
+	git log -1000 >/dev/null
+'
+
+test_perf 'log --raw -3000 (tree-only)' '
+	git log --raw -3000 >/dev/null
+'
+
+test_perf 'log -p -3000 (Myers)' '
+	git log -p -3000 >/dev/null
+'
+
+test_perf 'log -p -3000 --histogram' '
+	git log -p -3000 --histogram >/dev/null
+'
+
+test_perf 'log -p -3000 --patience' '
+	git log -p -3000 --patience >/dev/null
+'
+
+test_done
-- 
1.7.9.2.467.g7fee4
