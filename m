From: =?utf-8?q?G=C3=A1bor_Melis?= <mega@retes.hu>
Subject: Re: git emacs mode patch
Date: Sun, 25 Mar 2007 19:03:15 +0200
Message-ID: <200703251903.15333.mega@retes.hu>
References: <200703151403.56552.mega@retes.hu> <87y7lwxk2e.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TtqBGiGnuD/Jr6c"
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Mon Mar 26 11:27:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVlUH-0001uc-1m
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 11:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbXCZJ1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 05:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbXCZJ1d
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 05:27:33 -0400
Received: from rfallback.ya.com ([62.151.4.18]:40749 "EHLO rfallback.ya.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027AbXCZJ1c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 05:27:32 -0400
X-Greylist: delayed 58634 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Mar 2007 05:27:31 EDT
Received: from [192.168.1.53] (helo=smtpauth.ya.com)
	by rfallback.ya.com with esmtp id 1HVWES-0001yv-00
	for git@vger.kernel.org; Sun, 25 Mar 2007 19:10:16 +0200
Received: from [88.8.64.236] (helo=236.red-88-8-64.dynamicip.rima-tde.net)
	by smtpauth.ya.com with asmtp id 1HVW7b-0002th-00; Sun, 25 Mar 2007 19:03:11 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <87y7lwxk2e.fsf@wine.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43137>

--Boundary-00=_TtqBGiGnuD/Jr6c
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 17 March 2007 11:04, Alexandre Julliard wrote:
> G=C3=A1bor Melis <mega@retes.hu> writes:
> > +(defcustom git-hide-unknown t
> > +  "Hide files with unknown status by default."
> > +  :group 'git
> > +  :type 'boolean)
>
> This one should default to nil for backwards compatibility.
>
> > @@ -1017,15 +1028,18 @@ and returns the process output as a
> > string." (with-temp-buffer
> >          (git-run-command t nil "diff-index" "-z" "-M" "HEAD")
> >          (git-parse-status status)))
> > +    (unless (member 'up-to-date hidden-statuses)
> >        (with-temp-buffer
> > -        (git-run-command t nil "ls-files" "-z" "-u")
> > -        (git-parse-ls-unmerged status))
> > +        (git-run-command t nil "ls-files" "-z" "-t")
> > +        (git-parse-ls-files status 'unknown)))
> > +    (unless (member 'unknown hidden-statuses)
>
> Why are you removing the ls-files -u?  This will break the detection
> of unmerged files.
>
> > +(defun git-toggle-up-to-date ()
> > +  (interactive)
> > +  (if (member 'up-to-date hidden-statuses)
> > +      (setq hidden-statuses (remove 'up-to-date hidden-statuses))
> > +    (push 'up-to-date hidden-statuses))
>
> The status should be named 'uptodate instead of 'up-to-date since
> that's what's used for individual files. Having two different
> spellings for the same word would be very confusing.

Attached updated patch that adresses these valid objections and only=20
lists files once.

G=C3=A1bor

--Boundary-00=_TtqBGiGnuD/Jr6c
Content-Type: text/x-diff;
  charset="utf-8";
  name="hide-show.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hide-show.patch"

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 5f22dec..72d41bd 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -97,6 +97,16 @@ if there is already one that displays the same directory."
   :group 'git
   :type 'string)
 
+(defcustom git-hide-uptodate t
+  "Hide files with up-to-date status by default."
+  :group 'git
+  :type 'boolean)
+
+(defcustom git-hide-unknown nil
+  "Hide files with unknown status by default."
+  :group 'git
+  :type 'boolean)
+
 
 (defface git-status-face
   '((((class color) (background light)) (:foreground "purple")))
@@ -437,6 +447,7 @@ and returns the process output as a string."
       (setf (git-fileinfo->orig-name info) nil)
       (setf (git-fileinfo->needs-refresh info) t))))
 
+;;; This is an unholy mix of git-ls-files and git-diff-index state codes.
 (defun git-state-code (code)
   "Convert from a string to a added/deleted/modified state."
   (case (string-to-char code)
@@ -445,6 +456,7 @@ and returns the process output as a string."
     (?A 'added)
     (?D 'deleted)
     (?U 'unmerged)
+    (?H 'uptodate)
     (t nil)))
 
 (defun git-status-code-as-string (code)
@@ -515,15 +527,21 @@ and returns the process output as a string."
       (setq node (ewoc-next status node)))
     node))
 
-(defun git-parse-ls-files (status default-state &optional skip-existing)
+(defun git-parse-ls-files (status &optional default-state skip-existing)
   "Parse the output of git-ls-files in the current buffer."
   (goto-char (point-min))
   (let (infolist)
     (while (re-search-forward "\\([HMRCK?]\\) \\([^\0]*\\)\0" nil t 1)
-      (let ((state (match-string 1))
-            (name (match-string 2)))
-        (unless (and skip-existing (git-find-status-file status name))
-          (push (git-create-fileinfo (or (git-state-code state) default-state) name) infolist))))
+      (let* ((state (or default-state
+                        (git-state-code (match-string 1))))
+             (name (match-string 2))
+             (node (git-find-status-file status name)))
+        (if skip-existing
+            (unless node
+              (push (git-create-fileinfo state name) infolist))
+          (if node
+              (git-set-files-state (list (ewoc-data node)) state)
+            (push (git-create-fileinfo state name) infolist)))))
     (dolist (info (nreverse infolist))
       (ewoc-enter-last status info))))
 
@@ -1043,25 +1061,31 @@ and returns the process output as a string."
     (git-clear-status status)
     (git-run-command nil nil "update-index" "--info-only" "--refresh")
     (if (git-empty-db-p)
-        ; we need some special handling for an empty db
+        ;; we need some special handling for an empty db
         (with-temp-buffer
           (git-run-command t nil "ls-files" "-z" "-t" "-c")
           (git-parse-ls-files status 'added))
       (with-temp-buffer
         (git-run-command t nil "diff-index" "-z" "-M" "HEAD")
         (git-parse-status status)))
+    (with-temp-buffer
+      (git-run-command t nil "ls-files" "-z" "-u")
+      (git-parse-ls-unmerged status))
+    (unless (member 'uptodate hidden-statuses)
       (with-temp-buffer
-        (git-run-command t nil "ls-files" "-z" "-u")
-        (git-parse-ls-unmerged status))
+        (git-run-command t nil "ls-files" "-z" "-t" "-c")
+        (git-parse-ls-files status nil t)))
+    (unless (member 'unknown hidden-statuses)
       (when (file-readable-p ".git/info/exclude")
         (with-temp-buffer
           (git-run-command t nil "ls-files" "-z" "-t" "-o"
                            "--exclude-from=.git/info/exclude"
-                           (concat "--exclude-per-directory=" git-per-dir-ignore-file))
-          (git-parse-ls-files status 'unknown)))
+                           (concat "--exclude-per-directory="
+                                   git-per-dir-ignore-file))
+          (git-parse-ls-files status nil t))))
     (git-refresh-files)
     (git-refresh-ewoc-hf status)
-    ; move point to the current file name if any
+    ;; move point to the current file name if any
     (let ((node (and cur-name (git-find-status-file status cur-name))))
       (when node (ewoc-goto-node status node)))))
 
@@ -1113,6 +1137,8 @@ and returns the process output as a string."
     (define-key map "U"   'git-revert-file)
     (define-key map "v"   'git-view-file)
     (define-key map "x"   'git-remove-handled)
+    (define-key map "\M-u" 'git-toggle-uptodate)
+    (define-key map "\M-k" 'git-toggle-unknown)
     (define-key map "\C-?" 'git-unmark-file-up)
     (define-key map "\M-\C-?" 'git-unmark-all)
     ; the diff submap
@@ -1126,6 +1152,20 @@ and returns the process output as a string."
     (define-key diff-map "o" 'git-diff-file-other)
     (setq git-status-mode-map map)))
 
+(defun git-toggle-uptodate ()
+  (interactive)
+  (if (member 'uptodate hidden-statuses)
+      (setq hidden-statuses (remove 'uptodate hidden-statuses))
+    (push 'uptodate hidden-statuses))
+  (git-refresh-status))
+
+(defun git-toggle-unknown ()
+  (interactive)
+  (if (member 'unknown hidden-statuses)
+      (setq hidden-statuses (remove 'unknown hidden-statuses))
+    (push 'unknown hidden-statuses))
+  (git-refresh-status))
+
 ;; git mode should only run in the *git status* buffer
 (put 'git-status-mode 'mode-class 'special)
 
@@ -1145,6 +1185,11 @@ Commands:
   (let ((status (ewoc-create 'git-fileinfo-prettyprint "" "")))
     (set (make-local-variable 'git-status) status))
   (set (make-local-variable 'list-buffers-directory) default-directory)
+  (set (make-local-variable 'hidden-statuses) ())
+  (when git-hide-uptodate
+    (push 'uptodate hidden-statuses))
+  (when git-hide-unknown
+    (push 'unknown hidden-statuses))
   (run-hooks 'git-status-mode-hook)))
 
 (defun git-find-status-buffer (dir)

--Boundary-00=_TtqBGiGnuD/Jr6c--
