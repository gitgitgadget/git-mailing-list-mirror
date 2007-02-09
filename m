From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH 5/7] git-blame.el: blame unsaved changes
Date: Fri, 09 Feb 2007 09:21:32 +0100
Message-ID: <87mz3npwqb.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 09:45:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFRNZ-0005uR-C0
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 09:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946223AbXBIIpK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 9 Feb 2007 03:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946228AbXBIIpJ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 03:45:09 -0500
Received: from main.gmane.org ([80.91.229.2]:51580 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946223AbXBIIpH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 03:45:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HFRNO-0000F9-JG
	for git@vger.kernel.org; Fri, 09 Feb 2007 09:45:03 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 09:45:02 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 09:45:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:SFuKme1G2KqIBwCcHR7hF/w9uuw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39164>

Make git-blame use the current buffer contents for the blame, instead o=
f
the saved file.  This makes the blame correct even if there are unsaved
changes.

Also added a git-reblame command.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 contrib/emacs/git-blame.el |   65 +++++++++++++++++++++++++++++-------=
-------
 1 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 7ffc153..f183964 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -102,8 +102,17 @@
=20
 (defvar git-blame-ancient-color "dark green")
=20
-(defvar git-blame-overlays nil)
-(defvar git-blame-cache nil)
+(defvar git-blame-proc nil
+  "The running git-blame process")
+(make-variable-buffer-local 'git-blame-proc)
+
+(defvar git-blame-overlays nil
+  "The git-blame overlays used in the current buffer.")
+(make-variable-buffer-local 'git-blame-overlays)
+
+(defvar git-blame-cache nil
+  "A cache of git-blame information for the current buffer")
+(make-variable-buffer-local 'git-blame-cache)
=20
 (defvar git-blame-mode nil)
 (make-variable-buffer-local 'git-blame-mode)
@@ -118,9 +127,7 @@
   (if arg
       (setq git-blame-mode (eq arg 1))
     (setq git-blame-mode (not git-blame-mode)))
-  (make-local-variable 'git-blame-overlays)
   (make-local-variable 'git-blame-colors)
-  (make-local-variable 'git-blame-cache)
   (git-blame-cleanup)
   (if git-blame-mode
       (progn
@@ -131,24 +138,37 @@
         (setq git-blame-cache (make-hash-table :test 'equal))
         (git-blame-run))))
=20
+;;;###autoload
+(defun git-reblame ()
+  "Recalculate all blame information in the current buffer"
+  (unless git-blame-mode
+    (error "git-blame is not active"))
+  (interactive)
+  (git-blame-cleanup)
+  (git-blame-run))
+
 (defun git-blame-run ()
-  (let* ((display-buf (current-buffer))
-         (blame-buf (get-buffer-create
-                     (concat " git blame for " (buffer-name))))
-         (proc (start-process "git-blame" blame-buf
-                             "git" "blame" "--incremental"
-                             (file-name-nondirectory buffer-file-name)=
)))
-    (mapcar 'delete-overlay git-blame-overlays)
-    (setq git-blame-overlays nil)
-    (setq git-blame-cache (make-hash-table :test 'equal))
-    (with-current-buffer blame-buf
-      (erase-buffer)
-      (make-local-variable 'git-blame-file)
-      (make-local-variable 'git-blame-current)
-      (setq git-blame-file display-buf)
-      (setq git-blame-current nil))
-    (set-process-filter proc 'git-blame-filter)
-    (set-process-sentinel proc 'git-blame-sentinel)))
+  (if git-blame-proc
+      ;; Should maybe queue up a new run here
+      (message "Already running git blame")
+    (let ((display-buf (current-buffer))
+          (blame-buf (get-buffer-create
+                      (concat " git blame for " (buffer-name)))))
+      (setq git-blame-proc
+            (start-process "git-blame" blame-buf
+                           "git" "blame"
+                           "--incremental" "--contents" "-"
+                           (file-name-nondirectory buffer-file-name)))
+      (with-current-buffer blame-buf
+        (erase-buffer)
+        (make-local-variable 'git-blame-file)
+        (make-local-variable 'git-blame-current)
+        (setq git-blame-file display-buf)
+        (setq git-blame-current nil))
+      (set-process-filter git-blame-proc 'git-blame-filter)
+      (set-process-sentinel git-blame-proc 'git-blame-sentinel)
+      (process-send-region git-blame-proc (point-min) (point-max))
+      (process-send-eof git-blame-proc))))
=20
 (defun git-blame-cleanup ()
   "Remove all blame properties"
@@ -159,6 +179,9 @@
       (set-buffer-modified-p modified)))
=20
 (defun git-blame-sentinel (proc status)
+  (with-current-buffer (process-buffer proc)
+    (with-current-buffer git-blame-file
+      (setq git-blame-proc nil)))
   ;;(kill-buffer (process-buffer proc))
   (message "git blame finished"))
=20
--=20
1.5.0.rc3.204.g93c76


--=20
David K=C3=A5gedal
