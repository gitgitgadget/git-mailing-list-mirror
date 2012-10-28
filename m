From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 07/13] remote-hg: match hg merge behavior
Date: Sun, 28 Oct 2012 04:54:07 +0100
Message-ID: <1351396453-29042-8-git-send-email-felipe.contreras@gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 04:55:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSJyI-0003Nu-1j
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 04:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896Ab2J1DzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 23:55:17 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38829 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab2J1DzP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 23:55:15 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1585004eek.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 20:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dCB8lnJh1Txko+yhZJf1fVFVqivzQAR1MzTpR82f4sE=;
        b=iS7+d2duVEsDKcWaFjwPoQzjD301mLnJQ9baI7A/EwnbWJN78zTp3yhuX2uBNlP2x/
         HRyHG4cAV6ZTtxPaenctzmj0Pq9sKvvoqxtPJHqylQd5HMpPtXYOx5hv/ZYa4SzNQM2u
         60ET3V4A0leYRWzOS4NkH2fgTzkqt5NDbPz+7Np+i1Axv8NIcVThBMRAI+Xku58nBtRU
         TdwyN3oeI47MwbISm1AjdJXCkgsAeNazXWMDbqgQ5DsMesb6E1X6+bHyfS5zWzxXeJjt
         R6MjMmyPlQ3S7CkraQB89dqWvniXuEERdk1JSfXNGfhhTRbzAopTSAyDVqxCApCAgEJB
         MjMA==
Received: by 10.14.173.195 with SMTP id v43mr47320963eel.39.1351396515177;
        Sat, 27 Oct 2012 20:55:15 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id t7sm13223849eel.14.2012.10.27.20.55.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2012 20:55:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208525>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index 1689573..57e54c2 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -406,6 +406,12 @@ def parse_blob(parser):
     parser.next()
     return
 
+def get_merge_files(repo, p1, p2, files):
+    for e in repo[p1].files():
+        if e not in files:
+            f = { 'ctx' : repo[p1][e] }
+            files[e] = f
+
 def parse_commit(parser):
     global marks, blob_marks, bmarks, parsed_refs
 
@@ -450,6 +456,8 @@ def parse_commit(parser):
         of = files[f]
         if 'deleted' in of:
             raise IOError
+        if 'ctx' in of:
+            return of['ctx']
         is_exec = of['mode'] == 'x'
         is_link = of['mode'] == 'l'
         return context.memfilectx(f, of['data'], is_link, is_exec, None)
@@ -472,6 +480,13 @@ def parse_commit(parser):
     else:
         p2 = '\0' * 20
 
+    #
+    # If files changed from any of the parents, hg wants to know, but in git if
+    # nothing changed from the first parent, nothing changed.
+    #
+    if merge_mark:
+        get_merge_files(repo, p1, p2, files)
+
     ctx = context.memctx(repo, (p1, p2), data,
             files.keys(), getfilectx,
             user, (date, tz), extra)
-- 
1.8.0
