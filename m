From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] contrib/emacs: Add an Emacs VC backend.
Date: Sat, 04 Mar 2006 15:32:19 +0100
Message-ID: <87r75il1qk.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 04 15:32:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFXoH-0006Ul-GZ
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 15:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWCDOcd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 09:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWCDOcd
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 09:32:33 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:20929 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751650AbWCDOcc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Mar 2006 09:32:32 -0500
Received: from adsl-84-227-8-187.adslplus.ch ([84.227.8.187] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FFXny-0006vi-AM
	for git@vger.kernel.org; Sat, 04 Mar 2006 08:32:24 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 9F0224F90E; Sat,  4 Mar 2006 15:32:19 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
X-SA-Exim-Connect-IP: 84.227.8.187
X-SA-Exim-Mail-From: julliard@winehq.org
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,
	SPF_HELO_SOFTFAIL autolearn=no version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17182>

Add a basic Emacs VC backend. It currently supports the following
commands: checkin, checkout, diff, log, revert, and annotate. There is
only limited support for working with revisions other than HEAD.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>

---

 contrib/emacs/vc-git.el |  135 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 135 insertions(+), 0 deletions(-)
 create mode 100644 contrib/emacs/vc-git.el

b0c7984b6da71ab875c40a661b9a743370c41dfb
diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
new file mode 100644
index 0000000..2453cdc
--- /dev/null
+++ b/contrib/emacs/vc-git.el
@@ -0,0 +1,135 @@
+;;; vc-git.el --- VC backend for the git version control system
+
+;; Copyright (C) 2006 Alexandre Julliard
+
+;; This program is free software; you can redistribute it and/or
+;; modify it under the terms of the GNU General Public License as
+;; published by the Free Software Foundation; either version 2 of
+;; the License, or (at your option) any later version.
+;;
+;; This program is distributed in the hope that it will be
+;; useful, but WITHOUT ANY WARRANTY; without even the implied
+;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+;; PURPOSE.  See the GNU General Public License for more details.
+;;
+;; You should have received a copy of the GNU General Public
+;; License along with this program; if not, write to the Free
+;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+;; MA 02111-1307 USA
+
+;;; Commentary:
+
+;; This file contains a VC backend for the git version control
+;; system.
+;;
+;; To install: put this file on the load-path and add GIT to the list
+;; of supported backends in `vc-handled-backends'.
+;;
+;; TODO
+;;  - changelog generation
+;;  - working with revisions other than HEAD
+;;
+
+(defvar git-commits-coding-system 'utf-8
+  "Default coding system for git commits.")
+
+(defun vc-git--run-command-string (file &rest args)
+  "Run a git command on FILE and return its output as string."
+  (let* ((ok t)
+         (str (with-output-to-string
+                (with-current-buffer standard-output
+                  (unless (eq 0 (apply #'call-process "git" nil '(t nil) nil
+                                       (append args (list (file-relative-name file)))))
+                    (setq ok nil))))))
+    (and ok str)))
+
+(defun vc-git--run-command (file &rest args)
+  "Run a git command on FILE, discarding any output."
+  (let ((name (file-relative-name file)))
+    (eq 0 (apply #'call-process "git" nil (get-buffer "*Messages") nil (append args (list name))))))
+
+(defun vc-git-registered (file)
+  "Check whether FILE is registered with git."
+  (with-temp-buffer
+    (let* ((dir (file-name-directory file))
+           (name (file-relative-name file dir)))
+      (when dir (cd dir))
+      (and (eq 0 (call-process "git" nil '(t nil) nil "ls-files" "-c" "-z" "--" name))
+           (let ((str (buffer-string)))
+             (and (> (length str) (length name))
+                  (string= (substring str 0 (1+ (length name))) (concat name "\0"))))))))
+
+(defun vc-git-state (file)
+  "git-specific version of `vc-state'."
+  (let ((diff (vc-git--run-command-string file "diff-index" "-z" "HEAD" "--")))
+    (if (and diff (string-match ":[0-7]\\{6\\} [0-7]\\{6\\} [0-9a-f]\\{40\\} [0-9a-f]\\{40\\} [ADMU]\0[^\0]+\0" diff))
+        'edited
+      'up-to-date)))
+
+(defun vc-git-workfile-version (file)
+  "git-specific version of `vc-workfile-version'."
+  (let ((str (with-output-to-string
+               (with-current-buffer standard-output
+                 (call-process "git" nil '(t nil) nil "symbolic-ref" "HEAD")))))
+    (if (string-match "^\\(refs/heads/\\)?\\(.+\\)$" str)
+        (match-string 2 str)
+      str)))
+
+(defun vc-git-revert (file &optional contents-done)
+  "Revert FILE to the version stored in the git repository."
+  (if contents-done
+      (vc-git--run-command file "update-index" "--")
+    (vc-git--run-command file "checkout" "HEAD")))
+
+(defun vc-git-checkout-model (file)
+  'implicit)
+
+(defun vc-git-workfile-unchanged-p (file)
+  (let ((sha1 (vc-git--run-command-string file "hash-object" "--"))
+        (head (vc-git--run-command-string file "ls-tree" "-z" "HEAD" "--")))
+    (and head
+         (string-match "[0-7]\\{6\\} blob \\([0-9a-f]\\{40\\}\\)\t[^\0]+\0" head)
+         (string= (car (split-string sha1 "\n")) (match-string 1 head)))))
+
+(defun vc-git-register (file &optional rev comment)
+  "Register FILE into the git version-control system."
+  (vc-git--run-command file "update-index" "--add" "--"))
+
+(defun vc-git-print-log (file)
+  (let ((name (file-relative-name file))
+        (coding-system-for-read git-commits-coding-system))
+    (vc-do-command nil 'async "git" name "rev-list" "--pretty" "HEAD" "--")))
+
+(defun vc-git-diff (file &optional rev1 rev2)
+  (let ((name (file-relative-name file)))
+    (if (and rev1 rev2)
+        (vc-do-command "*vc-diff*" 0 "git" name "diff-tree" "-p" rev1 rev2 "--")
+      (vc-do-command "*vc-diff*" 0 "git" name "diff-index" "-p" (or rev1 "HEAD") "--"))
+    ; git-diff-index doesn't set exit status like diff does
+    (if (vc-git-workfile-unchanged-p file) 0 1)))
+
+(defun vc-git-checkin (file rev comment)
+  (let ((coding-system-for-write git-commits-coding-system))
+    (vc-git--run-command file "commit" "-m" comment "--only" "--")))
+
+(defun vc-git-checkout (file &optional editable rev destfile)
+  (vc-git--run-command file "checkout" (or rev "HEAD")))
+
+(defun vc-git-annotate-command (file buf &optional rev)
+  ; FIXME: rev is ignored
+  (let ((name (file-relative-name file)))
+    (call-process "git" nil buf nil "annotate" name)))
+
+(defun vc-git-annotate-time ()
+  (and (re-search-forward "[0-9a-f]+\t(.*\t\\([0-9]+\\)-\\([0-9]+\\)-\\([0-9]+\\) \\([0-9]+\\):\\([0-9]+\\):\\([0-9]+\\) \\([-+0-9]+\\)\t[0-9]+)" nil t)
+       (vc-annotate-convert-time
+        (apply #'encode-time (mapcar (lambda (match) (string-to-number (match-string match))) '(6 5 4 3 2 1 7))))))
+
+;; Not really useful since we can't do anything with the revision yet
+;;(defun vc-annotate-extract-revision-at-line ()
+;;  (save-excursion
+;;    (move-beginning-of-line 1)
+;;    (and (looking-at "[0-9a-f]+")
+;;         (buffer-substring (match-beginning 0) (match-end 0)))))
+
+(provide 'vc-git)
-- 
1.2.4.g0040-dirty

-- 
Alexandre Julliard
julliard@winehq.org
