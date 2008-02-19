From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] git.el: Add a git-grep command
Date: Tue, 19 Feb 2008 14:03:18 +0100
Message-ID: <87odaa4tcl.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 09:18:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS6cw-0007X4-Ck
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 09:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765314AbYBUIQg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2008 03:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbYBUIQg
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 03:16:36 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:49376 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762320AbYBUIQe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 03:16:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id DC46B200A22D;
	Thu, 21 Feb 2008 09:16:32 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06228-01-53; Thu, 21 Feb 2008 09:16:32 +0100 (CET)
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 39E60200A222;
	Thu, 21 Feb 2008 09:16:32 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 904477B4078; Thu, 21 Feb 2008 09:16:42 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74607>

This allows easy access to git grep from Emacs.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 contrib/emacs/git.el |   50 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

This works for me, but before including it someone else should try
it. It might only work in Emacs 22, for instance.

But when it works, it is really useful.

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index f69b697..898e70a 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -49,6 +49,7 @@
 (require 'ewoc)
 (require 'log-edit)
 (require 'easymenu)
+(require 'grep)
=20
=20
 ;;;; Customizations
@@ -1584,5 +1585,54 @@ Meant to be used in `after-save-hook'."
   (interactive)
   (describe-function 'git-status-mode))
=20
+(defvar git-grep-history nil)
+
+(defun git-grep (regexp &optional files dir)
+  "Recursively grep for REGEXP in FILES in directory tree rooted at DI=
R.
+The search is limited to file names matching shell pattern FILES.
+FILES may use abbreviations defined in `grep-files-aliases', e.g.
+entering `ch' is equivalent to `*.[ch]'.
+
+With \\[universal-argument] prefix, you can edit the constructed shell=
 command line
+before it is executed.
+With two \\[universal-argument] prefixes, directly edit and run `git-g=
rep-find-command'.
+
+Collect output in a buffer.  While find runs asynchronously, you
+can use \\[next-error] (M-x next-error), or \\<grep-mode-map>\\[compil=
e-goto-error]
+in the grep output buffer, to go to the lines where grep found matches=
=2E"
+  (interactive
+   (cond
+    ((equal current-prefix-arg '(16))
+     (list (read-from-minibuffer "Run: " "git grep "
+                                 nil nil 'git-grep-history)
+           nil))
+    (t (let* ((regexp (grep-read-regexp))
+              (files (grep-read-files regexp))
+              (dir (read-directory-name "Base directory: "
+                                        nil default-directory t)))
+         (list regexp files dir)))))
+  (when (and (stringp regexp) (> (length regexp) 0))
+    (if (null files)
+	(if (not (string=3D regexp grep-find-command))
+	    (compilation-start regexp 'grep-mode))
+      (setq dir (file-name-as-directory (expand-file-name dir)))
+      (let ((command (concat
+		      "git grep -n "
+		      "-e " (shell-quote-argument regexp)
+                      (if (string=3D files "*")
+                          ""
+                        (concat " -- " (shell-quote-argument files))))=
))
+	(when command
+	  (if current-prefix-arg
+	      (setq command
+		    (read-from-minibuffer "Confirm: "
+					  command nil nil 'git-grep-history))
+	    (add-to-history 'git-grep-history command))
+	  (let ((default-directory dir))
+	    (compilation-start (concat "PAGER=3D " command) 'grep-mode))
+	  ;; Set default-directory if we started rgrep in the *grep* buffer.
+	  (if (eq next-error-last-buffer (current-buffer))
+	      (setq default-directory dir)))))))
+
 (provide 'git)
 ;;; git.el ends here
--=20
1.5.4.2.148.g410dc


--=20
David K=C3=A5gedal
