From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 03/11] Introduce a performance test for git-blame
Date: Mon, 12 Mar 2012 16:09:59 +0100
Message-ID: <64fe6409a201285227862feffb2d51e4d8efc3eb.1331561353.git.trast@student.ethz.ch>
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
	id 1S76uA-0002Kk-Tz
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 16:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899Ab2CLPLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 11:11:14 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:39345 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755796Ab2CLPKL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 11:10:11 -0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192882>

It blames a pseudo-randomly chosen (but fixed as long as the tested
repository remains the same) set of 10 files with various options.
The choice of 10 is arbitrary, but gives a nice runtime with git.git.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/perf/p8002-blame.sh |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100755 t/perf/p8002-blame.sh

diff --git a/t/perf/p8002-blame.sh b/t/perf/p8002-blame.sh
new file mode 100755
index 0000000..000b9d2
--- /dev/null
+++ b/t/perf/p8002-blame.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description="Tests blame performance"
+
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+# Pick 10 files to blame pseudo-randomly.  The sort key is the blob
+# hash, so it is stable.
+test_expect_success 'setup' '
+	git ls-tree HEAD | grep ^100644 |
+	sort -k 3 | head | cut -f 2 >filelist
+'
+
+test_perf 'blame' '
+	while read -r name; do
+		git blame HEAD -- "$name" >/dev/null
+	done <filelist
+'
+
+test_perf 'blame -M' '
+	while read -r name; do
+		git blame -M HEAD -- "$name" >/dev/null
+	done <filelist
+'
+
+test_perf 'blame -C' '
+	while read -r name; do
+		git blame -C HEAD -- "$name" >/dev/null
+	done <filelist
+'
+
+test_perf 'blame -C -C' '
+	while read -r name; do
+		git blame -C -C HEAD -- "$name" >/dev/null
+	done <filelist
+'
+
+test_perf 'blame -C -C -C' '
+	while read -r name; do
+		git blame -C -C -C HEAD -- "$name" >/dev/null
+	done <filelist
+'
+
+test_done
-- 
1.7.10.rc0.230.g16d90
