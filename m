From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 14/21] remote-hg: show more proper errors
Date: Thu, 11 Apr 2013 07:23:10 -0500
Message-ID: <1365682997-11329-15-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:25:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGZC-000896-Jv
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161506Ab3DKMZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:25:13 -0400
Received: from mail-qa0-f41.google.com ([209.85.216.41]:58692 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161481Ab3DKMZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:25:09 -0400
Received: by mail-qa0-f41.google.com with SMTP id bs12so234202qab.7
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=dV1+0ZJk7Y6hWUEd/zeyuDa4w68xT7nJSqMzR8Bll4E=;
        b=WOjvKKUY4CzL8nu1boVNVJL0tpV3uxwYM8+XSiFYDlhJX8gUQqpMfj5bQKbVtV2j/A
         X1oWPMbat7bASTMlF+29llhVCuAzXrhCemlYefcm7DMLpItThel7o1XIlimLJXFsifq8
         RrVmnRslDjYrbzoU+EBvYA/yutVwnY24+c2cPU77ZhzakwsGA4bTTWkx9QmyFVVRtp02
         c6mJLTKYY+nv5g/A86d1bUnnRR420FXbCzm3dFlL5c30HJv0E79GzrewE5MacmYoG3ru
         bKbkDhjKy9t7osfFDergbrUn/mT1Odn6Cg9rlrKK2xnJMaVOIJJi+FEnR0Y+JGoZang6
         nm9w==
X-Received: by 10.224.10.144 with SMTP id p16mr6897081qap.47.1365683109103;
        Thu, 11 Apr 2013 05:25:09 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id n14sm7007895qaq.3.2013.04.11.05.25.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:25:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220868>

When cloning or pushing fails, we don't want to show a stack-trace.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index ff89725..3ae3598 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -9,7 +9,7 @@
 # Then you can clone with:
 # git clone hg::/path/to/mercurial/repo/
 
-from mercurial import hg, ui, bookmarks, context, util, encoding, node
+from mercurial import hg, ui, bookmarks, context, util, encoding, node, error
 
 import re
 import sys
@@ -284,11 +284,17 @@ def get_repo(url, alias):
     else:
         local_path = os.path.join(dirname, 'clone')
         if not os.path.exists(local_path):
-            peer, dstpeer = hg.clone(myui, {}, url, local_path, update=False, pull=True)
+            try:
+                peer, dstpeer = hg.clone(myui, {}, url, local_path, update=True, pull=True)
+            except:
+                die('Repository error')
             repo = dstpeer.local()
         else:
             repo = hg.repository(myui, local_path)
-            peer = hg.peer(myui, {}, url)
+            try:
+                peer = hg.peer(myui, {}, url)
+            except:
+                die('Repository error')
             repo.pull(peer, heads=None, force=True)
 
     return repo
-- 
1.8.2.1
