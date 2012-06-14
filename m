From: Lawrence Mitchell <wence@gmx.li>
Subject: [PATCH v2 2/3] git-blame.el: Use with-current-buffer where appropriate
Date: Thu, 14 Jun 2012 10:37:59 +0100
Message-ID: <1339666680-4381-2-git-send-email-wence@gmx.li>
References: <87k3za9rwj.fsf@gmx.li>
 <1339666680-4381-1-git-send-email-wence@gmx.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@gmail.com, git@vger.kernel.org, davidk@lysator.liu.se,
	user42@zip.com.au, osv@javad.com, gitster@pobox.com
To: =?UTF-8?q?R=C3=BCdiger=20Sonderfeld?= <ruediger@c-plusplus.de>
X-From: git-owner@vger.kernel.org Thu Jun 14 11:38:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf6Vs-00041h-2J
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 11:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862Ab2FNJio convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jun 2012 05:38:44 -0400
Received: from treacle.ucs.ed.ac.uk ([129.215.16.102]:37729 "EHLO
	treacle.ucs.ed.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225Ab2FNJim (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 05:38:42 -0400
Received: from lmtp1.ucs.ed.ac.uk (lmtp1.ucs.ed.ac.uk [129.215.149.64])
	by treacle.ucs.ed.ac.uk (8.13.8/8.13.4) with ESMTP id q5E9cBQr007640;
	Thu, 14 Jun 2012 10:38:15 +0100 (BST)
Received: from e4300lm.epcc.ed.ac.uk (e4300lm.epcc.ed.ac.uk [129.215.63.156])
	(authenticated user=lmitche4 mech=PLAIN bits=0)
	by lmtp1.ucs.ed.ac.uk (8.13.8/8.13.7) with ESMTP id q5E9c1Gx025947
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 14 Jun 2012 10:38:10 +0100 (BST)
X-Mailer: git-send-email 1.7.11.rc2.9.g10afb6c
In-Reply-To: <1339666680-4381-1-git-send-email-wence@gmx.li>
X-Edinburgh-Scanned: at treacle.ucs.ed.ac.uk
    with MIMEDefang 2.60, Sophie, Sophos Anti-Virus, Clam AntiVirus
X-Scanned-By: MIMEDefang 2.60 on 129.215.16.102
X-Scanned-By: MIMEDefang 2.52 on 129.215.149.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199990>

In git-blame-filter and git-blame-create-overlay we want to save
(along with the values of point and mark) the current-buffer in scope
when calling the functions.  The idiom

    (save-excursion
      (set-buffer buf)
      ...)

will correctly restore the correct buffer, but will not save the
values of point and mark in buf (only in the buffer current when the
save-excursion call is executed).  The intention of these functions is
to save the current buffer from the calling scope and the values of
point and mark in the buffer they are modifying.  The correct idiom
for this is

    (with-current-buffer buf
      (save-excursion
        ...))

Signed-off-by: R=C3=BCdiger Sonderfeld <ruediger@c-plusplus.de>
Signed-off-by: Lawrence Mitchell <wence@gmx.li>
---
 contrib/emacs/git-blame.el | 74 +++++++++++++++++++++++---------------=
--------
 1 file changed, 37 insertions(+), 37 deletions(-)

Updated commit message that actually correctly matches what Emacs
does, plus don't just squash the byte-compiler warnings but actually
fix the bug that it was pointing out to us.

=46or reference, here's the whitespace-squashed change:

| @@ -337,8 +337,8 @@ See also function `git-blame-mode'."
|  (defvar in-blame-filter nil)
=20
|  (defun git-blame-filter (proc str)
| +  (with-current-buffer (process-buffer proc)
|      (save-excursion
| -    (set-buffer (process-buffer proc))
|        (goto-char (process-mark proc))
|        (insert-before-markers str)
|        (goto-char 0)
| @@ -346,7 +346,7 @@ See also function `git-blame-mode'."
|          (let ((more t)
|                (in-blame-filter t))
|            (while more
| -          (setq more (git-blame-parse)))))))
| +            (setq more (git-blame-parse))))))))
=20
|  (defun git-blame-parse ()
|    (cond ((looking-at "\\([0-9a-f]\\{40\\}\\) \\([0-9]+\\) \\([0-9]+\=
\) \\([0-9]+\\)\n")
| @@ -385,8 +385,8 @@ See also function `git-blame-mode'."
|            info))))
=20
|  (defun git-blame-create-overlay (info start-line num-lines)
| +  (with-current-buffer git-blame-file
|      (save-excursion
| -    (set-buffer git-blame-file)
|        (let ((inhibit-point-motion-hooks t)
|              (inhibit-modification-hooks t))
|          (goto-char (point-min))
| @@ -411,7 +411,7 @@ See also function `git-blame-mode'."
|                                             (cdr (assq 'color (cdr in=
fo))))))
|            (overlay-put ovl 'line-prefix
|                         (propertize (format-spec git-blame-prefix-for=
mat spec)
| -                                 'face 'git-blame-prefix-face))))))
| +                                   'face 'git-blame-prefix-face)))))=
))
=20


diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 5428ff7..bb6d7bb 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -337,16 +337,16 @@ See also function `git-blame-mode'."
 (defvar in-blame-filter nil)
=20
 (defun git-blame-filter (proc str)
-  (save-excursion
-    (set-buffer (process-buffer proc))
-    (goto-char (process-mark proc))
-    (insert-before-markers str)
-    (goto-char 0)
-    (unless in-blame-filter
-      (let ((more t)
-            (in-blame-filter t))
-        (while more
-          (setq more (git-blame-parse)))))))
+  (with-current-buffer (process-buffer proc)
+    (save-excursion
+      (goto-char (process-mark proc))
+      (insert-before-markers str)
+      (goto-char 0)
+      (unless in-blame-filter
+        (let ((more t)
+              (in-blame-filter t))
+          (while more
+            (setq more (git-blame-parse))))))))
=20
 (defun git-blame-parse ()
   (cond ((looking-at "\\([0-9a-f]\\{40\\}\\) \\([0-9]+\\) \\([0-9]+\\)=
 \\([0-9]+\\)\n")
@@ -385,33 +385,33 @@ See also function `git-blame-mode'."
           info))))
=20
 (defun git-blame-create-overlay (info start-line num-lines)
-  (save-excursion
-    (set-buffer git-blame-file)
-    (let ((inhibit-point-motion-hooks t)
-          (inhibit-modification-hooks t))
-      (goto-char (point-min))
-      (forward-line (1- start-line))
-      (let* ((start (point))
-             (end (progn (forward-line num-lines) (point)))
-             (ovl (make-overlay start end))
-             (hash (car info))
-             (spec `((?h . ,(substring hash 0 6))
-                     (?H . ,hash)
-                     (?a . ,(git-blame-get-info info 'author))
-                     (?A . ,(git-blame-get-info info 'author-mail))
-                     (?c . ,(git-blame-get-info info 'committer))
-                     (?C . ,(git-blame-get-info info 'committer-mail))
-                     (?s . ,(git-blame-get-info info 'summary)))))
-        (push ovl git-blame-overlays)
-        (overlay-put ovl 'git-blame info)
-        (overlay-put ovl 'help-echo
-                     (format-spec git-blame-mouseover-format spec))
-        (if git-blame-use-colors
-            (overlay-put ovl 'face (list :background
-                                         (cdr (assq 'color (cdr info))=
))))
-        (overlay-put ovl 'line-prefix
-                     (propertize (format-spec git-blame-prefix-format =
spec)
-                                 'face 'git-blame-prefix-face))))))
+  (with-current-buffer git-blame-file
+    (save-excursion
+      (let ((inhibit-point-motion-hooks t)
+            (inhibit-modification-hooks t))
+        (goto-char (point-min))
+        (forward-line (1- start-line))
+        (let* ((start (point))
+               (end (progn (forward-line num-lines) (point)))
+               (ovl (make-overlay start end))
+               (hash (car info))
+               (spec `((?h . ,(substring hash 0 6))
+                       (?H . ,hash)
+                       (?a . ,(git-blame-get-info info 'author))
+                       (?A . ,(git-blame-get-info info 'author-mail))
+                       (?c . ,(git-blame-get-info info 'committer))
+                       (?C . ,(git-blame-get-info info 'committer-mail=
))
+                       (?s . ,(git-blame-get-info info 'summary)))))
+          (push ovl git-blame-overlays)
+          (overlay-put ovl 'git-blame info)
+          (overlay-put ovl 'help-echo
+                       (format-spec git-blame-mouseover-format spec))
+          (if git-blame-use-colors
+              (overlay-put ovl 'face (list :background
+                                           (cdr (assq 'color (cdr info=
))))))
+          (overlay-put ovl 'line-prefix
+                       (propertize (format-spec git-blame-prefix-forma=
t spec)
+                                   'face 'git-blame-prefix-face)))))))
=20
 (defun git-blame-add-info (info key value)
   (nconc info (list (cons (intern key) value))))
--=20
1.7.11.rc2.9.g10afb6c
