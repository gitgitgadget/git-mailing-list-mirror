From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/9] remote-bzr: add support to push URLs
Date: Thu, 25 Apr 2013 06:20:44 -0500
Message-ID: <1366888849-19607-5-git-send-email-felipe.contreras@gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 13:22:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVKGL-0004fJ-Ax
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 13:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758150Ab3DYLWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 07:22:33 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:47925 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758119Ab3DYLWc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 07:22:32 -0400
Received: by mail-ob0-f176.google.com with SMTP id wd20so2379921obb.21
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=+mQ7XxHBwRSRWH+ayg3cX7CRLp32Jq8XlMluH3KAVFE=;
        b=L4WXLc96g9G6NlaOoe9V7Qp8seSyHy9TkMFqGDghOJyjSQtrrv1wzWSrTKJrQNs+kq
         ICsBXKGnSdQt6a+/1pBLK/CVIkhT5TrONEXR/j7mMKlEZnV/7ZTXe4R8uRpGNVJqAr1C
         m0mguwtmxdSz30d17pQkL27IPyJi0HX4HOhYB9jcHVskwZ19qKQnbOyLfl3HnsJeqIUI
         Sma7J2UFTRebfXgt1ytd9WQVhag/XSddNWDTsGDOMYZ8m+oNPylVBDSBbkzxXDfcIAZB
         hRQYCimpEKx2Q2KZvwVt3gYjGDe9kfjt5CZdBylLa5J5SX/okYC8eJ2aL/b8m5CpENE2
         jaOg==
X-Received: by 10.182.219.136 with SMTP id po8mr143060obc.75.1366888951506;
        Thu, 25 Apr 2013 04:22:31 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id it9sm3013750obb.6.2013.04.25.04.22.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 04:22:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222372>

Just like in remote-hg.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 84734c7..d6319d6 100755
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
1.8.2.1
