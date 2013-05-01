From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 15/18] remote-bzr: improve progress reporting
Date: Tue, 30 Apr 2013 20:10:07 -0500
Message-ID: <1367370610-14250-16-git-send-email-felipe.contreras@gmail.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 03:12:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXLbH-0007sP-G1
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 03:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934111Ab3EABMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 21:12:45 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:34909 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934166Ab3EABMn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 21:12:43 -0400
Received: by mail-yh0-f51.google.com with SMTP id l109so209651yhq.10
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 18:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=EN6YoH6hgvtNZC57Pt5ne6YV2M+yFpo79WoQHrYFFlI=;
        b=lwx4NHLYlurl38nLysDu72kRda1HFpIcn1GBpWPOr/zmP/SOZ0mNAoVz/3O+/kN0Et
         DGBrIKN8R7l3aUyiI6Eb27pItLSBP5Z8uQlfFr9DNGrKpRQOhxwzvg2fUtUjF1LKG4fw
         140NZR5vm5kDIdgo6crHucrRAkiOOlJ6m8IQ1BDJakQvPkfrn4JesLiIYxKOtb+dHsoM
         Vwt+wP6Svr0de7vOAx/O64onk7TVW3+fsV3acDYWPpaBqOjNHjxODKKAsJGBiDE5ak+F
         cOiyOm0kGEiOqrB3RZfaNA+/yN+rC7DZXN6GpcVuc6mZ5vdui2SWa6Slw7H+ksKs1htu
         DlVA==
X-Received: by 10.236.98.66 with SMTP id u42mr586089yhf.157.1367370762706;
        Tue, 30 Apr 2013 18:12:42 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id q23sm1652447yhg.5.2013.04.30.18.12.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 18:12:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
In-Reply-To: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223059>

No need to manually count the revisions, and also, this would help to
iterate more properly.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index d284afc..2e21008 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -282,13 +282,16 @@ def export_branch(repo, name):
 
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
@@ -343,10 +346,13 @@ def export_branch(repo, name):
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
1.8.3.rc0.399.gc96a135
