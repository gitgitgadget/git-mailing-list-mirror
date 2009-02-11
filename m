From: Brent Goodrick <bgoodr@gmail.com>
Subject: [PATCH] Fix file mark handling and sort side-effects in git.el
Date: Tue, 10 Feb 2009 22:12:28 -0800
Message-ID: <18834.27724.991388.339214@hungover.brentg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 07:14:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX8MC-000264-Rt
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 07:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbZBKGMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 01:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbZBKGMe
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 01:12:34 -0500
Received: from wf-out-1314.google.com ([209.85.200.172]:62538 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbZBKGMd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 01:12:33 -0500
Received: by wf-out-1314.google.com with SMTP id 28so45960wfa.4
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 22:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:mime-version
         :content-type:content-transfer-encoding:message-id:date:to:subject
         :x-mailer;
        bh=749c+SVT3E69PyN3CmPjNL6TxbMxFid9JGlH9bTpo6E=;
        b=Rl6+kLEi6KG0RtJHCZuHLjhqbEjmAVFkz9gwdTaP8XfjMp08kdrt+u6kY38AjbguNY
         I+u7iS0RSCOQXxW4X+cpCLzdICTDIBM8X+BqKpaUM88LYG1KdAn7FrEBV42XOdoooVin
         XiNE/itdErIodaRZFT9LBUkBdtB8Ai0IPWVOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:mime-version:content-type:content-transfer-encoding:message-id
         :date:to:subject:x-mailer;
        b=et4aw82aXkW0SsSUrxNtZeZB6Bwg0Yg7+g77RM9CAYrBbG0VEGynv/cvEiQWWTKscu
         7BhrXYJJOLB6PWYTIpP1MUIR+8p9JgpzLt1CP6v1DfRLdetPFj1eCtKp4c/ouBx1LQir
         LdhgG04ejaldxF1+BUWbzTXPHn2ZVyWc6jTc4=
Received: by 10.140.250.14 with SMTP id x14mr5232081rvh.79.1234332752584;
        Tue, 10 Feb 2009 22:12:32 -0800 (PST)
Received: from hungover.brentg.com.thisisbogus.com ([76.14.208.3])
        by mx.google.com with ESMTPS id g22sm12049427rvb.9.2009.02.10.22.12.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Feb 2009 22:12:31 -0800 (PST)
X-Mailer: VM viewmail-609 under 23.0.60.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109381>


The `sort' Elisp function works destructively, causing anomalies where
operations on multiple files would be performed on one file.  This
checkin works around that by doing a deep copy with `append'.

Also, git-add-file needed to pass 'modified to git-marked-files-state,
as otherwise, files that are modified but not yet in the index would
not show up in the git-marked-files-state return value, which would
then cause a prompt for file to show up when the files are clearly
marked in the status buffer.

Signed-off-by: Brent Goodrick <bgoodr@gmail.com>
---
 contrib/emacs/git.el |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index fcbe2d9..93e47c1 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -532,7 +532,7 @@ Each entry is a cons of (SHORT-NAME . FULL-NAME)."
 (defun git-status-filenames-map (status func files &rest args)
   "Apply FUNC to the status files names in the FILES list."
   (when files
-    (setq files (sort files #'string-lessp))
+    (setq files (sort (append files nil) #'string-lessp))
     (let ((file (pop files))
           (node (ewoc-nth status 0)))
       (while (and file node)
@@ -773,7 +773,7 @@ Return the list of files that haven't been handled."
   "Update the status of FILES from the index."
   (unless git-status (error "Not in git-status buffer."))
   ;; set the needs-update flag on existing files
-  (if (setq files (sort files #'string-lessp))
+  (if (setq files (sort (append files nil) #'string-lessp))
       (git-status-filenames-map
        git-status (lambda (info) (setf (git-fileinfo->needs-update info) t)) files)
     (ewoc-map (lambda (info) (setf (git-fileinfo->needs-update info) t) nil) git-status)
@@ -1041,7 +1041,7 @@ Return the list of files that haven't been handled."
 (defun git-add-file ()
   "Add marked file(s) to the index cache."
   (interactive)
-  (let ((files (git-get-filenames (git-marked-files-state 'unknown 'ignored))))
+  (let ((files (git-get-filenames (git-marked-files-state 'modified 'unknown 'ignored))))
     ;; FIXME: add support for directories
     (unless files
       (push (file-relative-name (read-file-name "File to add: " nil nil t)) files))
-- 
1.6.2.rc0.10.gf6b9.dirty
