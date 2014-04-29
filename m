From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/8] remote-hg: fix parsing of custom committer
Date: Tue, 29 Apr 2014 04:04:28 -0500
Message-ID: <1398762275-346-2-git-send-email-felipe.contreras@gmail.com>
References: <1398762275-346-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 11:15:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf48L-0008HY-Fl
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933221AbaD2JPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:15:16 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:55638 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756300AbaD2JPO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:15:14 -0400
Received: by mail-oa0-f54.google.com with SMTP id i7so8665851oag.27
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 02:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3s0jWzZz9SRXpzNQcVrvPxvel0aB+ab4rdC+yPg3l3g=;
        b=e7Kr+LTi7ttqHuADksWr9wT6zOnL2nfb7161juwqLDP3WBNJnAhYQ2H1s5cfugEKaA
         E14gvDEJLSmegPtBNIVS1tyY9ZDoNHobY7kx49Sq5+MOiuwLmD6D/DdreJuvMoTKdcg4
         Ut+Ak4P1WgEdQzhTKFcjmrBo45ThPJkIgxANoQsE3Sx/Ik0vbie02YKeKyhAO9OHr4DR
         0zgGNwrMSw3vU+OaYFkBuUgU5Aadf6YdjbzI/NbBBddZyzd7w8Uu7nfQzfj9oPlADOMw
         ouyvXzH9Cp3lYcChw22CmjjnKQfBEP9iR5tQfuGVnjva4e2ihKrZKqoljcnZzpJxz7iT
         4hsg==
X-Received: by 10.60.159.36 with SMTP id wz4mr27131241oeb.30.1398762913828;
        Tue, 29 Apr 2014 02:15:13 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id pa3sm42802600obb.6.2014.04.29.02.15.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 02:15:12 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
In-Reply-To: <1398762275-346-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247547>

Other tools use the 'committer' extra field differently, so let's make
the parsing more reliable and don't assume it's in a certain format.

Reported-by: Kevin Cox <kevincox@kevincox.ca>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-hg.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-remote-hg.py b/git-remote-hg.py
index 34cda02..c849abb 100755
--- a/git-remote-hg.py
+++ b/git-remote-hg.py
@@ -461,8 +461,12 @@ def export_ref(repo, name, kind, head):
 
         author = "%s %d %s" % (fixup_user(user), time, gittz(tz))
         if 'committer' in extra:
-            user, time, tz = extra['committer'].rsplit(' ', 2)
-            committer = "%s %s %s" % (user, time, gittz(int(tz)))
+            try:
+                cuser, ctime, ctz = extra['committer'].rsplit(' ', 2)
+                committer = "%s %s %s" % (cuser, ctime, gittz(int(ctz)))
+            except ValueError:
+                cuser = extra['committer']
+                committer = "%s %d %s" % (fixup_user(cuser), time, gittz(tz))
         else:
             committer = author
 
-- 
1.9.2+fc1.3.gade8541
