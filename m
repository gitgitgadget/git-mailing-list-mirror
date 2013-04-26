From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/20] remote-bzr: fix partially pushed merge
Date: Thu, 25 Apr 2013 20:07:55 -0500
Message-ID: <1366938488-25425-8-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:09:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXAf-0003jO-Of
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664Ab3DZBJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:09:45 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:51876 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758523Ab3DZBJn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:09:43 -0400
Received: by mail-oa0-f45.google.com with SMTP id o17so3527424oag.32
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=QUqzWWY7iJ5epZD8GI3l3OThJycrFT/QzmSkWdQ1asY=;
        b=Ar2acnwqMIIbN1tIjoA5TZQuO+U6UpMTsLudcscPv2KtcWcbvn/vM2pmtnIvs59yRY
         K0zQODLRExB1BYJkseYH2vhoA3ZU7RJrmtQplk1hbHmcylnJUg40XO8iusWDpaxt4apW
         8DwdaIIGF93GmRNJaiclp/bR4F6NXPOTUceqWgVQcL0YHgz2JFplvoiVBJe6STJKbL6w
         IfMY9Ht1pBveTO/BleAJokmofhUHr1gs4l8Os38XGVnpXhvIhN30A29PDjVYlkrK17Fs
         YeLSv8hVGQ0edDYDE881bZX5B+mVuIB5DwYv2YtW7sh1awsBJN7hFnnHt0RArt8JuiFY
         JnFQ==
X-Received: by 10.60.33.105 with SMTP id q9mr20265004oei.54.1366938583462;
        Thu, 25 Apr 2013 18:09:43 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ru4sm5858780obb.4.2013.04.25.18.09.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:09:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222490>

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
1.8.2.1.884.g3532a8d
