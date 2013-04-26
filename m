From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 16/20] remote-bzr: improve progress reporting
Date: Thu, 25 Apr 2013 20:08:04 -0500
Message-ID: <1366938488-25425-17-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:10:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXB2-000481-Us
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932905Ab3DZBKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:10:11 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:44493 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932853Ab3DZBKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:10:09 -0400
Received: by mail-oa0-f43.google.com with SMTP id k7so3472882oag.2
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=EgxN15wGRpYGEYtQEWNZRlGJHGTIolbVqiByjkMLZ7I=;
        b=SKYyh5nqjF+JTkJz0zLgTXV1QWi5NyIQI8fX9X8T0G/Z/aLBtg9LxWTyCCSzmV+ydN
         SsEgd83SpqsG52G8YebHkPBSDphLLrFQuQooD9lTvAOlWA7+bsGeIkOHBPxQS84lB0j5
         wpCWMTZonRtsmlcT08oub2HtCLhsKsVTMBVsHXEXqzWkWSzQ06efJox2N17Cebcz2OIR
         gWkDBAZshu8JaoPu1sVonRXpge/qDNawgDLzAtp4+9El+mTYuehB2hK5IwwNSBkeY8Ik
         5JOUcVwjgNhisJW09qMm4FnDXTHFbhj+ONOowVF7/ZD/C9ATBWBN9rykZLEyATu55n+0
         iGTQ==
X-Received: by 10.182.84.135 with SMTP id z7mr16744755oby.35.1366938609351;
        Thu, 25 Apr 2013 18:10:09 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id dt3sm5851362obb.12.2013.04.25.18.10.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:10:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222497>

No need to manually count the revisions, and also, this would help to
iterate more properly.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 06d9d24..7d3052a 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -305,13 +305,16 @@ def export_branch(repo, name):
 
     branch.lock_read()
     revs = branch.iter_merge_sorted_revisions(None, tip, 'exclude', 'forward')
-    count = 0
+    tip_revno = branch.revision_id_to_revno(tip)
+    last_revno, _ = branch.last_revision_info()
+    total = last_revno - tip_revno
 
-    revs = [revid for revid, _, _, _ in revs if not marks.is_marked(revid)]
+    revs = [revid, seq for revid, _, seq, _ in revs if not marks.is_marked(revid)]
 
-    for revid in revs:
+    for revid, seq in revs:
 
         rev = repo.get_revision(revid)
+        revno = seq[0]
 
         parents = rev.parent_ids
         time = rev.timestamp
@@ -366,10 +369,13 @@ def export_branch(repo, name):
             print "M %s :%u %s" % f
         print
 
-        count += 1
-        if (count % 100 == 0):
-            print "progress revision %s '%s' (%d/%d)" % (revid, name, count, len(revs))
-            print "#############################################################"
+        if len(seq) > 1:
+            # let's skip branch revisions from the progress report
+            continue
+
+        progress = (revno - tip_revno)
+        if (progress % 100 == 0):
+            print "progress revision %d '%s' (%d/%d)" % (revno, name, progress, total)
 
     branch.unlock()
 
-- 
1.8.2.1.884.g3532a8d
