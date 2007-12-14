From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 17/17] Emacs mode: coalesce command
Date: Fri, 14 Dec 2007 11:59:49 +0100
Message-ID: <20071214105937.18066.96219.stgit@krank>
References: <20071214105238.18066.23281.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 12:00:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38HC-0001xm-Te
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 12:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764470AbXLNK7d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 05:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764400AbXLNK7d
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 05:59:33 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:51856 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761373AbXLNK7c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 05:59:32 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 15F89200A217;
	Fri, 14 Dec 2007 11:59:31 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 30527-01-33; Fri, 14 Dec 2007 11:59:30 +0100 (CET)
Received: from krank (oden.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id C5ABC200A1E8;
	Fri, 14 Dec 2007 11:59:30 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id 34FB37B406D;
	Fri, 14 Dec 2007 11:59:49 +0100 (CET)
In-Reply-To: <20071214105238.18066.23281.stgit@krank>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 contrib/stgit.el |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index dfbf4a0..4d0faca 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -141,6 +141,7 @@ Argument DIR is the repository path."
   (define-key stgit-mode-map "g"   'stgit-refresh)
   (define-key stgit-mode-map "r"   'stgit-rename)
   (define-key stgit-mode-map "e"   'stgit-edit)
+  (define-key stgit-mode-map "c"   'stgit-coalesce)
   (define-key stgit-mode-map "N"   'stgit-new)
   (define-key stgit-mode-map "\C-r"   'stgit-repair)
   (define-key stgit-mode-map "C"   'stgit-commit)
@@ -348,6 +349,26 @@ Commands:
            (substring patch 0 20))
           (t patch))))
=20
+(defun stgit-coalesce (patch-names)
+  "Run stg coalesce on the named patches"
+  (interactive (list (stgit-marked-patches)))
+  (let ((edit-buf (get-buffer-create "*stgit edit*"))
+        (dir default-directory))
+    (log-edit 'stgit-confirm-coalesce t nil edit-buf)
+    (set (make-local-variable 'stgit-patches) patch-names)
+    (setq default-directory dir)
+    (let ((standard-output edit-buf))
+      (apply 'stgit-run "coalesce" "--save-template=3D-" patch-names))=
))
+
+(defun stgit-confirm-coalesce ()
+  (interactive)
+  (let ((file (make-temp-file "stgit-edit-")))
+    (write-region (point-min) (point-max) file)
+    (stgit-capture-output nil
+      (apply 'stgit-run "coalesce" "-f" file stgit-patches))
+    (with-current-buffer log-edit-parent-buffer
+      (stgit-refresh))))
+
 (defun stgit-help ()
   "Display help for the StGit mode."
   (interactive)
