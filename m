From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 3/4] git.el: Check for existing buffers on revert.
Date: Thu, 07 Feb 2008 13:51:20 +0100
Message-ID: <87r6fporp3.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 13:52:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN6FD-00073P-0e
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 13:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761369AbYBGMve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 07:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760534AbYBGMvd
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 07:51:33 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:60856 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761369AbYBGMvc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 07:51:32 -0500
Received: from adsl-84-227-175-174.adslplus.ch ([84.227.175.174] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1JN6Dr-0006sv-HG
	for git@vger.kernel.org; Thu, 07 Feb 2008 06:51:31 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 9C41A1E7141; Thu,  7 Feb 2008 13:51:20 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72933>

Refuse to revert a file if it is modified in an existing buffer but
not saved. On success, revert the buffers that contains the files that
have been reverted.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 5519ed1..e1058b9 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1033,11 +1033,19 @@ Return the list of files that haven't been handled."
           ('deleted (push (git-fileinfo->name info) modified))
           ('unmerged (push (git-fileinfo->name info) modified))
           ('modified (push (git-fileinfo->name info) modified))))
+      ;; check if a buffer contains one of the files and isn't saved
+      (dolist (file (append added modified))
+        (let ((buffer (get-file-buffer file)))
+          (when (and buffer (buffer-modified-p buffer))
+            (error "Buffer %s is modified. Please kill or save modified buffers before reverting." (buffer-name buffer)))))
       (when added
         (apply #'git-call-process-env nil nil "update-index" "--force-remove" "--" added))
       (when modified
         (apply #'git-call-process-env nil nil "checkout" "HEAD" modified))
       (git-update-status-files (append added modified) 'uptodate)
+      (dolist (file (append added modified))
+        (let ((buffer (get-file-buffer file)))
+          (when buffer (with-current-buffer buffer (revert-buffer t t t)))))
       (git-success-message "Reverted" (git-get-filenames files)))))
 
 (defun git-resolve-file ()
-- 
1.5.4.38.g0d380

-- 
Alexandre Julliard
julliard@winehq.org
