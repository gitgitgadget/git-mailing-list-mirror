From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH] stgit.el: Try to make the point stay on the coalesced
	patch.
Date: Thu, 06 Nov 2008 11:27:14 +0100
Message-ID: <20081106102655.32048.21145.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: kha@treskal.com, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 06 11:28:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky26J-0003BK-DF
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 11:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538AbYKFK1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 05:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbYKFK1R
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 05:27:17 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:47565 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471AbYKFK1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 05:27:16 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 7C89340013;
	Thu,  6 Nov 2008 11:27:12 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 704FE4001B; Thu,  6 Nov 2008 11:27:12 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.1.7-deb
Received: from krank (vtab.com [62.20.90.195])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 2026340013;
	Thu,  6 Nov 2008 11:27:12 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id 9512DDC0A4;
	Thu,  6 Nov 2008 11:27:14 +0100 (CET)
User-Agent: StGIT/0.14.3.278.g6f7d
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100228>

It might not be spot on if all the coalesced patches were unapplied.
---

This fixes a small annoyance with the 'c' command.

 contrib/stgit.el |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/contrib/stgit.el b/contrib/stgit.el
index d0f19c3..971ecd1 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -193,6 +193,9 @@ Commands:
   (let ((patchsym (intern patch)))
     (setq stgit-marked-patches (delq patchsym stgit-marked-patches))))
 
+(defun stgit-clear-marks ()
+  (setq stgit-marked-patches '()))
+
 (defun stgit-marked-patches ()
   "Return the names of the marked patches."
   (mapcar 'symbol-name stgit-marked-patches))
@@ -406,8 +409,15 @@ With numeric prefix argument, pop that many patches."
     (write-region (point-min) (point-max) file)
     (stgit-capture-output nil
       (apply 'stgit-run "coalesce" "-f" file stgit-patches))
+    (stgit-clear-marks)
     (with-current-buffer log-edit-parent-buffer
-      (stgit-refresh))))
+      ;; Go to first marked patch and stay there
+      (goto-char (point-min))
+      (re-search-forward (concat "^[>+-]\\*") nil t)
+      (move-to-column goal-column)
+      (let ((pos (point)))
+        (stgit-refresh)
+        (goto-char pos)))))
 
 (defun stgit-help ()
   "Display help for the StGit mode."
