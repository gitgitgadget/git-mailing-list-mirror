From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 04/16] remote-hg: add support to push URLs
Date: Sun,  4 Nov 2012 03:13:26 +0100
Message-ID: <1351995218-19889-5-git-send-email-felipe.contreras@gmail.com>
References: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 03:14:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUpjA-0002ES-1i
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab2KDCOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 22:14:06 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62548 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab2KDCOD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:14:03 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1657497bkc.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hi8DAqTne2tl2MzacThVAZ0mKHVbCBXUTSmd2Fw9nFs=;
        b=qGIMcpyke+PU2DY+A2TwZq0gpdwcg0Pox0JtOyaAHf2He+fDVRAuwbljrs+eX5dx3m
         j7XlYAq/eGfZ8SLXkT1a1aevuqd8N/nNQ4T1xMprZIfMWHMkAiSM2b8ADlkNeh68QBz7
         /xasRJWhEi5urCN2D0M/o24CamxlBntoIbmzwLO3FxCGA8vdavs5kplDieehugDKRG6t
         7ZaW9G4XzMkWjvQJtKdgUvz8x2gZnlgJALV2s8AEu5uBDfKc8OhS/7n5y6cwFWIbeciL
         dxUI4A+r7pJ8GletKkb6DCo61uA/4CrMhZFZ1pCB8zq9wcB+ApXgNpkSBor+YV/IX5Jt
         4Mvg==
Received: by 10.205.120.134 with SMTP id fy6mr1393713bkc.18.1351995243153;
        Sat, 03 Nov 2012 19:14:03 -0700 (PDT)
Received: from localhost (ip-109-43-0-39.web.vodafone.de. [109.43.0.39])
        by mx.google.com with ESMTPS id e13sm7944249bkw.12.2012.11.03.19.14.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 19:14:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208991>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 45629e0..a5023c9 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -9,12 +9,13 @@
 # Then you can clone with:
 # git clone hg::/path/to/mercurial/repo/
 
-from mercurial import hg, ui, bookmarks, context
+from mercurial import hg, ui, bookmarks, context, util
 
 import re
 import sys
 import os
 import json
+import shutil
 
 NAME_RE = re.compile('^([^<>]+)')
 AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]+)>$')
@@ -574,6 +575,12 @@ def main(args):
     url = args[2]
     peer = None
 
+    if alias[4:] == url:
+        is_tmp = True
+        alias = util.sha1(alias).hexdigest()
+    else:
+        is_tmp = False
+
     gitdir = os.environ['GIT_DIR']
     dirname = os.path.join(gitdir, 'hg', alias)
     branches = {}
@@ -604,6 +611,9 @@ def main(args):
             die('unhandled command: %s' % line)
         sys.stdout.flush()
 
-    marks.store()
+    if not is_tmp:
+        marks.store()
+    else:
+        shutil.rmtree(dirname)
 
 sys.exit(main(sys.argv))
-- 
1.8.0
