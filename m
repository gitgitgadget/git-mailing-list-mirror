From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 12/18] remote-bzr: improve author sanitazion
Date: Tue, 30 Apr 2013 20:10:04 -0500
Message-ID: <1367370610-14250-13-git-send-email-felipe.contreras@gmail.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 03:12:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXLb8-0007lg-8B
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 03:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934145Ab3EABMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 21:12:33 -0400
Received: from mail-ye0-f174.google.com ([209.85.213.174]:61180 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934111Ab3EABM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 21:12:29 -0400
Received: by mail-ye0-f174.google.com with SMTP id l14so202412yen.5
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 18:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=2wqYroQPAjsy6uDfqW37GUhMNk8O4Yl4ApotUU/9vSc=;
        b=KHpLPRRrIzrH81SJ+B5mFbjIW11mHD5kUxjltSrZ/f1TtpRfJMaM2jgslS/x3AXf6k
         Tq8STEePplcOOkG4HKtNMOdFxnVXUOuoIGFp5QEcWkxeT0lz+5CLOhVCM2yxJRPbRm50
         endE6r3HRaDSLjAyo8ecGZaPl2+EpDZ9+qep3uxmrDPPPQ+9RlNWpese1K0IGAn05qq4
         G/Mqdxcgy4Ea2vpltrX/oKSOXG61ri7hJL0Ah+HjF0J6vM5Y6qoYQw+gM8K0C3VlcScT
         ZS/7SL5cohft9k438VydeRJ52Y3t9SokYTA4uxchd7UseBix4qv2sliwbRsp3o1/c1Gd
         VqVw==
X-Received: by 10.236.84.6 with SMTP id r6mr739140yhe.9.1367370748476;
        Tue, 30 Apr 2013 18:12:28 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id v48sm1503007yhi.26.2013.04.30.18.12.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 18:12:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
In-Reply-To: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223058>

So that we don't end up with '<None>', and also synchronize it with the
one from remote-hg.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 9fe830e..af46016 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -38,6 +38,7 @@ import atexit, shutil, hashlib, urlparse, subprocess
 
 NAME_RE = re.compile('^([^<>]+)')
 AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]*)>$')
+EMAIL_RE = re.compile('^([^<>]+[^ \\\t<>])?\\b(?:[ \\t<>]*?)\\b([^ \\t<>]+@[^ \\t<>]+)')
 RAW_AUTHOR_RE = re.compile('^(\w+) (.+)? <(.*)> (\d+) ([+-]\d+)')
 
 def die(msg, *args):
@@ -175,9 +176,19 @@ def fixup_user(user):
         name = m.group(1)
         mail = m.group(2).strip()
     else:
-        m = NAME_RE.match(user)
+        m = EMAIL_RE.match(user)
         if m:
-            name = m.group(1).strip()
+            name = m.group(1)
+            mail = m.group(2)
+        else:
+            m = NAME_RE.match(user)
+            if m:
+                name = m.group(1).strip()
+
+    if not name:
+        name = 'unknown'
+    if not mail:
+        mail = 'Unknown'
 
     return '%s <%s>' % (name, mail)
 
-- 
1.8.3.rc0.399.gc96a135
