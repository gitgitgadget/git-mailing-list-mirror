From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 06/16] remote-hg: match hg merge behavior
Date: Sun,  4 Nov 2012 03:13:28 +0100
Message-ID: <1351995218-19889-7-git-send-email-felipe.contreras@gmail.com>
References: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 03:14:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUpjS-0002Xh-4y
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416Ab2KDCON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 22:14:13 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62548 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab2KDCOL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:14:11 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1657497bkc.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1VQp8+v9bxUKiq6g4O85V/2H0vX5bYpr/kEhkleMgkA=;
        b=juYTpkqRrIROwh2o6QblcSIp5XRFsqKh4ZkgG9AUP3BT+tmUy/B3njteGP5KMZBWN6
         mXiEtdD7txTaZGJFzNdpwinwsS5eHB1hFY2AuLZAmCCliSOzJHPI5aRViWD83tdtUHZp
         6t7ZV75HZUCWRw9AmlXRo7IRjL1yiVEoeZSnksN6bXGL2NWr6lgCTaAnohBrsMMQKW0h
         oGZMAvirbP5OJxhkpJ8ZIfUCho4lKV3gba+EOqj5YwzWlyvNKCVQ7cVF181gR6RFkQhj
         YV8ziN3sTspJ0Scckd3hKr7SJ0Z5Lhi72ri2HxJAHGa8L7yZl4DXReRUD3Jch5aViXZm
         r0vw==
Received: by 10.204.157.144 with SMTP id b16mr1399577bkx.19.1351995250924;
        Sat, 03 Nov 2012 19:14:10 -0700 (PDT)
Received: from localhost (ip-109-43-0-39.web.vodafone.de. [109.43.0.39])
        by mx.google.com with ESMTPS id 1sm7942619bks.3.2012.11.03.19.14.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 19:14:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208997>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 503a9fc..247b7cb 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -427,6 +427,14 @@ def parse_blob(parser):
     parser.next()
     return
 
+def get_merge_files(repo, p1, p2, files):
+    for e in repo[p1].files():
+        if e not in files:
+            if e not in repo[p1].manifest():
+                continue
+            f = { 'ctx' : repo[p1][e] }
+            files[e] = f
+
 def parse_commit(parser):
     global marks, blob_marks, bmarks, parsed_refs
 
@@ -470,6 +478,8 @@ def parse_commit(parser):
         of = files[f]
         if 'deleted' in of:
             raise IOError
+        if 'ctx' in of:
+            return of['ctx']
         is_exec = of['mode'] == 'x'
         is_link = of['mode'] == 'l'
         return context.memfilectx(f, of['data'], is_link, is_exec, None)
@@ -492,6 +502,13 @@ def parse_commit(parser):
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
