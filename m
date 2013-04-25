From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 7/9] remote-hg: use python urlparse
Date: Thu, 25 Apr 2013 06:20:47 -0500
Message-ID: <1366888849-19607-8-git-send-email-felipe.contreras@gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 13:23:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVKGX-0004yr-Mt
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 13:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758183Ab3DYLWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 07:22:54 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:60328 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758067Ab3DYLWv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 07:22:51 -0400
Received: by mail-ob0-f169.google.com with SMTP id tb18so2410873obb.14
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 04:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=iPRIk79t9vArkV6IVO2ofI2uKD4VpQJUsJSvb9abKws=;
        b=frV73y7IsRIHXSV/v6RRweBsC2HSBEP6Y7dbD0RjDvychmWyRa9dgpK5OWsCL4wYmO
         L4kbNquZ18NL2PQvHnpAzLbp4+Gs2lJNSpG1LY3lRWRhQJ4yvrQhAF84Vg3CwP9/G4LG
         bydGB/cYZ/W115ozTSIkAbaa73SPG8rlObkNgEcPR+DO2WNiDgkn+sK87cVS1vqMgYC4
         BWVKaJB4Qlx3+PjtjP/J8fkMDRR61LDOV+oZK9zRBpHCEgWmfSHvlmWM1SEiqFxj2jAX
         OB3LysOvreqi2tmLacSkvB6RB9OEpRXWgkQNow5SWxKQaqR5wBdD65HJLYJTjdEHW8W5
         4nxw==
X-Received: by 10.60.85.74 with SMTP id f10mr12745789oez.32.1366888969870;
        Thu, 25 Apr 2013 04:22:49 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jw8sm3004088obb.14.2013.04.25.04.22.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 04:22:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222375>

It's simpler, and we don't need to depend on certain Mercurial versions.

Also, now we don't update the URL if 'file://' is not present.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 99abda4..67c3074 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -12,7 +12,7 @@
 # For remote repositories a local clone is stored in
 # "$GIT_DIR/hg/origin/clone/.hg/".
 
-from mercurial import hg, ui, bookmarks, context, util, encoding, node, error
+from mercurial import hg, ui, bookmarks, context, encoding, node, error
 
 import re
 import sys
@@ -22,7 +22,7 @@ import shutil
 import subprocess
 import urllib
 import atexit
-import hashlib
+import urlparse, hashlib
 
 #
 # If you want to switch to hg-git compatibility mode:
@@ -788,11 +788,11 @@ def do_export(parser):
     print
 
 def fix_path(alias, repo, orig_url):
-    repo_url = util.url(repo.url())
-    url = util.url(orig_url)
-    if str(url) == str(repo_url):
+    url = urlparse.urlparse(orig_url, 'file')
+    if url.scheme != 'file' or os.path.isabs(url.path):
         return
-    cmd = ['git', 'config', 'remote.%s.url' % alias, "hg::%s" % repo_url]
+    abs_url = urlparse.urljoin("%s/" % os.getcwd(), orig_url)
+    cmd = ['git', 'config', 'remote.%s.url' % alias, "hg::%s" % abs_url]
     subprocess.call(cmd)
 
 def main(args):
-- 
1.8.2.1
