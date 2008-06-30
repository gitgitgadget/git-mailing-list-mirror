From: Nikolaj Schumacher <n_schumacher@web.de>
Subject: [PATCH/RFC] git-blame.el: Use eldoc-mode to display current commit.
Date: Mon, 30 Jun 2008 11:57:48 +0200
Message-ID: <m2ej6fz1lv.fsf@nschum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 30 11:59:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDGA5-0006F6-SL
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 11:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419AbYF3J5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 05:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755727AbYF3J5x
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 05:57:53 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:39488 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288AbYF3J5v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 05:57:51 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id DFC64E5E8348;
	Mon, 30 Jun 2008 11:57:49 +0200 (CEST)
Received: from [77.135.94.229] (helo=thursday)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1KDG8r-0002CO-00; Mon, 30 Jun 2008 11:57:49 +0200
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2.50 (darwin)
X-Sender: n_schumacher@web.de
X-Provags-ID: V01U2FsdGVkX1/0f+ToABmPHV0q6aVTP6ZxDN+vujdoTn/0tkA6
	KrQ2tyY0HgqKzxNYjWO8scYl/qwj82P8dRxJUMyRmAOlDYm1ww
	/Lf/ihExUFoR/LVeV+5Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86897>

I think this is a better way to display the current commit.  However,
I'm not sure whether to rely on eldoc, or create my own timer.

regards,
Nikolaj Schumacher


>From 4bbd50ab1ae26ca154c20d140edfa187c9124959 Mon Sep 17 00:00:00 2001
From: Nikolaj Schumacher <git@nschum.de>
Date: Mon, 30 Jun 2008 11:44:46 +0200
Subject: [PATCH] git-blame.el: Use eldoc-mode to display current commit.

Previously, the current commit was displayed on every point movement using
text properties.  These properties stick to copied text, so that an error is
thrown once it is pasted in a different buffer.  Additionally, there is no
way to turn them off.  Using a configurable timer solves these problems.
Since eldoc already provides such functionality, hand off the work to it.
---
 contrib/emacs/git-blame.el |   27 +++++++++++----------------
 1 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 9f92cd2..c13e445 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -40,7 +40,7 @@
 ;; turn it on while viewing a file, the editor buffer will be updated by
 ;; setting the background of individual lines to a color that reflects
 ;; which commit it comes from.  And when you move around the buffer, a
-;; one-line summary will be shown in the echo area.
+;; one-line summary will be shown in the echo area if `eldoc-mode' is on.
 
 ;;; Installation:
 ;;
@@ -195,6 +195,7 @@ See also function `git-blame-mode'."
       (setq git-blame-colors git-blame-light-colors)))
   (setq git-blame-cache (make-hash-table :test 'equal))
   (setq git-blame-mode t)
+  (setq eldoc-documentation-function 'git-blame-identify)
   (git-blame-run))
 
 (defun git-blame-mode-off ()
@@ -354,15 +355,7 @@ See also function `git-blame-mode'."
             (overlay-put ovl 'git-blame info)
             (overlay-put ovl 'help-echo hash)
             (overlay-put ovl 'face (list :background
-                                         (cdr (assq 'color (nthcdr 5 info)))))
-            ;; the point-entered property doesn't seem to work in overlays
-            ;;(overlay-put ovl 'point-entered
-            ;;             `(lambda (x y) (git-blame-identify ,hash)))
-            (let ((modified (buffer-modified-p)))
-              (put-text-property (if (= start 1) start (1- start)) (1- end)
-                                 'point-entered
-                                 `(lambda (x y) (git-blame-identify ,hash)))
-              (set-buffer-modified-p modified))))
+                                         (cdr (assq 'color (nthcdr 5 info)))))))
         (setq num-lines (1- num-lines))))))
 
 (defun git-blame-add-info (key value)
@@ -383,14 +376,16 @@ See also function `git-blame-mode'."
                   hash)
     (buffer-substring (point-min) (1- (point-max)))))
 
-(defvar git-blame-last-identification nil)
-(make-variable-buffer-local 'git-blame-last-identification)
 (defun git-blame-identify (&optional hash)
   (interactive)
-  (let ((info (gethash (or hash (git-blame-current-commit)) git-blame-cache)))
-    (when (and info (not (eq info git-blame-last-identification)))
-      (message "%s" (nth 4 info))
-      (setq git-blame-last-identification info))))
+  (condition-case err
+      (let ((info (nth 4 (gethash (or hash (git-blame-current-commit))
+                                  git-blame-cache))))
+        (when info
+          (when (interactive-p)
+            (message "%s" info))
+          info))
+    (error nil)))
 
 ;; (defun git-blame-after-save ()
 ;;   (when git-blame-mode
-- 
1.5.5.3
