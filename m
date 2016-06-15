From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] Add an Emacs interface in contrib.
Date: Sat, 18 Feb 2006 17:50:49 +0100
Message-ID: <87mzgok3va.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Feb 18 17:51:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAVIY-00060i-5p
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 17:51:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWBRQvB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 11:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWBRQvB
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 11:51:01 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:59356 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751419AbWBRQvA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 11:51:00 -0500
Received: from adsl-84-226-98-136.adslplus.ch ([84.226.98.136] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FAVIJ-0004Wc-LM
	for git@vger.kernel.org; Sat, 18 Feb 2006 10:50:59 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 900974F929; Sat, 18 Feb 2006 17:50:49 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-SA-Exim-Connect-IP: 84.226.98.136
X-SA-Exim-Mail-From: julliard@winehq.org
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=AWL,BAYES_00,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_NJABL_DUL,RCVD_IN_XBL,
	SPF_HELO_SOFTFAIL autolearn=no version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16417>

This is an Emacs interface for git. The user interface is modeled on
pcl-cvs. It has been developed on Emacs 21 and will probably need some
tweaking to work on XEmacs.

The basic command is 'M-x git-status' which displays a buffer listing
modified files in the selected project tree. In that buffer the
following features are supported:

  - add/remove files
  - list unknown files
  - commit marked files
  - manage .gitignore
  - commit merges based on MERGE_HEAD
  - revert files to the HEAD version
  - resolve conflicts with smerge or ediff
  - diff files against HEAD/base/mine/other or combined diff
  - get a log of the revisions for specified files

There are plenty of unimplemented features too, see the TODO list at
the top of the file...

Signed-off-by: Alexandre Julliard <julliard@winehq.org>

---

 contrib/emacs/git.el |  956 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 956 insertions(+), 0 deletions(-)
 create mode 100644 contrib/emacs/git.el

fd1fee63b25d241f6f345fa33bdc6fd7554841dc
diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
new file mode 100644
index 0000000..8f23477
--- /dev/null
+++ b/contrib/emacs/git.el
@@ -0,0 +1,956 @@
+;;; git.el --- A user interface for git
+
+;; Copyright (C) 2005, 2006 Alexandre Julliard <julliard@winehq.org>
+
+;; Version: 1.0
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
+;; This file contains an interface for the git version control
+;; system. It provides easy access to the most frequently used git
+;; commands. The user interface is as far as possible identical to
+;; that of the PCL-CVS mode.
+;;
+;; To install: put this file on the load-path and place the following
+;; in your .emacs file:
+;;
+;;    (require 'git)
+;;
+;; To start: `M-x git-status'
+;;
+;; TODO
+;;  - portability to XEmacs
+;;  - better handling of subprocess errors
+;;  - hook into file save (after-save-hook)
+;;  - diff against other branch
+;;  - renaming files from the status buffer
+;;  - support for appending signed-off-by
+;;  - creating tags
+;;  - fetch/pull
+;;  - switching branches
+;;  - revlist browser
+;;  - git-show-branch browser
+;;  - customize support
+;;  - menus
+;;
+
+(eval-when-compile (require 'cl))
+(require 'ewoc)
+
+
+;;;; Faces
+;;;; ------------------------------------------------------------
+
+(defface git-status-face
+  '((((class color) (background light)) (:foreground "purple")))
+  "Git mode face used to highlight added and modified files.")
+
+(defface git-unmerged-face
+  '((((class color) (background light)) (:foreground "red" :bold t)))
+  "Git mode face used to highlight unmerged files.")
+
+(defface git-unknown-face
+  '((((class color) (background light)) (:foreground "goldenrod" :bold t)))
+  "Git mode face used to highlight unknown files.")
+
+(defface git-uptodate-face
+  '((((class color) (background light)) (:foreground "grey60")))
+  "Git mode face used to highlight up-to-date files.")
+
+(defface git-ignored-face
+  '((((class color) (background light)) (:foreground "grey60")))
+  "Git mode face used to highlight ignored files.")
+
+(defface git-mark-face
+  '((((class color) (background light)) (:foreground "red" :bold t)))
+  "Git mode face used for the file marks.")
+
+(defface git-header-face
+  '((((class color) (background light)) (:foreground "blue")))
+  "Git mode face used for commit headers.")
+
+(defface git-separator-face
+  '((((class color) (background light)) (:foreground "brown")))
+  "Git mode face used for commit separator.")
+
+(defface git-permission-face
+  '((((class color) (background light)) (:foreground "green" :bold t)))
+  "Git mode face used for permission changes.")
+
+(defvar git-committer-name nil
+  "*User name to use for commits.
+If not set, fall back to `add-log-full-name' and then `user-full-name'.")
+
+(defvar git-committer-email nil
+  "*Email address to use for commits.
+If not set, fall back to `add-log-mailing-address' and then `user-mail-address'.")
+
+(defvar git-commits-coding-system 'utf-8
+  "Default coding system for git commits.")
+
+(defconst git-log-msg-separator "--- log message follows this line ---")
+
+(defconst git-per-dir-ignore-file ".gitignore"
+  "Name of the per-directory ignore file.")
+
+
+;;;; Utilities
+;;;; ------------------------------------------------------------
+
+(defun git-get-env-strings (env)
+  "Build a list of NAME=VALUE strings from a list of environment strings."
+  (mapcar (lambda (entry) (concat (car entry) "=" (cdr entry))) env))
+
+(defun git-call-process-env (buffer env &rest args)
+  "Wrapper for call-process that sets environment strings."
+  (if env
+      (apply #'call-process "env" nil buffer nil
+             (append (git-get-env-strings env) (list "git") args))
+    (apply #'call-process "git" nil buffer nil args)))
+
+(defun git-run-process-region (buffer start end program args)
+  "Run a git process with a buffer region as input."
+  (let ((output-buffer (current-buffer))
+        (dir default-directory))
+    (with-current-buffer buffer
+      (cd dir)
+      (apply #'call-process-region start end program
+             nil (list output-buffer nil) nil args))))
+
+(defun git-run-command-buffer (buffer-name &rest args)
+  "Run a git command, sending the output to a buffer named BUFFER-NAME."
+  (let ((dir default-directory)
+        (buffer (get-buffer-create buffer-name)))
+    (message "Running git %s..." (car args))
+    (with-current-buffer buffer
+      (let ((default-directory dir)
+            (buffer-read-only nil))
+        (erase-buffer)
+        (apply #'git-call-process-env buffer nil args)))
+    (message "Running git %s...done" (car args))
+    buffer))
+
+(defun git-run-command (buffer env &rest args)
+  (message "Running git %s..." (car args))
+  (apply #'git-call-process-env buffer env args)
+  (message "Running git %s...done" (car args)))
+
+(defun git-run-command-region (buffer start end env &rest args)
+  "Run a git command with specified buffer region as input."
+  (message "Running git %s..." (car args))
+  (unless (eq 0 (if env
+                    (git-run-process-region
+                     buffer start end "env"
+                     (append (git-get-env-strings env) (list "git") args))
+                  (git-run-process-region
+                   buffer start end "git" args)))
+    (error "Failed to run \"git %s\":\n%s" (mapconcat (lambda (x) x) args " ") (buffer-string)))
+  (message "Running git %s...done" (car args)))
+
+(defun git-get-string-sha1 (string)
+  "Read a SHA1 from the specified string."
+  (let ((pos (string-match "[0-9a-f]\\{40\\}" string)))
+    (and pos (substring string pos (match-end 0)))))
+
+(defun git-get-committer-name ()
+  "Return the name to use as GIT_COMMITTER_NAME."
+  ; copied from log-edit
+  (or git-committer-name
+      (and (boundp 'add-log-full-name) add-log-full-name)
+      (and (fboundp 'user-full-name) (user-full-name))
+      (and (boundp 'user-full-name) user-full-name)))
+
+(defun git-get-committer-email ()
+  "Return the email address to use as GIT_COMMITTER_EMAIL."
+  ; copied from log-edit
+  (or git-committer-email
+      (and (boundp 'add-log-mailing-address) add-log-mailing-address)
+      (and (fboundp 'user-mail-address) (user-mail-address))
+      (and (boundp 'user-mail-address) user-mail-address)))
+
+(defun git-escape-file-name (name)
+  "Escape a file name if necessary."
+  (if (string-match "[\n\t\"\\]" name)
+      (concat "\""
+              (mapconcat (lambda (c)
+                   (case c
+                     (?\n "\\n")
+                     (?\t "\\t")
+                     (?\\ "\\\\")
+                     (?\" "\\\"")
+                     (t (char-to-string c))))
+                 name "")
+              "\"")
+    name))
+
+(defun git-get-top-dir (dir)
+  "Retrieve the top-level directory of a git tree."
+  (let ((cdup (with-output-to-string
+                (with-current-buffer standard-output
+                  (cd dir)
+                  (unless (eq 0 (call-process "git" nil t nil "rev-parse" "--show-cdup"))
+                    (error "cannot find top-level git tree for %s." dir))))))
+    (expand-file-name (concat (file-name-as-directory dir)
+                              (car (split-string cdup "\n"))))))
+
+;stolen from pcl-cvs
+(defun git-append-to-ignore (file)
+  "Add a file name to the ignore file in its directory."
+  (let* ((fullname (expand-file-name file))
+         (dir (file-name-directory fullname))
+         (name (file-name-nondirectory fullname)))
+  (save-window-excursion
+    (set-buffer (find-file-noselect (expand-file-name git-per-dir-ignore-file dir)))
+    (goto-char (point-max))
+    (unless (zerop (current-column)) (insert "\n"))
+    (insert name "\n")
+    (sort-lines nil (point-min) (point-max))
+    (save-buffer))))
+
+
+;;;; Wrappers for basic git commands
+;;;; ------------------------------------------------------------
+
+(defun git-rev-parse (rev)
+  "Parse a revision name and return its SHA1."
+  (git-get-string-sha1
+   (with-output-to-string
+     (with-current-buffer standard-output
+       (git-call-process-env t nil "rev-parse" rev)))))
+
+(defun git-symbolic-ref (ref)
+  "Wrapper for the git-symbolic-ref command."
+  (car
+   (split-string
+    (with-output-to-string
+      (with-current-buffer standard-output
+        (git-call-process-env t nil "symbolic-ref" ref)))
+    "\n")))
+
+(defun git-update-ref (ref val &optional oldval)
+  "Update a reference by calling git-update-ref."
+  (apply #'git-call-process-env nil nil "update-ref" ref val (if oldval (list oldval))))
+
+(defun git-read-tree (tree &optional index-file)
+  "Read a tree into the index file."
+  (apply #'git-call-process-env nil
+         (if index-file `(("GIT_INDEX_FILE" . ,index-file)) nil)
+         "read-tree" (if tree (list tree))))
+
+(defun git-write-tree (&optional index-file)
+  "Call git-write-tree and return the resulting tree SHA1 as a string."
+  (git-get-string-sha1
+   (with-output-to-string
+     (with-current-buffer standard-output
+       (git-call-process-env t
+        (if index-file `(("GIT_INDEX_FILE" . ,index-file)) nil)
+        "write-tree")))))
+
+(defun git-commit-tree (buffer tree head)
+  "Call git-commit-tree with buffer as input and return the resulting commit SHA1."
+  (let ((author-name (git-get-committer-name))
+        (author-email (git-get-committer-email))
+        author-date log-start log-end args)
+    (when head
+      (push "-p" args)
+      (push head args))
+    (with-current-buffer buffer
+      (goto-char (point-min))
+      (if
+          (setq log-start (re-search-forward (concat "^" git-log-msg-separator "\n") nil t))
+          (save-restriction
+            (narrow-to-region (point-min) log-start)
+            (goto-char (point-min))
+            (when (re-search-forward "^Author: +\\(.*?\\) *<\\(.*\\)> *$" nil t)
+              (setq author-name (match-string 1)
+                    author-email (match-string 2)))
+            (goto-char (point-min))
+            (when (re-search-forward "^Date: +\\(.*\\)$" nil t)
+              (setq author-date (match-string 1)))
+            (goto-char (point-min))
+            (while (re-search-forward "^Parent: +\\([0-9a-f]+\\)" nil t)
+              (unless (string-equal head (match-string 1))
+                (push "-p" args)
+                (push (match-string 1) args))))
+        (setq log-start (point-min)))
+      (setq log-end (point-max)))
+    (git-get-string-sha1
+     (with-output-to-string
+       (with-current-buffer standard-output
+         (let ((coding-system-for-write git-commits-coding-system)
+               (env `(("GIT_AUTHOR_NAME" . ,author-name)
+                      ("GIT_AUTHOR_EMAIL" . ,author-email)
+                      ("GIT_COMMITTER_NAME" . ,(git-get-committer-name))
+                      ("GIT_COMMITTER_EMAIL" . ,(git-get-committer-email)))))
+           (when author-date (push `("GIT_AUTHOR_DATE" . ,author-date) env))
+           (apply #'git-run-command-region
+                  buffer log-start log-end env
+                  "commit-tree" tree (nreverse args))))))))
+
+(defun git-empty-db-p ()
+  "Check if the git db is empty (no commit done yet)."
+  (not (eq 0 (call-process "git" nil nil nil "rev-parse" "--verify" "HEAD"))))
+
+(defun git-get-merge-heads ()
+  "Retrieve the merge heads from the MERGE_HEAD file if present."
+  (let (heads)
+    (when (file-readable-p ".git/MERGE_HEAD")
+      (with-temp-buffer
+        (insert-file-contents ".git/MERGE_HEAD" nil nil nil t)
+        (goto-char (point-min))
+        (while (re-search-forward "[0-9a-f]\\{40\\}" nil t)
+          (push (match-string 0) heads))))
+    (nreverse heads)))
+
+;;;; File info structure
+;;;; ------------------------------------------------------------
+
+; fileinfo structure stolen from pcl-cvs
+(defstruct (git-fileinfo
+            (:copier nil)
+            (:constructor git-create-fileinfo (state name &optional old-perm new-perm rename-state orig-name marked))
+            (:conc-name git-fileinfo->))
+  marked              ;; t/nil
+  state               ;; current state
+  name                ;; file name
+  old-perm new-perm   ;; permission flags
+  rename-state        ;; rename or copy state
+  orig-name           ;; original name for renames or copies
+  needs-refresh)      ;; whether file needs to be refreshed
+
+(defvar git-status nil)
+
+(defun git-clear-status (status)
+  "Remove everything from the status list."
+  (ewoc-filter status (lambda (info) nil)))
+
+(defun git-set-files-state (files state)
+  "Set the state of a list of files."
+  (dolist (info files)
+    (unless (eq (git-fileinfo->state info) state)
+      (setf (git-fileinfo->state info) state)
+      (setf (git-fileinfo->rename-state info) nil)
+      (setf (git-fileinfo->orig-name info) nil)
+      (setf (git-fileinfo->needs-refresh info) t))))
+
+(defun git-state-code (code)
+  "Convert from a string to a added/deleted/modified state."
+  (case (string-to-char code)
+    (?M 'modified)
+    (?? 'unknown)
+    (?A 'added)
+    (?D 'deleted)
+    (?U 'unmerged)
+    (t nil)))
+
+(defun git-status-code-as-string (code)
+  "Format a git status code as string."
+  (case code
+    ('modified (propertize "Modified" 'face 'git-status-face))
+    ('unknown  (propertize "Unknown " 'face 'git-unknown-face))
+    ('added    (propertize "Added   " 'face 'git-status-face))
+    ('deleted  (propertize "Deleted " 'face 'git-status-face))
+    ('unmerged (propertize "Unmerged" 'face 'git-unmerged-face))
+    ('uptodate (propertize "Uptodate" 'face 'git-uptodate-face))
+    ('ignored  (propertize "Ignored " 'face 'git-ignored-face))
+    (t "?       ")))
+
+(defun git-rename-as-string (info)
+  "Return a string describing the copy or rename associated with INFO, or an empty string if none."
+  (let ((state (git-fileinfo->rename-state info)))
+    (if state
+        (propertize
+         (concat "   ("
+                 (if (eq state 'copy) "copied from "
+                   (if (eq (git-fileinfo->state info) 'added) "renamed to "
+                     "renamed from "))
+                 (git-escape-file-name (git-fileinfo->orig-name info))
+                 ")") 'face 'git-status-face)
+      "")))
+
+(defun git-permissions-as-string (old-perm new-perm)
+  "Format a permission change as string."
+  (propertize
+   (if (or (not old-perm)
+           (not new-perm)
+           (eq 0 (logand #O111 (logxor old-perm new-perm))))
+       "  "
+     (if (eq 0 (logand #O111 old-perm)) "+x" "-x"))
+  'face 'git-permission-face))
+
+(defun git-fileinfo-prettyprint (info)
+  "Pretty-printer for the git-fileinfo structure."
+  (insert (format "   %s %s %s  %s%s"
+                  (if (git-fileinfo->marked info) (propertize "*" 'face 'git-mark-face) " ")
+                  (git-status-code-as-string (git-fileinfo->state info))
+                  (git-permissions-as-string (git-fileinfo->old-perm info) (git-fileinfo->new-perm info))
+                  (git-escape-file-name (git-fileinfo->name info))
+                  (git-rename-as-string info))))
+
+(defun git-parse-status (status)
+  "Parse the output of git-diff-index in the current buffer."
+  (goto-char (point-min))
+  (while (re-search-forward
+          ":\\([0-7]\\{6\\}\\) \\([0-7]\\{6\\}\\) [0-9a-f]\\{40\\} [0-9a-f]\\{40\\} \\(\\([ADMU]\\)\0\\([^\0]+\\)\\|\\([CR]\\)[0-9]*\0\\([^\0]+\\)\0\\([^\0]+\\)\\)\0"
+          nil t 1)
+    (let ((old-perm (string-to-number (match-string 1) 8))
+          (new-perm (string-to-number (match-string 2) 8))
+          (state (or (match-string 4) (match-string 6)))
+          (name (or (match-string 5) (match-string 7)))
+          (new-name (match-string 8)))
+      (if new-name  ; copy or rename
+          (if (eq ?C (string-to-char state))
+              (ewoc-enter-last status (git-create-fileinfo 'added new-name old-perm new-perm 'copy name))
+            (ewoc-enter-last status (git-create-fileinfo 'deleted name 0 0 'rename new-name))
+            (ewoc-enter-last status (git-create-fileinfo 'added new-name old-perm new-perm 'rename name)))
+        (ewoc-enter-last status (git-create-fileinfo (git-state-code state) name old-perm new-perm))))))
+
+(defun git-find-status-file (status file)
+  "Find a given file in the status ewoc and return its node."
+  (let ((node (ewoc-nth status 0)))
+    (while (and node (not (string= file (git-fileinfo->name (ewoc-data node)))))
+      (setq node (ewoc-next status node)))
+    node))
+
+(defun git-parse-ls-files (status default-state &optional skip-existing)
+  "Parse the output of git-ls-files in the current buffer."
+  (goto-char (point-min))
+  (let (infolist)
+    (while (re-search-forward "\\([HMRCK?]\\) \\([^\0]*\\)\0" nil t 1)
+      (let ((state (match-string 1))
+            (name (match-string 2)))
+        (unless (and skip-existing (git-find-status-file status name))
+          (push (git-create-fileinfo (or (git-state-code state) default-state) name) infolist))))
+    (dolist (info (nreverse infolist))
+      (ewoc-enter-last status info))))
+
+(defun git-parse-ls-unmerged (status)
+  "Parse the output of git-ls-files -u in the current buffer."
+  (goto-char (point-min))
+  (let (files)
+    (while (re-search-forward "[0-7]\\{6\\} [0-9a-f]\\{40\\} [123]\t\\([^\0]+\\)\0" nil t)
+      (let ((node (git-find-status-file status (match-string 1))))
+        (when node (push (ewoc-data node) files))))
+    (git-set-files-state files 'unmerged)))
+
+(defun git-add-status-file (state name)
+  "Add a new file to the status list (if not existing already) and return its node."
+  (unless git-status (error "Not in git-status buffer."))
+  (or (git-find-status-file git-status name)
+      (ewoc-enter-last git-status (git-create-fileinfo state name))))
+
+(defun git-marked-files ()
+  "Return a list of all marked files, or if none a list containing just the file at cursor position."
+  (unless git-status (error "Not in git-status buffer."))
+  (or (ewoc-collect git-status (lambda (info) (git-fileinfo->marked info)))
+      (list (ewoc-data (ewoc-locate git-status)))))
+
+(defun git-marked-files-state (&rest states)
+  "Return marked files that are in the specified states."
+  (let ((files (git-marked-files))
+        result)
+    (dolist (info files)
+      (when (memq (git-fileinfo->state info) states)
+        (push info result)))
+    result))
+
+(defun git-refresh-files ()
+  "Refresh all files that need it and clear the needs-refresh flag."
+  (unless git-status (error "Not in git-status buffer."))
+  (ewoc-map
+   (lambda (info)
+     (let ((refresh (git-fileinfo->needs-refresh info)))
+       (setf (git-fileinfo->needs-refresh info) nil)
+       refresh))
+   git-status)
+  ; move back to goal column
+  (when goal-column (move-to-column goal-column)))
+
+(defun git-refresh-ewoc-hf (status)
+  "Refresh the ewoc header and footer."
+  (let ((branch (git-symbolic-ref "HEAD"))
+        (head (if (git-empty-db-p) "Nothing committed yet"
+                (substring (git-rev-parse "HEAD") 0 10)))
+        (merge-heads (git-get-merge-heads)))
+    (ewoc-set-hf status
+                 (format "Directory:  %s\nBranch:     %s\nHead:       %s%s\n"
+                         default-directory
+                         (if (string-match "^refs/heads/" branch)
+                             (substring branch (match-end 0))
+                           branch)
+                         head
+                         (if merge-heads
+                             (concat "\nMerging:    "
+                                     (mapconcat (lambda (str) (substring str 0 10)) merge-heads " "))
+                           ""))
+                 (if (ewoc-nth status 0) "" "    No changes."))))
+
+(defun git-get-filenames (files)
+  (mapcar (lambda (info) (git-fileinfo->name info)) files))
+
+(defun git-update-index (index-file files)
+  "Run git-update-index on a list of files."
+  (let ((env (and index-file `(("GIT_INDEX_FILE" . ,index-file))))
+        added deleted modified)
+    (dolist (info files)
+      (case (git-fileinfo->state info)
+        ('added (push info added))
+        ('deleted (push info deleted))
+        ('modified (push info modified))))
+    (when added
+      (apply #'git-run-command nil env "update-index" "--add" "--" (git-get-filenames added)))
+    (when deleted
+      (apply #'git-run-command nil env "update-index" "--remove" "--" (git-get-filenames deleted)))
+    (when modified
+      (apply #'git-run-command nil env "update-index" "--" (git-get-filenames modified)))))
+
+(defun git-do-commit ()
+  "Perform the actual commit using the current buffer as log message."
+  (interactive)
+  (let ((buffer (current-buffer))
+        (index-file (make-temp-file "gitidx")))
+    (with-current-buffer log-edit-parent-buffer
+      (if (git-marked-files-state 'unmerged)
+          (message "You cannot commit unmerged files, resolve them first.")
+        (unwind-protect
+            (let ((files (git-marked-files-state 'added 'deleted 'modified))
+                  head head-tree)
+              (unless (git-empty-db-p)
+                (setq head (git-rev-parse "HEAD")
+                      head-tree (git-rev-parse "HEAD^{tree}")))
+              (if files
+                  (progn
+                    (git-read-tree head-tree index-file)
+                    (git-update-index nil files)         ;update both the default index
+                    (git-update-index index-file files)  ;and the temporary one
+                    (let ((tree (git-write-tree index-file)))
+                      (if (or (not (string-equal tree head-tree))
+                              (yes-or-no-p "The tree was not modified, do you really want to perform an empty commit? "))
+                          (let ((commit (git-commit-tree buffer tree head)))
+                            (git-update-ref "HEAD" commit head)
+                            (condition-case nil (delete-file ".git/MERGE_HEAD") (error nil))
+                            (with-current-buffer buffer (erase-buffer))
+                            (git-set-files-state files 'uptodate)
+                            (git-refresh-files)
+                            (git-refresh-ewoc-hf git-status)
+                            (message "Committed %s." commit))
+                        (message "Commit aborted."))))
+                (message "No files to commit.")))
+          (delete-file index-file))))))
+
+
+;;;; Interactive functions
+;;;; ------------------------------------------------------------
+
+(defun git-mark-file ()
+  "Mark the file that the cursor is on and move to the next one."
+  (interactive)
+  (unless git-status (error "Not in git-status buffer."))
+  (let* ((pos (ewoc-locate git-status))
+         (info (ewoc-data pos)))
+    (setf (git-fileinfo->marked info) t)
+    (ewoc-invalidate git-status pos)
+    (ewoc-goto-next git-status 1)))
+
+(defun git-unmark-file ()
+  "Unmark the file that the cursor is on and move to the next one."
+  (interactive)
+  (unless git-status (error "Not in git-status buffer."))
+  (let* ((pos (ewoc-locate git-status))
+         (info (ewoc-data pos)))
+    (setf (git-fileinfo->marked info) nil)
+    (ewoc-invalidate git-status pos)
+    (ewoc-goto-next git-status 1)))
+
+(defun git-unmark-file-up ()
+  "Unmark the file that the cursor is on and move to the previous one."
+  (interactive)
+  (unless git-status (error "Not in git-status buffer."))
+  (let* ((pos (ewoc-locate git-status))
+         (info (ewoc-data pos)))
+    (setf (git-fileinfo->marked info) nil)
+    (ewoc-invalidate git-status pos)
+    (ewoc-goto-prev git-status 1)))
+
+(defun git-mark-all ()
+  "Mark all files."
+  (interactive)
+  (unless git-status (error "Not in git-status buffer."))
+  (ewoc-map (lambda (info) (setf (git-fileinfo->marked info) t) t) git-status)
+  ; move back to goal column after invalidate
+  (when goal-column (move-to-column goal-column)))
+
+(defun git-unmark-all ()
+  "Unmark all files."
+  (interactive)
+  (unless git-status (error "Not in git-status buffer."))
+  (ewoc-map (lambda (info) (setf (git-fileinfo->marked info) nil) t) git-status)
+  ; move back to goal column after invalidate
+  (when goal-column (move-to-column goal-column)))
+
+(defun git-toggle-all-marks ()
+  "Toggle all file marks."
+  (interactive)
+  (unless git-status (error "Not in git-status buffer."))
+  (ewoc-map (lambda (info) (setf (git-fileinfo->marked info) (not (git-fileinfo->marked info))) t) git-status)
+  ; move back to goal column after invalidate
+  (when goal-column (move-to-column goal-column)))
+
+(defun git-next-file (&optional n)
+  "Move the selection down N files."
+  (interactive "p")
+  (unless git-status (error "Not in git-status buffer."))
+  (ewoc-goto-next git-status n))
+
+(defun git-prev-file (&optional n)
+  "Move the selection up N files."
+  (interactive "p")
+  (unless git-status (error "Not in git-status buffer."))
+  (ewoc-goto-prev git-status n))
+
+(defun git-add-file ()
+  "Add marked file(s) to the index cache."
+  (interactive)
+  (let ((files (git-marked-files-state 'unknown)))
+    (unless files
+      (push (ewoc-data
+             (git-add-status-file 'added (file-relative-name
+                                          (read-file-name "File to add: " nil nil t))))
+            files))
+    (apply #'git-run-command nil nil "update-index" "--info-only" "--add" "--" (git-get-filenames files))
+    (git-set-files-state files 'added)
+    (git-refresh-files)))
+
+(defun git-ignore-file ()
+  "Add marked file(s) to the ignore list."
+  (interactive)
+  (let ((files (git-marked-files-state 'unknown)))
+    (unless files
+      (push (ewoc-data
+             (git-add-status-file 'unknown (file-relative-name
+                                            (read-file-name "File to ignore: " nil nil t))))
+            files))
+    (dolist (info files) (git-append-to-ignore (git-fileinfo->name info)))
+    (git-set-files-state files 'ignored)
+    (git-refresh-files)))
+
+(defun git-remove-file ()
+  "Remove the marked file(s)."
+  (interactive)
+  (let ((files (git-marked-files-state 'added 'modified 'unknown 'uptodate)))
+    (unless files
+      (push (ewoc-data
+             (git-add-status-file 'unknown (file-relative-name
+                                            (read-file-name "File to remove: " nil nil t))))
+            files))
+    (if (yes-or-no-p
+         (format "Remove %d file%s? " (length files) (if (> (length files) 1) "s" "")))
+        (progn
+          (dolist (info files)
+            (let ((name (git-fileinfo->name info)))
+              (when (file-exists-p name) (delete-file name))))
+          (apply #'git-run-command nil nil "update-index" "--info-only" "--remove" "--" (git-get-filenames files))
+          ; remove unknown files from the list, set the others to deleted
+          (ewoc-filter git-status
+                       (lambda (info files)
+                         (not (and (memq info files) (eq (git-fileinfo->state info) 'unknown))))
+                       files)
+          (git-set-files-state files 'deleted)
+          (git-refresh-files)
+          (unless (ewoc-nth git-status 0)  ; refresh header if list is empty
+            (git-refresh-ewoc-hf git-status)))
+      (message "Aborting"))))
+
+(defun git-revert-file ()
+  "Revert changes to the marked file(s)."
+  (interactive)
+  (let ((files (git-marked-files))
+        added modified)
+    (when (and files
+               (yes-or-no-p
+                (format "Revert %d file%s? " (length files) (if (> (length files) 1) "s" ""))))
+      (dolist (info files)
+        (case (git-fileinfo->state info)
+          ('added (push info added))
+          ('deleted (push info modified))
+          ('unmerged (push info modified))
+          ('modified (push info modified))))
+      (when added
+          (apply #'git-run-command nil nil "update-index" "--force-remove" "--" (git-get-filenames added))
+          (git-set-files-state added 'unknown))
+      (when modified
+          (apply #'git-run-command nil nil "checkout" "HEAD" (git-get-filenames modified))
+          (git-set-files-state modified 'uptodate))
+      (git-refresh-files))))
+
+(defun git-resolve-file ()
+  "Resolve conflicts in marked file(s)."
+  (interactive)
+  (let ((files (git-marked-files-state 'unmerged)))
+    (when files
+      (apply #'git-run-command nil nil "update-index" "--info-only" "--" (git-get-filenames files))
+      (git-set-files-state files 'modified)
+      (git-refresh-files))))
+
+(defun git-remove-handled ()
+  "Remove handled files from the status list."
+  (interactive)
+  (ewoc-filter git-status
+               (lambda (info)
+                 (not (or (eq (git-fileinfo->state info) 'ignored)
+                          (eq (git-fileinfo->state info) 'uptodate)))))
+  (unless (ewoc-nth git-status 0)  ; refresh header if list is empty
+    (git-refresh-ewoc-hf git-status)))
+
+(defun git-setup-diff-buffer (buffer)
+  "Setup a buffer for displaying a diff."
+  (with-current-buffer buffer
+    (diff-mode)
+    (goto-char (point-min))
+    (setq buffer-read-only t))
+  (display-buffer buffer)
+  (shrink-window-if-larger-than-buffer))
+
+(defun git-diff-file ()
+  "Diff the marked file(s) against HEAD."
+  (interactive)
+  (let ((files (git-marked-files)))
+    (git-setup-diff-buffer
+     (apply #'git-run-command-buffer "*git-diff*" "diff-index" "-p" "-M" "HEAD" "--" (git-get-filenames files)))))
+
+(defun git-diff-unmerged-file (stage)
+  "Diff the marked unmerged file(s) against the specified stage."
+  (let ((files (git-marked-files)))
+    (git-setup-diff-buffer
+     (apply #'git-run-command-buffer "*git-diff*" "diff-files" "-p" stage "--" (git-get-filenames files)))))
+
+(defun git-diff-file-base ()
+  "Diff the marked unmerged file(s) against the common base file."
+  (interactive)
+  (git-diff-unmerged-file "-1"))
+
+(defun git-diff-file-mine ()
+  "Diff the marked unmerged file(s) against my pre-merge version."
+  (interactive)
+  (git-diff-unmerged-file "-2"))
+
+(defun git-diff-file-other ()
+  "Diff the marked unmerged file(s) against the other's pre-merge version."
+  (interactive)
+  (git-diff-unmerged-file "-3"))
+
+(defun git-diff-file-combined ()
+  "Do a combined diff of the marked unmerged file(s)."
+  (interactive)
+  (git-diff-unmerged-file "-c"))
+
+(defun git-diff-file-idiff ()
+  "Perform an interactive diff on the current file."
+  (interactive)
+  (error "Interactive diffs not implemented yet."))
+
+(defun git-log-file ()
+  "Display a log of changes to the marked file(s)."
+  (interactive)
+  (let* ((files (git-marked-files))
+         (coding-system-for-read git-commits-coding-system)
+         (buffer (apply #'git-run-command-buffer "*git-log*" "rev-list" "--pretty" "HEAD" "--" (git-get-filenames files))))
+    (with-current-buffer buffer
+      ; (git-log-mode)  FIXME: implement log mode
+      (goto-char (point-min))
+      (setq buffer-read-only t))
+    (display-buffer buffer)))
+
+(defun git-log-edit-files ()
+  "Return a list of marked files for use in the log-edit buffer."
+  (with-current-buffer log-edit-parent-buffer
+    (git-get-filenames (git-marked-files-state 'added 'deleted 'modified))))
+
+(defun git-commit-file ()
+  "Commit the marked file(s), asking for a commit message."
+  (interactive)
+  (unless git-status (error "Not in git-status buffer."))
+  (let ((buffer (get-buffer-create "*git-commit*"))
+        (merge-heads (git-get-merge-heads))
+        (dir default-directory))
+    (with-current-buffer buffer
+      (when (eq 0 (buffer-size))
+        (cd dir)
+        (erase-buffer)
+        (insert
+         (propertize
+          (format "Author: %s <%s>\n%s"
+                  (git-get-committer-name) (git-get-committer-email)
+                  (if merge-heads
+                      (format "Parent: %s\n%s\n"
+                              (git-rev-parse "HEAD")
+                              (mapconcat (lambda (str) (concat "Parent: " str)) merge-heads "\n"))
+                    ""))
+          'face 'git-header-face)
+         (propertize git-log-msg-separator 'face 'git-separator-face)
+         "\n")
+        (when (and merge-heads (file-readable-p ".git/MERGE_MSG"))
+          (insert-file-contents ".git/MERGE_MSG"))))
+      (log-edit #'git-do-commit nil #'git-log-edit-files buffer)))
+
+(defun git-find-file ()
+  "Visit the current file in its own buffer."
+  (interactive)
+  (unless git-status (error "Not in git-status buffer."))
+  (let ((info (ewoc-data (ewoc-locate git-status))))
+    (find-file (git-fileinfo->name info))
+    (when (eq 'unmerged (git-fileinfo->state info))
+      (smerge-mode))))
+
+(defun git-find-file-imerge ()
+  "Visit the current file in interactive merge mode."
+  (interactive)
+  (unless git-status (error "Not in git-status buffer."))
+  (let ((info (ewoc-data (ewoc-locate git-status))))
+    (find-file (git-fileinfo->name info))
+    (smerge-ediff)))
+
+(defun git-view-file ()
+  "View the current file in its own buffer."
+  (interactive)
+  (unless git-status (error "Not in git-status buffer."))
+  (let ((info (ewoc-data (ewoc-locate git-status))))
+    (view-file (git-fileinfo->name info))))
+
+(defun git-refresh-status ()
+  "Refresh the git status buffer."
+  (interactive)
+  (let* ((status git-status)
+         (pos (ewoc-locate status))
+         (cur-name (and pos (git-fileinfo->name (ewoc-data pos)))))
+    (unless status (error "Not in git-status buffer."))
+    (git-clear-status status)
+    (git-run-command nil nil "update-index" "--info-only" "--refresh")
+    (if (git-empty-db-p)
+        ; we need some special handling for an empty db
+        (with-temp-buffer
+          (git-run-command t nil "ls-files" "-z" "-t" "-c")
+          (git-parse-ls-files status 'added))
+      (with-temp-buffer
+        (git-run-command t nil "diff-index" "-z" "-M" "HEAD")
+        (git-parse-status status)))
+      (with-temp-buffer
+        (git-run-command t nil "ls-files" "-z" "-u")
+        (git-parse-ls-unmerged status))
+      (when (file-readable-p ".git/info/exclude")
+        (with-temp-buffer
+          (git-run-command t nil "ls-files" "-z" "-t" "-o"
+                           "--exclude-from=.git/info/exclude"
+                           (concat "--exclude-per-directory=" git-per-dir-ignore-file))
+          (git-parse-ls-files status 'unknown)))
+    (git-refresh-files)
+    (git-refresh-ewoc-hf status)
+    ; move point to the current file name if any
+    (let ((node (and cur-name (git-find-status-file status cur-name))))
+      (when node (ewoc-goto-node status node)))))
+
+(defun git-status-quit ()
+  "Quit git-status mode."
+  (interactive)
+  (bury-buffer))
+
+;;;; Major Mode
+;;;; ------------------------------------------------------------
+
+(defvar git-status-mode-hook nil
+  "Run after `git-status-mode' is setup.")
+
+(defvar git-status-mode-map nil
+  "Keymap for git major mode.")
+
+(defvar git-status nil
+  "List of all files managed by the git-status mode.")
+
+(unless git-status-mode-map
+  (let ((map (make-keymap))
+        (diff-map (make-sparse-keymap)))
+    (suppress-keymap map)
+    (define-key map " "   'git-next-file)
+    (define-key map "a"   'git-add-file)
+    (define-key map "c"   'git-commit-file)
+    (define-key map "d"    diff-map)
+    (define-key map "="   'git-diff-file)
+    (define-key map "f"   'git-find-file)
+    (define-key map [RET] 'git-find-file)
+    (define-key map "g"   'git-refresh-status)
+    (define-key map "i"   'git-ignore-file)
+    (define-key map "l"   'git-log-file)
+    (define-key map "m"   'git-mark-file)
+    (define-key map "M"   'git-mark-all)
+    (define-key map "n"   'git-next-file)
+    (define-key map "p"   'git-prev-file)
+    (define-key map "q"   'git-status-quit)
+    (define-key map "r"   'git-remove-file)
+    (define-key map "R"   'git-resolve-file)
+    (define-key map "T"   'git-toggle-all-marks)
+    (define-key map "u"   'git-unmark-file)
+    (define-key map "U"   'git-revert-file)
+    (define-key map "v"   'git-view-file)
+    (define-key map "x"   'git-remove-handled)
+    (define-key map "\C-?" 'git-unmark-file-up)
+    (define-key map "\M-\C-?" 'git-unmark-all)
+    ; the diff submap
+    (define-key diff-map "b" 'git-diff-file-base)
+    (define-key diff-map "c" 'git-diff-file-combined)
+    (define-key diff-map "=" 'git-diff-file)
+    (define-key diff-map "e" 'git-diff-file-idiff)
+    (define-key diff-map "E" 'git-find-file-imerge)
+    (define-key diff-map "m" 'git-diff-file-mine)
+    (define-key diff-map "o" 'git-diff-file-other)
+    (setq git-status-mode-map map)))
+
+;; git mode should only run in the *git status* buffer
+(put 'git-status-mode 'mode-class 'special)
+
+(defun git-status-mode ()
+  "Major mode for interacting with Git.
+Commands:
+\\{git-status-mode-map}"
+  (kill-all-local-variables)
+  (buffer-disable-undo)
+  (setq mode-name "git status"
+        major-mode 'git-status-mode
+        goal-column 17
+        buffer-read-only t)
+  (use-local-map git-status-mode-map)
+  (let ((buffer-read-only nil))
+    (erase-buffer)
+  (let ((status (ewoc-create 'git-fileinfo-prettyprint "" "")))
+    (set (make-local-variable 'git-status) status))
+  (run-hooks 'git-status-mode-hook)))
+
+(defun git-status (dir)
+  "Entry point into git-status mode."
+  (interactive "DSelect directory: ")
+  (setq dir (git-get-top-dir dir))
+  (if (file-directory-p (concat (file-name-as-directory dir) ".git"))
+      (let ((buffer (create-file-buffer (expand-file-name "*git-status*" dir))))
+        (switch-to-buffer buffer)
+        (git-status-mode)
+        (cd dir)
+        (git-refresh-status)
+        (goto-char (point-min)))
+    (message "%s is not a git working tree." dir)))
+
+(provide 'git)
+;;; git.el ends here
-- 
1.2.1.gfd1fe

-- 
Alexandre Julliard
julliard@winehq.org
