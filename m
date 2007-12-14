From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 15/17] Emacs mode: Added stgit-new
Date: Fri, 14 Dec 2007 11:59:23 +0100
Message-ID: <20071214105918.18066.55913.stgit@krank>
References: <20071214105238.18066.23281.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 12:00:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38HB-0001xm-KX
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 12:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764450AbXLNK7I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 05:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764396AbXLNK7H
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 05:59:07 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:51851 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764346AbXLNK7G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 05:59:06 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 26566200A217;
	Fri, 14 Dec 2007 11:59:05 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 30527-01-32; Fri, 14 Dec 2007 11:59:04 +0100 (CET)
Received: from krank (dns.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id C5584200A1E8;
	Fri, 14 Dec 2007 11:59:04 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id 3A44D7B406D;
	Fri, 14 Dec 2007 11:59:23 +0100 (CET)
In-Reply-To: <20071214105238.18066.23281.stgit@krank>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68293>


Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 contrib/stgit.el |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index 0859086..1cb4dd2 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -132,6 +132,7 @@ Argument DIR is the repository path."
   (define-key stgit-mode-map "g"   'stgit-refresh)
   (define-key stgit-mode-map "r"   'stgit-rename)
   (define-key stgit-mode-map "e"   'stgit-edit)
+  (define-key stgit-mode-map "N"   'stgit-new)
   (define-key stgit-mode-map "\C-r"   'stgit-repair)
   (define-key stgit-mode-map "C"   'stgit-commit)
   (define-key stgit-mode-map "U"   'stgit-uncommit)
@@ -270,6 +271,44 @@ Commands:
     (with-current-buffer log-edit-parent-buffer
       (stgit-refresh))))
=20
+(defun stgit-new ()
+  "Create a new patch"
+  (interactive)
+  (let ((edit-buf (get-buffer-create "*stgit edit*")))
+    (log-edit 'stgit-confirm-new t nil edit-buf)))
+
+(defun stgit-confirm-new ()
+  (interactive)
+  (let ((file (make-temp-file "stgit-edit-"))
+        (patch (stgit-create-patch-name
+                (buffer-substring (point-min)
+                                  (save-excursion (goto-char (point-mi=
n))
+                                                  (end-of-line)
+                                                  (point))))))
+    (write-region (point-min) (point-max) file)
+    (stgit-capture-output nil
+      (stgit-run "new" "-m" "placeholder" patch)
+      (stgit-run "edit" "-f" file patch))
+    (with-current-buffer log-edit-parent-buffer
+      (stgit-refresh))))
+
+(defun stgit-create-patch-name (description)
+  "Create a patch name from a long description"
+  (let ((patch ""))
+    (while (> (length description) 0)
+      (cond ((string-match "\\`[a-zA-Z_-]+" description)
+             (setq patch (downcase (concat patch (match-string 0 descr=
iption))))
+             (setq description (substring description (match-end 0))))
+            ((string-match "\\` +" description)
+             (setq patch (concat patch "-"))
+             (setq description (substring description (match-end 0))))
+            ((string-match "\\`[^a-zA-Z_-]+" description)
+             (setq description (substring description (match-end 0))))=
))
+    (cond ((=3D (length patch) 0)
+           "patch")
+          ((> (length patch) 20)
+           (substring patch 0 20))
+          (t patch))))
=20
 (defun stgit-help ()
   "Display help for the StGit mode."
