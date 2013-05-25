From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 30/48] remote-hg: reorganize bookmark handling
Date: Fri, 24 May 2013 21:29:46 -0500
Message-ID: <1369449004-17981-31-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:33:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4IQ-0002Uw-KI
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360Ab3EYCdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:17 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:53234 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641Ab3EYCdP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:33:15 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so6874427oag.4
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nRWBGSAmhHEn8WQR075QUbbmqTf4AEq/tTNy8sgJCOo=;
        b=ibaxsbTzSpLGaFA2cnGL0ZRZU6+RbpLzwI10YEpKtmkqpZZCEllQIG754+YQfdyK6i
         qKFwKL89ozxS7tu+qDoboqVbjmyxC3KHBCzNlp0Gv7fQ5BLBpO63js+j/xAajpOBcNEX
         yUDF9uv5H2iDjazTiNn2bTIaUhVJKMTFCzSfprgxkGVDioXFfv4fy2Gl+JjFR4T+3R7Y
         5U7iPyifBuA7xLO59yLYeHIidw8UdHVIj1PVT5hOsQMrM3mTOp3CQNe/JDXl9/djyx80
         TC16VJRSTJfU0INczckkbxAbz2j70VXBkQn27y/paNV+XBD/QRG+3WBJLKiM+tRHBWdS
         teVg==
X-Received: by 10.60.155.177 with SMTP id vx17mr13959487oeb.9.1369449194892;
        Fri, 24 May 2013 19:33:14 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x10sm20557799oes.6.2013.05.24.19.33.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:33:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225444>

We don't need to update both internal and remote bookmarks, so let's do
one or the other, and move the shared code earlier, so it's simpler.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 50 ++++++++++++++----------------------
 1 file changed, 19 insertions(+), 31 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 61e6c87..99de7c2 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -885,8 +885,17 @@ def do_export(parser):
             print "ok %s" % ref
         elif ref.startswith('refs/heads/'):
             bmark = ref[len('refs/heads/'):]
-            p_bmarks.append((bmark, node))
-            continue
+            new = node
+            old = bmarks[bmark].hex() if bmark in bmarks else ''
+
+            if old == new:
+                continue
+
+            print "ok %s" % ref
+            if bmark != fake_bmark and \
+                    not (bmark == 'master' and bmark not in parser.repo._bookmarks):
+                p_bmarks.append((ref, bmark, old, new))
+
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
             tag = hgref(tag)
@@ -906,39 +915,18 @@ def do_export(parser):
 
     if peer:
         parser.repo.push(peer, force=force_push, newbranch=True)
-        remote_bmarks = peer.listkeys('bookmarks')
-
-    # handle bookmarks
-    for bmark, node in p_bmarks:
-        ref = 'refs/heads/' + bmark
-        new = node
-
-        if bmark in bmarks:
-            old = bmarks[bmark].hex()
-        else:
-            old = ''
-
-        if old == new:
-            continue
 
-        if bmark == fake_bmark or \
-                bmark == 'master' and 'master' not in parser.repo._bookmarks:
-            print "ok %s" % ref
-            continue
-        elif bookmarks.pushbookmark(parser.repo, bmark, old, new):
-            # updated locally
-            pass
-        else:
-            print "error %s" % ref
-            continue
-
-        if peer:
+        # update remote bookmarks
+        remote_bmarks = peer.listkeys('bookmarks')
+        for ref, bmark, old, new in p_bmarks:
             old = remote_bmarks.get(bmark, '')
             if not peer.pushkey('bookmarks', bmark, old, new):
                 print "error %s" % ref
-                continue
-
-        print "ok %s" % ref
+    else:
+        # update local bookmarks
+        for ref, bmark, old, new in p_bmarks:
+            if not bookmarks.pushbookmark(parser.repo, bmark, old, new):
+                print "error %s" % ref
 
     print
 
-- 
1.8.3.rc3.312.g47657de
