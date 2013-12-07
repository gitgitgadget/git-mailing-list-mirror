From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/4] remote-helpers: add extra safety checks
Date: Sat,  7 Dec 2013 07:09:41 -0600
Message-ID: <1386421783-27781-3-git-send-email-felipe.contreras@gmail.com>
References: <1386421783-27781-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 14:17:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpHl4-0003Ei-JU
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 14:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174Ab3LGNRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 08:17:19 -0500
Received: from mail-oa0-f54.google.com ([209.85.219.54]:41615 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528Ab3LGNRR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 08:17:17 -0500
Received: by mail-oa0-f54.google.com with SMTP id h16so2046307oag.41
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 05:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VNjNAyi3fvDm+xZs7nePdbZidGmBNmSV305G/9yuQqE=;
        b=f0VpLoWqJLkxwTeEySYiKY4zXtgi1d0CQJb3XGZt3v20WjVzBJCpqSq+yPVG9I1C8H
         2PMAgn/7RqIqurDUwyXj5crFmlXjSp4JvHQ/A3FSSjroysetYPO9gZW/2kOlfX2ixcqs
         Xm67qQH4VeUDqm41gxEoQqMzdWn/0lTa6UW+205O+z6N5s32IvegOfOwu0eufJ8ZWJ/U
         YnsfYkxvilrhEII8r0Y2WUv2/7oon9KO4qyjwvZ51mP9ZN4kR2/GetMXlpoJ4lUY+SB+
         5J7e0M4OPzlugXEu2YOhBDoKfWAdJ5AhxumuoskcxSQe6RY/1FzH6dkY+SZ4F4syjIph
         64wQ==
X-Received: by 10.182.107.164 with SMTP id hd4mr496442obb.58.1386422237070;
        Sat, 07 Dec 2013 05:17:17 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u9sm5267278oey.0.2013.12.07.05.17.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 05:17:16 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1386421783-27781-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238981>

Suggested-by: Roman Ovchinnikov <coolthecold@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 14 ++++++++++----
 contrib/remote-helpers/git-remote-hg  | 14 ++++++++++----
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 054161a..858ba3c 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -884,6 +884,16 @@ def main(args):
     global branches, peers
     global transports
 
+    marks = None
+    is_tmp = False
+    gitdir = os.environ.get('GIT_DIR', None)
+
+    if len(args) < 3:
+        die('Not enough arguments.')
+
+    if not gitdir:
+        die('GIT_DIR not set')
+
     alias = args[1]
     url = args[2]
 
@@ -892,7 +902,6 @@ def main(args):
     blob_marks = {}
     parsed_refs = {}
     files_cache = {}
-    marks = None
     branches = {}
     peers = {}
     transports = []
@@ -900,11 +909,8 @@ def main(args):
     if alias[5:] == url:
         is_tmp = True
         alias = hashlib.sha1(alias).hexdigest()
-    else:
-        is_tmp = False
 
     prefix = 'refs/bzr/%s' % alias
-    gitdir = os.environ['GIT_DIR']
     dirname = os.path.join(gitdir, 'bzr', alias)
 
     if not is_tmp:
diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index a81d59e..aa1d230 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -1165,6 +1165,16 @@ def main(args):
     global dry_run
     global notes, alias
 
+    marks = None
+    is_tmp = False
+    gitdir = os.environ.get('GIT_DIR', None)
+
+    if len(args) < 3:
+        die('Not enough arguments.')
+
+    if not gitdir:
+        die('GIT_DIR not set')
+
     alias = args[1]
     url = args[2]
     peer = None
@@ -1185,16 +1195,12 @@ def main(args):
     if alias[4:] == url:
         is_tmp = True
         alias = hashlib.sha1(alias).hexdigest()
-    else:
-        is_tmp = False
 
-    gitdir = os.environ['GIT_DIR']
     dirname = os.path.join(gitdir, 'hg', alias)
     branches = {}
     bmarks = {}
     blob_marks = {}
     parsed_refs = {}
-    marks = None
     parsed_tags = {}
     filenodes = {}
     fake_bmark = None
-- 
1.8.4.2+fc1
