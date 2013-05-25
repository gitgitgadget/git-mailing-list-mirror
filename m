From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 36/48] remote-hg: check diverged bookmarks
Date: Fri, 24 May 2013 21:29:52 -0500
Message-ID: <1369449004-17981-37-git-send-email-felipe.contreras@gmail.com>
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
	id 1Ug4Il-0002lu-FZ
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732Ab3EYCdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:40 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:39680 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647Ab3EYCde (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:33:34 -0400
Received: by mail-oa0-f48.google.com with SMTP id i4so6965638oah.21
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9QBc9e7Xo9NZfL+P++pKSW05p9RqUGJSlckFnLZ9F3s=;
        b=cdXnrehy+TUJ2rX9OvC2TFyqT6Tn+7mHUkR6Q5SbMHFHddOnwVcbjDT0HyXO0yQMm6
         jRFA4rbLnmaKMbxTTbQDiv5+2dxEpSQeddifKWIcFQXgh8NmSnHgELV+qf9c0SlMsBIi
         8y3dxAhrnGGusTFJX6a8gAkoERKjZpuldB9hnQ0q+D+LBJZAfUnaRogP6BWyi7pyyi1p
         wEaypJybPcWVmKid89GZFIBSufdk5YICtEg4ZD3V/+JPJHPIJFgiDoya9TXOPc2561Yk
         wkwoubsnJyGmWFwD9cliMW79BL9cLdf/Zk2uGxewQQmYhccDTtN0qcjL554KBoivZeVc
         MmOw==
X-Received: by 10.182.240.136 with SMTP id wa8mr13798631obc.2.1369449213749;
        Fri, 24 May 2013 19:33:33 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id nt17sm20020103obb.13.2013.05.24.19.33.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:33:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225453>

So that we can report a proper error.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 24 ++++++++++++++++++++++++
 contrib/remote-helpers/test-hg.sh    |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index b6f85b2..e8ebc17 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -859,6 +859,23 @@ def write_tag(repo, tag, node, msg, author):
 
     return (tagnode, branch)
 
+def checkheads_bmark(repo, ref, ctx):
+    if force_push:
+        return True
+
+    bmark = ref[len('refs/heads/'):]
+    if not bmark in bmarks:
+        # new bmark
+        return True
+
+    ctx_old = bmarks[bmark]
+    ctx_new = ctx
+    if not repo.changelog.descendant(ctx_old.rev(), ctx_new.rev()):
+        print "error %s non-fast forward" % ref
+        return False
+
+    return True
+
 def checkheads(repo, remote, p_revs):
 
     remotemap = remote.branchmap()
@@ -875,6 +892,13 @@ def checkheads(repo, remote, p_revs):
         if not branch in remotemap:
             # new branch
             continue
+        if not ref.startswith('refs/heads/branches'):
+            if ref.startswith('refs/heads/'):
+                if not checkheads_bmark(repo, ref, ctx):
+                    ret = False
+
+            # only check branches
+            continue
         new.setdefault(branch, []).append(ctx.rev())
 
     for branch, heads in new.iteritems():
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index c4e4a1a..8ea5111 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -380,7 +380,7 @@ test_expect_success 'remote update bookmark diverge' '
 	check_bookmark hgrepo diverge "bump bookmark"
 '
 
-test_expect_failure 'remote new bookmark multiple branch head' '
+test_expect_success 'remote new bookmark multiple branch head' '
 	test_when_finished "rm -rf gitrepo*" &&
 
 	(
-- 
1.8.3.rc3.312.g47657de
