From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 01/17] Add an StGit mode for emacs
Date: Fri, 14 Dec 2007 11:55:42 +0100
Message-ID: <20071214105530.18066.14326.stgit@krank>
References: <20071214105238.18066.23281.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 11:56:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38Cu-0008M6-MQ
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 11:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759994AbXLNKz1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 05:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759340AbXLNKz1
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 05:55:27 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:51816 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758756AbXLNKz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 05:55:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 1DE32200A239;
	Fri, 14 Dec 2007 11:55:25 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 27584-01-53; Fri, 14 Dec 2007 11:55:24 +0100 (CET)
Received: from krank (vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 96DAF200A238;
	Fri, 14 Dec 2007 11:55:24 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id 041BB7B406D;
	Fri, 14 Dec 2007 11:55:43 +0100 (CET)
In-Reply-To: <20071214105238.18066.23281.stgit@krank>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68277>

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 contrib/stgit.el |  141 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 141 insertions(+), 0 deletions(-)
 create mode 100644 contrib/stgit.el


diff --git a/contrib/stgit.el b/contrib/stgit.el
new file mode 100644
index 0000000..1bdc0a5
--- /dev/null
+++ b/contrib/stgit.el
@@ -0,0 +1,141 @@
+(defun stgit (dir)
+  "Manage stgit patches"
+  (interactive "DDirectory: \n")
+  (switch-to-stgit-buffer dir)
+  (stgit-refresh))
+
+(defun switch-to-stgit-buffer (dir)
+  "Switch to a (possibly new) buffer displaying StGit patches for DIR"
+  (setq dir (file-name-as-directory dir))
+  (let ((buffers (buffer-list)))
+    (while (and buffers
+                (not (with-current-buffer (car buffers)
+                       (and (eq major-mode 'stgit-mode)
+                            (string=3D default-directory dir)))))
+      (setq buffers (cdr buffers)))
+    (switch-to-buffer (if buffers
+                          (car buffers)
+                        (create-stgit-buffer dir)))))
+
+(defun create-stgit-buffer (dir)
+  "Create a buffer for showing StGit patches.
+Argument DIR is the repository path."
+  (let ((buf (create-file-buffer (concat dir "*stgit*")))
+        (inhibit-read-only t))
+    (with-current-buffer buf
+      (setq default-directory dir)
+      (stgit-mode)
+      (setq buffer-read-only t))
+    buf))
+
+(defmacro stgit-capture-output (name &rest body)
+  "Capture StGit output and show it in a window at the end"
+  `(let ((output-buf (get-buffer-create ,(or name "*StGit output*"))))
+     (with-current-buffer output-buf
+       (erase-buffer))
+     (let ((standard-output output-buf))
+       ,@body)
+     (if (with-current-buffer output-buf (< (point-min) (point-max)))
+         (display-buffer output-buf t))))
+(put 'stgit-capture-output 'lisp-indent-function 1)
+
+(defun stgit-run (&rest args)
+  (apply 'call-process "stg" nil standard-output nil args))
+
+(defun stgit-refresh ()
+  "Update the contents of the stgit buffer"
+  (interactive)
+  (let ((inhibit-read-only t)
+        (curline (line-number-at-pos))
+        (curpatch (stgit-patch-at-point)))
+    (erase-buffer)
+    (insert "Branch: ")
+    (stgit-run "branch")
+    (stgit-run "series")
+    (if curpatch
+        (stgit-goto-patch curpatch)
+      (goto-line curline))))
+
+(defvar stgit-mode-hook nil
+  "Run after `stgit-mode' is setup.")
+
+(defvar stgit-mode-map nil
+  "Keymap for StGit major mode.")
+
+(unless stgit-mode-map
+  (setq stgit-mode-map (make-keymap))
+  (suppress-keymap stgit-mode-map)
+  (define-key stgit-mode-map "g"   'stgit-refresh)
+  (define-key stgit-mode-map "r"   'stgit-rename)
+  (define-key stgit-mode-map ">"   'stgit-push-next)
+  (define-key stgit-mode-map "<"   'stgit-pop)
+  (define-key stgit-mode-map "=3D"   'stgit-show))
+
+(defun stgit-mode ()
+  "Major mode for interacting with StGit.
+Commands:
+\\{stgit-mode-map}"
+  (kill-all-local-variables)
+  (buffer-disable-undo)
+  (setq mode-name "StGit"
+        major-mode 'stgit-mode
+        goal-column 2)
+  (use-local-map stgit-mode-map)
+  (set (make-local-variable 'list-buffers-directory) default-directory=
)
+  (run-hooks 'stgit-mode-hook))
+
+(defun stgit-patch-at-point ()
+  "Return the patch name on the current line"
+  (save-excursion
+    (beginning-of-line)
+    (if (looking-at "[>+-] \\(.*\\)")
+        (match-string 1)
+      nil)))
+
+(defun stgit-goto-patch (patch)
+  "Move point to the line containing PATCH"
+  (let ((p (point)))
+    (goto-char (point-min))
+    (if (re-search-forward (concat "[>+-] " (regexp-quote patch) "$") =
nil t)
+        (progn (move-to-column goal-column)
+               t)
+      (goto-char p)
+      nil)))
+
+(defun stgit-rename (name)
+  "Rename the patch under point"
+  (interactive (list (read-string "Patch name: " (stgit-patch-at-point=
))))
+  (let ((old-name (stgit-patch-at-point)))
+    (unless old-name
+      (error "No patch on this line"))
+    (stgit-capture-output nil
+      (stgit-run "rename" old-name name))
+    (stgit-refresh)
+    (stgit-goto-patch name)))
+
+(defun stgit-push-next ()
+  "Push the patch on the line after pos"
+  (interactive)
+  (forward-line 1)
+  (let ((patch (stgit-patch-at-point)))
+    (stgit-capture-output nil
+      (stgit-run "push" patch))
+    (stgit-refresh)))
+
+(defun stgit-pop ()
+  "Pop the patch on the current line"
+  (interactive)
+  (let ((patch (stgit-patch-at-point)))
+    (stgit-capture-output nil
+      (stgit-run "pop" patch))
+    (stgit-refresh)
+    (previous-line)))
+
+(defun stgit-show ()
+  "Show the patch on the current line"
+  (interactive)
+  (stgit-capture-output "*StGit patch*"
+    (stgit-run "show" (stgit-patch-at-point))
+    (with-current-buffer standard-output
+      (goto-char (point-min))
+      (diff-mode))))
