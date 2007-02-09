From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH 3/7] Handle uncommitted changes and cache descriptions
Date: Fri, 09 Feb 2007 09:20:38 +0100
Message-ID: <87veibpwrt.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 09:25:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFR4D-0004Th-JZ
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 09:25:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946205AbXBIIZK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 9 Feb 2007 03:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946212AbXBIIZJ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 03:25:09 -0500
Received: from main.gmane.org ([80.91.229.2]:49882 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946205AbXBIIZH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 03:25:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HFR42-0005V0-Nd
	for git@vger.kernel.org; Fri, 09 Feb 2007 09:25:02 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 09:25:02 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 09:25:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:+hAir8Qksfqo4Wz4/0Ki3oHGFEY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39160>


Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 contrib/emacs/git-blame.el |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 56a548b..c99437e 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -187,8 +187,10 @@
                (res-line (string-to-number (match-string 3)))
                (num-lines (string-to-number (match-string 4))))
            (setq git-blame-current
-                 (git-blame-new-commit
-                  hash src-line res-line num-lines)))
+                 (if (string=3D hash "00000000000000000000000000000000=
00000000")
+                     nil
+                   (git-blame-new-commit
+                    hash src-line res-line num-lines))))
          (delete-region (point) (match-end 0))
          t)
         ((looking-at "filename \\(.+\\)\n")
@@ -220,6 +222,7 @@
           (unless color
             (setq color git-blame-ancient-color))
           (setq info (list hash src-line res-line num-lines
+                           (git-describe-commit hash)
                            (cons 'color color))))
         (puthash hash info git-blame-cache))
       (goto-line res-line)
@@ -233,7 +236,8 @@
             (overlay-put ovl 'git-blame info)
             (overlay-put ovl 'help-echo hash)
             (overlay-put ovl 'face (list :background
-                                         (cdr (assq 'color (cddddr inf=
o)))))
+                                         (cdr (assq 'color (nthcdr 5 i=
nfo)))))
+            ;; the point-entered property doesn't seem to work in over=
lays
             ;;(overlay-put ovl 'point-entered
             ;;             `(lambda (x y) (git-blame-identify ,hash)))
             (let ((modified (buffer-modified-p)))
@@ -253,11 +257,21 @@
         (car info)
       (error "No commit info"))))
=20
+(defun git-describe-commit (hash)
+  (with-temp-buffer
+    (call-process "git" nil t nil
+                  "log" "-1" "--pretty=3Doneline"
+                  hash)
+    (buffer-substring (point-min) (1- (point-max)))))
+
+(defvar git-blame-last-identification nil)
+(make-variable-buffer-local 'git-blame-last-identification)
 (defun git-blame-identify (&optional hash)
   (interactive)
-  (shell-command
-   (format "git log -1 --pretty=3Doneline %s" (or hash
-                                                (git-blame-current-com=
mit)))))
+  (let ((info (gethash (or hash (git-blame-current-commit)) git-blame-=
cache)))
+    (when (and info (not (eq info git-blame-last-identification)))
+      (message "%s" (nth 4 info))
+      (setq git-blame-last-identification info))))
=20
 (provide 'git-blame)
=20
--=20
1.5.0.rc3.204.g93c76


--=20
David K=C3=A5gedal
