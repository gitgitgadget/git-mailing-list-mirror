From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] remote-bzr: fix prefix of tags
Date: Mon, 15 Apr 2013 16:47:28 -0500
Message-ID: <1366062448-2136-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 15 23:48:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URrGc-0006Ll-CE
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 23:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935246Ab3DOVsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 17:48:46 -0400
Received: from mail-qe0-f53.google.com ([209.85.128.53]:38562 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934779Ab3DOVsp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 17:48:45 -0400
Received: by mail-qe0-f53.google.com with SMTP id q19so3005010qeb.12
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=NEU9Zoc528doLWHkTIswAZ0wNysHo1xp1N3YQrsdQt8=;
        b=dDd41hiExYBpDNeFOXYh7tTUR6yzvCZW1Dpa7OBzGTlUeLSeX/xOxtb27Z44GuqwD7
         dw7/G7cM8gW0AZxdMD2yR/4PDKIxknYHxlbpIdL9PB0IYRua+ux71MFaojiynLSTmCRh
         hctvrj9lF2ik6gD70HPUOQYjr29zkfRRI0Pg1qGjgA2mTm83oxnmbP6YIq+kAO8OU/1d
         fZmkbOJhfS9YgctAdCexMkAbxiHq7N7vY+yM3Vvc7P38FtG9KWlx2R+rGZFVfB/zNCmW
         9HvEALzUB2tmLhdcoHr4GVD/5Q+EKyBTMPMzQ04M7JLCbsDTYvgQL5X8cLyyXwzyrt2W
         8Njg==
X-Received: by 10.224.86.206 with SMTP id t14mr46795qal.90.1366062525206;
        Mon, 15 Apr 2013 14:48:45 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id z2sm14867327qad.4.2013.04.15.14.48.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 14:48:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.679.g509521a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221321>

In the current transport-helper code, refs without namespaced refspecs don't
work correctly, so let's always use them.

Some people reported issues with 'git clone --mirror', and this fixes them, as
well as possibly others.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index bd25e08..aa7bc97 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -249,7 +249,7 @@ def export_files(tree, files):
     return final
 
 def export_branch(branch, name):
-    global prefix, dirname
+    global prefix
 
     ref = '%s/heads/%s' % (prefix, name)
     tip = marks.get_tip(name)
@@ -335,8 +335,10 @@ def export_branch(branch, name):
     marks.set_tip(name, revid)
 
 def export_tag(repo, name):
-    global tags
-    print "reset refs/tags/%s" % name
+    global tags, prefix
+
+    ref = '%s/tags/%s' % (prefix, name)
+    print "reset %s" % ref
     print "from :%u" % rev_to_mark(tags[name])
     print
 
@@ -649,6 +651,7 @@ def do_capabilities(parser):
     print "import"
     print "export"
     print "refspec refs/heads/*:%s/heads/*" % prefix
+    print "refspec refs/tags/*:%s/tags/*" % prefix
 
     path = os.path.join(dirname, 'marks-git')
 
-- 
1.8.2.1.679.g509521a
