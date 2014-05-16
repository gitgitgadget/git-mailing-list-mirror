From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 17/31] "guilt graph" no longer loops when no patches are applied.
Date: Fri, 16 May 2014 16:46:04 +0200
Message-ID: <1400251578-17221-18-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:54:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJWq-0006Qu-2z
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbaEPOy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:54:28 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:37417 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112AbaEPOy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:54:27 -0400
Received: by mail-lb0-f170.google.com with SMTP id w7so2034576lbi.29
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BlfyXD9WIVKHA3C+23eox7Uj/akusMsY2tjE0CP0tuw=;
        b=GKNsU6HuHzP6WAeHuQQng2kW3FA1/+z4RZo/wDbzH7dTP/UzNKEkAzNp+ecq36BndO
         6xB5yUsGa5joSz2uZ3cTjBKromPl/fsz4RPgENnKW/9SOAWsEeHPn176a1/4VZr3OdA+
         mDXtcwEK2WHXmNJSRvc6nv7U36q5lXestisUWto6oaBuBLTKJLT965ReGdOv6+Ne9qA1
         9dmxEisCFEuBypIocMapse419susI9bThFHhSuQVbMTtyPDTryRmYegKv971CDn2CMPK
         /U2czv9ZsKqrbbvfADB3MaYv1QEauAM/IgKX2AfaTvDxE7GRx/8BGDs+INaqKjYFV/92
         t3hQ==
X-Gm-Message-State: ALoCoQnRPma0BCZm7EwQCghlHcWJANz/LO0G6nsVcADVyPgme/oajL7DyhgdANLlSENM7V2p5Q9T
X-Received: by 10.112.77.166 with SMTP id t6mr2196243lbw.53.1400252066251;
        Fri, 16 May 2014 07:54:26 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.54.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:54:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249326>

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
