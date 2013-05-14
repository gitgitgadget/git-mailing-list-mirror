From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 42/47] remote-hg: check diverged bookmarks
Date: Mon, 13 May 2013 23:37:05 -0500
Message-ID: <1368506230-19614-43-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:41:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc733-000504-Mc
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037Ab3ENElA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:41:00 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:43972 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756031Ab3ENEk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:40:58 -0400
Received: by mail-oa0-f43.google.com with SMTP id o6so104979oag.2
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=s0rtQKlh2z1fpLPn+tLYbDQV2RyZG8WUc4mFBwp4R08=;
        b=SfijPnbgYyKAQzxAW8AeeVjwIvElY6cwW4esTJcG4PthXM02pR93VZnEodyANboHgw
         JKYd70Tg6eMFimkrnTmIQ+JITFUUeiKWchhEvDczbPTjUjKP63DZvb/1K+ma/U0vSBB9
         TW1oXiDScUPIqm/P3DotFdscL1K3BYeY7Hh13fkGVCZEAYgIfYuw0Y9TdmjK6BMjLBg1
         m1obCz7XbKMTY07qsWQQWfPrp54ap14NYZI5cCUTKuwcRl51fGTwAePvltngsPAAMIke
         jM/Hd3eBs+PDzZ/3k6PrYwaUA+9p6TD/gRd1MnScdYApS/B1rpvyMGyOMBkBsV3tx0E9
         yFLA==
X-Received: by 10.60.55.97 with SMTP id r1mr15340630oep.85.1368506457848;
        Mon, 13 May 2013 21:40:57 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c20sm20505917oez.4.2013.05.13.21.40.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:40:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224274>

So that we can report a proper error.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 24 ++++++++++++++++++++++++
 contrib/remote-helpers/test-hg.sh    |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 5a5667d..df3b9a4 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -839,6 +839,23 @@ def write_tag(repo, tag, node, msg, author):
 
     return (tagnode, branch)
 
+def checkheads_bmark(ref, ctx):
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
+    if not ctx_old.descendant(ctx_new):
+        print "error %s non-fast forward" % ref
+        return False
+
+    return True
+
 def checkheads(repo, remote, p_revs):
 
     remotemap = remote.branchmap()
@@ -855,6 +872,13 @@ def checkheads(repo, remote, p_revs):
         if not branch in remotemap:
             # new branch
             continue
+        if not ref.startswith('refs/heads/branches'):
+            if ref.startswith('refs/heads/'):
+                if not checkheads_bmark(ref, ctx):
+                    ret = False
+
+            # only check branches
+            continue
         new.setdefault(branch, []).append(ctx.rev())
 
     for branch, heads in new.iteritems():
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 4f6fd4c..ecf7bd4 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -320,7 +320,7 @@ test_expect_success 'remote update bookmark diverge' '
 	check_bookmark hgrepo diverge "bump bookmark"
 '
 
-test_expect_failure 'remote new bookmark multiple branch head' '
+test_expect_success 'remote new bookmark multiple branch head' '
 	test_when_finished "rm -rf gitrepo*" &&
 
 	(
-- 
1.8.3.rc1.579.g184e698
