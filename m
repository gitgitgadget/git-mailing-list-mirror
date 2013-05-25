From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/8] remote-bzr: recover from failed clones
Date: Fri, 24 May 2013 21:24:19 -0500
Message-ID: <1369448666-17515-2-git-send-email-felipe.contreras@gmail.com>
References: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:26:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4BR-0006M3-Gc
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718Ab3EYC0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:26:08 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:37662 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab3EYC0H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:26:07 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so6193735obc.26
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9A/3ZxH+0ine98zZVToCDTKy71v06T6gQugU/FOvecU=;
        b=iI0geXv2cmY0Sc0K/bwVlTc30VA50ACON0HhKpcZA95Nx/ngYwlLGxycw1uPlqSM/e
         cB3kAla4PB6GWvQBDTsT006X9LfFJOAA44DoT5uGTecb/V4r3MVCpzFcO1PN/RBLXSR+
         uGZ8ZGIOlTH57X6VTHdHtvfdbvHyRuAdqZrpF9kzpyG+Qk2A+imSZTeJlV5QXWLpcrWH
         MLM+KtfqZzNqjmGQldAwMABwhxqXcH1VP5Snge3rfflrwVRys5bj2V8Cxvu/g3+zx3bF
         6WXBgbYSTYLmYZY9xpQmfbmyzGx8oijg4rpOfo8gaXW5UOXJo3BN2gzPrTw1/pA4K0SQ
         WJrA==
X-Received: by 10.182.233.227 with SMTP id tz3mr13661142obc.23.1369448767109;
        Fri, 24 May 2013 19:26:07 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id q4sm20097816obl.1.2013.05.24.19.26.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:26:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225406>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 10300c6..8a4df51 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -769,22 +769,24 @@ def get_remote_branch(origin, remote_branch, name):
     global dirname, peers
 
     branch_path = os.path.join(dirname, 'clone', name)
-    if os.path.exists(branch_path):
-        # pull
+
+    try:
         d = bzrlib.bzrdir.BzrDir.open(branch_path)
         branch = d.open_branch()
-        try:
-            branch.pull(remote_branch, [], None, False)
-        except bzrlib.errors.DivergedBranches:
-            # use remote branch for now
-            return remote_branch
-    else:
+    except bzrlib.errors.NotBranchError:
         # clone
         d = origin.sprout(branch_path, None,
                 hardlink=True, create_tree_if_local=False,
                 force_new_repo=False,
                 source_branch=remote_branch)
         branch = d.open_branch()
+    else:
+        # pull
+        try:
+            branch.pull(remote_branch, [], None, False)
+        except bzrlib.errors.DivergedBranches:
+            # use remote branch for now
+            return remote_branch
 
     return branch
 
-- 
1.8.3.rc3.312.g47657de
