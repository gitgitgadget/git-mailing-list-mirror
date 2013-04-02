From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/13] remote-hg: split bookmark handling
Date: Tue,  2 Apr 2013 13:02:57 -0600
Message-ID: <1364929382-1399-9-git-send-email-felipe.contreras@gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 21:05:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6Vv-0007A7-5b
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762118Ab3DBTE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:04:28 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:46413 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762098Ab3DBTE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:04:26 -0400
Received: by mail-yh0-f49.google.com with SMTP id m1so113919yhg.36
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=jvJV86Z6hpEBo2jJSK424U7kbEaTgLigJTkk+hNgLRk=;
        b=tn1hoVFJsfdH8o8xr/R33CQIsGJKcew3PJ7YdenCmmEpMCyYEWtFJJDwW5GTXVX1US
         YGvnmidnfvJ4PnG+r1qbpz7T/501m1rRqZNseFsw/acfTaJfMdgyPpEEWSZXB2vUE+NH
         N3KN/n7FK28A8lUHMeGKmULqz+8Nl4cG1U7g33g3YHxMdKlii3FGqKiANiq6gBH7vUQH
         +uEJMlEFWUplRWS4TcdVmDC3nzfpAOp3xpvmeyKnum+xSybOsWc73VDwLweBAELEMpXQ
         rU35h7yO4YzzGQRm8qiZZonodOyJn2AEJR8Z5PetZ7JzMY8NWnL0GJ6khMSWUx2xoIT8
         kyAw==
X-Received: by 10.236.193.200 with SMTP id k48mr16082731yhn.69.1364929465797;
        Tue, 02 Apr 2013 12:04:25 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id u80sm4912443yhj.5.2013.04.02.12.04.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 12:04:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219839>

Will be useful for remote bookmarks.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 38 +++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 874ccd4..73d79cb 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -685,6 +685,8 @@ def parse_tag(parser):
 def do_export(parser):
     global parsed_refs, bmarks, peer
 
+    p_bmarks = []
+
     parser.next()
 
     for line in parser.each_block('done'):
@@ -706,20 +708,9 @@ def do_export(parser):
             pass
         elif ref.startswith('refs/heads/'):
             bmark = ref[len('refs/heads/'):]
-            if bmark in bmarks:
-                old = bmarks[bmark].hex()
-            else:
-                old = ''
-
-            if bmark == 'master' and 'master' not in parser.repo._bookmarks:
-                # fake bookmark
-                print "ok %s" % ref
-                continue
-
-            if not bookmarks.pushbookmark(parser.repo, bmark, old, node):
-                print "error %s" % ref
-                continue
-
+            p_bmarks.append((bmark, node))
+            # handle below
+            continue
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
             parser.repo.tag([tag], node, None, True, None, {})
@@ -731,6 +722,25 @@ def do_export(parser):
     if peer:
         parser.repo.push(peer, force=False)
 
+    # handle bookmarks
+    for bmark, node in p_bmarks:
+
+        if bmark in bmarks:
+            old = bmarks[bmark].hex()
+        else:
+            old = ''
+
+        if bmark == 'master' and 'master' not in parser.repo._bookmarks:
+            # fake bookmark
+            print "ok %s" % ref
+            continue
+
+        if not bookmarks.pushbookmark(parser.repo, bmark, old, node):
+            print "error %s" % ref
+            continue
+
+        print "ok %s" % ref
+
     print
 
 def fix_path(alias, repo, orig_url):
-- 
1.8.2
