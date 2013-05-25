From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 12/48] remote-hg: add version checks to the marks
Date: Fri, 24 May 2013 21:29:28 -0500
Message-ID: <1369449004-17981-13-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:32:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4HT-0001j5-GO
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941Ab3EYCcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:32:22 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:54216 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab3EYCcT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:32:19 -0400
Received: by mail-oa0-f51.google.com with SMTP id f4so7012178oah.10
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hwu8hdKvkd6vyKomT8fffgISMpaXAbNHSQ3Pgzv0HDE=;
        b=0t9AA8dyMshmlceyjAijzKF6lD6d6FHghGLFiMIiZyezNi9OhyI8TcERwizx2GgrhU
         k5cUNSUn7NIwvwixwhXZ7Y4WktwUUAC2tAjxCHB9Y39UpC7VH/SCtFYkOlNjU/LI1mQw
         vPvIAbL4sfEJGXJuCtotgAIsJXgcR82e+yiWwy/X3D70q0MrrV8fHqpyCOLpj5m0JLjw
         VGKeNWRVjdwu2ka8FduoZ0jtvJSSlbKmS240DS17NtdZ8tLWapDIVACHfuB/ANwsb4yQ
         +y/VRUMpdxdzvmdo852A1/RL6uU+nzhMbFA2GDP+H4dS0WBJDnm1BCt2EsGduGuCiqMz
         PtRA==
X-Received: by 10.182.227.133 with SMTP id sa5mr13299333obc.96.1369449139149;
        Fri, 24 May 2013 19:32:19 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id kd10sm20547755oeb.7.2013.05.24.19.32.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:32:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225426>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 07ea104..e2bef7f 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -55,6 +55,8 @@ EMAIL_RE = re.compile('^([^<>]+[^ \\\t<>])?\\b(?:[ \\t<>]*?)\\b([^ \\t<>]+@[^ \\
 AUTHOR_HG_RE = re.compile('^(.*?) ?<(.*?)(?:>(.+)?)?$')
 RAW_AUTHOR_RE = re.compile('^(\w+) (?:(.+)? )?<(.*)> (\d+) ([+-]\d+)')
 
+VERSION = 1
+
 def die(msg, *args):
     sys.stderr.write('ERROR: %s\n' % (msg % args))
     sys.exit(1)
@@ -103,12 +105,19 @@ class Marks:
 
     def __init__(self, path):
         self.path = path
+        self.clear()
+        self.load()
+
+        if self.version < VERSION:
+            self.clear()
+            self.version = VERSION
+
+    def clear(self):
         self.tips = {}
         self.marks = {}
         self.rev_marks = {}
         self.last_mark = 0
-
-        self.load()
+        self.version = 0
 
     def load(self):
         if not os.path.exists(self.path):
@@ -119,12 +128,13 @@ class Marks:
         self.tips = tmp['tips']
         self.marks = tmp['marks']
         self.last_mark = tmp['last-mark']
+        self.version = tmp.get('version', 1)
 
         for rev, mark in self.marks.iteritems():
             self.rev_marks[mark] = int(rev)
 
     def dict(self):
-        return { 'tips': self.tips, 'marks': self.marks, 'last-mark' : self.last_mark }
+        return { 'tips': self.tips, 'marks': self.marks, 'last-mark' : self.last_mark, 'version' : self.version }
 
     def store(self):
         json.dump(self.dict(), open(self.path, 'w'))
-- 
1.8.3.rc3.312.g47657de
