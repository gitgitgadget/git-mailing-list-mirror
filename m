From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] remote-bzr: fix for disappeared revisions
Date: Tue,  7 May 2013 18:39:35 -0500
Message-ID: <1367969975-4163-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 08 01:41:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZrVK-0005sI-G0
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 01:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715Ab3EGXlC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 19:41:02 -0400
Received: from mail-ye0-f171.google.com ([209.85.213.171]:57037 "EHLO
	mail-ye0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab3EGXlA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 19:41:00 -0400
Received: by mail-ye0-f171.google.com with SMTP id l12so268757yen.30
        for <git@vger.kernel.org>; Tue, 07 May 2013 16:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=59omehHWmxgY4uKhG2sL80Vhy59L3WQzE+oNSifRQBs=;
        b=MCu+3TboDMORMvYXTPRg3PGMxyJM3WfTcvLGTUO1aVS2pec6TC/0B/viMMxCyQm5Vn
         MpwXkdMZRfW8baSwdLJ7kg02XkyLpb0lRMPKNtvNgxADchNYtOwvsxMW52ugxAe7rMw1
         dDEvMl3Hp30ngYmMrAAGlVU2C1I8x7a+SUf1Etvct2I9OJJg2aSqUH8joe9QRgy3AKlf
         YEi+Juyk3fAR3ElWGqbdAu940+BquAS54Zb57sX6yF1jK9jep/AVmQEMTxDYHAp8my+3
         gO4RMtAGWcdkhljo3+Hi52bHjvWntwcts6yGSM5igiWWR/m6EcCddjQwnu3/wfIkUcCN
         3DeA==
X-Received: by 10.236.77.196 with SMTP id d44mr4205203yhe.44.1367970059885;
        Tue, 07 May 2013 16:40:59 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id a24sm21221970yho.24.2013.05.07.16.40.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 16:40:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.553.gac13664
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223629>

It's possible that the previous tip goes away, we should not assume it's
always present. Fortunately we are only using it to calculate the
progress to display to the user, so only that needs to be fixed.

Also, add a test that triggers this issue.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 15 ++++++++++----
 contrib/remote-helpers/test-bzr.sh    | 37 +++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 0ef30f8..3e452af 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -282,9 +282,13 @@ def export_branch(repo, name):
 
     branch.lock_read()
     revs = branch.iter_merge_sorted_revisions(None, tip, 'exclude', 'forward')
-    tip_revno = branch.revision_id_to_revno(tip)
-    last_revno, _ = branch.last_revision_info()
-    total = last_revno - tip_revno
+    try:
+        tip_revno = branch.revision_id_to_revno(tip)
+        last_revno, _ = branch.last_revision_info()
+        total = last_revno - tip_revno
+    except bzrlib.errors.NoSuchRevision:
+        tip_revno = 0
+        total = 0
 
     for revid, _, seq, _ in revs:
 
@@ -353,7 +357,10 @@ def export_branch(repo, name):
 
         progress = (revno - tip_revno)
         if (progress % 100 == 0):
-            print "progress revision %d '%s' (%d/%d)" % (revno, name, progress, total)
+            if total:
+                print "progress revision %d '%s' (%d/%d)" % (revno, name, progress, total)
+            else:
+                print "progress revision %d '%s' (%d)" % (revno, name, progress)
 
     branch.unlock()
 
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index cec55f1..3f417ad 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -300,4 +300,41 @@ test_expect_success 'proper bzr repo' '
   test_cmp ../expected actual
 '
 
+test_expect_success 'strip' '
+  mkdir -p tmp && cd tmp &&
+  test_when_finished "cd .. && rm -rf tmp" &&
+
+  (
+  bzr init bzrrepo &&
+  cd bzrrepo &&
+
+  echo one >> content &&
+  bzr add content &&
+  bzr commit -m one &&
+
+  echo two >> content &&
+  bzr commit -m two
+  ) &&
+
+  git clone "bzr::$PWD/bzrrepo" gitrepo &&
+
+  (
+  cd bzrrepo &&
+  bzr uncommit --force &&
+
+  echo three >> content &&
+  bzr commit -m three &&
+
+  echo four >> content &&
+  bzr commit -m four &&
+  bzr log --line | sed -e "s/^[0-9]\+: //" > ../expected
+  ) &&
+
+  (cd gitrepo &&
+  git fetch &&
+  git log --format="%an %ad %s" --date=short origin/master > ../actual) &&
+
+  test_cmp actual expected
+'
+
 test_done
-- 
1.8.3.rc1.553.gac13664
