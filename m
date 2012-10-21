From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 4/6] remote-hg: add support for trivial features
Date: Sun, 21 Oct 2012 19:49:02 +0200
Message-ID: <1350841744-21564-5-git-send-email-felipe.contreras@gmail.com>
References: <1350841744-21564-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 21 19:49:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPzel-0002nk-97
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 19:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430Ab2JURtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 13:49:36 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:46928 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932420Ab2JURtf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 13:49:35 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so1065914wey.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 10:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8FtZAlrAx6lUPaYoUQX/uNAnu3PJP2m3wWJ55JfF0Pg=;
        b=gh7HAU3mPEMgoSJVcnDklIdT55pmBRmVgze6ERhdALSJOOCpxfQHXTQgY03xi4+/1c
         LKepMbJtltTN1B+gTwBRBwA3jPUomCiDUeDtHOUc9qF13cAwbzRqR+akRLsVmrK46V0Z
         LPA/zqFMmQEK2wvg41UL7N9dS+Y4rsfY7l3NR5nK4+lWgY5Kor+nVZX3ITICJqN5Yqzi
         hJGl/fRiyoe5UA93gyRLGK3FULdcdAUkGd37TfK7jhKOq+rK3XY8Vu2nfPnvdoKo577E
         i24Wwzc/w8ocpshPR3bdQIxdqhy2oHyxyWbUGo6MSOcOyPrXbDUJaSdRoKg6dhLw6l1W
         sdEQ==
Received: by 10.180.102.131 with SMTP id fo3mr31674249wib.1.1350841774131;
        Sun, 21 Oct 2012 10:49:34 -0700 (PDT)
Received: from localhost (ip-109-43-0-67.web.vodafone.de. [109.43.0.67])
        by mx.google.com with ESMTPS id dt9sm46888107wib.1.2012.10.21.10.49.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Oct 2012 10:49:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc2.7.g0961fdf.dirty
In-Reply-To: <1350841744-21564-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208132>

So that the other remote-hg tests don't barf.

I'm not particularily happy with this code, but does the trick.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index 34a00cd..772bb69 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -12,6 +12,7 @@ import re
 import sys
 import os
 import json
+import shutil
 
 first = True
 
@@ -172,7 +173,13 @@ def get_repo(url, alias):
     myui = ui.ui()
     myui.setconfig('ui', 'interactive', 'off')
 
-    if hg.islocal(url):
+    if url.startswith("remote://"):
+        remote = True
+        url = "file://%s" % url[9:]
+    else:
+        remote = False
+
+    if hg.islocal(url) and not remote:
         repo = hg.repository(myui, url)
     else:
         local_path = os.path.join(dirname, 'clone')
@@ -442,6 +449,12 @@ def main(args):
     url = args[2]
     peer = None
 
+    if not alias.isalnum():
+        is_tmp = True
+        alias = "tmp"
+    else:
+        is_tmp = False
+
     gitdir = os.environ['GIT_DIR']
     dirname = os.path.join(gitdir, 'hg', alias)
     branches = {}
@@ -468,6 +481,9 @@ def main(args):
             do_export(parser)
         sys.stdout.flush()
 
-    marks.store()
+    if not is_tmp:
+        marks.store()
+    else:
+        shutil.rmtree(dirname)
 
 sys.exit(main(sys.argv))
-- 
1.8.0.rc2.7.g0961fdf.dirty
