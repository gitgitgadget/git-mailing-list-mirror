From: Alexandre Julliard <julliard@winehq.org>
Subject: Emacs mode for git
Date: Sun, 27 Nov 2005 23:25:36 +0100
Message-ID: <87u0dx7mov.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-From: git-owner@vger.kernel.org Sun Nov 27 23:26:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgUyC-0008PX-KW
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 23:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVK0WZr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 17:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVK0WZr
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 17:25:47 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:64432 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751161AbVK0WZq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 17:25:46 -0500
Received: from adsl-84-227-57-102.adslplus.ch ([84.227.57.102] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1EgUxm-00034w-Dd
	for git@vger.kernel.org; Sun, 27 Nov 2005 16:25:45 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id BA5574F8A1; Sun, 27 Nov 2005 23:25:36 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-SA-Exim-Connect-IP: 84.227.57.102
X-SA-Exim-Mail-From: julliard@winehq.org
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on mail
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,
	SPF_HELO_SOFTFAIL autolearn=no version=3.0.2
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12831>

--=-=-=

Here's the beginning of an Emacs mode for git. My primary goal at this
point is to replicate the behavior of the pcl-cvs mode.

Most basic functions are implemented (diff, commit, revert, add/remove
files, .gitignore, etc.) There is currently no support for multiple
branches or file merges. The code has been tested only on Emacs 21, it
will probably need some tweaking to run on XEmacs.

Feedback welcome...

-- 
Alexandre Julliard
julliard@winehq.org


--=-=-=
Content-Disposition: inline; filename=git.el

;;; git.el --- A user interface for git

;; Copyright (C) 2005 Alexandre Julliard <julliard@winehq.org>

;; Version: 0.1

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA

;;; Commentary:

;; This file contains an interface for the git version control
;; system. It provides easy access to the most frequently used git
;; commands. The user interface is as far as possible identical to
;; that of the PCL-CVS mode.
;;
;; To install: put this file on the load-path and place the following
;; in your .emacs file:
;;
;;    (require 'git)
;;
;; To start: `M-x git-status'
;;
;; TODO
;;  - better handling of subprocess errors
;;  - GIT_DIR support
;;  - hook into file save (after-save-hook)
;;  - diff against other branch
;;  - commands for renaming files
;;  - fetch and merge
;;

(eval-when-compile (require 'cl))
(require 'ewoc)


;;;; Faces
;;;; ------------------------------------------------------------

(defface git-status-face
  '((((class color) (background light)) (:foreground "purple")))
  "Git mode face used to highlight renamed files.")

(defface git-unmerged-face
  '((((class color) (background light)) (:foreground "red" :bold t)))
  "Git mode face used to highlight unmerged files.")

(defface git-unknown-face
  '((((class color) (background light)) (:foreground "goldenrod" :bold t)))
  "Git mode face used to highlight unknown files.")

(defface git-uptodate-face
  '((((class color) (background light)) (:foreground "grey60")))
  "Git mode face used to highlight up-to-date files.")

(defface git-ignored-face
  '((((class color) (background light)) (:foreground "grey60")))
  "Git mode face used to highlight ignored files.")

(defface git-mark-face
  '((((class color) (background light)) (:foreground "red" :bold t)))
  "Git mode face used for the file marks.")

(defface git-header-face
  '((((class color) (background light)) (:foreground "blue")))
  "Git mode face used for commit headers.")

(defface git-separator-face
  '((((class color) (background light)) (:foreground "brown")))
  "Git mode face used for commit separator.")

(defface git-permission-face
  '((((class color) (background light)) (:foreground "green" :bold t)))
  "Git mode face used for permission changes.")

(defvar git-committer-name nil
  "*User name to use for commits.
If not set, fall back to `add-log-full-name' and then `user-full-name'.")

(defvar git-committer-email nil
  "*Email address to use for commits.
If not set, fall back to `add-log-mailing-address' and then `user-mail-address'.")

(defconst git-log-msg-separator "--- log message follows this line ---")

(defconst git-per-dir-ignore-file ".gitignore"
  "Name of the per-directory ignore file.")


;;;; Utilities
;;;; ------------------------------------------------------------

(defun git-get-env-strings (env)
  "Build a list of NAME=VALUE strings from a list of environment strings."
  (mapcar (lambda (entry) (concat (car entry) "=" (cdr entry))) env))

(defun git-call-process-env (program infile buffer display env &rest args)
  "Wrapper for call-process that sets environment strings."
  (let ((coding-system-for-read 'utf-8)
        (coding-system-for-write 'utf-8))
    (if env
        (apply #'call-process "env" infile buffer display
               (append (git-get-env-strings env) (list program) args))
      (apply #'call-process program infile buffer display args))))

(defun git-run-process-region (buffer start end args)
  "Run a git process with a buffer region as input."
  (let ((output-buffer (current-buffer))
        (dir default-directory))
    (with-current-buffer buffer
      (let ((coding-system-for-read 'utf-8)  ; FIXME: should be configurable
            (coding-system-for-write 'utf-8))
        (cd dir)
        (apply #'call-process-region start end (car args)
               nil (list output-buffer nil) nil (cdr args))))))

(defun git-run-command-buffer (buffer-name &rest args)
  "Run a git command, sending the output to a buffer named BUFFER-NAME."
  (let ((dir default-directory)
        (buffer (get-buffer-create buffer-name)))
    (message "Running %s..." (car args))
    (with-current-buffer buffer
      (let ((default-directory dir)
            (buffer-read-only nil))
        (erase-buffer)
        (apply #'git-call-process-env (car args) nil buffer nil nil (cdr args))))
    (message "Running %s...done" (car args))
    buffer))

(defun git-run-command (buffer env &rest args)
  (message "Running %s..." (car args))
  (apply #'git-call-process-env (car args) nil buffer nil env (cdr args))
  (message "Running %s...done" (car args)))

(defun git-run-command-region (buffer start end env &rest args)
  "Run a git command with specified buffer region as input."
  (message "Running %s..." (car args))
  (unless (eq 0 (git-run-process-region
                 buffer start end
                 (if env (append (list "env") (git-get-env-strings env) args) args)))
    (error "Failed to run \"%s\":\n%s" (mapconcat (lambda (x) x) args " ") (buffer-string)))
  (message "Running %s...done" (car args)))

(defun git-get-buffer-sha1 (buffer)
  "Read a SHA1 string from the specified buffer."
  (with-current-buffer buffer
    (goto-char (point-min))
    (and (re-search-forward "[0-9a-f]\\{40\\}")
         (match-string 0))))

(defun git-get-string-sha1 (string)
  "Read a SHA1 from the specified string."
  (let ((pos (string-match "[0-9a-f]\\{40\\}" string)))
    (and pos (substring string pos (match-end 0)))))

(defun git-get-committer-name ()
  "Return the name to use as GIT_COMMITTER_NAME."
  ; copied from log-edit
  (or git-committer-name
      (and (boundp 'add-log-full-name) add-log-full-name)
      (and (fboundp 'user-full-name) (user-full-name))
      (and (boundp 'user-full-name) user-full-name)))

(defun git-get-committer-email ()
  "Return the email address to use as GIT_COMMITTER_EMAIL."
  ; copied from log-edit
  (or git-committer-email
      (and (boundp 'add-log-mailing-address) add-log-mailing-address)
      (and (fboundp 'user-mail-address) (user-mail-address))
      (and (boundp 'user-mail-address) user-mail-address)))

(defun git-escape-file-name (name)
  "Escape a file name if necessary."
  (if (string-match "[\n\t\"\\]" name)
      (concat "\""
              (mapconcat (lambda (c)
                   (case c
                     (?\n "\\n")
                     (?\t "\\t")
                     (?\\ "\\\\")
                     (?\" "\\\"")
                     (t (char-to-string c))))
                 name "")
              "\"")
    name))

;stolen from pcl-cvs
(defun git-append-to-ignore (file)
  "Add a file name to the ignore file in its directory."
  (let* ((fullname (expand-file-name file))
         (dir (file-name-directory fullname))
         (name (file-name-nondirectory fullname)))
  (save-window-excursion
    (set-buffer (find-file-noselect (expand-file-name git-per-dir-ignore-file dir)))
    (goto-char (point-max))
    (unless (zerop (current-column)) (insert "\n"))
    (insert name "\n")
    (sort-lines nil (point-min) (point-max))
    (save-buffer))))


;;;; Wrappers for basic git commands
;;;; ------------------------------------------------------------

(defun git-rev-parse (rev)
  "Parse a revision name and return its SHA1."
  (git-get-string-sha1
   (with-output-to-string
     (with-current-buffer standard-output
       (git-call-process-env "git-rev-parse" nil t nil nil rev)))))

(defun git-symbolic-ref (ref)
  "Wrapper for the git-symbolic-ref command."
  (car
   (split-string
    (with-output-to-string
      (with-current-buffer standard-output
        (git-call-process-env "git-symbolic-ref" nil t nil nil ref)))
    "\n")))

(defun git-update-ref (ref val &optional oldval)
  "Update a reference by calling git-update-ref."
  (apply #'git-call-process-env "git-update-ref" nil nil nil nil ref val (if oldval (list oldval))))

(defun git-read-tree (tree &optional index-file)
  "Read a tree into the index file."
  (apply #'git-call-process-env
         "git-read-tree" nil nil nil
         (if index-file `(("GIT_INDEX_FILE" . ,index-file)) nil)
         (if tree (list tree))))

(defun git-write-tree (&optional index-file)
  "Call git-write-tree and return the resulting tree SHA1 as a string."
  (git-get-string-sha1
   (with-output-to-string
     (with-current-buffer standard-output
       (git-call-process-env
        "git-write-tree" nil t nil
        (if index-file `(("GIT_INDEX_FILE" . ,index-file)) nil))))))

(defun git-commit-tree (buffer tree parents)
  "Call git-commit-tree with buffer as input and return the resulting commit SHA1."
  (let ((author-name (git-get-committer-name))
        (author-email (git-get-committer-email))
        author-date log-start log-end args)
    (with-current-buffer buffer
      (goto-char (point-min))
      (if
          (setq log-start (re-search-forward (concat "^" git-log-msg-separator "\n") nil t))
          (progn
            (goto-char (point-min))
            (when (re-search-forward "^Author: +\\(.*?\\) *<\\(.*\\)> *$" nil t)
              (setq author-name (match-string 1)
                    author-email (match-string 2)))
            (goto-char (point-min))
            (when (re-search-forward "^Date: +\\(.*\\)$" nil t)
              (setq author-date (match-string 1))))
        (setq log-start (point-min)))
      (setq log-end (point-max)))
    (dolist (p parents)
      (push "-p" args)
      (push p args))
    (git-get-string-sha1
     (with-output-to-string
       (with-current-buffer standard-output
         (let ((env `(("GIT_AUTHOR_NAME" . ,author-name)
                      ("GIT_AUTHOR_EMAIL" . ,author-email)
                      ("GIT_COMMITTER_NAME" . ,(git-get-committer-name))
                      ("GIT_COMMITTER_EMAIL" . ,(git-get-committer-email)))))
           (when author-date (push `("GIT_AUTHOR_DATE" . ,author-date) env))
           (apply #'git-run-command-region
                  buffer log-start log-end env
                  "git-commit-tree" tree (nreverse args))))))))

(defun git-empty-db-p ()
  "Check if the git db is empty (no commit done yet)."
  (not (file-exists-p ".git/HEAD")))


;;;; File info structure
;;;; ------------------------------------------------------------

; fileinfo structure stolen from pcl-cvs
(defstruct (git-fileinfo
            (:copier nil)
            (:constructor git-create-fileinfo (state name &optional old-perm new-perm rename-state orig-name marked))
            (:conc-name git-fileinfo->))
  marked              ;; t/nil
  state               ;; current state
  name                ;; file name
  old-perm new-perm   ;; permission flags
  rename-state        ;; rename or copy state
  orig-name           ;; original name for renames or copies
  needs-refresh)      ;; whether file needs to be refreshed

(defvar git-status nil)

(defun git-clear-status (status)
  "Remove everything from the status list."
  (ewoc-filter status (lambda (info) nil)))

(defun git-set-files-state (files state)
  "Set the state of a list of files."
  (dolist (info files)
    (unless (eq (git-fileinfo->state info) state)
      (setf (git-fileinfo->state info) state)
      (setf (git-fileinfo->rename-state info) nil)
      (setf (git-fileinfo->orig-name info) nil)
      (setf (git-fileinfo->needs-refresh info) t))))

(defun git-state-code (code)
  "Convert from a string to a added/deleted/modified state."
  (case (string-to-char code)
    (?M 'modified)
    (?? 'unknown)
    (?A 'added)
    (?D 'deleted)
    (?U 'unmerged)
    (t nil)))

(defun git-status-code-as-string (code)
  "Format a git status code as string."
  (case code
    ('modified (propertize "Modified" 'face 'git-status-face))
    ('unknown  (propertize "Unknown " 'face 'git-unknown-face))
    ('added    (propertize "Added   " 'face 'git-status-face))
    ('deleted  (propertize "Deleted " 'face 'git-status-face))
    ('unmerged (propertize "Unmerged" 'face 'git-unmerged-face))
    ('uptodate (propertize "Uptodate" 'face 'git-uptodate-face))
    ('ignored  (propertize "Ignored " 'face 'git-ignored-face))
    (t "?       ")))

(defun git-rename-as-string (info)
  "Return a string describing the copy or rename associated with INFO, or an empty string if none."
  (let ((state (git-fileinfo->rename-state info)))
    (if state
        (propertize
         (concat "   ("
                 (if (eq state 'copy) "copied from "
                   (if (eq (git-fileinfo->state info) 'added) "renamed to "
                     "renamed from "))
                 (git-escape-file-name (git-fileinfo->orig-name info))
                 ")") 'face 'git-status-face)
      "")))

(defun git-permissions-as-string (old-perm new-perm)
  "Format a permission change as string."
  (propertize
   (if (or (not old-perm)
           (not new-perm)
           (eq 0 (logand #O111 (logxor old-perm new-perm))))
       "  "
     (if (eq 0 (logand #O111 old-perm)) "+x" "-x"))
  'face 'git-permission-face))

(defun git-fileinfo-prettyprint (info)
  "Pretty-printer for the git-fileinfo structure."
  (insert (format "   %s %s %s  %s%s"
                  (if (git-fileinfo->marked info) (propertize "*" 'face 'git-mark-face) " ")
                  (git-status-code-as-string (git-fileinfo->state info))
                  (git-permissions-as-string (git-fileinfo->old-perm info) (git-fileinfo->new-perm info))
                  (git-escape-file-name (git-fileinfo->name info))
                  (git-rename-as-string info))))

(defun git-parse-status (status)
  "Parse the output of git-diff-index in the current buffer."
  (goto-char (point-min))
  (while (re-search-forward
          ":\\([0-7]\\{6\\}\\) \\([0-7]\\{6\\}\\) [0-9a-f]\\{40\\} [0-9a-f]\\{40\\} \\(\\([ADMU]\\)\0\\([^\0]+\\)\\|\\([CR]\\)[0-9]*\0\\([^\0]+\\)\0\\([^\0]+\\)\\)\0"
          nil t 1)
    (let ((old-perm (string-to-number (match-string 1) 8))
          (new-perm (string-to-number (match-string 2) 8))
          (state (or (match-string 4) (match-string 6)))
          (name (or (match-string 5) (match-string 7)))
          (new-name (match-string 8)))
      (if new-name  ; copy or rename
          (if (eq ?C (string-to-char state))
              (ewoc-enter-last status (git-create-fileinfo 'added new-name old-perm new-perm 'copy name))
            (ewoc-enter-last status (git-create-fileinfo 'deleted name 0 0 'rename new-name))
            (ewoc-enter-last status (git-create-fileinfo 'added new-name old-perm new-perm 'rename name)))
        (ewoc-enter-last status (git-create-fileinfo (git-state-code state) name old-perm new-perm))))))

(defun git-find-status-file (status file)
  "Find a given file in the status ewoc and return its node."
  (let ((node (ewoc-nth status 0)))
    (while (and node (not (string= file (git-fileinfo->name (ewoc-data node)))))
      (setq node (ewoc-next status node)))
    node))

(defun git-parse-ls-files (status default-state &optional skip-existing)
  "Parse the output of git-ls-files in the current buffer."
  (goto-char (point-min))
  (while (re-search-forward "\\([HMRCK?]\\) \\([^\0]*\\)\0" nil t 1)
    (let ((state (match-string 1))
          (name (match-string 2))
          infolist)
      (unless (and skip-existing (git-find-status-file status name))
        (push (git-create-fileinfo (or (git-state-code state) default-state) name) infolist))
      (dolist (info infolist)
          (ewoc-enter-last status info)))))

(defun git-add-status-file (state name &optional old-perm new-perm)
  "Add a new file to the status list (if not existing already) and return its node."
  (unless git-status (error "Not in git-status buffer."))
  (or (git-find-status-file git-status name)
      (ewoc-enter-last git-status (git-create-fileinfo state name))))

(defun git-marked-files ()
  "Return a list of all marked files, or if none a list containing just the file at cursor position."
  (unless git-status (error "Not in git-status buffer."))
  (or (ewoc-collect git-status (lambda (info) (git-fileinfo->marked info)))
      (list (ewoc-data (ewoc-locate git-status)))))

(defun git-marked-files-state (&rest states)
  "Return marked files that are in the specified states."
  (let ((files (git-marked-files))
        result)
    (dolist (info files)
      (when (memq (git-fileinfo->state info) states)
        (push info result)))
    result))

(defun git-refresh-files ()
  "Refresh all files that need it and clear the needs-refresh flag."
  (unless git-status (error "Not in git-status buffer."))
  (ewoc-map
   (lambda (info)
     (let ((refresh (git-fileinfo->needs-refresh info)))
       (setf (git-fileinfo->needs-refresh info) nil)
       refresh))
   git-status)
  ; move back to goal column
  (when goal-column (move-to-column goal-column)))

(defun git-refresh-ewoc-hf (status)
  "Refresh the ewoc header and footer."
  (ewoc-set-hf status
               (format "Directory:  %s\nBranch:     %s\nHead:       %s\n"
                       default-directory
                       (git-symbolic-ref "HEAD")
                       (if (git-empty-db-p) "Nothing committed yet" (git-rev-parse "HEAD")))
               (if (ewoc-nth status 0) "" "    No changes.")))

(defun git-check-exclude-file ()
  "Check for non empty .git/info/exclude file like git-status does."
  (when (file-readable-p ".git/info/exclude")
    (with-temp-buffer
      (insert-file-contents ".git/info/exclude" nil nil nil t)
      (goto-char (point-min))
      (re-search-forward "^[^#]" nil t))))

(defun git-get-filenames (files)
  (mapcar (lambda (info) (git-fileinfo->name info)) files))

(defun git-update-index (index-file files)
  "Run git-update-index on a list of files."
  (let ((env (and index-file `(("GIT_INDEX_FILE" . ,index-file))))
        added deleted modified)
    (dolist (info files)
      (case (git-fileinfo->state info)
        ('added (push info added))
        ('deleted (push info deleted))
        ('modified (push info modified))))
    (when added
      (apply #'git-run-command nil env "git-update-index" "--add" "--" (git-get-filenames added)))
    (when deleted
      (apply #'git-run-command nil env "git-update-index" "--remove" "--" (git-get-filenames deleted)))
    (when modified
      (apply #'git-run-command nil env "git-update-index" "--" (git-get-filenames modified)))))

(defun git-do-commit ()
  "Perform the actual commit using the current buffer as log message."
  (interactive)
  (let ((buffer (current-buffer))
        (index-file (make-temp-file "gitidx")))
    (with-current-buffer log-edit-parent-buffer
      (unwind-protect
          (let ((files (git-marked-files-state 'added 'deleted 'modified))
                head head-tree)
            (unless (git-empty-db-p)
              (setq head (git-rev-parse "HEAD")
                    head-tree (git-rev-parse "HEAD^{tree}")))
            (if files
                (progn
                  (git-read-tree head-tree index-file)
                  (git-update-index nil files)         ;update both the default index
                  (git-update-index index-file files)  ;and the temporary one
                  (let ((tree (git-write-tree index-file)))
                    (if (or (not (string-equal tree head-tree))
                            (yes-or-no-p "The tree was not modified, do you really want to perform an empty commit? "))
                        (let ((commit (git-commit-tree buffer tree (if head (list head)))))
                          (git-update-ref "HEAD" commit head)
                          (git-set-files-state files 'uptodate)
                          (git-refresh-files)
                          (git-refresh-ewoc-hf git-status)
                          (message "Committed %s." commit))
                      (message "Commit aborted."))))
              (message "No files to commit.")))
        (delete-file index-file)))))


;;;; Interactive functions
;;;; ------------------------------------------------------------

(defun git-mark-file ()
  "Mark the file that the cursor is on and move to the next one."
  (interactive)
  (unless git-status (error "Not in git-status buffer."))
  (let* ((pos (ewoc-locate git-status))
         (info (ewoc-data pos)))
    (setf (git-fileinfo->marked info) t)
    (ewoc-invalidate git-status pos)
    (ewoc-goto-next git-status 1)))

(defun git-unmark-file ()
  "Unmark the file that the cursor is on and move to the next one."
  (interactive)
  (unless git-status (error "Not in git-status buffer."))
  (let* ((pos (ewoc-locate git-status))
         (info (ewoc-data pos)))
    (setf (git-fileinfo->marked info) nil)
    (ewoc-invalidate git-status pos)
    (ewoc-goto-next git-status 1)))

(defun git-unmark-file-up ()
  "Unmark the file that the cursor is on and move to the previous one."
  (interactive)
  (unless git-status (error "Not in git-status buffer."))
  (let* ((pos (ewoc-locate git-status))
         (info (ewoc-data pos)))
    (setf (git-fileinfo->marked info) nil)
    (ewoc-invalidate git-status pos)
    (ewoc-goto-prev git-status 1)))

(defun git-mark-all ()
  "Mark all files."
  (interactive)
  (unless git-status (error "Not in git-status buffer."))
  (ewoc-map (lambda (info) (setf (git-fileinfo->marked info) t) t) git-status)
  ; move back to goal column after invalidate
  (when goal-column (move-to-column goal-column)))

(defun git-unmark-all ()
  "Unmark all files."
  (interactive)
  (unless git-status (error "Not in git-status buffer."))
  (ewoc-map (lambda (info) (setf (git-fileinfo->marked info) nil) t) git-status)
  ; move back to goal column after invalidate
  (when goal-column (move-to-column goal-column)))

(defun git-toggle-all-marks ()
  "Toggle all file marks."
  (interactive)
  (unless git-status (error "Not in git-status buffer."))
  (ewoc-map (lambda (info) (setf (git-fileinfo->marked info) (not (git-fileinfo->marked info))) t) git-status)
  ; move back to goal column after invalidate
  (when goal-column (move-to-column goal-column)))

(defun git-next-file (&optional n)
  "Move the selection down N files."
  (interactive "p")
  (unless git-status (error "Not in git-status buffer."))
  (ewoc-goto-next git-status n))

(defun git-prev-file (&optional n)
  "Move the selection up N files."
  (interactive "p")
  (unless git-status (error "Not in git-status buffer."))
  (ewoc-goto-prev git-status n))

(defun git-add-file ()
  "Add marked file(s) to the index cache."
  (interactive)
  (let ((files (git-marked-files-state 'unknown)))
    (unless files
      (push (ewoc-data
             (git-add-status-file 'added (file-relative-name
                                          (read-file-name "File to add: " nil nil t))))
            files))
    (apply #'git-run-command nil nil "git-update-index" "--info-only" "--add" "--" (git-get-filenames files))
    (git-set-files-state files 'added)
    (git-refresh-files)))

(defun git-ignore-file ()
  "Add marked file(s) to the ignore list."
  (interactive)
  (let ((files (git-marked-files-state 'unknown)))
    (unless files
      (push (ewoc-data
             (git-add-status-file 'unknown (file-relative-name
                                            (read-file-name "File to ignore: " nil nil t))))
            files))
    (dolist (info files) (git-append-to-ignore (git-fileinfo->name info)))
    (git-set-files-state files 'ignored)
    (git-refresh-files)))

(defun git-remove-file ()
  "Remove the marked file(s)."
  (interactive)
  (let ((files (git-marked-files-state 'added 'modified 'unknown 'uptodate)))
    (unless files
      (push (ewoc-data
             (git-add-status-file 'unknown (file-relative-name
                                            (read-file-name "File to remove: " nil nil t))))
            files))
    (if (yes-or-no-p
         (format "Remove %d file%s? " (length files) (if (> (length files) 1) "s" "")))
        (progn
          (dolist (info files)
            (let ((name (git-fileinfo->name info)))
              (when (file-exists-p name) (delete-file name))))
          (apply #'git-run-command nil nil "git-update-index" "--info-only" "--remove" "--" (git-get-filenames files))
          ; remove unknown files from the list, set the others to deleted
          (ewoc-filter git-status
                       (lambda (info files)
                         (not (and (memq info files) (eq (git-fileinfo->state info) 'unknown))))
                       files)
          (git-set-files-state files 'deleted)
          (git-refresh-files))
      (message "Aborting"))))

(defun git-revert-file ()
  "Revert changes to the marked file(s)."
  (interactive)
  (let ((files (git-marked-files))
        added deleted modified)
    (when (and files
               (yes-or-no-p
                (format "Revert %d file%s? " (length files) (if (> (length files) 1) "s" ""))))
      (dolist (info files)
        (case (git-fileinfo->state info)
          ('added (push info added))
          ('deleted (push info deleted))
          ('modified (push info modified))))
          ; FIXME: unmerged state
      (when added
          (apply #'git-run-command nil nil "git-update-index" "--force-remove" "--" (git-get-filenames added))
          (git-set-files-state added 'unknown))
      (when modified
          (apply #'git-run-command nil nil "git-checkout-index" "-f" "-u" "--" (git-get-filenames modified))
          (git-set-files-state modified 'uptodate))
      (when deleted
        (error "revert for deleted files not implemented yet"))
      (git-refresh-files))))

(defun git-remove-handled ()
  "Remove handled files from the status list."
  (interactive)
  (ewoc-filter git-status
               (lambda (info)
                 (not (or (eq (git-fileinfo->state info) 'ignored)
                          (eq (git-fileinfo->state info) 'uptodate))))))

(defun git-diff-file ()
  "Diff the marked file(s) against HEAD."
  (interactive)
  (let* ((files (git-marked-files))
         (buffer (apply #'git-run-command-buffer "*git-diff*" "git-diff-index" "-p" "-M" "HEAD" "--" (git-get-filenames files))))
    (with-current-buffer buffer
      (diff-mode)
      (goto-char (point-min))
      (setq buffer-read-only t))
    (display-buffer buffer)))

(defun git-log-file ()
  "Display a log of changes to the marked file(s)."
  (interactive)
  (let* ((files (git-marked-files))
         (buffer (apply #'git-run-command-buffer "*git-log*" "git-rev-list" "--pretty" "HEAD" "--" (git-get-filenames files))))
    (with-current-buffer buffer
      ; (git-log-mode)  FIXME: implement log mode
      (goto-char (point-min))
      (setq buffer-read-only t))
    (display-buffer buffer)))

(defun git-commit-file (arg)
  "Commit the marked file(s), asking for a commit message. With prefix arg, add Author and Date fields for easy editing."
  (interactive "P")
  (let ((buffer (get-buffer-create "*git-commit*")))
    (with-current-buffer buffer
      (when arg
        ; FIXME: should get these from the merge info if any
        (erase-buffer)
        (insert
         (propertize
          (format "Author: %s <%s>\nDate: %s"
                  (git-get-committer-name)
                  (git-get-committer-email)
                  (current-time-string))
          'face 'git-header-face)
         "\n"
         (propertize git-log-msg-separator 'face 'git-separator-face)
         "\n")))
    (log-edit #'git-do-commit nil nil buffer)))

(defun git-find-file ()
  "Visit the current file in its own buffer."
  (interactive)
  (unless git-status (error "Not in git-status buffer."))
  (let ((info (ewoc-data (ewoc-locate git-status))))
    (find-file (git-fileinfo->name info))))

(defun git-view-file ()
  "View the current file in its own buffer."
  (interactive)
  (unless git-status (error "Not in git-status buffer."))
  (let ((info (ewoc-data (ewoc-locate git-status))))
    (view-file (git-fileinfo->name info))))

(defun git-refresh-status ()
  "Refresh the git status buffer."
  (interactive)
  (let* ((status git-status)
         (pos (ewoc-locate status))
         (cur-name (and pos (git-fileinfo->name (ewoc-data pos)))))
    (unless status (error "Not in git-status buffer."))
    (git-clear-status status)
    (git-run-command nil nil "git-update-index" "--info-only" "--refresh")
    (if (git-empty-db-p)
        ; we need some special handling for an empty db
        (with-temp-buffer
          (git-run-command t nil "git-ls-files" "-z" "-t" "-c")
          (git-parse-ls-files status 'added))
      (with-temp-buffer
        (git-run-command t nil "git-diff-index" "-z" "-M" "HEAD")
        (git-parse-status status)))
    (when (git-check-exclude-file)
      (with-temp-buffer
        (git-run-command t nil "git-ls-files" "-z" "-t" "-o"
                         "--exclude-from=.git/info/exclude"
                         (concat "--exclude-per-directory=" git-per-dir-ignore-file))
        (git-parse-ls-files status 'unknown)))
    (git-refresh-files)
    (git-refresh-ewoc-hf status)
    ; move point to the current file name if any
    (let ((node (and cur-name (git-find-status-file status cur-name))))
      (when node (ewoc-goto-node status node)))))

(defun git-status-quit ()
  "Quit git-status mode."
  (interactive)
  (bury-buffer))

;;;; Major Mode
;;;; ------------------------------------------------------------

(defvar git-status-mode-hook nil
  "Run after `git-status-mode' is setup.")

(defvar git-status-mode-map nil
  "Keymap for git major mode.")

(defvar git-status nil
  "List of all files managed by the git-status mode.")

(unless git-status-mode-map
  (let ((map (make-keymap)))
    (suppress-keymap map)
    (define-key map " "   'git-next-file)
    (define-key map "a"   'git-add-file)
    (define-key map "c"   'git-commit-file)
    (define-key map "d"   'git-diff-file)
    (define-key map "="   'git-diff-file)
    (define-key map "f"   'git-find-file)
    (define-key map [RET] 'git-find-file)
    (define-key map "g"   'git-refresh-status)
    (define-key map "i"   'git-ignore-file)
    (define-key map "l"   'git-log-file)
    (define-key map "m"   'git-mark-file)
    (define-key map "M"   'git-mark-all)
    (define-key map "n"   'git-next-file)
    (define-key map "p"   'git-prev-file)
    (define-key map "q"   'git-status-quit)
    (define-key map "r"   'git-remove-file)
    (define-key map "T"   'git-toggle-all-marks)
    (define-key map "u"   'git-unmark-file)
    (define-key map "U"   'git-revert-file)
    (define-key map "v"   'git-view-file)
    (define-key map "x"   'git-remove-handled)
    (define-key map "\C-?" 'git-unmark-file-up)
    (define-key map "\M-\C-?" 'git-unmark-all)
    (setq git-status-mode-map map)))

;; git mode should only run in the *git status* buffer
(put 'git-status-mode 'mode-class 'special)

(defun git-status-mode ()
  "Major mode for interacting with Git.
Commands:
\\{git-status-mode-map}"
  (kill-all-local-variables)
  (buffer-disable-undo)
  (setq mode-name "git status"
        major-mode 'git-status-mode
        goal-column 17
        buffer-read-only t)
  (use-local-map git-status-mode-map)
  (let ((buffer-read-only nil))
    (erase-buffer)
  (let ((status (ewoc-create 'git-fileinfo-prettyprint "" "")))
    (set (make-local-variable 'git-status) status))
  (run-hooks 'git-status-mode-hook)))

(defun git-status (dir)
  "Entry point into git-status mode."
  (interactive "DSelect directory: ")
  (if (file-directory-p (concat (file-name-as-directory dir) ".git"))
      (let ((buffer (create-file-buffer (expand-file-name "*git-status*" dir))))
        (switch-to-buffer buffer)
        (git-status-mode)
        (cd dir)
        (git-refresh-status)
        (goto-char (point-min)))
    (message "%s is not a git working tree." dir)))

(provide 'git)
;;; git.el ends here

--=-=-=--
