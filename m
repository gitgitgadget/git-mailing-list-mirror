From: Anton Trunov <anton.a.trunov@gmail.com>
Subject: [PATCH] xmerge.c: fix xdl_merge to conform with the manual
Date: Tue,  3 Mar 2015 20:37:00 +0300
Message-ID: <1425404233-89907-1-git-send-email-anton.a.trunov@gmail.com>
Cc: jrnieder@gmail.com, charles@hashpling.org,
	Johannes.Schindelin@gmx.de, Anton Trunov <anton.a.trunov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 18:38:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSqlp-0007kZ-9q
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 18:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070AbbCCRiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 12:38:08 -0500
Received: from mail-la0-f66.google.com ([209.85.215.66]:35827 "EHLO
	mail-la0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbbCCRiH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 12:38:07 -0500
Received: by lamq1 with SMTP id q1so499716lam.2
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 09:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=m6pWexz3ISTHkEOq0/JW7uhwzuANcnJA18M0djC69qA=;
        b=HHoYGMzdap5lMCtzErjwkCJOM8h7jdrGlDUI+O+vmK1pEPTCMO6t409eE8cDsjdlTW
         Yvwnz9Rwuehla5YlhlMMs1kPbz/pqmI4KKIn93ZrNJyGmY5AvjgaMi6Yhb5k/wwGAe2Y
         uG+lZauJkxi+9P0B9c+AMWX2M2bpY6UhseA9qqfO5ngjNoO0OpCG7nM+ynXvefeGrMlf
         vbvWtsuFMxFLCIaC+1zOsDMO2xhU1wsBCxARhm2hHS3uSMOeUgGMpVg4ycGl5w8NGvZX
         RvkpvfHWjoOBACZoIEwdg4P4i9JOc/4dFsA4alGK4lKbm5LC1IBwl9eK6CpoArs05DFE
         po4Q==
X-Received: by 10.152.206.7 with SMTP id lk7mr24358427lac.55.1425404285126;
        Tue, 03 Mar 2015 09:38:05 -0800 (PST)
Received: from localhost.localdomain ([195.191.146.16])
        by mx.google.com with ESMTPSA id s7sm287810las.30.2015.03.03.09.38.01
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Mar 2015 09:38:03 -0800 (PST)
X-Mailer: git-send-email 2.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264672>

The git-merge manual says that the ignore-space-change,
ignore-all-space, ignore-space-at-eol options preserve our version
if their version only introduces whitespace changes to a line.

So far if there is whitespace-only changes to both sides
in *all* lines their version will be used.

This commit fixes merge behavior in this case by checking
change for their version first.

Signed-off-by: Anton Trunov <anton.a.trunov <at> gmail.com>
---
 t/t3032-merge-recursive-options.sh | 43 ++++++++++++++++++++++++++++++++++++++
 xdiff/xmerge.c                     | 10 ++++-----
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recursive-options.sh
index 4029c9c..4cbedb4 100755
--- a/t/t3032-merge-recursive-options.sh
+++ b/t/t3032-merge-recursive-options.sh
@@ -204,4 +204,47 @@ test_expect_success '--ignore-space-at-eol' '
 	test_cmp expected actual
 '
 
+# Setup for automerging with whitespace-only changes
+# on both sides and in *all* lines
+
+test_expect_success 'setup: w/s only changes in all lines on both sides' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init
+
+	echo " two words" >text.txt &&
+	git add text.txt &&
+	test_tick &&
+	git commit -m "Initial revision" &&
+
+	git checkout -b remote &&
+	echo " \t\ttwo     words  " >text.txt &&
+	git commit -a -m "remote: insert whitespace only" &&
+
+	git checkout master &&
+	echo "    two words" >text.txt &&
+	git commit -a -m "master: insert whitespace only"
+'
+
+test_expect_success 'w/s only in all lines: --ignore-space-change preserves ours' '
+	echo "    two words" >expected &&
+	git read-tree --reset -u HEAD &&
+	git merge-recursive --ignore-space-change HEAD^ -- HEAD remote &&
+	test_cmp expected text.txt
+'
+
+test_expect_success 'w/s only in all lines: --ignore-all-space preserves ours' '
+	echo "    two words" >expected &&
+	git read-tree --reset -u HEAD &&
+	git merge-recursive --ignore-all-space HEAD^ -- HEAD remote &&
+	test_cmp expected text.txt
+'
+
+test_expect_success 'w/s only in all lines: --ignore-space-at-eol fails' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --ignore-space-at-eol HEAD^ -- HEAD remote &&
+	grep "<<<<<<" text.txt
+'
+
 test_done
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 625198e..2c7db26 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -596,14 +596,14 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
 		return -1;
 	}
 	status = 0;
-	if (!xscr1) {
-		result->ptr = xdl_malloc(mf2->size);
-		memcpy(result->ptr, mf2->ptr, mf2->size);
-		result->size = mf2->size;
-	} else if (!xscr2) {
+	if (!xscr2) {
 		result->ptr = xdl_malloc(mf1->size);
 		memcpy(result->ptr, mf1->ptr, mf1->size);
 		result->size = mf1->size;
+	} else if (!xscr1) {
+		result->ptr = xdl_malloc(mf2->size);
+		memcpy(result->ptr, mf2->ptr, mf2->size);
+		result->size = mf2->size;
 	} else {
 		status = xdl_do_merge(&xe1, xscr1,
 				      &xe2, xscr2,
-- 
2.3.1.167.g7f4ba4b
