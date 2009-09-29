From: =?UTF-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] git-blame.el: Change how blame information is shown.
Date: Tue, 29 Sep 2009 17:12:57 +0200
Message-ID: <1254237177-20355-1-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 17:24:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MseO1-0004EU-C7
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 17:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbZI2PM4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Sep 2009 11:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbZI2PMz
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 11:12:55 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:51145 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbZI2PMz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 11:12:55 -0400
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 94FF64005A;
	Tue, 29 Sep 2009 17:12:13 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 88AE040067; Tue, 29 Sep 2009 17:12:13 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [62.20.90.206])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 54AC64005A;
	Tue, 29 Sep 2009 17:12:13 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id 9879461159; Tue, 29 Sep 2009 17:12:57 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.rc3.21.g3b9e
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129309>

It is more customizable, and uses a line prefix to show the commit.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

I have only tested this on Emacs 23, so please test it on at least
Emacs 22 and let me know if there are any problems.

Suggestions for the default value of git-blame-prefix-format are also
welcome.

contrib/emacs/git-blame.el |  156 +++++++++++++++++++++++++++++--------=
-------
 1 files changed, 102 insertions(+), 54 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 4fa70c5..2f25ff4 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -80,6 +80,57 @@
=20
 (eval-when-compile (require 'cl))			      ; to use `push', `pop'
=20
+(defface git-blame-prefix-face
+  '((((background dark)) (:foreground "gray"
+                          :background "black"))
+    (((background light)) (:foreground "gray"
+                           :background "white"))
+    (t (:weight bold)))
+  "The face used for the hash prefix."
+  :group 'git-blame)
+
+(defgroup git-blame nil
+  "A minor mode showing Git blame information."
+  :group 'git
+  :link '(function-link git-blame-mode))
+
+
+(defcustom git-blame-use-colors t
+  "Use colors to indicate commits in `git-blame-mode'."
+  :type 'boolean
+  :group 'git-blame)
+
+(defcustom git-blame-prefix-format
+  "%h %20A:"
+  "The format of the prefix added to each line in `git-blame'
+mode. The format is passed to `format-spec' with the following format =
keys:
+
+  %h - the abbreviated hash
+  %H - the full hash
+  %a - the author name
+  %A - the author email
+  %c - the committer name
+  %C - the committer email
+  %s - the commit summary
+"
+  :group 'git-blame)
+
+(defcustom git-blame-mouseover-format
+  "%h %a %A: %s"
+  "The format of the description shown when pointing at a line in
+`git-blame' mode. The format string is passed to `format-spec'
+with the following format keys:
+
+  %h - the abbreviated hash
+  %H - the full hash
+  %a - the author name
+  %A - the author email
+  %c - the committer name
+  %C - the committer email
+  %s - the commit summary
+"
+  :group 'git-blame)
+
=20
 (defun git-blame-color-scale (&rest elements)
   "Given a list, returns a list of triples formed with each
@@ -302,72 +353,69 @@ See also function `git-blame-mode'."
                (src-line (string-to-number (match-string 2)))
                (res-line (string-to-number (match-string 3)))
                (num-lines (string-to-number (match-string 4))))
-           (setq git-blame-current
-                 (if (string=3D hash "00000000000000000000000000000000=
00000000")
-                     nil
-                   (git-blame-new-commit
-                    hash src-line res-line num-lines))))
-         (delete-region (point) (match-end 0))
-         t)
-        ((looking-at "filename \\(.+\\)\n")
-         (let ((filename (match-string 1)))
-           (git-blame-add-info "filename" filename))
-         (delete-region (point) (match-end 0))
+           (delete-region (point) (match-end 0))
+           (setq git-blame-current (list (git-blame-new-commit hash)
+                                         src-line res-line num-lines))=
)
          t)
         ((looking-at "\\([a-z-]+\\) \\(.+\\)\n")
          (let ((key (match-string 1))
                (value (match-string 2)))
-           (git-blame-add-info key value))
-         (delete-region (point) (match-end 0))
-         t)
-        ((looking-at "boundary\n")
-         (setq git-blame-current nil)
-         (delete-region (point) (match-end 0))
+           (delete-region (point) (match-end 0))
+           (git-blame-add-info (car git-blame-current) key value)
+           (when (string=3D key "filename")
+             (git-blame-create-overlay (car git-blame-current)
+                                       (caddr git-blame-current)
+                                       (cadddr git-blame-current))
+             (setq git-blame-current nil)))
          t)
         (t
          nil)))
=20
-(defun git-blame-new-commit (hash src-line res-line num-lines)
+(defun git-blame-new-commit (hash)
+  (with-current-buffer git-blame-file
+    (or (gethash hash git-blame-cache)
+        ;; Assign a random color to each new commit info
+        ;; Take care not to select the same color multiple times
+        (let* ((color (if git-blame-colors
+                          (git-blame-random-pop git-blame-colors)
+                        git-blame-ancient-color))
+               (info `(,hash (color . ,color))))
+          (puthash hash info git-blame-cache)
+          info))))
+
+(defun git-blame-create-overlay (info start-line num-lines)
   (save-excursion
     (set-buffer git-blame-file)
-    (let ((info (gethash hash git-blame-cache))
-          (inhibit-point-motion-hooks t)
+    (let ((inhibit-point-motion-hooks t)
           (inhibit-modification-hooks t))
-      (when (not info)
-	;; Assign a random color to each new commit info
-	;; Take care not to select the same color multiple times
-	(let ((color (if git-blame-colors
-			 (git-blame-random-pop git-blame-colors)
-		       git-blame-ancient-color)))
-          (setq info (list hash src-line res-line num-lines
-                           (git-describe-commit hash)
-                           (cons 'color color))))
-        (puthash hash info git-blame-cache))
-      (goto-line res-line)
-      (while (> num-lines 0)
-        (if (get-text-property (point) 'git-blame)
-            (forward-line)
-          (let* ((start (point))
-                 (end (progn (forward-line 1) (point)))
-                 (ovl (make-overlay start end)))
-            (push ovl git-blame-overlays)
-            (overlay-put ovl 'git-blame info)
-            (overlay-put ovl 'help-echo hash)
+      (goto-line start-line)
+      (let* ((start (point))
+             (end (progn (forward-line num-lines) (point)))
+             (ovl (make-overlay start end))
+             (hash (car info))
+             (spec `((?h . ,(substring hash 0 6))
+                     (?H . ,hash)
+                     (?a . ,(git-blame-get-info info 'author))
+                     (?A . ,(git-blame-get-info info 'author-mail))
+                     (?c . ,(git-blame-get-info info 'committer))
+                     (?C . ,(git-blame-get-info info 'committer-mail))
+                     (?s . ,(git-blame-get-info info 'summary)))))
+        (push ovl git-blame-overlays)
+        (overlay-put ovl 'git-blame info)
+        (overlay-put ovl 'help-echo
+                     (format-spec git-blame-mouseover-format spec))
+        (if git-blame-use-colors
             (overlay-put ovl 'face (list :background
-                                         (cdr (assq 'color (nthcdr 5 i=
nfo)))))
-            ;; the point-entered property doesn't seem to work in over=
lays
-            ;;(overlay-put ovl 'point-entered
-            ;;             `(lambda (x y) (git-blame-identify ,hash)))
-            (let ((modified (buffer-modified-p)))
-              (put-text-property (if (=3D start 1) start (1- start)) (=
1- end)
-                                 'point-entered
-                                 `(lambda (x y) (git-blame-identify ,h=
ash)))
-              (set-buffer-modified-p modified))))
-        (setq num-lines (1- num-lines))))))
-
-(defun git-blame-add-info (key value)
-  (if git-blame-current
-      (nconc git-blame-current (list (cons (intern key) value)))))
+                                         (cdr (assq 'color (cdr info))=
))))
+        (overlay-put ovl 'line-prefix
+                     (propertize (format-spec git-blame-prefix-format =
spec)
+                                 'face 'git-blame-prefix-face))))))
+
+(defun git-blame-add-info (info key value)
+  (nconc info (list (cons (intern key) value))))
+
+(defun git-blame-get-info (info key)
+  (cdr (assq key (cdr info))))
=20
 (defun git-blame-current-commit ()
   (let ((info (get-char-property (point) 'git-blame)))
--=20
1.6.4.rc3.21.g3b9e
