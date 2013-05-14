From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 25/47] remote-hg: improve progress calculation
Date: Mon, 13 May 2013 23:36:48 -0500
Message-ID: <1368506230-19614-26-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:40:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc72D-0004WY-V4
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755708Ab3ENEkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:40:04 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34909 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755623Ab3ENEkB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:40:01 -0400
Received: by mail-ob0-f169.google.com with SMTP id vb8so100137obc.0
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=LThvOAwUS/Z8EG/BBLwuLpAjmLX0D9VkXU3yXvdWYVc=;
        b=wpdK6LjVaaiOohFu9WHse9JML6T3oNl+BprQ1QnrAxl53ekC1mTIJbv3zX2bKfWv0o
         ICuadRY1kr9Ey+grLgrD6y9lrR5dXBupRbypVrcsZOT6CTSMkpoDmXfPfqElZvwH96KC
         USxIxs7QYh6TPQ6tRHOK6k9lOX/f9SUcCDp335mmL4wAons2LnQ2wDw3phBi0X0RwPGc
         bsiHSLsDomsLSuMvJKKqXYyVLDSvIvMpcsBlVQKFXv1V8oxszfkU0xaR4MYzO5OKWKMF
         bsBTVJI68Yxh8aynAxrDH7o54o/mo7slHLx9vdReZ2kUC4gjgflUfXfvxiWNbLtarHM0
         CX2w==
X-Received: by 10.60.149.129 with SMTP id ua1mr15992505oeb.56.1368506400930;
        Mon, 13 May 2013 21:40:00 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x10sm20486161oes.6.2013.05.13.21.39.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:40:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224256>

No need to manually keep track of the revision count.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 49af8d5..e05106a 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -418,7 +418,7 @@ def export_ref(repo, name, kind, head):
         tip = 0
 
     revs = xrange(tip, head.rev() + 1)
-    count = 0
+    total = len(revs)
 
     for rev in revs:
 
@@ -426,7 +426,6 @@ def export_ref(repo, name, kind, head):
         node = c.node()
 
         if marks.is_marked(c.hex()):
-            count += 1
             continue
 
         (manifest, user, (time, tz), files, desc, extra) = repo.changelog.read(node)
@@ -498,9 +497,9 @@ def export_ref(repo, name, kind, head):
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
1.8.3.rc1.579.g184e698
