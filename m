From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 22/48] remote-hg: update bookmarks when using a remote
Date: Fri, 24 May 2013 21:29:38 -0500
Message-ID: <1369449004-17981-23-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:33:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4I1-00029y-RL
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292Ab3EYCcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:32:52 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:52654 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906Ab3EYCcu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:32:50 -0400
Received: by mail-oa0-f41.google.com with SMTP id n9so7060086oag.0
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=YGtI457eL7fOJRXP/f1cCG/4ppGvfqxi6ejc0y4XHGU=;
        b=WcNPv+3JNDZjar+YNC/Xin7wDsGbucwyO5zu/0RE8mV1pxEMBZDYCjL/pigJN0pTKg
         ONGzFgLie4S3yqPjw8KEjYfE8h5Woset+ndNxJ6mlf2vC210hjgZz08qolpFKO9+5+fa
         +1vx9M5+rPrmcvpgAgVKIiQbtJ9h/oMgojAW5KOB7lDKd1Kc2VTYdgutsfFcDonSgiiO
         qh1mTdcbuD/NryGI/P8cnT3ZaMX14oXNBlZG5XuALuSaHqZtl1PHceeS41cxSpOUq9oV
         v782xvMiwtcnaBSiXYfYvvECIw5gDrJR2qVHHZdsBBOtNVGIxUlcWNtJLcHvu+j84Dvi
         ryxQ==
X-Received: by 10.182.125.164 with SMTP id mr4mr13626730obb.94.1369449169806;
        Fri, 24 May 2013 19:32:49 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n5sm20062322obi.8.2013.05.24.19.32.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:32:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225438>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 7c859b8..76438a6 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -356,6 +356,21 @@ def fixup_user(user):
 
     return '%s <%s>' % (name, mail)
 
+def updatebookmarks(repo, peer):
+    remotemarks = peer.listkeys('bookmarks')
+    localmarks = repo._bookmarks
+
+    if not remotemarks:
+        return
+
+    for k, v in remotemarks.iteritems():
+        localmarks[k] = hgbin(v)
+
+    if hasattr(localmarks, 'write'):
+        localmarks.write()
+    else:
+        bookmarks.write(repo)
+
 def get_repo(url, alias):
     global dirname, peer
 
@@ -394,6 +409,8 @@ def get_repo(url, alias):
             die('Repository error')
         repo.pull(peer, heads=None, force=True)
 
+        updatebookmarks(repo, peer)
+
     return repo
 
 def rev_to_mark(rev):
-- 
1.8.3.rc3.312.g47657de
