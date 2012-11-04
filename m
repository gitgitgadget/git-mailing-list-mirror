From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 15/16] remote-hg: add option to not track branches
Date: Sun,  4 Nov 2012 03:13:37 +0100
Message-ID: <1351995218-19889-16-git-send-email-felipe.contreras@gmail.com>
References: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 03:15:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUpjq-0002tS-VW
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860Ab2KDCOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 22:14:48 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62548 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809Ab2KDCOr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:14:47 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1657497bkc.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7tF9EaSDOavjN8j16gVuh9OrjH7A1N1zn1s5KBC1VyI=;
        b=a6YSG17dqACTLXWteFbY0/F0RNBYKHndUIbCpLs6gjgVEDf8qyl3DAE6Ib0dRgp7Vg
         DeolxR3lm8kQgONfXxxrC/2rBfjWeYKAHNzMl80aHgYtlkKmXvcBEX07xMcl8ln9Qcfa
         +3sqO/IeGOBR/+HrskMLGnqKpnq4pPe//mJWHiv7JPYkYshP3oqhsbjyLZiax/tF6oA2
         DRKcOMWUSkfB55mgqSswAjxpgfFrX6O41rW1qGsfkaSpb+HfvB5wkGjAkXUntooXjInc
         nTA5ZDIdYHdrLcG+xn9vB0AsUo025Q7PBlRX9VSn85whoBQ5zRf+Tt+Id7opT3ZXKqs0
         vUrA==
Received: by 10.204.148.21 with SMTP id n21mr1439236bkv.124.1351995286932;
        Sat, 03 Nov 2012 19:14:46 -0700 (PDT)
Received: from localhost (ip-109-43-0-39.web.vodafone.de. [109.43.0.39])
        by mx.google.com with ESMTPS id g8sm7941611bkv.6.2012.11.03.19.14.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 19:14:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209003>

Some people prefer it this way.

 % git config --global remote-hg.track-branches false

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index dbe309a..a9ae844 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -449,14 +449,9 @@ def list_head(repo, cur):
     g_head = (head, node)
 
 def do_list(parser):
-    global branches, bmarks, mode
+    global branches, bmarks, mode, track_branches
 
     repo = parser.repo
-    for branch in repo.branchmap():
-        heads = repo.branchheads(branch)
-        if len(heads):
-            branches[branch] = heads
-
     for bmark, node in bookmarks.listbookmarks(repo).iteritems():
         bmarks[bmark] = repo[node]
 
@@ -464,7 +459,12 @@ def do_list(parser):
 
     list_head(repo, cur)
 
-    if mode != 'hg':
+    if track_branches:
+        for branch in repo.branchmap():
+            heads = repo.branchheads(branch)
+            if len(heads):
+                branches[branch] = heads
+
         for branch in branches:
             print "? refs/heads/branches/%s" % branch
 
@@ -713,16 +713,22 @@ def main(args):
     global prefix, dirname, branches, bmarks
     global marks, blob_marks, parsed_refs
     global peer, mode, bad_mail, bad_name
+    global track_branches
 
     alias = args[1]
     url = args[2]
     peer = None
 
-    cmd = ['git', 'config', '--get', 'remote-hg.hg-git-compat']
     hg_git_compat = False
+    track_branches = True
     try:
+        cmd = ['git', 'config', '--get', 'remote-hg.hg-git-compat']
         if subprocess.check_output(cmd) == 'true\n':
             hg_git_compat = True
+            track_branches = False
+        cmd = ['git', 'config', '--get', 'remote-hg.track-branches']
+        if subprocess.check_output(cmd) == 'false\n':
+            track_branches = False
     except subprocess.CalledProcessError:
         pass
 
-- 
1.8.0
