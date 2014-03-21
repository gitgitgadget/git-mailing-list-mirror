From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 17/28] "guilt graph" no longer loops when no patches are applied.
Date: Fri, 21 Mar 2014 08:31:55 +0100
Message-ID: <1395387126-13681-18-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:34:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtyT-0003nr-Bz
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbaCUHee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:34:34 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:35598 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174AbaCUHd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:26 -0400
Received: by mail-la0-f50.google.com with SMTP id y1so1358136lam.23
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wtwuNRYz+97WJ5GM+F7IWCF8/VEVa8eqcbUa0xkWswo=;
        b=WysTo7mpSN/G1m2FOPQzh3vrHe2ccTCJHoYSPjpbrVeRhc0ex3PtxgOjuoa2ec6NNB
         yFOeKm2vRjaEfSCSD+Xvf/zHEXNYBl0457jdrQ7KSXhfyvw/4YKZprqMU5NVi5ESwTjT
         yPFZDQn5chQeK1qc29HeXwlsyJo4qBKYUHgYzKPGJnlM/hNJnu4eH9VBJJJvaDKsmyve
         sSY7R4UwaeF0HH9DAE5HFKg/0H3lbTzXRBgcfaMOQUAhrZP5LC2JmNMmD3miseX8QFDI
         eHNlutZSoFr1BesnHfnWcuKORGzqna5Ax6IYrHCVsHMUb/1bSHPxwG6W3l23kyapcQkv
         TKuw==
X-Gm-Message-State: ALoCoQm2jNiKX7sAXnH/G38D76qTKgnpx6ZElBQBjD0hWUSdgFJkyKVxAm23FWtZkP+pbPqTgAIk
X-Received: by 10.112.181.232 with SMTP id dz8mr343926lbc.46.1395387205112;
        Fri, 21 Mar 2014 00:33:25 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244666>

Give an error message if no patches are applied.  Added a test case
that never terminates unless this fix is applied.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt-graph          | 10 ++++++++--
 regression/t-033.out |  3 +++
 regression/t-033.sh  | 11 +++++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)
 create mode 100644 regression/t-033.out
 create mode 100755 regression/t-033.sh

diff --git a/guilt-graph b/guilt-graph
index b3469dc..00301d5 100755
--- a/guilt-graph
+++ b/guilt-graph
@@ -17,8 +17,14 @@ fi
 
 patchname="$1"
 
-bottom=`git rev-parse refs/patches/$branch/$(head_n 1 < "$applied")`
-base=`git rev-parse $bottom^`
+bottompatch=$(head_n 1 < "$applied")
+if [ -z "$bottompatch" ]
+then
+	echo "No patch applied." >&2
+	exit 1
+fi
+
+base=`git rev-parse "refs/patches/${branch}/${bottompatch}^"`
 
 if [ -z "$patchname" ]; then
 	top=`git rev-parse HEAD`
diff --git a/regression/t-033.out b/regression/t-033.out
new file mode 100644
index 0000000..76613f9
--- /dev/null
+++ b/regression/t-033.out
@@ -0,0 +1,3 @@
+% setup_repo
+% guilt graph
+No patch applied.
diff --git a/regression/t-033.sh b/regression/t-033.sh
new file mode 100755
index 0000000..ae40577
--- /dev/null
+++ b/regression/t-033.sh
@@ -0,0 +1,11 @@
+#!/bin/bash
+#
+# Test the graph code
+#
+
+source "$REG_DIR/scaffold"
+
+cmd setup_repo
+
+shouldfail guilt graph
+
-- 
1.8.3.1
