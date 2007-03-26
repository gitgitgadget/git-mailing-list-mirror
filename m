From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git.el: Display some information about the HEAD commit.
Date: Mon, 26 Mar 2007 12:16:16 +0200
Message-ID: <874po848en.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 12:16:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVmFb-0002VN-W8
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 12:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbXCZKQW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 06:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbXCZKQW
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 06:16:22 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:48986 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbXCZKQV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 06:16:21 -0400
Received: from adsl-84-227-31-197.adslplus.ch ([84.227.31.197] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HVmFP-0006Mz-Mp
	for git@vger.kernel.org; Mon, 26 Mar 2007 04:16:20 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 04B5B4F61D; Mon, 26 Mar 2007 12:16:17 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43147>

Use git-log --pretty=oneline to print a short description of the
current HEAD (and merge heads if any) in the buffer header.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 5f22dec..2f9995e 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -263,6 +263,16 @@ and returns the process output as a string."
              (locale-charset-to-coding-system repo-config))
       'utf-8)))
 
+(defun git-get-logoutput-coding-system ()
+  "Return the coding system used for git-log output."
+  (let ((repo-config (or (git-config "i18n.logoutputencoding")
+                         (git-config "i18n.commitencoding"))))
+    (or git-commits-coding-system
+        (and repo-config
+             (fboundp 'locale-charset-to-coding-system)
+             (locale-charset-to-coding-system repo-config))
+      'utf-8)))
+
 (defun git-escape-file-name (name)
   "Escape a file name if necessary."
   (if (string-match "[\n\t\"\\]" name)
@@ -406,6 +416,14 @@ and returns the process output as a string."
           (push (match-string 0) heads))))
     (nreverse heads)))
 
+(defun git-get-commit-description (commit)
+  "Get a one-line description of COMMIT."
+  (let ((coding-system-for-read (git-get-logoutput-coding-system)))
+    (let ((descr (git-call-process-env-string nil "log" "--max-count=1" "--pretty=oneline" commit)))
+      (if (and descr (string-match "\\`\\([0-9a-f]\\{40\\}\\) *\\(.*\\)$" descr))
+          (concat (substring (match-string 1 descr) 0 10) " - " (match-string 2 descr))
+        descr))))
+
 ;;;; File info structure
 ;;;; ------------------------------------------------------------
 
@@ -573,7 +591,7 @@ and returns the process output as a string."
   "Refresh the ewoc header and footer."
   (let ((branch (git-symbolic-ref "HEAD"))
         (head (if (git-empty-db-p) "Nothing committed yet"
-                (substring (git-rev-parse "HEAD") 0 10)))
+                (git-get-commit-description "HEAD")))
         (merge-heads (git-get-merge-heads)))
     (ewoc-set-hf status
                  (format "Directory:  %s\nBranch:     %s\nHead:       %s%s\n"
@@ -584,7 +602,7 @@ and returns the process output as a string."
                          head
                          (if merge-heads
                              (concat "\nMerging:    "
-                                     (mapconcat (lambda (str) (substring str 0 10)) merge-heads " "))
+                                     (mapconcat (lambda (str) (git-get-commit-description str)) merge-heads "\n            "))
                            ""))
                  (if (ewoc-nth status 0) "" "    No changes."))))
 
-- 
1.5.1.rc2.2.g6da42

-- 
Alexandre Julliard
julliard@winehq.org
