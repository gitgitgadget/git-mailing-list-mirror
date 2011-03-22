From: jari.aalto@cante.net
Subject: [PATCH] git.el: Add new user functions for push, pull, fetch.
Date: Tue, 22 Mar 2011 15:30:51 +0200
Organization: Private
Message-ID: <1300800651-12502-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 14:38:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q21mh-0000qU-4S
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 14:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167Ab1CVNiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 09:38:01 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:41776 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320Ab1CVNiA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 09:38:00 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Mar 2011 09:37:59 EDT
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 1FDEFEB9D1
	for <git@vger.kernel.org>; Tue, 22 Mar 2011 15:30:53 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A05CD51D4FC; Tue, 22 Mar 2011 15:30:53 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 01BA92BD44
	for <git@vger.kernel.org>; Tue, 22 Mar 2011 15:30:51 +0200 (EET)
Received: from db.cante.net ([192.168.1.5] helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.74)
	(envelope-from <jari.aalto@cante.net>)
	id 1Q21ff-0003G4-Hu; Tue, 22 Mar 2011 15:30:51 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169736>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 contrib/emacs/git.el |   75 ++++++++++++++++++++++++++++++++++++++++++++=
+++++-
 1 files changed, 74 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 214930a..20a3b2c 100644
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
@@ -1520,6 +1524,7 @@ amended version of it."
=20
 (unless git-status-mode-map
   (let ((map (make-keymap))
+        (remote-map (make-sparse-keymap))
         (commit-map (make-sparse-keymap))
         (diff-map (make-sparse-keymap))
         (toggle-map (make-sparse-keymap)))
@@ -1547,6 +1552,7 @@ amended version of it."
     (define-key map "P"   'git-prev-unmerged-file)
     (define-key map "q"   'git-status-quit)
     (define-key map "r"   'git-remove-file)
+    (define-key map "R"   remote-map)
     (define-key map "t"    toggle-map)
     (define-key map "T"   'git-toggle-all-marks)
     (define-key map "u"   'git-unmark-file)
@@ -1555,6 +1561,13 @@ amended version of it."
     (define-key map "x"   'git-remove-handled)
     (define-key map "\C-?" 'git-unmark-file-up)
     (define-key map "\M-\C-?" 'git-unmark-all)
+    ; remotes
+    (define-key remote-map "\C-a" 'git-push)
+    (define-key remote-map "R" 'git-pull)  ; retrieve "RR"
+    (define-key remote-map "r" 'git-pull)  ; retrieve "Rr" (synonym)
+    (define-key remote-map "p" 'git-push)
+    (define-key remote-map "f" 'git-fetch)
+    (define-key remote-map "\C-a" 'git-fetch)
     ; the commit submap
     (define-key commit-map "\C-a" 'git-amend-commit)
     (define-key commit-map "\C-b" 'git-branch)
@@ -1607,6 +1620,10 @@ amended version of it."
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
@@ -1689,6 +1706,62 @@ Meant to be used in `after-save-hook'."
             (git-call-process nil "add" "--refresh" "--" filename)
             (git-update-status-files (list filename))))))))
=20
+(defun git-ask-remote (message)
+  "Return remote."
+  (let ((ret
+	 (completing-read
+	  "Push to remote: "
+	  '(("origin" 1))		;FIXME read all remotes
+	  (not 'predicate)
+	  (not 'match)
+	  "origin")))
+    (if (not (string-match "[^ \t]" ret))
+	"origin"
+      ret)))
+
+(defun git-push (&optional remote)
+  "Pull to REMOTE. Use \\[current-prefix-arg] to interactively set REMOT=
E."
+  (interactive
+   (list (or (and current-prefix-arg
+		  (git-ask-remote "Push to remote: "))
+	     "origin")))
+  ;; FIXME: could colled some status data for display
+  (git-call-process-display-error "push" remote)
+  (git-update-status-files)
+  (message "Pushed to remote: %s" remote))
+
+(defun git-fetch (&optional remote)
+  "Fetch from REMOTE. Use \\[current-prefix-arg] to interactively set RE=
MOTE."
+  (interactive
+   (list (or (and current-prefix-arg
+		  (git-ask-remote "Fetch from remote: "))
+	     "origin")))
+  ;; FIXME: could colled some status data for display
+  (git-call-process-display-error "fetch" remote)
+  (git-update-status-files)
+  (message "Fetched from remote: %s" remote))
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
+				    (or (eq state 'modified)
+					(eq state 'added)
+					(eq state 'deleted)
+					(eq state 'unmerged))))))
+    (if not-clean
+	(error "Error: Can't pull while in unclean state (commit all first)."))
+    (unless git-status (error "Not in git-status buffer."))
+    ;; FIXME: could colled some status data for display
+    (git-call-process-display-error "pull" remote)
+    (git-update-status-files)
+    (message "Pushed to remote: %s" remote)))
+
 (defun git-help ()
   "Display help for Git mode."
   (interactive)
--=20
1.7.2.3
