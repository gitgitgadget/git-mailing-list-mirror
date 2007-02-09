From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH 7/7] git-blame.el: Autoupdate while editing
Date: Fri, 09 Feb 2007 09:22:19 +0100
Message-ID: <87ejozpwp0.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 09:50:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFRSP-00007f-HZ
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 09:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946229AbXBIIuK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 9 Feb 2007 03:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946228AbXBIIuK
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 03:50:10 -0500
Received: from main.gmane.org ([80.91.229.2]:59582 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946229AbXBIIuI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 03:50:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HFRSE-0000pJ-08
	for git@vger.kernel.org; Fri, 09 Feb 2007 09:50:02 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 09:50:01 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 09:50:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:q/R6aoB6u1ukXO6Y3O792QxYlxU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39166>

This adds the support for automatically updating the buffer while editi=
ng.
A configuration variable git-blame-autoupdate controls whether this sho=
uld
be enabled or not.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 contrib/emacs/git-blame.el |   95 ++++++++++++++++++++++++++++++++++++=
+++----
 1 files changed, 86 insertions(+), 9 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 7daa4e6..64ad50b 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -102,6 +102,9 @@
=20
 (defvar git-blame-ancient-color "dark green")
=20
+(defvar git-blame-autoupdate t
+  "*Automatically update the blame display while editing")
+
 (defvar git-blame-proc nil
   "The running git-blame process")
 (make-variable-buffer-local 'git-blame-proc)
@@ -114,6 +117,14 @@
   "A cache of git-blame information for the current buffer")
 (make-variable-buffer-local 'git-blame-cache)
=20
+(defvar git-blame-idle-timer nil
+  "An idle timer that updates the blame")
+(make-variable-buffer-local 'git-blame-cache)
+
+(defvar git-blame-update-queue nil
+  "A queue of update requests")
+(make-variable-buffer-local 'git-blame-update-queue)
+
 (defvar git-blame-mode nil)
 (make-variable-buffer-local 'git-blame-mode)
 (unless (assq 'git-blame-mode minor-mode-alist)
@@ -129,6 +140,9 @@
       (setq git-blame-mode (eq arg 1))
     (setq git-blame-mode (not git-blame-mode)))
   (make-local-variable 'git-blame-colors)
+  (if git-blame-autoupdate
+      (add-hook 'after-change-functions 'git-blame-after-change nil t)
+    (remove-hook 'after-change-functions 'git-blame-after-change t))
   (git-blame-cleanup)
   (if git-blame-mode
       (progn
@@ -137,7 +151,8 @@
               (setq git-blame-colors git-blame-dark-colors)
             (setq git-blame-colors git-blame-light-colors)))
         (setq git-blame-cache (make-hash-table :test 'equal))
-        (git-blame-run))))
+        (git-blame-run))
+    (cancel-timer git-blame-idle-timer)))
=20
 ;;;###autoload
 (defun git-reblame ()
@@ -148,18 +163,24 @@
   (git-blame-cleanup)
   (git-blame-run))
=20
-(defun git-blame-run ()
+(defun git-blame-run (&optional startline endline)
   (if git-blame-proc
       ;; Should maybe queue up a new run here
       (message "Already running git blame")
     (let ((display-buf (current-buffer))
           (blame-buf (get-buffer-create
-                      (concat " git blame for " (buffer-name)))))
+                      (concat " git blame for " (buffer-name))))
+          (args '("--incremental" "--contents" "-")))
+      (if startline
+          (setq args (append args
+                             (list "-L" (format "%d,%d" startline endl=
ine)))))
+      (setq args (append args
+                         (list (file-name-nondirectory buffer-file-nam=
e))))
       (setq git-blame-proc
-            (start-process "git-blame" blame-buf
-                           "git" "blame"
-                           "--incremental" "--contents" "-"
-                           (file-name-nondirectory buffer-file-name)))
+            (apply 'start-process
+                   "git-blame" blame-buf
+                   "git" "blame"
+                   args))
       (with-current-buffer blame-buf
         (erase-buffer)
         (make-local-variable 'git-blame-file)
@@ -183,10 +204,28 @@
     (setq git-blame-overlays nil)
     (remove-git-blame-text-properties (point-min) (point-max)))
=20
+(defun git-blame-update-region (start end)
+  "Rerun blame to get updates between START and END"
+  (let ((overlays (overlays-in start end)))
+    (while overlays
+      (let ((overlay (pop overlays)))
+        (if (< (overlay-start overlay) start)
+            (setq start (overlay-start overlay)))
+        (if (> (overlay-end overlay) end)
+            (setq end (overlay-end overlay)))
+        (setq git-blame-overlays (delete overlay git-blame-overlays))
+        (delete-overlay overlay))))
+  (remove-git-blame-text-properties start end)
+  ;; We can be sure that start and end are at line breaks
+  (git-blame-run (1+ (count-lines (point-min) start))
+                 (count-lines (point-min) end)))
+
 (defun git-blame-sentinel (proc status)
   (with-current-buffer (process-buffer proc)
     (with-current-buffer git-blame-file
-      (setq git-blame-proc nil)))
+      (setq git-blame-proc nil)
+      (if git-blame-update-queue
+          (git-blame-delayed-update))))
   ;;(kill-buffer (process-buffer proc))
   ;;(message "git blame finished")
   )
@@ -241,7 +280,8 @@
   (save-excursion
     (set-buffer git-blame-file)
     (let ((info (gethash hash git-blame-cache))
-          (inhibit-point-motion-hooks t))
+          (inhibit-point-motion-hooks t)
+          (inhibit-modification-hooks t))
       (when (not info)
         (let ((color (pop git-blame-colors)))
           (unless color
@@ -298,6 +338,43 @@
       (message "%s" (nth 4 info))
       (setq git-blame-last-identification info))))
=20
+;; (defun git-blame-after-save ()
+;;   (when git-blame-mode
+;;     (git-blame-cleanup)
+;;     (git-blame-run)))
+;; (add-hook 'after-save-hook 'git-blame-after-save)
+
+(defun git-blame-after-change (start end length)
+  (when git-blame-mode
+    (git-blame-enq-update start end)))
+
+(defvar git-blame-last-update nil)
+(make-variable-buffer-local 'git-blame-last-update)
+(defun git-blame-enq-update (start end)
+  "Mark the region between START and END as needing blame update"
+  ;; Try to be smart and avoid multiple callouts for sequential
+  ;; editing
+  (cond ((and git-blame-last-update
+              (=3D start (cdr git-blame-last-update)))
+         (setcdr git-blame-last-update end))
+        ((and git-blame-last-update
+              (=3D end (car git-blame-last-update)))
+         (setcar git-blame-last-update start))
+        (t
+         (setq git-blame-last-update (cons start end))
+         (setq git-blame-update-queue (nconc git-blame-update-queue
+                                             (list git-blame-last-upda=
te)))))
+  (unless (or git-blame-proc git-blame-idle-timer)
+    (setq git-blame-idle-timer
+          (run-with-idle-timer 0.5 nil 'git-blame-delayed-update))))
+
+(defun git-blame-delayed-update ()
+  (setq git-blame-idle-timer nil)
+  (if git-blame-update-queue
+      (let ((first (pop git-blame-update-queue))
+            (inhibit-point-motion-hooks t))
+        (git-blame-update-region (car first) (cdr first)))))
+
 (provide 'git-blame)
=20
 ;;; git-blame.el ends here
--=20
1.5.0.rc3.204.g93c76


--=20
David K=C3=A5gedal
