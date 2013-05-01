From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 06/18] remote-bzr: fixes for branch diverge
Date: Tue, 30 Apr 2013 20:09:58 -0500
Message-ID: <1367370610-14250-7-git-send-email-felipe.contreras@gmail.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 03:12:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXLae-0007HS-UH
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 03:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933834Ab3EABMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 21:12:08 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:54495 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933816Ab3EABMG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 21:12:06 -0400
Received: by mail-yh0-f41.google.com with SMTP id i57so211097yha.28
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 18:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=nGIKLX75JgXa8LWFo9LwefYs2HGM95EkPAO217Q6ofc=;
        b=H/C8PWcJTkLxkqBv05USlu7GRdjnJ5vJSUmImKyQ4XxXZO2SXYG9iKvYB+ktUwbBKK
         yNkHxGspHyu9VY/MkhfGCLpzvv//OMhaCCNb8lO0njKS1Zl6U2ZBY7pvyA4bWYttBUAS
         VHdARRMfCf3cfQ6/3JO5dUTbKfhdZRXvEFBmMIExAZDP2uhGyBJzz4LrvkpClcnIL6ef
         4WWZO5YETFzP61gvC+snhw2yeyhaVPQnTVwHFkAOlap2X1XCNGC6enMzgCzudRm9XlLI
         z19UrzGOi9VyYQJMA0t1JpQy96tvImmLDOcwvgt7rf3ElwadcKHogKgFbHvm+aSsAih5
         vgmQ==
X-Received: by 10.236.206.226 with SMTP id l62mr139185yho.189.1367370725347;
        Tue, 30 Apr 2013 18:12:05 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w62sm1107041yhd.27.2013.04.30.18.12.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 18:12:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
In-Reply-To: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223050>

If the branches diverge we want to reset the pointer to where the remote
actually is. Since we can access remote branches just as easily as local
ones, let's do so.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 6a7f836..bf254a0 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -354,6 +354,7 @@ def do_import(parser):
     if os.path.exists(path):
         print "feature import-marks=%s" % path
     print "feature export-marks=%s" % path
+    print "feature force"
     sys.stdout.flush()
 
     while parser.check('import'):
@@ -716,7 +717,12 @@ def get_repo(url, alias):
             # pull
             d = bzrlib.bzrdir.BzrDir.open(clone_path)
             branch = d.open_branch()
-            result = branch.pull(remote_branch, [], None, False)
+            try:
+                result = branch.pull(remote_branch, [], None, False)
+            except bzrlib.errors.DivergedBranches:
+                # use remote branch for now
+                peer = None
+                return remote_branch
         else:
             # clone
             d = origin.sprout(clone_path, None,
-- 
1.8.3.rc0.399.gc96a135
