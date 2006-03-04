From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 3/5] git.el: Automatically update .gitignore status.
Date: Sat, 04 Mar 2006 17:38:20 +0100
Message-ID: <87bqwmkvwj.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 04 17:38:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFZm2-0007m4-Gd
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 17:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWCDQi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 11:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWCDQi2
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 11:38:28 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:16844 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S932109AbWCDQi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Mar 2006 11:38:27 -0500
Received: from adsl-84-227-8-187.adslplus.ch ([84.227.8.187] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FFZlu-0000jn-Jy
	for git@vger.kernel.org; Sat, 04 Mar 2006 10:38:26 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id A3B244F90E; Sat,  4 Mar 2006 17:38:20 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
X-SA-Exim-Connect-IP: 84.227.8.187
X-SA-Exim-Mail-From: julliard@winehq.org
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,
	SPF_HELO_SOFTFAIL autolearn=no version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17186>

Update .gitignore files in the status list as they are created or
modified.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>

---

 contrib/emacs/git.el |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

403b5738e69df610ab625085ccbd771a466b7af8
diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 2363e48..335dcb2 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -213,14 +213,19 @@ If not set, fall back to `add-log-mailin
   "Add a file name to the ignore file in its directory."
   (let* ((fullname (expand-file-name file))
          (dir (file-name-directory fullname))
-         (name (file-name-nondirectory fullname)))
+         (name (file-name-nondirectory fullname))
+         (ignore-name (expand-file-name git-per-dir-ignore-file dir))
+         (created (not (file-exists-p ignore-name))))
   (save-window-excursion
-    (set-buffer (find-file-noselect (expand-file-name git-per-dir-ignore-file dir)))
+    (set-buffer (find-file-noselect ignore-name))
     (goto-char (point-max))
     (unless (zerop (current-column)) (insert "\n"))
     (insert name "\n")
     (sort-lines nil (point-min) (point-max))
-    (save-buffer))))
+    (save-buffer))
+  (when created
+    (git-run-command nil nil "update-index" "--info-only" "--add" "--" (file-relative-name ignore-name)))
+  (git-add-status-file (if created 'added 'modified) (file-relative-name ignore-name))))
 
 
 ;;;; Wrappers for basic git commands
-- 
1.2.4.g0040-dirty

-- 
Alexandre Julliard
julliard@winehq.org
