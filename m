From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 13/17] Emacs mode: Add stgit-edit command
Date: Fri, 14 Dec 2007 11:59:02 +0100
Message-ID: <20071214105856.18066.18189.stgit@krank>
References: <20071214105238.18066.23281.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 12:00:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38HA-0001xm-Ao
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 12:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764253AbXLNK6r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 05:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764294AbXLNK6q
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 05:58:46 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:51847 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764061AbXLNK6p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 05:58:45 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 98AF9200A238;
	Fri, 14 Dec 2007 11:58:44 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 27584-01-65; Fri, 14 Dec 2007 11:58:44 +0100 (CET)
Received: from krank (vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 4CB79200A217;
	Fri, 14 Dec 2007 11:58:44 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id B335F7B406D;
	Fri, 14 Dec 2007 11:59:02 +0100 (CET)
In-Reply-To: <20071214105238.18066.23281.stgit@krank>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68292>


Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 contrib/stgit.el |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index 4282585..a344869 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -89,6 +89,7 @@ Argument DIR is the repository path."
   (define-key stgit-mode-map "n"   'next-line)
   (define-key stgit-mode-map "g"   'stgit-refresh)
   (define-key stgit-mode-map "r"   'stgit-rename)
+  (define-key stgit-mode-map "e"   'stgit-edit)
   (define-key stgit-mode-map "\C-r"   'stgit-repair)
   (define-key stgit-mode-map "C"   'stgit-commit)
   (define-key stgit-mode-map "U"   'stgit-uncommit)
@@ -204,6 +205,30 @@ Commands:
       (goto-char (point-min))
       (diff-mode))))
=20
+(defun stgit-edit ()
+  "Edit the patch on the current line"
+  (interactive)
+  (let ((patch (if (stgit-applied-at-point)
+                   (stgit-patch-at-point)
+                 (error "This patch is not applied")))
+        (edit-buf (get-buffer-create "*stgit edit*"))
+        (dir default-directory))
+    (log-edit 'stgit-confirm-edit t nil edit-buf)
+    (set (make-local-variable 'stgit-edit-patch) patch)
+    (setq default-directory dir)
+    (let ((standard-output edit-buf))
+      (stgit-run "edit" "--save-template=3D-" patch))))
+
+(defun stgit-confirm-edit ()
+  (interactive)
+  (let ((file (make-temp-file "stgit-edit-")))
+    (write-region (point-min) (point-max) file)
+    (stgit-capture-output nil
+      (stgit-run "edit" "-f" file stgit-edit-patch))
+    (with-current-buffer log-edit-parent-buffer
+      (stgit-refresh))))
+
+
 (defun stgit-help ()
   "Display help for the StGit mode."
   (interactive)
