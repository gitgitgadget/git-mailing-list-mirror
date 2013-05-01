From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 07/18] remote-bzr: fix partially pushed merge
Date: Tue, 30 Apr 2013 20:09:59 -0500
Message-ID: <1367370610-14250-8-git-send-email-felipe.contreras@gmail.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 03:12:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXLak-0007OG-PV
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 03:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934085Ab3EABMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 21:12:12 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:36510 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934056Ab3EABMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 21:12:09 -0400
Received: by mail-yh0-f48.google.com with SMTP id z12so212304yhz.21
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 18:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=LfgI3ygcvHf/b6rdQLfYJvvUmtJPt56fsLwQGXqDIDw=;
        b=G75+Oo1w6/43zm+nKe5/IAkeelCrdRWFbD8ZK2/jmsNwgFUSdaY5ZqDUgTk0cdy+/H
         4CbTR/Go2UvHMz/mLEo2jb3athMyzsCyi70WcjMsTsZBIfhjbPcaTOP4Nfr2ncyHA5tq
         St0jrey3UqRo/fnQO/JtbxcANmKYm6fXoDJGSVdkq+HHi8/TPVVuT9NHw0ltaAmyj2AL
         QxYPlIkST38LpVlgocKYlwpfa012kmu3L321Cmx/+ZIEea1O5aYLv+TE60sMg1Y7rk7u
         //8epWFT+dKGxouhq0ehGDUVcZVztntv2/zDgf78ZBuNNSEhBrySPCQH6JcwXdaf9YFI
         NZpA==
X-Received: by 10.236.111.112 with SMTP id v76mr703849yhg.20.1367370728629;
        Tue, 30 Apr 2013 18:12:08 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n15sm1660580yhi.2.2013.04.30.18.12.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 18:12:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
In-Reply-To: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223051>

If part of the merge was already pushed, we don't have the blob_marks
available, however, the commits are already stored in bazaar, so we can
use the revision_tree to fetch the contents.

We want to do this only when there's no other option.

There's no easy way to test this.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index bf254a0..fdead31 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -387,6 +387,7 @@ class CustomTree():
         global files_cache
 
         self.updates = {}
+        self.branch = repo
 
         def copy_tree(revid):
             files = files_cache[revid] = {}
@@ -515,13 +516,21 @@ class CustomTree():
 
         return changes
 
-    def get_file_with_stat(self, file_id, path=None):
+    def get_content(self, file_id):
         path, mark = self.rev_files[file_id]
-        return (StringIO.StringIO(blob_marks[mark]), None)
+        if mark:
+            return blob_marks[mark]
+
+        # last resort
+        tree = self.branch.repository.revision_tree(self.base_id)
+        return tree.get_file_text(file_id)
+
+    def get_file_with_stat(self, file_id, path=None):
+        content = self.get_content(file_id)
+        return (StringIO.StringIO(content), None)
 
     def get_symlink_target(self, file_id):
-        path, mark = self.rev_files[file_id]
-        return blob_marks[mark]
+        return self.get_content(file_id)
 
     def id2path(self, file_id):
         path, mark = self.rev_files[file_id]
-- 
1.8.3.rc0.399.gc96a135
