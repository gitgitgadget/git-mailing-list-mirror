From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATH 3/4] remote-hg: add version checks to the marks
Date: Fri,  5 Apr 2013 05:36:18 -0600
Message-ID: <1365161779-32170-4-git-send-email-felipe.contreras@gmail.com>
References: <1365161779-32170-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Max Horn <max@quendi.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 18:58:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWFZ-0002u6-BI
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236Ab3DELh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 07:37:27 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:44780 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab3DELhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 07:37:25 -0400
Received: by mail-oa0-f44.google.com with SMTP id h1so3899151oag.17
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 04:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=xw1iJeF/WSJSwfQ4eI3EF6jvc2Q4CD+mQP024XV08j4=;
        b=A3jEEhzVakL3E6C7EksJDkYFPjYD+BPivaprlqtXwl9j7PjraoUzoiPxpSLTaLQpac
         bThu9l+Li/wLlXbv532FIMBuEYKh0UQPTls6FHoS81KFFVT0t1VWtyzc/n6CxEn5HHhu
         hFluTaULCgoehUxo20qdRL5EdG3GJD6bMuRENdMa/4DKJwhUECsMEQDGZk0RSBshBtS/
         cDpjsiMhJJF58T2qHV22yCNF0D3Ea3oI9J6nDcW6aoS1VWqP56yjQrUtAeZoaR78rxn7
         7g5Wj6jMcDzIFmiCwvVgzksZUF4cRAJBa2FirYcC60X91pMx6IRfuZ2EdBbqH/MEEURq
         ge4A==
X-Received: by 10.182.190.19 with SMTP id gm19mr7599373obc.34.1365161844737;
        Fri, 05 Apr 2013 04:37:24 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id n1sm11458294obc.10.2013.04.05.04.37.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 04:37:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365161779-32170-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220175>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 02fda2d..9e124e1 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -43,6 +43,8 @@ AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]*)>$')
 AUTHOR_HG_RE = re.compile('^(.*?) ?<(.*?)(?:>(.+)?)?$')
 RAW_AUTHOR_RE = re.compile('^(\w+) (?:(.+)? )?<(.*)> (\d+) ([+-]\d+)')
 
+VERSION = 1
+
 def die(msg, *args):
     sys.stderr.write('ERROR: %s\n' % (msg % args))
     sys.exit(1)
@@ -76,12 +78,19 @@ class Marks:
 
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
@@ -92,12 +101,13 @@ class Marks:
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
1.8.2
