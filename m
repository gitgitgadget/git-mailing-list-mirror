From: jari.aalto@cante.net
Subject: [PATCH v4] contrib/emacs/git.el: Add user functions for push, pull, fetch
Date: Fri, 15 Apr 2011 00:07:13 +0300
Organization: Private
Message-ID: <bff33bffb02487b123d280a0f3fe9ac0cdd9cda6.1302815124.git.jari.aalto@cante.net>
References: <ae4f9adf62502f58a870a322cd30a62e23aba747.1301852577.git.jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 23:07:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QATlA-0007B4-01
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 23:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab1DNVHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 17:07:21 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:37310 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab1DNVHT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 17:07:19 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 978CAEBA1B
	for <git@vger.kernel.org>; Fri, 15 Apr 2011 00:07:16 +0300 (EEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A067CF903F4; Fri, 15 Apr 2011 00:07:16 +0300
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 6FA331C6385
	for <git@vger.kernel.org>; Fri, 15 Apr 2011 00:07:15 +0300 (EEST)
Received: from vc.cante.net ([192.168.1.5] helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.74)
	(envelope-from <jari.aalto@cante.net>)
	id 1QATkw-0001aZ-1Q; Fri, 15 Apr 2011 00:07:14 +0300
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <ae4f9adf62502f58a870a322cd30a62e23aba747.1301852577.git.jari.aalto@cante.net>
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171554>

From: Jari Aalto <jari.aalto@cante.net>

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 contrib/emacs/git.el |  110 ++++++++++++++++++++++++++++++++++++++++++++=
+++++-
 1 files changed, 109 insertions(+), 1 deletions(-)

  [v2]
  ** This fixes the pull message. The only change is last line:
  ** (message "Pulled from remote: %s" remote)))

  [v3] Fixes commented by <julliard@winehq.org>
  ** Extra C-a keymap binding removed
  ** Check success status before displaying message
  ** no need to refresh the status files on push or fetch

  [v4]
  ** Parse remotes from .git/config and offer them as completions (push/p=
ull)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 65c95d9..97d2484 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1,6 +1,7 @@
 ;;; git.el --- A user interface for git
=20
 ;; Copyright (C) 2005, 2006, 2007, 2008, 2009 Alexandre Julliard <jullia=
rd@winehq.org>
+;; Copyright (C) 2010 Jari Aalto <jari.aalto@cante.net>
=20
 ;; Version: 1.0
=20
@@ -33,11 +34,14 @@
 ;;
 ;; To start: `M-x git-status'
 ;;
+;; RUDIMENTARY
+;; - fetch/pull. Be sure to start gpg-agent, ssh-agent prior emacs
+;;   to access ssh Git remotes.
+;;
 ;; TODO
 ;;  - diff against other branch
 ;;  - renaming files from the status buffer
 ;;  - creating tags
-;;  - fetch/pull
 ;;  - revlist browser
 ;;  - git-show-branch browser
 ;;
@@ -384,6 +388,25 @@ the process output as a string, or nil if the git co=
mmand failed."
   (git-get-string-sha1
    (git-call-process-string "rev-parse" rev)))
=20
+(defun git-root ()
+  "Return root of git directory. Start from current dir way up."
+  (let* ((dir (file-name-as-directory default-directory))
+	 (try (format "%s%s" dir ".git")))
+    (while (and dir
+		(not (file-directory-p try)))
+      (if (string-match "^\\(.*/\\).+$" dir)
+	  (setq dir (match-string 1 dir)
+		try (format "%s%s" dir ".git"))
+	(setq dir nil
+	      try nil)))
+    try))
+
+(defsubst git-config-file ()
+  "Return 'config' file location."
+  (let ((dir (git-root)))
+    (if dir
+	(format "%s/config" dir))))
+
 (defun git-config (key)
   "Retrieve the value associated to KEY in the git repository config fil=
e."
   (let ((str (git-call-process-string "config" key)))
@@ -1527,6 +1550,7 @@ amended version of it."
=20
 (unless git-status-mode-map
   (let ((map (make-keymap))
+        (remote-map (make-sparse-keymap))
         (commit-map (make-sparse-keymap))
         (diff-map (make-sparse-keymap))
         (toggle-map (make-sparse-keymap)))
@@ -1554,6 +1578,7 @@ amended version of it."
     (define-key map "P"   'git-prev-unmerged-file)
     (define-key map "q"   'git-status-quit)
     (define-key map "r"   'git-remove-file)
+    (define-key map "R"   remote-map)
     (define-key map "t"    toggle-map)
     (define-key map "T"   'git-toggle-all-marks)
     (define-key map "u"   'git-unmark-file)
@@ -1562,6 +1587,11 @@ amended version of it."
     (define-key map "x"   'git-remove-handled)
     (define-key map "\C-?" 'git-unmark-file-up)
     (define-key map "\M-\C-?" 'git-unmark-all)
+    ; remotes
+    (define-key remote-map "R" 'git-pull)  ; retrieve "RR"
+    (define-key remote-map "r" 'git-pull)  ; retrieve "Rr" (synonym)
+    (define-key remote-map "p" 'git-push)
+    (define-key remote-map "f" 'git-fetch)
     ; the commit submap
     (define-key commit-map "\C-a" 'git-amend-commit)
     (define-key commit-map "\C-b" 'git-branch)
@@ -1614,6 +1644,10 @@ amended version of it."
       ["Interactive Diff File" git-diff-file-idiff t]
       ["Log" git-log-file t]
       "--------"
+      ["Push" git-push t]
+      ["Pull" git-pull t]
+      ["Fetch" git-fetch t]
+      "--------"
       ["Mark" git-mark-file t]
       ["Mark All" git-mark-all t]
       ["Unmark" git-unmark-file t]
@@ -1696,6 +1730,80 @@ Meant to be used in `after-save-hook'."
             (git-call-process nil "add" "--refresh" "--" filename)
             (git-update-status-files (list filename))))))))
