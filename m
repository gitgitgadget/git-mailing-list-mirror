From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git.el: Define the propertize function if needed, for XEmacs compatibility.
Date: Tue, 09 Jan 2007 21:27:40 +0100
Message-ID: <877ivw0wub.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 09 21:27:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4NZX-0002ua-Pb
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 21:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbXAIU1t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 15:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbXAIU1t
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 15:27:49 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:53774 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbXAIU1t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 15:27:49 -0500
Received: from adsl-84-226-97-216.adslplus.ch ([84.226.97.216] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1H4NZT-0005IN-LU
	for git@vger.kernel.org; Tue, 09 Jan 2007 14:27:48 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id A63E24F6AD; Tue,  9 Jan 2007 21:27:40 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36396>

Also use `concat' instead of `format' in the pretty-printer since
format doesn't preserve properties under XEmacs.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index ede3ab2..d90ba81 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -280,6 +280,15 @@ and returns the process output as a string."
     (git-run-command nil nil "update-index" "--info-only" "--add" "--" (file-relative-name ignore-name)))
   (git-add-status-file (if created 'added 'modified) (file-relative-name ignore-name))))
 
+; propertize definition for XEmacs, stolen from erc-compat
+(eval-when-compile
+  (unless (fboundp 'propertize)
+    (defun propertize (string &rest props)
+      (let ((string (copy-sequence string)))
+        (while props
+          (put-text-property 0 (length string) (nth 0 props) (nth 1 props) string)
+          (setq props (cddr props)))
+        string))))
 
 ;;;; Wrappers for basic git commands
 ;;;; ------------------------------------------------------------
@@ -448,11 +457,10 @@ and returns the process output as a string."
 
 (defun git-fileinfo-prettyprint (info)
   "Pretty-printer for the git-fileinfo structure."
-  (insert (format "   %s %s %s  %s%s"
-                  (if (git-fileinfo->marked info) (propertize "*" 'face 'git-mark-face) " ")
-                  (git-status-code-as-string (git-fileinfo->state info))
-                  (git-permissions-as-string (git-fileinfo->old-perm info) (git-fileinfo->new-perm info))
-                  (git-escape-file-name (git-fileinfo->name info))
+  (insert (concat "   " (if (git-fileinfo->marked info) (propertize "*" 'face 'git-mark-face) " ")
+                  " " (git-status-code-as-string (git-fileinfo->state info))
+                  " " (git-permissions-as-string (git-fileinfo->old-perm info) (git-fileinfo->new-perm info))
+                  "  " (git-escape-file-name (git-fileinfo->name info))
                   (git-rename-as-string info))))
 
 (defun git-parse-status (status)
-- 
1.4.4.4.g37ed

-- 
Alexandre Julliard
julliard@winehq.org
