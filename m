From: David Kastrup <dak@gnu.org>
Subject: [PATCH] contrib/emacs/vc-git.el: various improvements.
Date: Mon, 16 Jul 2007 03:24:20 +0200
Organization: Organization?!?
Message-ID: <403842ba71506c7b194812cd9a4f669c847eb7bc.1184548803.git.dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 03:45:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAFeC-0000AG-RU
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 03:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758494AbXGPBpK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 21:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758537AbXGPBpJ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 21:45:09 -0400
Received: from main.gmane.org ([80.91.229.2]:55373 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758479AbXGPBpH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 21:45:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IAFe2-00041p-8p
	for git@vger.kernel.org; Mon, 16 Jul 2007 03:45:02 +0200
Received: from dslb-084-061-039-155.pools.arcor-ip.net ([84.61.39.155])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 03:45:02 +0200
Received: from dak by dslb-084-061-039-155.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 03:45:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-039-155.pools.arcor-ip.net
X-From-Line: 403842ba71506c7b194812cd9a4f669c847eb7bc Mon Sep 17 00:00:00 2001
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:ClvQrvWu92kvtyndaclYo6bCu/c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52624>

(vc-git-symbolic-commit): Simplify and make it return
something useful in almost all cases.
(vc-git-previous-version): Simplify.
(vc-git-next-version): Simplify and make more efficient.
(vc-git-annotate-command): heed REV argument.
(vc-annotate-extract-revision-at-line): Activate.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 contrib/emacs/vc-git.el |  110 ++++++++++++++++++++---------------------------
 1 files changed, 47 insertions(+), 63 deletions(-)

diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index b8f6be5..3637c8a 100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -84,67 +84,51 @@
 (defun vc-git-symbolic-commit (commit)
   "Translate COMMIT string into symbolic form.
 Returns nil if not possible."
-  (and commit
-       (with-temp-buffer
-	 (and
-	  (zerop
-	   (call-process "git" nil '(t nil) nil "name-rev"
-			 "--name-only" "--tags"
-			 commit))
-	  (goto-char (point-min))
-	  (= (forward-line 2) 1)
-	  (bolp)
-	  (buffer-substring-no-properties (point-min) (1- (point-max)))))))
+  (with-temp-buffer
+    (and
+     (zerop
+      (call-process "git" nil '(t nil) nil "name-rev"
+		    commit))
+     (goto-char (point-max))
+     (bolp)
+     (zerop (forward-line -1))
+     (bobp)
+     (progn
+       (search-forward " " nil t)
+       (not (eolp)))
+     (buffer-substring-no-properties (point) (1- (point-max))))))
 
 (defun vc-git-previous-version (file rev)
   "git-specific version of `vc-previous-version'."
-  (let ((default-directory (file-name-directory (expand-file-name file)))
-	(file (file-name-nondirectory file)))
-    (vc-git-symbolic-commit
-     (with-temp-buffer
-       (and
-	(zerop
-	 (call-process "git" nil '(t nil) nil "rev-list"
-		       "-2" rev "--" file))
-	(goto-char (point-max))
-	(bolp)
-	(zerop (forward-line -1))
-	(not (bobp))
-	(buffer-substring-no-properties
-	   (point)
-	   (1- (point-max))))))))
+  (vc-git-symbolic-commit
+   (with-temp-buffer
+     (and
+      (zerop
+       (call-process "git" nil '(t nil) nil "rev-list" "--abbrev"
+		     "--abbrev-commit" "-2" rev "--" (file-relative-name file)))
+      (goto-char (point-max))
+      (bolp)
+      (zerop (forward-line -1))
+      (not (bobp))
+      (buffer-substring-no-properties
+       (point)
+       (1- (point-max)))))))
 
 (defun vc-git-next-version (file rev)
   "git-specific version of `vc-next-version'."
-  (let* ((default-directory (file-name-directory
-			     (expand-file-name file)))
-	(file (file-name-nondirectory file))
-	(current-rev
-	 (with-temp-buffer
-	   (and
-	    (zerop
-	     (call-process "git" nil '(t nil) nil "rev-list"
-			   "-1" rev "--" file))
-	    (goto-char (point-max))
-	    (bolp)
-	    (zerop (forward-line -1))
-	    (bobp)
-	    (buffer-substring-no-properties
-	     (point)
-	     (1- (point-max)))))))
-    (and current-rev
-	 (vc-git-symbolic-commit
-	  (with-temp-buffer
-	    (and
-	     (zerop
-	      (call-process "git" nil '(t nil) nil "rev-list"
-			    "HEAD" "--" file))
-	     (goto-char (point-min))
-	     (search-forward current-rev nil t)
-	     (zerop (forward-line -1))
-	     (buffer-substring-no-properties
-	      (point)
-	      (progn (forward-line 1) (1- (point))))))))))
+  (vc-git-symbolic-commit
+   (with-temp-buffer
+     (and
+      (zerop
+       (call-process "git" nil '(t nil) nil "rev-list" "--abbrev"
+		     "--abbrev-commit"
+		     "HEAD" "--not" rev "--" (file-relative-name file)))
+      (goto-char (point-max))
+      (bolp)
+      (zerop (forward-line -1))
+      (buffer-substring-no-properties
+       (point)
+       (1- (point-max)))))))
 
 (defun vc-git-revert (file &optional contents-done)
   "Revert FILE to the version stored in the git repository."
@@ -197,20 +181,20 @@ Returns nil if not possible."
     (vc-git--run-command file "checkout" (or rev "HEAD"))))
 
 (defun vc-git-annotate-command (file buf &optional rev)
-  ; FIXME: rev is ignored
   (let ((name (file-relative-name file)))
-    (call-process "git" nil buf nil "blame" name)))
+    (if rev
+	(call-process "git" nil buf nil "blame" rev "--" name)
+      (call-process "git" nil buf nil "blame" "--" name))))
 
 (defun vc-git-annotate-time ()
   (and (re-search-forward "[0-9a-f]+ (.* \\([0-9]+\\)-\\([0-9]+\\)-\\([0-9]+\\) \\([0-9]+\\):\\([0-9]+\\):\\([0-9]+\\) \\([-+0-9]+\\) +[0-9]+)" nil t)
        (vc-annotate-convert-time
         (apply #'encode-time (mapcar (lambda (match) (string-to-number (match-string match))) '(6 5 4 3 2 1 7))))))
 
-;; Not really useful since we can't do anything with the revision yet
-;;(defun vc-annotate-extract-revision-at-line ()
-;;  (save-excursion
-;;    (move-beginning-of-line 1)
-;;    (and (looking-at "[0-9a-f]+")
-;;         (buffer-substring (match-beginning 0) (match-end 0)))))
+(defun vc-annotate-extract-revision-at-line ()
+  (save-excursion
+    (move-beginning-of-line 1)
+    (and (looking-at "[0-9a-f]+")
+         (buffer-substring (match-beginning 0) (match-end 0)))))
 
 (provide 'vc-git)
-- 
1.4.4.2
