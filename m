From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/9] remote-bzr: add support to push URLs
Date: Thu, 25 Apr 2013 19:08:17 -0500
Message-ID: <1366934902-18704-5-git-send-email-felipe.contreras@gmail.com>
References: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 02:09:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVWEf-0003ha-1y
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 02:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463Ab3DZAJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 20:09:51 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:36021 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932256Ab3DZAJu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 20:09:50 -0400
Received: by mail-oa0-f48.google.com with SMTP id f4so3434027oah.35
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 17:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=UbfJTdwq4qa9biJ/2uBax43XrDKZyagTNtrFKQSEOSQ=;
        b=CWJslMiZvwVaC4ARUqJXAomEu1zu0G29bJVtD713VUBO+jmsS3bL/VhXgaaUkpiacq
         ATvndVlSwEGh1GCeZrWfvHhH19y5NSjNBFh7mO/EPVdUhiTPCLPcBlmtbhH/xKOaqQ13
         DPJnGYRn1rIN5LfnbdHIAF5DyECGMdAi1hZmPoPGGmo/onGg+OFuUJh022eiwF/Ln7mz
         WEpFvyRMuPzczqaUyB/e2QgokFPjO/zYiBJCr0fFQAj/i6lOerMIg7oV+y/dP6RPFV9u
         JoWolP6u2IfexSVHC16reEPdZ6Ewa+9L1pZBkHvsb6joLqyZF9ZOm0IXnuCOuS5A3F23
         QAXw==
X-Received: by 10.60.101.163 with SMTP id fh3mr17571492oeb.95.1366934990303;
        Thu, 25 Apr 2013 17:09:50 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wl10sm5651895obc.1.2013.04.25.17.09.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 17:09:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222473>

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
1.8.2.1.884.g3532a8d
