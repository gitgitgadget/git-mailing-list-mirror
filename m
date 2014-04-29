From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/8] remote-{hg,bzr}: store marks only on success
Date: Tue, 29 Apr 2014 04:04:30 -0500
Message-ID: <1398762275-346-4-git-send-email-felipe.contreras@gmail.com>
References: <1398762275-346-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 11:15:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf48T-0008Qh-Ci
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933227AbaD2JPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:15:24 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:38205 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756300AbaD2JPV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:15:21 -0400
Received: by mail-oa0-f51.google.com with SMTP id l6so887408oag.10
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 02:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fzjGuAFLSEaCvE7Sy6wy3NPun4HkircvZsOw0NXoSDc=;
        b=WKqci1B/aZp7zEXqTa4st2RMXBDe29954iwWFSnG0wqvbcdfThexGMHBqDkPep2m1r
         WCcY0mfGwUsYvE+sPnmg6JzeYDfPFJb5jfK26ZCJOalD4XQP/biW8u9IXboiNRdV2Z4W
         TRVPg4yP1gUstMXztAnGwNB4MLY/idkt+K5GJqqJzLHV9ShIxKqtCHl6Tx9A2om67QCV
         XP2/5JxZj6ZpX8d1o5nIkGhXMYUsvsjhjntvoYltBz6bI8l+HZpJ74x7tiIGSohBSaba
         8cvovfNg1GclTqrtbzVzSpfleHlr1Z2N70tt1TvGLDzOMRcwWQ8Ht1Q+EffP136+sVKU
         dhAQ==
X-Received: by 10.60.131.40 with SMTP id oj8mr26459601oeb.14.1398762921224;
        Tue, 29 Apr 2014 02:15:21 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id pt8sm38993456obb.5.2014.04.29.02.15.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 02:15:20 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
In-Reply-To: <1398762275-346-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247549>

Commit 2594a79 (remote-hg: fix bad state issue) originally introduced
this code in order to avoid synchronization issues while pushing,
because `git fast-export` might end up writing the marks before a crash
in the remote helper occurs.

However, the problem is in `git fast-export`; the marks should only be
written after both have finished successfully.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-bzr.py | 8 +++-----
 git-remote-hg.py  | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/git-remote-bzr.py b/git-remote-bzr.py
index 9abb58e..71b138e 100755
--- a/git-remote-bzr.py
+++ b/git-remote-bzr.py
@@ -971,12 +971,10 @@ def main(args):
             die('unhandled command: %s' % line)
         sys.stdout.flush()
 
+    marks.store()
+
 def bye():
-    if not marks:
-        return
-    if not is_tmp:
-        marks.store()
-    else:
+    if is_tmp:
         shutil.rmtree(dirname)
 
 atexit.register(bye)
diff --git a/git-remote-hg.py b/git-remote-hg.py
index 204ceeb..8aca6dd 100755
--- a/git-remote-hg.py
+++ b/git-remote-hg.py
@@ -1258,12 +1258,10 @@ def main(args):
             die('unhandled command: %s' % line)
         sys.stdout.flush()
 
+    marks.store()
+
 def bye():
-    if not marks:
-        return
-    if not is_tmp:
-        marks.store()
-    else:
+    if is_tmp:
         shutil.rmtree(dirname)
 
 atexit.register(bye)
-- 
1.9.2+fc1.3.gade8541
