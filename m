From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 3/3] git.el: Display file types and type changes.
Date: Sun, 06 Jan 2008 12:13:36 +0100
Message-ID: <87y7b36wbj.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 12:14:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBTSE-0001ZS-6l
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 12:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbYAFLNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 06:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753290AbYAFLNm
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 06:13:42 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:59767 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbYAFLNl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 06:13:41 -0500
Received: from adsl-84-227-6-44.adslplus.ch ([84.227.6.44] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1JBTRj-0004jH-8t
	for git@vger.kernel.org; Sun, 06 Jan 2008 05:13:40 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id F16BE1E7149; Sun,  6 Jan 2008 12:13:36 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69728>

Handle the T status from git-diff-index to display type changes
between file/symlink/subproject. Also always show the file type for
symlink and subprojects to indicate that they are not normal files.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   34 +++++++++++++++++++++++++++++++---
 1 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 820df11..5f0d461 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -489,8 +489,7 @@ and returns the process output as a string."
   "Set the state of a file info."
   (unless (eq (git-fileinfo->state info) state)
     (setf (git-fileinfo->state info) state
-          (git-fileinfo->old-perm info) 0
-          (git-fileinfo->new-perm info) 0
+          (git-fileinfo->new-perm info) (git-fileinfo->old-perm info)
           (git-fileinfo->rename-state info) nil
           (git-fileinfo->orig-name info) nil
           (git-fileinfo->needs-refresh info) t)))
@@ -524,6 +523,7 @@ and returns the process output as a string."
     (?A 'added)
     (?D 'deleted)
     (?U 'unmerged)
+    (?T 'modified)
     (t nil)))
 
 (defun git-status-code-as-string (code)
@@ -538,6 +538,33 @@ and returns the process output as a string."
     ('ignored  (propertize "Ignored " 'face 'git-ignored-face))
     (t "?       ")))
 
+(defun git-file-type-as-string (info)
+  "Return a string describing the file type of INFO."
+  (let* ((old-type (lsh (or (git-fileinfo->old-perm info) 0) -9))
+         (new-type (lsh (or (git-fileinfo->new-perm info) 0) -9))
+         (str (case new-type
+                (?\100  ;; file
+                 (case old-type
+                   (?\100 nil)
+                   (?\120 "   (type change symlink -> file)")
+                   (?\160 "   (type change subproject -> file)")))
+                 (?\120  ;; symlink
+                  (case old-type
+                    (?\100 "   (type change file -> symlink)")
+                    (?\160 "   (type change subproject -> symlink)")
+                    (t "   (symlink)")))
+                  (?\160  ;; subproject
+                   (case old-type
+                     (?\100 "   (type change file -> subproject)")
+                     (?\120 "   (type change symlink -> subproject)")
+                     (t "   (subproject)")))
+                  (?\000  ;; deleted or unknown
+                   (case old-type
+                     (?\120 "   (symlink)")
+                     (?\160 "   (subproject)")))
+                  (t (format "   (unknown type %o)" new-type)))))
+    (if str (propertize str 'face 'git-status-face) "")))
+
 (defun git-rename-as-string (info)
   "Return a string describing the copy or rename associated with INFO, or an empty string if none."
   (let ((state (git-fileinfo->rename-state info)))
@@ -567,6 +594,7 @@ and returns the process output as a string."
                   " " (git-status-code-as-string (git-fileinfo->state info))
                   " " (git-permissions-as-string (git-fileinfo->old-perm info) (git-fileinfo->new-perm info))
                   "  " (git-escape-file-name (git-fileinfo->name info))
+                  (git-file-type-as-string info)
                   (git-rename-as-string info))))
 
 (defun git-insert-info-list (status infolist)
@@ -603,7 +631,7 @@ Return the list of files that haven't been handled."
       (apply #'git-call-process-env t nil "diff-index" "-z" "-M" "HEAD" "--" files)
       (goto-char (point-min))
       (while (re-search-forward
-              ":\\([0-7]\\{6\\}\\) \\([0-7]\\{6\\}\\) [0-9a-f]\\{40\\} [0-9a-f]\\{40\\} \\(\\([ADMU]\\)\0\\([^\0]+\\)\\|\\([CR]\\)[0-9]*\0\\([^\0]+\\)\0\\([^\0]+\\)\\)\0"
+              ":\\([0-7]\\{6\\}\\) \\([0-7]\\{6\\}\\) [0-9a-f]\\{40\\} [0-9a-f]\\{40\\} \\(\\([ADMUT]\\)\0\\([^\0]+\\)\\|\\([CR]\\)[0-9]*\0\\([^\0]+\\)\0\\([^\0]+\\)\\)\0"
               nil t 1)
         (let ((old-perm (string-to-number (match-string 1) 8))
               (new-perm (string-to-number (match-string 2) 8))
-- 
1.5.4.rc2.53.gb6f8

-- 
Alexandre Julliard
julliard@winehq.org
