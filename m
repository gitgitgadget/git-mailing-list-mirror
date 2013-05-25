From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 17/48] remote-hg: improve progress calculation
Date: Fri, 24 May 2013 21:29:33 -0500
Message-ID: <1369449004-17981-18-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:32:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Hg-0001rE-5X
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184Ab3EYCch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:32:37 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:42764 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068Ab3EYCcf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:32:35 -0400
Received: by mail-ob0-f172.google.com with SMTP id tb18so6275939obb.3
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pBNPyc51s5yCc2C+fZCdsIRtTA5J8lVdYrQ0HUEsI/0=;
        b=mztEvWODKLeh0mqHv479u3uPNRphB/2whPsA/hN9lHHb30RWOr7jm22yWppiACWpci
         jCUNnJfTHqFcStnj/iMhslw0HTGhwppxnVx8yovrayLe7BBbumCiukY1xhyFVRnLZBCz
         mhJ78UPZE5Xogot1nwbrdbRPgpUA6sZ2ytdFDocTfgXWmLWzRgYdlBFd443mOOHH4j1p
         6SZ1adY6cWEkE7pYZj0ri/E6CCExKlyvP6uCvY2CcC4AszzyFyNnq8894xsX5hN95Xcw
         rZ5+xhx+lsiaew62jv7ycyxJJRQrUIZAAXV8IzoPtQXfJM7626D3Az7tYCJxHGee4cB9
         pyaQ==
X-Received: by 10.60.131.243 with SMTP id op19mr13219599oeb.132.1369449154837;
        Fri, 24 May 2013 19:32:34 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w7sm20053156obx.9.2013.05.24.19.32.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:32:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225430>

No need to manually keep track of the revision count.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index ee60dbf..48edf3b 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -415,7 +415,7 @@ def export_ref(repo, name, kind, head):
         tip = 0
 
     revs = xrange(tip, head.rev() + 1)
-    count = 0
+    total = len(revs)
 
     for rev in revs:
 
@@ -423,7 +423,6 @@ def export_ref(repo, name, kind, head):
         node = c.node()
 
         if marks.is_marked(c.hex()):
-            count += 1
             continue
 
         (manifest, user, (time, tz), files, desc, extra) = repo.changelog.read(node)
@@ -495,9 +494,9 @@ def export_ref(repo, name, kind, head):
             print "D %s" % (fix_file_path(f))
         print
 
-        count += 1
-        if (count % 100 == 0):
-            print "progress revision %d '%s' (%d/%d)" % (rev, name, count, len(revs))
+        progress = (rev - tip)
+        if (progress % 100 == 0):
+            print "progress revision %d '%s' (%d/%d)" % (rev, name, progress, total)
 
     # make sure the ref is updated
     print "reset %s/%s" % (prefix, ename)
-- 
1.8.3.rc3.312.g47657de
