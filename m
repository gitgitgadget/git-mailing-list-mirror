From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git.el: Avoid setting font lock keywords before entering log-edit mode.
Date: Sat, 06 Jan 2007 14:46:47 +0100
Message-ID: <87lkkgw9mg.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 06 14:47:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3Bsy-000875-Sx
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 14:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbXAFNq6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 08:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbXAFNq6
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 08:46:58 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:56285 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbXAFNq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 08:46:57 -0500
Received: from adsl-84-227-145-235.adslplus.ch ([84.227.145.235] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1H3Bss-00049y-Kn
	for git@vger.kernel.org; Sat, 06 Jan 2007 07:46:56 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 8C0984F693; Sat,  6 Jan 2007 14:46:47 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36088>

Instead, reinitialize the keywords after the fact. This avoids
conflicts with other users of log-edit mode, like pcl-cvs.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 38915e5..ede3ab2 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -49,6 +49,7 @@
 
 (eval-when-compile (require 'cl))
 (require 'ewoc)
+(require 'log-edit)
 
 
 ;;;; Customizations
@@ -147,6 +148,13 @@ if there is already one that displays the same directory."
 
 (defconst git-log-msg-separator "--- log message follows this line ---")
 
+(defvar git-log-edit-font-lock-keywords
+  `(("^\\(Author:\\|Date:\\|Parent:\\|Signed-off-by:\\)\\(.*\\)$"
+     (1 font-lock-keyword-face)
+     (2 font-lock-function-name-face))
+    (,(concat "^\\(" (regexp-quote git-log-msg-separator) "\\)$")
+     (1 font-lock-comment-face))))
+
 (defun git-get-env-strings (env)
   "Build a list of NAME=VALUE strings from a list of environment strings."
   (mapcar (lambda (entry) (concat (car entry) "=" (cdr entry))) env))
@@ -894,14 +902,9 @@ and returns the process output as a string."
               (sign-off
                (insert (format "\n\nSigned-off-by: %s <%s>\n"
                                (git-get-committer-name) (git-get-committer-email)))))))
-    (let ((log-edit-font-lock-keywords
-           `(("^\\(Author:\\|Date:\\|Parent:\\|Signed-off-by:\\)\\(.*\\)"
-              (1 font-lock-keyword-face)
-              (2 font-lock-function-name-face))
-             (,(concat "^\\(" (regexp-quote git-log-msg-separator) "\\)$")
-              (1 font-lock-comment-face)))))
-      (log-edit #'git-do-commit nil #'git-log-edit-files buffer)
-      (re-search-forward (regexp-quote (concat git-log-msg-separator "\n")) nil t))))
+    (log-edit #'git-do-commit nil #'git-log-edit-files buffer)
+    (setq font-lock-keywords (font-lock-compile-keywords git-log-edit-font-lock-keywords))
+    (re-search-forward (regexp-quote (concat git-log-msg-separator "\n")) nil t)))
 
 (defun git-find-file ()
   "Visit the current file in its own buffer."
-- 
1.5.0.rc0.g5a8e

-- 
Alexandre Julliard
julliard@winehq.org
