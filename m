From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 17/29] "guilt graph" no longer loops when no patches are applied.
Date: Tue, 13 May 2014 22:30:53 +0200
Message-ID: <1400013065-27919-18-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:36:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJRO-0006Rd-UV
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167AbaEMUgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:36:44 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:65470 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911AbaEMUgm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:36:42 -0400
Received: by mail-la0-f51.google.com with SMTP id gf5so709461lab.38
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zo/FWoxcoL8dO0qx/mDIILDxcmAgHv8ZTYMHzmNVb5c=;
        b=d1DQnhqUgzCSpSoses1pn/iHWLK49EhR3HPHD2KAs95mcljh9e1J3OUeKe4wneZaJ+
         sFcHztdacs31l8cJqWOX+/Hq9HTevYuigHwPOgAjfDg9Sn92pT80T/WRT87xh9M/9VXd
         ZHjL/znC3eH93Oy8fY/kwBsUnfgjf9CoKFxGaE+BhQJ3UgLMuTJvDucLKPWyKx4S77CN
         BkNDMWdoPgTjamdKMDNejQkfzVqa90MEuuXxKvi1xuTQbQuvJXKjxB9aw+O4jpqmQub6
         ZEs/RIFvZiiWiEqQdtYnnRh959PccGjRK03vi09h01ZjH+ywMg51JrsEMznzitQHNUnr
         QrMw==
X-Gm-Message-State: ALoCoQnLQ5LH7ODFzPQD02DcKxK9OPAMt0tyFtbzly4V+LacMJrjrOQ+0v0IFaBCcy3FMvtKMZsG
X-Received: by 10.152.2.2 with SMTP id 2mr19429302laq.26.1400013401506;
        Tue, 13 May 2014 13:36:41 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.36.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:36:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248834>

Give an error message if no patches are applied.  Added a test case
that never terminates unless this fix is applied.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt-graph          |  9 +++++++--
 regression/t-033.out |  3 +++
 regression/t-033.sh  | 13 +++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 regression/t-033.out
 create mode 100755 regression/t-033.sh

diff --git a/guilt-graph b/guilt-graph
index b3469dc..56d0e77 100755
--- a/guilt-graph
+++ b/guilt-graph
@@ -17,8 +17,13 @@ fi
 
 patchname="$1"
 
-bottom=`git rev-parse refs/patches/$branch/$(head_n 1 < "$applied")`
-base=`git rev-parse $bottom^`
+bottompatch=$(head_n 1 < "$applied")
+if [ -z "$bottompatch" ]; then
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
index 0000000..a3a8981
--- /dev/null
+++ b/regression/t-033.sh
@@ -0,0 +1,13 @@
+#!/bin/bash
+#
+# Test the graph code
+#
+
+source "$REG_DIR/scaffold"
+
+cmd setup_repo
+
+# Check that "guilt graph" gives a proper "No patch applied" error
+# message when no patches are applied.  (An older version of guilt
+# used to enter an endless loop in this situation.)
+shouldfail guilt graph
-- 
1.8.3.1
