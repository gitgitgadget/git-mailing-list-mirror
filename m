From: David Kastrup <dak@gnu.org>
Subject: [PATCH] Make several improvements and get annotations to work (Emacs support pending).
Date: Mon, 16 Jul 2007 01:42:30 +0200
Organization: Organization?!?
Message-ID: <4613d30307e12be13b88b76f755ea8756a56f554.1184548803.git.dak@gnu.org>
References: <403842ba71506c7b194812cd9a4f669c847eb7bc.1184548803.git.dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 03:25:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAFKp-0005bL-2M
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 03:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760162AbXGPBZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 21:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760132AbXGPBZH
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 21:25:07 -0400
Received: from main.gmane.org ([80.91.229.2]:35189 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760123AbXGPBZF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 21:25:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IAFKg-0002hi-Jf
	for git@vger.kernel.org; Mon, 16 Jul 2007 03:25:02 +0200
Received: from dslb-084-061-039-155.pools.arcor-ip.net ([84.61.39.155])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 03:25:02 +0200
Received: from dak by dslb-084-061-039-155.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 03:25:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-039-155.pools.arcor-ip.net
X-From-Line: 4613d30307e12be13b88b76f755ea8756a56f554 Mon Sep 17 00:00:00 2001
In-Reply-To: <403842ba71506c7b194812cd9a4f669c847eb7bc.1184548803.git.dak@gnu.org>
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:TL8++aEnmaFGgLdtjWpsxt6nkBA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52619>

(vc-git-symbolic-commit): Allow nil to pass through.
(vc-git-previous-version): Use explicit parent argument.
(vc-git-next-version): Simplify.
(vc-git-annotate-command): Use `vc-do-command'.
(vc-git-annotate-extract-revision-at-line): Rename from
`vc-annotate-extract-revision-at-line'.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 contrib/emacs/vc-git.el |   76 +++++++++++++++++++++++++++--------------------
 1 files changed, 44 insertions(+), 32 deletions(-)

diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index 3637c8a..2a0a0fe 100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -84,19 +84,20 @@
 (defun vc-git-symbolic-commit (commit)
   "Translate COMMIT string into symbolic form.
 Returns nil if not possible."
-  (with-temp-buffer
-    (and
-     (zerop
-      (call-process "git" nil '(t nil) nil "name-rev"
-		    commit))
-     (goto-char (point-max))
-     (bolp)
-     (zerop (forward-line -1))
-     (bobp)
-     (progn
-       (search-forward " " nil t)
-       (not (eolp)))
-     (buffer-substring-no-properties (point) (1- (point-max))))))
+  (and commit
+       (with-temp-buffer
+	 (and
+	  (zerop
+	   (call-process "git" nil '(t nil) nil "name-rev"
+			 commit))
+	  (goto-char (point-max))
+	  (bolp)
+	  (zerop (forward-line -1))
+	  (bobp)
+	  (progn
+	    (search-forward " " nil t)
+	    (not (eolp)))
+	  (buffer-substring-no-properties (point) (1- (point-max)))))))
 
 (defun vc-git-previous-version (file rev)
   "git-specific version of `vc-previous-version'."
@@ -104,15 +105,13 @@ Returns nil if not possible."
    (with-temp-buffer
      (and
       (zerop
-       (call-process "git" nil '(t nil) nil "rev-list" "--abbrev"
-		     "--abbrev-commit" "-2" rev "--" (file-relative-name file)))
-      (goto-char (point-max))
-      (bolp)
-      (zerop (forward-line -1))
-      (not (bobp))
-      (buffer-substring-no-properties
-       (point)
-       (1- (point-max)))))))
+       (call-process "git" nil '(t nil) nil "rev-list"
+		     "--abbrev"
+		     "--abbrev-commit" "-1" "--parents" rev "--"
+		     (file-relative-name file)))
+      (goto-char (point-min))
+      (search-forward-regexp " \\([^ \n]*\\)" nil t)
+      (match-string 1)))))
 
 (defun vc-git-next-version (file rev)
   "git-specific version of `vc-next-version'."
@@ -121,8 +120,9 @@ Returns nil if not possible."
      (and
       (zerop
        (call-process "git" nil '(t nil) nil "rev-list" "--abbrev"
-		     "--abbrev-commit"
+		     "--abbrev-commit"  "--remove-empty"
 		     "HEAD" "--not" rev "--" (file-relative-name file)))
+      (goto-char (point-min))
       (goto-char (point-max))
       (bolp)
       (zerop (forward-line -1))
@@ -174,24 +174,36 @@ Returns nil if not possible."
                        (vc-git--run-command-string file "ls-files" "-z" "--full-name" "--")
                        0 -1))
             (coding-system-for-read 'no-conversion)
-            (coding-system-for-write 'no-conversion))
+            coding-system-for-write)
         (with-temp-file destfile
-          (eq 0 (call-process "git" nil t nil "cat-file" "blob"
-                              (concat (or rev "HEAD") ":" fullname)))))
+	  (prog1
+	      (eq 0 (call-process "git" nil t nil "cat-file" "blob"
+				  (concat (or rev "HEAD") ":" fullname)))
+	    (setq coding-system-for-write 'no-conversion))))
     (vc-git--run-command file "checkout" (or rev "HEAD"))))
 
-(defun vc-git-annotate-command (file buf &optional rev)
-  (let ((name (file-relative-name file)))
-    (if rev
-	(call-process "git" nil buf nil "blame" rev "--" name)
-      (call-process "git" nil buf nil "blame" "--" name))))
+(defun vc-git-annotate-command (file buffer &optional version)
+  "Execute \"git blame\" on FILE, inserting the contents in BUFFER.
+Optional arg VERSION is a version to annotate from."
+  (vc-do-command buffer
+		 'async
+		 "git" file "blame"
+		 (or version "HEAD")
+		 "--"))
+
+;;(defun vc-git-annotate-command (file buf &optional rev)
+;;  (let ((name (file-relative-name file)))
+;;    (vc-setup-buffer buf)
+;;    (if rev
+;;	(call-process "git" nil buf nil "blame" rev "--" name)
+;;      (call-process "git" nil buf nil "blame" "--" name))))
 
 (defun vc-git-annotate-time ()
   (and (re-search-forward "[0-9a-f]+ (.* \\([0-9]+\\)-\\([0-9]+\\)-\\([0-9]+\\) \\([0-9]+\\):\\([0-9]+\\):\\([0-9]+\\) \\([-+0-9]+\\) +[0-9]+)" nil t)
        (vc-annotate-convert-time
         (apply #'encode-time (mapcar (lambda (match) (string-to-number (match-string match))) '(6 5 4 3 2 1 7))))))
 
-(defun vc-annotate-extract-revision-at-line ()
+(defun vc-git-annotate-extract-revision-at-line ()
   (save-excursion
     (move-beginning-of-line 1)
     (and (looking-at "[0-9a-f]+")
-- 
1.4.4.2
