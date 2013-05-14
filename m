From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 20/47] remote-hg: add version checks to the marks
Date: Mon, 13 May 2013 23:36:43 -0500
Message-ID: <1368506230-19614-21-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:41:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc73X-0005Ki-JW
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab3ENElj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:41:39 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:65228 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592Ab3ENEjo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:39:44 -0400
Received: by mail-ob0-f182.google.com with SMTP id va2so94912obc.27
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=R+1Mm6KJyddlT8uRriSZvognGxxuB4mJ2ELj6cPu+84=;
        b=V5cWPuGzh194llrPgptCipRpEwa25y/oV+r3cW+DeLDZDFupPEBnynCZnHucFa7Opg
         E03AYU8U5AKBhhqX3EnmhxJdevZEkPmj61clgYgIpFICV7UOt271Yn/j2f6iCsQhfKI+
         V+JDwVERRPx1GHB3ng1FQwDSYPCcXLOBoxGA/IKKEBRHKwIRWOw3aG2cvGqbRH251Tjn
         P9ld4X+BRPC1/kbRDnHqi80H8pv+kwGwKRptjMcabfb0FKYXF2vSYMvE2VerDjYFVAzf
         4NZpGCwiNNibbceZJVLdysEhVzmCpoDX9xph0td/SUyDoB6rW0AAZ2ur+BvZmyT/t9Cv
         0Oyw==
X-Received: by 10.60.96.105 with SMTP id dr9mr15344027oeb.59.1368506384352;
        Mon, 13 May 2013 21:39:44 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n6sm20470781oel.8.2013.05.13.21.39.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:39:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224282>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index a3618de..36b8fd4 100755
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
1.8.3.rc1.579.g184e698
