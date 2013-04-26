From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 13/20] remote-bzr: improve author sanitazion
Date: Thu, 25 Apr 2013 20:08:01 -0500
Message-ID: <1366938488-25425-14-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:10:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXAt-0003xY-Pw
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932860Ab3DZBKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:10:03 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:57205 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932672Ab3DZBKB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:10:01 -0400
Received: by mail-ob0-f180.google.com with SMTP id uk5so3021497obc.25
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=SyEKdJZBQwtzuO5lrx2/QL7MzLDQQfON1O9Z2WpTuFo=;
        b=V7dEjZMNfzyGYdExX6aIjKWiBGlE15u+a815droy4eviFS+Gna1yEH9Jx9xzEwB/s7
         p/IZHae6QMoLOBn2hMSW7bWwEF5CFvbOK3Ftvs/X2e3GB0LSdn9nCL90buPhwFcH/ASC
         zX+CSN+4becUaMlOuWmcmSSc/Cgs+ysMrP81FLx5gGBq/kvxJk1vzC1qqeIoqbiXSss8
         ezRedFSTDHk5GqXgCtPEHfZ2bNnop1rLY4lR9pFZS0o+h4l4WYn3q4+4HVmKUPkgtSGt
         RXQjU10LwgmcHPJ7HySqDAwwEpjaO0hsr0YPOAd2/IbwAPvdG9fo1F2BnTAef45vgpv4
         3bYg==
X-Received: by 10.60.171.167 with SMTP id av7mr16912673oec.77.1366938600634;
        Thu, 25 Apr 2013 18:10:00 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h8sm2271101obk.10.2013.04.25.18.09.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:09:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222495>

So that we don't end up with '<None>', and also synchronize it with the
one from remote-hg.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index fcd8e41..5c25b06 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -38,6 +38,7 @@ import atexit, shutil, hashlib, urlparse, subprocess
 
 NAME_RE = re.compile('^([^<>]+)')
 AUTHOR_RE = re.compile('^([^<>]+?)? ?<([^<>]*)>$')
+EMAIL_RE = re.compile('^([^<>]+[^ \\\t<>])?\\b(?:[ \\t<>]*?)\\b([^ \\t<>]+@[^ \\t<>]+)')
 RAW_AUTHOR_RE = re.compile('^(\w+) (.+)? <(.*)> (\d+) ([+-]\d+)')
 
 def die(msg, *args):
@@ -198,9 +199,19 @@ def fixup_user(user):
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
1.8.2.1.884.g3532a8d
