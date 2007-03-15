From: =?iso-8859-1?q?G=E1bor_Melis?= <mega@retes.hu>
Subject: git emacs mode patch
Date: Thu, 15 Mar 2007 14:03:56 +0100
Message-ID: <200703151403.56552.mega@retes.hu>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8QU+FRPNAjXrUfz"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 15 15:24:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRqse-0007DQ-O1
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 15:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422714AbXCOOYe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 10:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422718AbXCOOYe
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 10:24:34 -0400
Received: from crow2.exxs.net ([213.202.244.8]:33671 "EHLO crow2.exxs.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422714AbXCOOYd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 10:24:33 -0400
X-Greylist: delayed 4828 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Mar 2007 10:24:32 EDT
Received: from dev277.development.ravenpack.com (62.37.239.2.static.abi.uni2.es [62.37.239.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by crow2.exxs.net (Postfix) with ESMTP id 3E9FFBE05B
	for <git@vger.kernel.org>; Thu, 15 Mar 2007 14:03:51 +0100 (CET)
User-Agent: KMail/1.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42283>

--Boundary-00=_8QU+FRPNAjXrUfz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The attached patch makes it possible to toggle show/hide of files with=20
up-to-date and unknown statuses with M-d and M-u.

Cheers,
G=E1bor Melis

Please CC me, I'm not on the list.

--Boundary-00=_8QU+FRPNAjXrUfz
Content-Type: text/x-diff;
  charset="us-ascii";
  name="git-el.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="git-el.patch"

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index db87a37..2f993de 100644
=2D-- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -97,6 +97,16 @@ if there is already one that displays the same directory=
=2E"
   :group 'git
   :type 'string)
=20
+(defcustom git-hide-up-to-date t
+  "Hide files with up-to-date status by default."
+  :group 'git
+  :type 'boolean)
+
+(defcustom git-hide-unknown t
+  "Hide files with unknown status by default."
+  :group 'git
+  :type 'boolean)
+
=20
 (defface git-status-face
   '((((class color) (background light)) (:foreground "purple")))
@@ -428,6 +438,7 @@ and returns the process output as a string."
     (?A 'added)
     (?D 'deleted)
     (?U 'unmerged)
+    (?H 'uptodate)
     (t nil)))
=20
 (defun git-status-code-as-string (code)
@@ -1017,15 +1028,18 @@ and returns the process output as a string."
       (with-temp-buffer
         (git-run-command t nil "diff-index" "-z" "-M" "HEAD")
         (git-parse-status status)))
+    (unless (member 'up-to-date hidden-statuses)
       (with-temp-buffer
=2D        (git-run-command t nil "ls-files" "-z" "-u")
=2D        (git-parse-ls-unmerged status))
+        (git-run-command t nil "ls-files" "-z" "-t")
+        (git-parse-ls-files status 'unknown)))
+    (unless (member 'unknown hidden-statuses)
       (when (file-readable-p ".git/info/exclude")
         (with-temp-buffer
           (git-run-command t nil "ls-files" "-z" "-t" "-o"
                            "--exclude-from=3D.git/info/exclude"
=2D                           (concat "--exclude-per-directory=3D" git-per-=
dir-ignore-file))
=2D          (git-parse-ls-files status 'unknown)))
+                           (concat "--exclude-per-directory=3D"
+                                   git-per-dir-ignore-file))
+          (git-parse-ls-files status 'unknown))))
     (git-refresh-files)
     (git-refresh-ewoc-hf status)
     ; move point to the current file name if any
@@ -1080,6 +1094,8 @@ and returns the process output as a string."
     (define-key map "U"   'git-revert-file)
     (define-key map "v"   'git-view-file)
     (define-key map "x"   'git-remove-handled)
+    (define-key map "\M-d" 'git-toggle-up-to-date)
+    (define-key map "\M-u" 'git-toggle-unknown)
     (define-key map "\C-?" 'git-unmark-file-up)
     (define-key map "\M-\C-?" 'git-unmark-all)
     ; the diff submap
@@ -1093,6 +1109,20 @@ and returns the process output as a string."
     (define-key diff-map "o" 'git-diff-file-other)
     (setq git-status-mode-map map)))
=20
+(defun git-toggle-up-to-date ()
+  (interactive)
+  (if (member 'up-to-date hidden-statuses)
+      (setq hidden-statuses (remove 'up-to-date hidden-statuses))
+    (push 'up-to-date hidden-statuses))
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
=20
@@ -1112,6 +1142,11 @@ Commands:
   (let ((status (ewoc-create 'git-fileinfo-prettyprint "" "")))
     (set (make-local-variable 'git-status) status))
   (set (make-local-variable 'list-buffers-directory) default-directory)
+  (set (make-local-variable 'hidden-statuses) ())
+  (when git-hide-up-to-date
+    (push 'up-to-date hidden-statuses))
+  (when git-hide-unknown
+    (push 'unknown hidden-statuses))
   (run-hooks 'git-status-mode-hook)))
=20
 (defun git-find-status-buffer (dir)

--Boundary-00=_8QU+FRPNAjXrUfz--
