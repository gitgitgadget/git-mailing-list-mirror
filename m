From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 17/33] "guilt graph" no longer loops when no patches are applied.
Date: Sun, 18 May 2014 23:59:53 +0200
Message-ID: <1400450409-30998-18-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:08:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9FZ-0007if-1f
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbaERWIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:08:04 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:43868 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbaERWID (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:08:03 -0400
Received: by mail-lb0-f178.google.com with SMTP id w7so3393381lbi.37
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BlfyXD9WIVKHA3C+23eox7Uj/akusMsY2tjE0CP0tuw=;
        b=PHOP1QyfgjRiVjUG7sHkUQ2dS46S814gXlD2K7pLdLSuExcAIquZqXCk6/Fvs39KHL
         NsV9/8cS1+6YlyOo8ioZ1+TiuDVE2ydyfb8b2rhh4ZzCcV9tkuu4y1EONpynKaX2Ho/+
         W/3tjA6h6vRaokIvEXuK6A0KVWXy3L2x1frYfi1j6En5Is6Ixy6Obtkz+7DKvAgdfYTU
         4+l4cSDVYLpmG6p27aHNxr1GKg8ar1cSePfHoIJvJK3azQ1K9tdsKIZLs6rAfeVQkCk2
         91whip9hPWCiNl+BDo0lLJtxzLrmA+qqa7muxVB/zbR8NPvQWySyIjOOuQyXR27z+FlN
         B/XA==
X-Gm-Message-State: ALoCoQns2u16EMjZ5GJe26ByzD7UX9BCqkNDsP6idQAzn26iBiRuGSgOQ/cGM8uVl+vRSneeu8I7
X-Received: by 10.152.6.228 with SMTP id e4mr3197370laa.57.1400450881907;
        Sun, 18 May 2014 15:08:01 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.08.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:08:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249532>

Give an error message if no patches are applied.  Added a test case
that never terminates unless this fix is applied.

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
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
