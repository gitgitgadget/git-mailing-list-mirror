From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 17/47] remote-hg: use a shared repository store
Date: Mon, 13 May 2013 23:36:40 -0500
Message-ID: <1368506230-19614-18-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:39:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc71d-0004Aq-7G
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab3ENEjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:39:37 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:33357 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab3ENEjf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:39:35 -0400
Received: by mail-oa0-f54.google.com with SMTP id o17so102581oag.13
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=XEyX9q8C4m9QB3fuE6PuoPR7E3/opKxdPjwRijqgDvE=;
        b=aEDhx2TGhuG/3oHvtv9Ul2UlWmZc2GC0gYbI1xLpCHrXtlbhpfyX10IVuWiDz/PNmK
         BNHrVOasQSWyc53tT+yNbVC6TN7rmiXnOVFil9svnYiTlL+/I6d+9owGEzVB5t9UznUL
         ztLvJa0J+cxpoGobBQt3y/LLZqQajTit3RDgyQ/qrf8fu/nyK/o9VtgAI8hqX3syzRLH
         PYE/DGVogWhRZFex/DxuENfqSnjGoDC2kHIFxRnKU+d6CLh3j9PeKuzZaK6Frx+rTOf/
         lQxotWs8BPt24WZHysVtYNyKD0tw9JNEF08S0kH0eGHuJS9R8GmspdFxl0vvMGhGD/NH
         JC2g==
X-Received: by 10.60.47.1 with SMTP id z1mr15863408oem.134.1368506374593;
        Mon, 13 May 2013 21:39:34 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id q4sm20058546obl.1.2013.05.13.21.39.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:39:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224249>

This way we don't have to have duplicated Mercurial objects.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 60e875d..d676c98 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -343,21 +343,29 @@ def get_repo(url, alias):
 
     if hg.islocal(url):
         repo = hg.repository(myui, url)
+        if not os.path.exists(dirname):
+            os.makedirs(dirname)
     else:
-        local_path = os.path.join(dirname, 'clone')
-        if not os.path.exists(local_path):
+        shared_path = os.path.join(gitdir, 'hg')
+        if not os.path.exists(shared_path):
             try:
-                peer, dstpeer = hg.clone(myui, {}, url, local_path, update=True, pull=True)
+                hg.clone(myui, {}, url, shared_path, update=False, pull=True)
             except:
                 die('Repository error')
-            repo = dstpeer.local()
-        else:
-            repo = hg.repository(myui, local_path)
-            try:
-                peer = hg.peer(myui, {}, url)
-            except:
-                die('Repository error')
-            repo.pull(peer, heads=None, force=True)
+
+        if not os.path.exists(dirname):
+            os.mkdir(dirname)
+
+        local_path = os.path.join(dirname, 'clone')
+        if not os.path.exists(local_path):
+            hg.share(myui, shared_path, local_path, update=False)
+
+        repo = hg.repository(myui, local_path)
+        try:
+            peer = hg.peer(myui, {}, url)
+        except:
+            die('Repository error')
+        repo.pull(peer, heads=None, force=True)
 
         rb = peer.listkeys('bookmarks')
         bookmarks.updatefromremote(myui, repo, rb, url)
@@ -901,7 +909,7 @@ def fix_path(alias, repo, orig_url):
     subprocess.call(cmd)
 
 def main(args):
-    global prefix, dirname, branches, bmarks
+    global prefix, gitdir, dirname, branches, bmarks
     global marks, blob_marks, parsed_refs
     global peer, mode, bad_mail, bad_name
     global track_branches, force_push, is_tmp
@@ -947,9 +955,6 @@ def main(args):
     if not is_tmp:
         fix_path(alias, peer or repo, url)
 
-    if not os.path.exists(dirname):
-        os.makedirs(dirname)
-
     marks_path = os.path.join(dirname, 'marks-hg')
     marks = Marks(marks_path)
 
-- 
1.8.3.rc1.579.g184e698
