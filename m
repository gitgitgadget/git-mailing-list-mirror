From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 07/14] remote-hg: match hg merge behavior
Date: Tue, 30 Oct 2012 05:35:29 +0100
Message-ID: <1351571736-4682-8-git-send-email-felipe.contreras@gmail.com>
References: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 05:36:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT3Z7-0006Bb-0m
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 05:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569Ab2J3EgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 00:36:23 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56861 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab2J3EgV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 00:36:21 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2268812bkc.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 21:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FB+Iv/65ZcQ0c6L5yFfBx16HkB0mU273iB/6Vpq40kk=;
        b=xrNmcxaJWA0P3zKpuMC5xErq1WoWYXgx21SAZuLxoS54gMzbFQ03S373LdPPZ6EdAk
         KHd8gzYrQkoLKZEvtPoRvCuhzAkaHuMpc1dsKpEnsA1RwrY1+Ln8WlxKSrgBouuCva+G
         7ag+hZpsGs4jrSrwWKqNPNfxSD7kyrYNAovL9k1ZlhdQ5oxWkfdt1nrsdyiU/gtEaoMv
         2wgd08LQpC4UzzGN+9lPdA2TMVYyaqe97CeOt1V52487wY/TwNoYT+H4kHRBxLJMXwS4
         MRLbXz6fu+iNEAmb0cdhYYtxypH57nBkRt31YJpVKyJlQETQnLBXJneGzW+8X8MvvQf7
         z8TA==
Received: by 10.204.150.141 with SMTP id y13mr9646623bkv.1.1351571780657;
        Mon, 29 Oct 2012 21:36:20 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id ht18sm5171906bkc.14.2012.10.29.21.36.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 21:36:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208670>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index 29824be..c28f4b4 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -409,6 +409,12 @@ def parse_blob(parser):
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
 
@@ -453,6 +459,8 @@ def parse_commit(parser):
         of = files[f]
         if 'deleted' in of:
             raise IOError
+        if 'ctx' in of:
+            return of['ctx']
         is_exec = of['mode'] == 'x'
         is_link = of['mode'] == 'l'
         return context.memfilectx(f, of['data'], is_link, is_exec, None)
@@ -475,6 +483,13 @@ def parse_commit(parser):
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
