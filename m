From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 39/48] remote-hg: use remote 'default' not local one
Date: Fri, 24 May 2013 21:29:55 -0500
Message-ID: <1369449004-17981-40-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:33:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Im-0002lu-I1
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755790Ab3EYCdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:45 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:43250 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647Ab3EYCdn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:33:43 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so3023805obc.34
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4zPZSGPT1/8v7H5J2ISSV9fq1IbW+/ZeHjB6w8XKBYE=;
        b=i98LaLz8i+gJ4DDw0ak+y2Xvdebu3qyZlLs/5sbvh8/7NSL8AYn/qtdo6r5m+KjYo4
         SgVjsqOrlK+mfikay2ft1wMZ9mUEy1KkJpx5sx6AwDyDOtGO1Pbuz7lXKTGFS+NcWUan
         5gPB0PsJZgJBT6pwTSzZLLpvCBNm8O6slorP4goyVqpyFSt4PyipX+w3JvoB6su3j6iU
         JN4/E5lXK+BLbruNfpZFAXZpQiRoSecD3NUUCZbUxczRcGXgN8PaXds9dhn/qYISJls/
         ZAuZgJESUatubLsLZnZh4vuORi2XeuuQqFYiYlQ4HroVQM9/t8qK9K+XVEZ5ebV/NrKZ
         mUlg==
X-Received: by 10.60.56.234 with SMTP id d10mr13572494oeq.29.1369449222823;
        Fri, 24 May 2013 19:33:42 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wz1sm6626405obc.3.2013.05.24.19.33.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:33:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225451>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 19 +++++++++----------
 contrib/remote-helpers/test-hg.sh    |  2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 5ad5c1e..a1b22f7 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -580,11 +580,11 @@ def get_branch_tip(repo, branch):
 def list_head(repo, cur):
     global g_head, bmarks, fake_bmark
 
-    if 'default' not in repo:
+    if 'default' not in branches:
         # empty repo
         return
 
-    node = repo['default']
+    node = repo[branch_tip('default')]
     head = 'master' if not 'master' in bmarks else 'default'
     fake_bmark = head
     bmarks[head] = node
@@ -601,18 +601,17 @@ def do_list(parser):
         bmarks[bmark] = repo[node]
 
     cur = repo.dirstate.branch()
+    orig = peer if peer else repo
+
+    for branch, heads in orig.branchmap().iteritems():
+        # only open heads
+        heads = [h for h in heads if 'close' not in repo.changelog.read(h)[5]]
+        if heads:
+            branches[branch] = heads
 
     list_head(repo, cur)
 
     if track_branches:
-        orig = peer if peer else repo
-
-        for branch, heads in orig.branchmap().iteritems():
-            # only open heads
-            heads = [h for h in heads if 'close' not in repo.changelog.read(h)[5]]
-            if heads:
-                branches[branch] = heads
-
         for branch in branches:
             print "? refs/heads/branches/%s" % gitref(branch)
 
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 8ea5111..84df1c3 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -486,7 +486,7 @@ test_expect_success 'remote big push' '
 	check_bookmark hgrepo new_bmark ''
 '
 
-test_expect_failure 'remote double failed push' '
+test_expect_success 'remote double failed push' '
 	test_when_finished "rm -rf hgrepo gitrepo*" &&
 
 	(
-- 
1.8.3.rc3.312.g47657de
