From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/8] remote-bzr: recover from failed clones
Date: Thu, 16 May 2013 03:36:40 -0500
Message-ID: <1368693407-21267-2-git-send-email-felipe.contreras@gmail.com>
References: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 10:38:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucthy-0000N5-3b
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756774Ab3EPIic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:38:32 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:57267 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756737Ab3EPIi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 04:38:28 -0400
Received: by mail-ob0-f170.google.com with SMTP id er7so3124054obc.1
        for <git@vger.kernel.org>; Thu, 16 May 2013 01:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=IM7wgxxLtfDguceWj1YFKRxxQeCH+vZAy8UKm6fxbM4=;
        b=mQtm8Ts7gdmfq/9GFYVAkurDwMVtPzDbeOQM61BH5YGQNqjD1FnvIXlAhD/F4smEJ7
         9K90IaNdlbEMmHWhHm6ZvrWVgKqGGxbT1qYkl5POoPPn5iljcPA+TFrLPUxh7T0H7rWO
         2zrlgmyib/vF1y6A8RFEfTc6NB+XWYkcN++vdMwSvwPOkiVde3zygc5LeTJ7V1lCJz+j
         Ji6AcrnhyLKV41l94jrTdeAYBia2lPOqdwWgZoKSp0qFFemNdtKLDP/b5k2yrezAh8im
         sFuOYuZzJ/MMcb3bcH9Dq/adBDXkB6oybMrvi377fMFiJAOrDvjD71GIR3YihrvcjSOL
         oV4A==
X-Received: by 10.60.47.1 with SMTP id z1mr22005875oem.134.1368693508427;
        Thu, 16 May 2013 01:38:28 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x5sm7157659oep.1.2013.05.16.01.38.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 01:38:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224503>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index b295dd4..7cd9ed8 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -768,22 +768,24 @@ def get_remote_branch(origin, remote_branch, name):
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
1.8.3.rc2.542.g24820ba