=20
+(defun git-remote-parse ()
+  "Parse remotes from current point forward. Return list."
+  (let (list)
+    ;; [remote "origin"]
+    (while (re-search-forward "^\\[remote[[:space:]]+\"\\([^\"]+\\)" nil=
 t)
+      (push (match-string-no-properties 1) list))
+    list))
+
+(defun git-remote-list ()
+  "Return list of remotes from Git configuration."
+  (with-temp-buffer
+    (insert-file-contents-literally (git-config-file))
+    (goto-char (point-min))
+    (git-remote-parse)))
+
+(defun git-ask-remote (prompt)
+  "Read remote with PROMPT."
+  (let ((list (git-remote-list))
+	(default "origin")
+	ret)
+    (unless (member default list)
+      (setq default (car list)))
+    (setq ret
+	  (completing-read prompt
+			   list
+			   (not 'predicate)
+			   'require-match
+			   (not 'default)
+			   (not 'history)
+			   default))
+    (if (string-match "^[ \t\r\n]*$" ret)
+	(setq ret default))
+    ret))
+
+(defun git-push (&optional remote)
+  "Pull to REMOTE. Use \\[current-prefix-arg] to interactively set REMOT=
E."
+  (interactive
+   (list (or (and current-prefix-arg
+		  (git-ask-remote "Push to remote: "))
+	     "origin")))
+  ;; FIXME: could collect some status data for display
+  (when (git-call-process-display-error "push" remote)
+    (message "Pushed to remote: %s" remote)))
+
+(defun git-fetch (&optional remote)
+  "Fetch from REMOTE. Use \\[current-prefix-arg] to interactively set RE=
MOTE."
+  (interactive
+   (list (or (and current-prefix-arg
+		  (git-ask-remote "Fetch from remote: "))
+	     "origin")))
+  ;; FIXME: could collect some status data for display
+  (when (git-call-process-display-error "fetch" remote)
+    (message "Fetched from remote: %s" remote)))
+
+(defun git-pull (&optional remote)
+  "Pull from REMOTE. Use \\[current-prefix-arg] to interactively set REM=
OTE."
+  (interactive
+   (list (or (and current-prefix-arg
+		  (git-ask-remote "Pull from remote: "))
+	     "origin")))
+  (let ((not-clean
+	 (ewoc-collect git-status (lambda (info &optional state)
+				    (setq state (git-fileinfo->state info))
+				    (or (memq state '(added
+						      deleted
+						      modified
+						      unmerged)))))))
+    (if not-clean
+	(error "Error: Can't pull while in unclean state (commit all first)."))
+    (unless git-status (error "Not in git-status buffer."))
+    ;; FIXME: could collect some status data for display
+    (when (git-call-process-display-error "pull" remote)
+      (message "Pulled from remote: %s" remote))))
+
 (defun git-help ()
   "Display help for Git mode."
   (interactive)
--=20
1.7.4.1
