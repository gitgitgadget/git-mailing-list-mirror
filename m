From: Curt Brune <curt@brune.net>
Subject: [PATCH] . git.el: use commit.template if available
Date: Fri, 14 Jun 2013 10:25:35 -0700
Message-ID: <20130614172535.GA24983@higgs.cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: julliard@winehq.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 14 19:25:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnXkt-0005DL-84
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 19:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616Ab3FNRZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 13:25:39 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:51731 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578Ab3FNRZi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 13:25:38 -0400
Received: by mail-pd0-f171.google.com with SMTP id y14so789436pdi.16
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 10:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:x-gm-message-state;
        bh=RZklzYvx71IHDwP70B9prqySAUnGeWMmeB9EPtZ+jWU=;
        b=lPx13O+2XbD99rxGOvmwrA9YOQPsnXc3E6uBrGdbC0+xwFrRjdowUiiy+wnlVhoDGO
         oyXXm3ZJjA1EM8JkxcFP1aJltGH4ik7Kv/AeYawp8CQbuRcVWiPA6syN/MCi0q5W3vnq
         SUTeA6Z1UVFsrklgiI1+Ihqpa5AO9lsxq+v/Ov06U+7kFAXEMUyxyN9cfFVMBPOThoqX
         P91VrE2B67uo/FRHh5DofNRMYS4xg6pdJdoAmuY+lczzQpny0ScKl2BQ582/pKoaKFiG
         S4qlvF+FmFx1X4z5J9ZUyOqj9DIW/5Jx+upVe13DQC9zKXI9A89PZDIMJW4+HTaKgI+v
         qiBg==
X-Received: by 10.68.185.162 with SMTP id fd2mr3494832pbc.176.1371230738282;
        Fri, 14 Jun 2013 10:25:38 -0700 (PDT)
Received: from localhost ([157.22.42.200])
        by mx.google.com with ESMTPSA id o10sm2960551pbq.39.2013.06.14.10.25.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 10:25:37 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQniMjEOPbRqkZ9wfTuJHndj4NhUac/fQMjaKtuXBVW6VY3iGKdMeZYmEug2v4dmat8+n4NY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227902>


If the user's git config defines commit.template then include the
contents of that file in the log buffer by default.

In git-setup-log-buffer, instead of supplying the default commit
message insert the user's commit.template.

Signed-off-by: Curt Brune <curt@brune.net>
---
 contrib/emacs/git.el |   47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 5ffc506..827578f 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -296,6 +296,11 @@ the process output as a string, or nil if the git command failed."
       (and (fboundp 'user-mail-address) (user-mail-address))
       (and (boundp 'user-mail-address) user-mail-address)))
 
+(defun git-get-commit-template ()
+  "Return the git commit template or nil"
+  ; copied from log-edit
+  (git-config "commit.template"))
+
 (defun git-get-commits-coding-system ()
   "Return the coding system to use for commits."
   (let ((repo-config (git-config "i18n.commitencoding")))
@@ -1280,29 +1285,33 @@ The FILES list must be sorted."
   (let ((dir default-directory)
         (committer-name (git-get-committer-name))
         (committer-email (git-get-committer-email))
+        (commit-template (git-get-commit-template))
         (sign-off git-append-signed-off-by))
     (with-current-buffer buffer
       (cd dir)
       (erase-buffer)
-      (insert
-       (propertize
-        (format "Author: %s <%s>\n%s%s"
-                (or author-name committer-name)
-                (or author-email committer-email)
-                (if date (format "Date: %s\n" date) "")
-                (if merge-heads
-                    (format "Merge: %s\n"
-                            (mapconcat 'identity merge-heads " "))
-                  ""))
-        'face 'git-header-face)
-       (propertize git-log-msg-separator 'face 'git-separator-face)
-       "\n")
-      (when subject (insert subject "\n\n"))
-      (cond (msg (insert msg "\n"))
-            ((file-readable-p ".git/rebase-apply/msg")
-             (insert-file-contents ".git/rebase-apply/msg"))
-            ((file-readable-p ".git/MERGE_MSG")
-             (insert-file-contents ".git/MERGE_MSG")))
+      (if commit-template
+	  (insert-file-contents commit-template)
+	(progn
+          (insert
+           (propertize
+            (format "Author: %s <%s>\n%s%s"
+                    (or author-name committer-name)
+                    (or author-email committer-email)
+                    (if date (format "Date: %s\n" date) "")
+                    (if merge-heads
+                        (format "Merge: %s\n"
+                                (mapconcat 'identity merge-heads " "))
+                      ""))
+            'face 'git-header-face)
+           (propertize git-log-msg-separator 'face 'git-separator-face)
+           "\n")
+          (when subject (insert subject "\n\n"))
+          (cond (msg (insert msg "\n"))
+                ((file-readable-p ".git/rebase-apply/msg")
+                 (insert-file-contents ".git/rebase-apply/msg"))
+                ((file-readable-p ".git/MERGE_MSG")
+                 (insert-file-contents ".git/MERGE_MSG")))))
       ; delete empty lines at end
       (goto-char (point-min))
       (when (re-search-forward "\n+\\'" nil t)
-- 
1.7.9.5
