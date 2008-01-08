From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 1/3] git.el: Make sure we never insert the same file twice.
Date: Tue, 08 Jan 2008 14:45:46 +0100
Message-ID: <873at8jur9.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 14:46:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCEma-0007Jw-MI
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 14:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbYAHNpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 08:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756362AbYAHNpw
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 08:45:52 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:38247 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735AbYAHNpw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 08:45:52 -0500
Received: from adsl-62-167-25-224.adslplus.ch ([62.167.25.224] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1JCEm5-000230-Bf
	for git@vger.kernel.org; Tue, 08 Jan 2008 07:45:50 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id B14621E7166; Tue,  8 Jan 2008 14:45:46 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69877>

Skip non-zero stage files during git-ls-files -c, they are handled
later. Also fix git-insert-info-list to merge duplicate file names.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 9a0f03f..885ad20 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -608,7 +608,7 @@ and returns the process output as a string."
     (while info
       (setf (git-fileinfo->needs-refresh info) t)
       (cond ((not node)
-             (ewoc-enter-last status info)
+             (setq node (ewoc-enter-last status info))
              (setq info (pop infolist)))
             ((string-lessp (git-fileinfo->name (ewoc-data node))
                            (git-fileinfo->name info))
@@ -620,7 +620,7 @@ and returns the process output as a string."
               (setf (ewoc-data node) info)
               (setq info (pop infolist)))
             (t
-             (ewoc-enter-before status node info)
+             (setq node (ewoc-enter-before status node info))
              (setq info (pop infolist)))))))
 
 (defun git-run-diff-index (status files)
@@ -677,7 +677,7 @@ Return the list of files that haven't been handled."
     (with-temp-buffer
       (apply #'git-call-process-env t nil "ls-files" "-z" "-s" "-c" "--" files)
       (goto-char (point-min))
-      (while (re-search-forward "\\([0-7]\\{6\\}\\) [0-9a-f]\\{40\\} [0-3]\t\\([^\0]+\\)\0" nil t)
+      (while (re-search-forward "\\([0-7]\\{6\\}\\) [0-9a-f]\\{40\\} 0\t\\([^\0]+\\)\0" nil t)
 	(let* ((new-perm (string-to-number (match-string 1) 8))
 	       (old-perm (if (eq default-state 'added) 0 new-perm))
 	       (name (match-string 2)))
-- 
1.5.4.rc2.71.ge10a9

-- 
Alexandre Julliard
julliard@winehq.org
