From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 4/9] remote-bzr: add support to push URLs
Date: Fri, 26 Apr 2013 16:12:34 -0500
Message-ID: <1367010759-17928-5-git-send-email-felipe.contreras@gmail.com>
References: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 23:14:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVpyE-0007Ij-EY
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 23:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757475Ab3DZVOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 17:14:10 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:52421 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987Ab3DZVOI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 17:14:08 -0400
Received: by mail-oa0-f53.google.com with SMTP id m6so4458000oag.12
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 14:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=aO2I1lpX0pAus7vf3P8PPCGQw4ltYah0xvsZwfk5gx4=;
        b=qCKUvAJafIgNu0orDzu48kTbUnWJ5vOL5dFzw8znYqMAPBrsEc/rkMdR1g79P63n/x
         V6xDy34HcHiXlNXpiCpyA3erMJfVfQNdleFBkCxvnHP1AnS2zWY1MX2AXzNHhAM5z6wt
         yv28lZ8wL9xJ8dV57WmH3h73eOMvvFtau49Advy0H0vpXtOrFLy/P+DNk9ViuD2zj5IM
         4Aqt8maWTUVNfEhACcVe1arlrb0FG8ziRD7s7fcdGrujHJgzRIMd8OD5e4/2zaPr5buM
         6PrLYLlFVc8QiXe7cx5eZrz3747Gvdpv97htHCjQ0XpIEMRTNbGmpnTyp7AE71iv1NYo
         MVIA==
X-Received: by 10.182.160.106 with SMTP id xj10mr23049672obb.98.1367010847034;
        Fri, 26 Apr 2013 14:14:07 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id rn6sm6196159oeb.0.2013.04.26.14.14.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 14:14:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222587>

Just like in remote-hg.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 7b6584e..f1d6d5e 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -32,7 +32,7 @@ import os
 import json
 import re
 import StringIO
-import atexit
+import atexit, shutil, hashlib
 
 NAME_RE = re.compile('^([^<>]+)')
 AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]*)>$')
@@ -719,11 +719,11 @@ def main(args):
     global blob_marks
     global parsed_refs
     global files_cache
+    global is_tmp
 
     alias = args[1]
     url = args[2]
 
-    prefix = 'refs/bzr/%s' % alias
     tags = {}
     filenodes = {}
     blob_marks = {}
@@ -731,6 +731,13 @@ def main(args):
     files_cache = {}
     marks = None
 
+    if alias[5:] == url:
+        is_tmp = True
+        alias = hashlib.sha1(alias).hexdigest()
+    else:
+        is_tmp = False
+
+    prefix = 'refs/bzr/%s' % alias
     gitdir = os.environ['GIT_DIR']
     dirname = os.path.join(gitdir, 'bzr', alias)
 
@@ -759,7 +766,10 @@ def main(args):
 def bye():
     if not marks:
         return
-    marks.store()
+    if not is_tmp:
+        marks.store()
+    else:
+        shutil.rmtree(dirname)
 
 atexit.register(bye)
 sys.exit(main(sys.argv))
-- 
1.8.2.1.1031.g2ee5873
