From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 36/47] remote-hg: reorganize bookmark handling
Date: Mon, 13 May 2013 23:36:59 -0500
Message-ID: <1368506230-19614-37-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:40:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc72k-0004oJ-15
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956Ab3ENEkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:40:39 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:50393 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184Ab3ENEki (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:40:38 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so104517oag.5
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=BAw145qkFcYwxhUi5XA7El7eYzB80Sv6KhmTLMm4bqY=;
        b=vGwyE3D4tQ/NFCUhC2RQzCV4j2HP/XOBD2Jb7Sl4toTfLI+ausYsiHwNfus9jZ/8mA
         MXh8oSgngcnzanmKwHt4tezjwhD5CxWjLfYCS6NH0KvtNMKnWxpBLDN2AqZY7NngCbQ+
         3mfavxUOVzhFscWw/c1mFal33tPNJhu4Iz2DcAG2L+1xvV/5iLmzdPyfu9jcGPkRFMn1
         76YBerpVps93wG96FRpuJK/UljcW2PfcGB9h/1DOLMMVpumDtJr3Zz4HFJu0klCsZW2k
         Wt2w5qzdxunjeVabissGZMbwxE5kZFjdM7YkLSVBy3D563Rs329txIvOlDmRXHZZ6Ncs
         afLA==
X-Received: by 10.60.79.231 with SMTP id m7mr3721570oex.105.1368506438247;
        Mon, 13 May 2013 21:40:38 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jt1sm818761oeb.5.2013.05.13.21.40.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:40:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224267>

We don't need to update both internal and remote bookmarks, so let's do
one or the other, and move the shared code earlier, so it's simpler.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 52 +++++++++++++++---------------------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 6c7392f..14fadd1 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -870,8 +870,19 @@ def do_export(parser):
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
+            if bmark == 'master' and 'master' not in parser.repo._bookmarks:
+                # fake bookmark
+                pass
+            else:
+                p_bmarks.append((ref, bmark, old, new))
+
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
             tag = hgref(tag)
@@ -891,39 +902,18 @@ def do_export(parser):
 
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
-
-        if bmark == 'master' and 'master' not in parser.repo._bookmarks:
-            # fake bookmark
-            print "ok %s" % ref
-            continue
-        elif bookmarks.pushbookmark(parser.repo, bmark, old, new):
-            # updated locally
-            pass
-        else:
-            print "error %s" % ref
-            continue
 
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
1.8.3.rc1.579.g184e698
