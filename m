From: Martin Nordholts <enselic@gmail.com>
Subject: [PATCH] git.el: Use git-add-file for unmerged files, remove git-resolve-file
Date: Thu, 03 Sep 2009 22:27:24 +0200
Message-ID: <4AA026AC.10907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Thu Sep 03 22:24:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjIr2-0004zE-67
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 22:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756242AbZICUYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 16:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756211AbZICUYO
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 16:24:14 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:41352 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924AbZICUYN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 16:24:13 -0400
Received: by bwz19 with SMTP id 19so231236bwz.37
        for <git@vger.kernel.org>; Thu, 03 Sep 2009 13:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=1xv2oostZTWNFvDXP3Nt1IQV1+xPw47uQ5G7UTIqaaQ=;
        b=xCvQU73tZCS3t7i4OCpyuJOS8BNFdzVxMQmoPauacEjMI0y4Cd72K4/tYeCltAK4WI
         Bhx2Etm6a5t2ou9jAN8/FQgSYjbgz2nkigq/r7Y/DTEGRNhKAuXsYfTBISGlG2ht/dGB
         wtfwQ+lvPvN7/GPYtX0Xcpmgw0RbD1HMx4dFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=E5unoQa7GZHmkjsiwqm5Xc9TtjZXYpSJm8OKh6FDsjdjrNSx4Fs/8W2QUAkHP0qg1b
         8+r6pIsrPODQyMua7N1lKwpFIo3cMZ2uiOxzXGXL7h9opSzlIV/Xgb7WZRP2DPBTp5fc
         Edai/O9uNpxBRHWjKPZpUNqafH3ISZAZd+5ps=
Received: by 10.102.254.38 with SMTP id b38mr4350495mui.58.1252009453964;
        Thu, 03 Sep 2009 13:24:13 -0700 (PDT)
Received: from ?192.168.1.2? (c-267871d5.017-113-6c756e10.cust.bredbandsbolaget.se [213.113.120.38])
        by mx.google.com with ESMTPS id s11sm233427mue.13.2009.09.03.13.24.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Sep 2009 13:24:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Thunderbird/3.0b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127666>

Use `git-add-file' to mark unmerged files as resolved in the
*git-status* buffer to be consistent with git's CLI instructions. Also
remove `git-resolve-file' to make it clear that that "R" is a now a
free keybinding.

Signed-off-by: Martin Nordholts <martinn@src.gnome.org>
---
 contrib/emacs/git.el |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 8c70ad8..214930a 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1046,7 +1046,7 @@ The FILES list must be sorted."
 (defun git-add-file ()
   "Add marked file(s) to the index cache."
   (interactive)
-  (let ((files (git-get-filenames (git-marked-files-state 'unknown 'ignored))))
+  (let ((files (git-get-filenames (git-marked-files-state 'unknown 'ignored 'unmerged))))
     ;; FIXME: add support for directories
     (unless files
       (push (file-relative-name (read-file-name "File to add: " nil nil t)) files))
@@ -1119,15 +1119,6 @@ The FILES list must be sorted."
               (when buffer (with-current-buffer buffer (revert-buffer t t t)))))
           (git-success-message "Reverted" names))))))
 
-(defun git-resolve-file ()
-  "Resolve conflicts in marked file(s)."
-  (interactive)
-  (let ((files (git-get-filenames (git-marked-files-state 'unmerged))))
-    (when files
-      (when (apply 'git-call-process-display-error "update-index" "--" files)
-        (git-update-status-files files)
-        (git-success-message "Resolved" files)))))
-
 (defun git-remove-handled ()
   "Remove handled files from the status list."
   (interactive)
@@ -1556,7 +1547,6 @@ amended version of it."
     (define-key map "P"   'git-prev-unmerged-file)
     (define-key map "q"   'git-status-quit)
     (define-key map "r"   'git-remove-file)
-    (define-key map "R"   'git-resolve-file)
     (define-key map "t"    toggle-map)
     (define-key map "T"   'git-toggle-all-marks)
     (define-key map "u"   'git-unmark-file)
@@ -1598,7 +1588,6 @@ amended version of it."
       ("Merge"
 	["Next Unmerged File" git-next-unmerged-file t]
 	["Prev Unmerged File" git-prev-unmerged-file t]
-	["Mark as Resolved" git-resolve-file t]
 	["Interactive Merge File" git-find-file-imerge t]
 	["Diff Against Common Base File" git-diff-file-base t]
 	["Diff Combined" git-diff-file-combined t]
-- 
1.6.2.5
