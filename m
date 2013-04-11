From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 08/21] remote-hg: split bookmark handling
Date: Thu, 11 Apr 2013 07:23:04 -0500
Message-ID: <1365682997-11329-9-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:24:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGYe-0007Gc-EC
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139Ab3DKMYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:24:49 -0400
Received: from mail-qa0-f43.google.com ([209.85.216.43]:64768 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934828Ab3DKMYs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:24:48 -0400
Received: by mail-qa0-f43.google.com with SMTP id i13so236409qae.9
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=EdJ6jos1gHOSq8eTg/Z4MCI2/6Yjc/LRDRl9d63iDw4=;
        b=r7U77yvguM0gFfrZb0inT6pCnAzBOzLig5gMnC1FMjyWp8fOuzD0GLv8Kve2lbRG4h
         paoZskX+X67sWk1r27GqUQ8wRfAzHJM2PU8eZUdB89PWfFXmVlUwjPdzx74QRGhMZPQd
         D9998yRZt9XcBqMLWwYsKV56tNZXf13IRCdhahsURisWubF+8/HN9vt21DXnLzVAkHSi
         UtLcSJGRIT07bzaUW9+mfzrGXKmq2W2V+UeIaUwXLLqLpmHTEtyAwQvRTgYn7jMJZvBa
         QVP7f0fHiNNu3oqcemf6pA4fyJAoLQZjhZQ0PXrWmeHkk4mlAd3I/BS3UmJuGMmS/P4U
         hGwg==
X-Received: by 10.49.16.233 with SMTP id j9mr7666901qed.12.1365683088057;
        Thu, 11 Apr 2013 05:24:48 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id u3sm7019048qab.1.2013.04.11.05.24.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:24:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220860>

Will be useful for remote bookmarks.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 39 +++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 874ccd4..73cd812 100755
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
@@ -731,6 +722,26 @@ def do_export(parser):
     if peer:
         parser.repo.push(peer, force=False)
 
+    # handle bookmarks
+    for bmark, node in p_bmarks:
+        ref = 'refs/heads/' + bmark
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
1.8.2.1
