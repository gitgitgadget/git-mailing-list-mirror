From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 05/13] remote-hg: add support to push URLs
Date: Sun, 28 Oct 2012 04:54:05 +0100
Message-ID: <1351396453-29042-6-git-send-email-felipe.contreras@gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 04:55:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSJxu-000380-8H
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 04:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867Ab2J1Dy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 23:54:58 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38829 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab2J1Dy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 23:54:57 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1585004eek.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 20:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KYdFYl/+EfoWg/bmj5HTLRCTIyW1OhIRBAdN/9Awh+Y=;
        b=FL3rB2Mr5Bm/XASH/dtbgs2PWaa8iKW9EOG2MVdsbNGczSvAeIUTaKquR1fJ7f8a0U
         yZN12wNtww/RZYZVXmw2CnSJK2kp+NY8I0YpSF7OcX1wAOQvvsN3LwCz2MG4UL8eSe6d
         N8kT6XErRtTstRx5TuZ+I7KUOO7V8AE9i5LNpMXIin51vKchivR1jzt7veWZH0v94ugV
         4lm1yIBM7CBm0Tke8LoP8tqXObrdpcyJzHnLba/1n87r0Fpei3OMjooWCF2M5la+Y3mB
         9aLT1GtC2h164gxm1Y0lAsqSxpl3RjkARbVOLxkFfYew2q/GGYZlmRCTftePCsHg9mGW
         fIFw==
Received: by 10.14.173.71 with SMTP id u47mr47709895eel.20.1351396497141;
        Sat, 27 Oct 2012 20:54:57 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id g5sm13232109eem.4.2012.10.27.20.54.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2012 20:54:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208523>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index b10e7d1..c96e1a8 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -6,12 +6,13 @@
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
@@ -551,6 +552,12 @@ def main(args):
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
@@ -581,6 +588,9 @@ def main(args):
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
