From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 14/20] remote-bzr: add custom method to find branches
Date: Thu, 25 Apr 2013 20:08:02 -0500
Message-ID: <1366938488-25425-15-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:10:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXB2-000481-Ey
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932889Ab3DZBKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:10:07 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:38081 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932853Ab3DZBKD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:10:03 -0400
Received: by mail-ob0-f181.google.com with SMTP id ta17so3114974obb.12
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=OLunS90FzPOz5HD5XtAjeAmXYqulxofn4XJVlGHlhc4=;
        b=oYgJy0NGdxCNs4SNglAEmrKCgEUuP5tV/zD6PHoFT1b+xi/TtNq/xRUtUKJQKQNTBC
         m8jJs3YDjqo1Dl666IvEeLHpM153Cda5NvQkx5v9vdgY0Zlo0JC7eo05+IDAV5TYqvhJ
         F8aeo4FJwR2AQWHpCwRBzjwBtBhUHLU49FwEFUkRr5sbAvP3gJwlg7T45NEr4exqPMz3
         BDMKqEU+GjnWPV1tlqCm12jgPBKCyLXQypnKOOOZ+gnDM8ak1WFHevupNCoLaKs7Hsz0
         R3sskT2z8HZO1TcBmq2H3tMyWV7PNCTMZeVVFiUuZGDMZk576k+Xe44+fPf7Nn5L3P5z
         qYdg==
X-Received: by 10.60.150.175 with SMTP id uj15mr14248527oeb.82.1366938603454;
        Thu, 25 Apr 2013 18:10:03 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id zc8sm5855970obc.8.2013.04.25.18.10.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:10:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222496>

The official method is incredibly inefficient and slow.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 5c25b06..5155b93 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -779,6 +779,25 @@ def get_remote_branch(origin, remote_branch, name):
 
     return branch
 
+def find_branches(repo):
+    transport = repo.user_transport
+
+    for fn in transport.iter_files_recursive():
+        if not fn.endswith('.bzr/branch-format'):
+            continue
+
+        name = subdir = fn[:-len('/.bzr/branch-format')]
+        name = name if name != '' else 'master'
+        name = name.replace('/', '+')
+
+        try:
+            cur = transport.clone(subdir)
+            branch = bzrlib.branch.Branch.open_from_transport(cur)
+        except bzrlib.errors.NotBranchError:
+            continue
+        else:
+            yield name, branch
+
 def get_repo(url, alias):
     global dirname, peer, branches
 
@@ -819,11 +838,7 @@ def get_repo(url, alias):
     else:
         # repository
 
-        for branch in repo.find_branches():
-
-            name = repo.user_transport.relpath(branch.base)
-            name = name if name != '' else 'master'
-            name = name.replace('/', '+')
+        for name, branch in find_branches(repo):
 
             if not is_local:
                 peers[name] = branch
-- 
1.8.2.1.884.g3532a8d
