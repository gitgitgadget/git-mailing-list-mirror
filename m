From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 6/9] remote-bzr: store converted URL
Date: Thu, 25 Apr 2013 19:08:19 -0500
Message-ID: <1366934902-18704-7-git-send-email-felipe.contreras@gmail.com>
References: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 02:10:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVWEk-0003nL-MA
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 02:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471Ab3DZAJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 20:09:57 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61854 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757199Ab3DZAJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 20:09:56 -0400
Received: by mail-ob0-f174.google.com with SMTP id wc20so3067833obb.33
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 17:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=PQv2qvt+cmWXkFCZrJIlsVweF/KLyNhlQ/kilZ/SfLw=;
        b=QqFmlrVNorYEl8QTzaryzIeqjopCxZqTD26VIWN/f7EFCo6VyZuz55vsIR4/0Yz5Vf
         Xdhi/3SxUGnBFk+gRN7tqGzu0nXUIMHxlxhuuH5z2mK6paGXFqKrKFhda7CpT/eRQ1Sw
         EYeQoOx6FcWHFWPMKpMTONSwU/7e669XRWMq94oJVohurupdTlWv/H+upNVkJBdw2Zz4
         xow33ldcFDLpovfgsGCAkiQkhYeqvmimgSA4n1K+5UgXGxOFMXV2JfctxpTdXvVvJDsY
         pOWhIXWVOLR5M+5hYrgI/APcW0gjw4Au3LKitB8H7PXCoKbA5JsSoSzc+eLKX/c9qQ4r
         KUHw==
X-Received: by 10.60.39.167 with SMTP id q7mr16773293oek.80.1366934996036;
        Thu, 25 Apr 2013 17:09:56 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ns4sm5651148obc.2.2013.04.25.17.09.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 17:09:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222475>

Mercurial might convert the URL to something more appropriate, like an
absolute path. Lets store that instead of the original URL, which won't
work from a different working directory if it's relative.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index f1d6d5e..dda2932 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -32,7 +32,7 @@ import os
 import json
 import re
 import StringIO
-import atexit, shutil, hashlib
+import atexit, shutil, hashlib, urlparse, subprocess
 
 NAME_RE = re.compile('^([^<>]+)')
 AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]*)>$')
@@ -713,6 +713,14 @@ def get_repo(url, alias):
 
     return branch
 
+def fix_path(alias, orig_url):
+    url = urlparse.urlparse(orig_url, 'file')
+    if url.scheme != 'file' or os.path.isabs(url.path):
+        return
+    abs_url = urlparse.urljoin("%s/" % os.getcwd(), orig_url)
+    cmd = ['git', 'config', 'remote.%s.url' % alias, "bzr::%s" % abs_url]
+    subprocess.call(cmd)
+
 def main(args):
     global marks, prefix, dirname
     global tags, filenodes
@@ -741,6 +749,9 @@ def main(args):
     gitdir = os.environ['GIT_DIR']
     dirname = os.path.join(gitdir, 'bzr', alias)
 
+    if not is_tmp:
+        fix_path(alias, url)
+
     if not os.path.exists(dirname):
         os.makedirs(dirname)
 
-- 
1.8.2.1.884.g3532a8d
