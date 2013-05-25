From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 09/48] remote-hg: use a shared repository store
Date: Fri, 24 May 2013 21:29:25 -0500
Message-ID: <1369449004-17981-10-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:32:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4HK-0001c7-9n
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775Ab3EYCcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:32:12 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:41246 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551Ab3EYCcK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:32:10 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so7037249oag.9
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hZdqhk0uudsO3ebvcIkS0A/7nEjqGdHQuWV3V6qYhW4=;
        b=ey904BKdpHz2DTTImDAYsJNpwm1XUOx1MTPagYH3Teywf26oeZMp8yhiquct5Ieq8h
         0ftp9GBXmrjhYoVpWjdAMDaT11b35mhziRFd4NoXwVmoYwVOKHr43oNL/FUk7mN/lZ0x
         lS0UIvVRCFwBTkFZx1A8OzKKilRo1CFXWjkfqn7j3fK+0S957jexkjBQXDybQ/16ByYE
         cnhUVKZa7td6wAln4uu2+P1Q4mLhePhcrM8uVXb6ZT0iDffnoKtu4tICZgnSnI+vZlpM
         clI34NPHcbs11lKdwtTonhnlrKZ7GIPNw13uiOwfXGAl4cp42Fj0accAGkwNxaWGh2pu
         6nhg==
X-Received: by 10.60.65.38 with SMTP id u6mr13416244oes.52.1369449129626;
        Fri, 24 May 2013 19:32:09 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ku7sm20076028obc.6.2013.05.24.19.32.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:32:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225423>

This way we don't have to have duplicated Mercurial objects.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 21f8acd..7507976 100755
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
+            os.makedirs(dirname)
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
 
     return repo
 
@@ -898,7 +906,7 @@ def fix_path(alias, repo, orig_url):
     subprocess.call(cmd)
 
 def main(args):
-    global prefix, dirname, branches, bmarks
+    global prefix, gitdir, dirname, branches, bmarks
     global marks, blob_marks, parsed_refs
     global peer, mode, bad_mail, bad_name
     global track_branches, force_push, is_tmp
@@ -944,9 +952,6 @@ def main(args):
     if not is_tmp:
         fix_path(alias, peer or repo, url)
 
-    if not os.path.exists(dirname):
-        os.makedirs(dirname)
-
     marks_path = os.path.join(dirname, 'marks-hg')
     marks = Marks(marks_path)
 
-- 
1.8.3.rc3.312.g47657de
