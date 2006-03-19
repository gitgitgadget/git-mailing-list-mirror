From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 1/3] git.el: More robust handling of subprocess errors when returning strings.
Date: Sun, 19 Mar 2006 10:05:22 +0100
Message-ID: <871wwydctp.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Mar 19 10:05:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKtr6-0006nG-G3
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 10:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWCSJFl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 04:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWCSJFl
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 04:05:41 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:43717 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751444AbWCSJFk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Mar 2006 04:05:40 -0500
Received: from adsl-84-226-35-143.adslplus.ch ([84.226.35.143] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FKtqn-0005D1-14
	for git@vger.kernel.org; Sun, 19 Mar 2006 03:05:32 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 2F9004F657; Sun, 19 Mar 2006 10:05:22 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
X-SA-Exim-Connect-IP: 84.226.35.143
X-SA-Exim-Mail-From: julliard@winehq.org
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=AWL,BAYES_00,
	RCVD_IN_NJABL_DUL,SPF_HELO_SOFTFAIL autolearn=no version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17709>

Make sure that functions that call a git process and return a string
always return nil when the subprocess failed.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>

---

 contrib/emacs/git.el |   29 +++++++++++++----------------
 1 files changed, 13 insertions(+), 16 deletions(-)

66a8d3c3e63a2d4178c9917e0c172bdc2cbec3bb
diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 5135e36..cf650da 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -148,6 +148,12 @@ The default is to fall back to `add-log-
              (append (git-get-env-strings env) (list "git") args))
     (apply #'call-process "git" nil buffer nil args)))
 
+(defun git-call-process-env-string (env &rest args)
+  "Wrapper for call-process that sets environment strings, and returns the process output as a string."
+  (with-temp-buffer
+    (and (eq 0 (apply #' git-call-process-env t env args))
+         (buffer-string))))
+
 (defun git-run-process-region (buffer start end program args)
   "Run a git process with a buffer region as input."
   (let ((output-buffer (current-buffer))
@@ -189,8 +195,9 @@ The default is to fall back to `add-log-
 
 (defun git-get-string-sha1 (string)
   "Read a SHA1 from the specified string."
-  (let ((pos (string-match "[0-9a-f]\\{40\\}" string)))
-    (and pos (substring string pos (match-end 0)))))
+  (and string
+       (string-match "[0-9a-f]\\{40\\}" string)
+       (match-string 0 string)))
 
 (defun git-get-committer-name ()
   "Return the name to use as GIT_COMMITTER_NAME."
@@ -259,18 +266,12 @@ The default is to fall back to `add-log-
 (defun git-rev-parse (rev)
   "Parse a revision name and return its SHA1."
   (git-get-string-sha1
-   (with-output-to-string
-     (with-current-buffer standard-output
-       (git-call-process-env t nil "rev-parse" rev)))))
+   (git-call-process-env-string nil "rev-parse" rev)))
 
 (defun git-symbolic-ref (ref)
   "Wrapper for the git-symbolic-ref command."
-  (car
-   (split-string
-    (with-output-to-string
-      (with-current-buffer standard-output
-        (git-call-process-env t nil "symbolic-ref" ref)))
-    "\n")))
+  (let ((str (git-call-process-env-string nil "symbolic-ref" ref)))
+    (and str (car (split-string str "\n")))))
 
 (defun git-update-ref (ref val &optional oldval)
   "Update a reference by calling git-update-ref."
@@ -285,11 +286,7 @@ The default is to fall back to `add-log-
 (defun git-write-tree (&optional index-file)
   "Call git-write-tree and return the resulting tree SHA1 as a string."
   (git-get-string-sha1
-   (with-output-to-string
-     (with-current-buffer standard-output
-       (git-call-process-env t
-        (if index-file `(("GIT_INDEX_FILE" . ,index-file)) nil)
-        "write-tree")))))
+   (git-call-process-env-string (and index-file `(("GIT_INDEX_FILE" . ,index-file))) "write-tree")))
 
 (defun git-commit-tree (buffer tree head)
   "Call git-commit-tree with buffer as input and return the resulting commit SHA1."
-- 
1.2.4.g9c5a7

-- 
Alexandre Julliard
julliard@winehq.org
