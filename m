From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 45/47] remote-hg: use remote 'default' not local one
Date: Mon, 13 May 2013 23:37:08 -0500
Message-ID: <1368506230-19614-46-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:41:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc73F-0005A8-T7
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068Ab3ENElL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:41:11 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:40527 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab3ENElI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:41:08 -0400
Received: by mail-ob0-f173.google.com with SMTP id eh20so99097obb.18
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=6tw4LHx+8tbOI9iRONHB3IWVGLf/F5E2k4SZejQVLB0=;
        b=OeZpBgW0NQioHCu5uYUHWdpZD/got2rpvlgUeX+eoniis9rVkQIvT0PxgStXNNJMku
         yPhl70nJ6nOf4LYDy5ZlHIp/9mqmYBw0w4FyA7EMm/IuY5DPRkOHZmzr9HtxJOUMcZV9
         NwDK8D42e6QVjJW6W+maMLcchMa3Ufbf7jx88SMpA7/aSOx2nMxH0Rbi6DwAkhYXugO3
         uYCXdNEsiISLTeX7zqhvtKMpIHKKAZR9B5+BZU1I2fBacqyEJrv/98H00UsLTcqQ8e7i
         4Z2xcqslVCecQTBeNX1EFqR77fMYJk+Hs7yQ0Jl5mc4KVXjUM+pkR+v4dCAKBZiQHhXn
         rtWQ==
X-Received: by 10.60.55.137 with SMTP id s9mr15118416oep.49.1368506467518;
        Mon, 13 May 2013 21:41:07 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wq8sm20002384obb.7.2013.05.13.21.41.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:41:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224276>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 19 +++++++++----------
 contrib/remote-helpers/test-hg.sh    |  2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index cacf2da..ff38fac 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -561,11 +561,11 @@ def get_branch_tip(repo, branch):
 def list_head(repo, cur):
     global g_head, bmarks
 
-    if 'default' not in repo:
+    if 'default' not in branches:
         # empty repo
         return
 
-    node = repo['default']
+    node = repo[branch_tip('default')]
     head = 'master' if not 'master' in bmarks else 'default'
     bmarks[head] = node
 
@@ -581,18 +581,17 @@ def do_list(parser):
         bmarks[bmark] = repo[node]
 
     cur = repo.dirstate.branch()
+    orig = peer if peer else repo
+
+    for branch, heads in orig.branchmap().iteritems():
+        # only open heads
+        heads = [h for h in heads if not repo[h].closesbranch()]
+        if heads:
+            branches[branch] = heads
 
     list_head(repo, cur)
 
     if track_branches:
-        orig = peer if peer else repo
-
-        for branch, heads in orig.branchmap().iteritems():
-            # only open heads
-            heads = [h for h in heads if not repo[h].closesbranch()]
-            if heads:
-                branches[branch] = heads
-
         for branch in branches:
             print "? refs/heads/branches/%s" % gitref(branch)
 
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index ecf7bd4..b3422c4 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -426,7 +426,7 @@ test_expect_success 'remote big push' '
 	check_bookmark hgrepo new_bmark ''
 '
 
-test_expect_failure 'remote double failed push' '
+test_expect_success 'remote double failed push' '
 	test_when_finished "rm -rf hgrepo gitrepo*" &&
 
 	(
-- 
1.8.3.rc1.579.g184e698
