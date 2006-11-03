X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 1/4] git.el: Added functions for moving to the next/prev unmerged file.
Date: Fri, 03 Nov 2006 17:41:23 +0100
Message-ID: <87d58432ks.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 16:43:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30864>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg26o-0003eE-Dl for gcvg-git@gmane.org; Fri, 03 Nov
 2006 17:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753358AbWKCQlb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 11:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbWKCQlb
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 11:41:31 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:20663 "EHLO
 mail.codeweavers.com") by vger.kernel.org with ESMTP id S1753358AbWKCQlb
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 11:41:31 -0500
Received: from adsl-84-227-158-29.adslplus.ch ([84.227.158.29]
 helo=wine.dyndns.org) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1Gg26j-0004Sa-HT for
 git@vger.kernel.org; Fri, 03 Nov 2006 10:41:30 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000) id D1E70109EB7; Fri,
  3 Nov 2006 17:41:23 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This is useful when doing a merge that changes many files with only a
few conflicts here and there.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 5354cd6..e283df2 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -670,6 +670,32 @@ and returns the process output as a stri
   (unless git-status (error "Not in git-status buffer."))
   (ewoc-goto-prev git-status n))
 
+(defun git-next-unmerged-file (&optional n)
+  "Move the selection down N unmerged files."
+  (interactive "p")
+  (unless git-status (error "Not in git-status buffer."))
+  (let* ((last (ewoc-locate git-status))
+         (node (ewoc-next git-status last)))
+    (while (and node (> n 0))
+      (when (eq 'unmerged (git-fileinfo->state (ewoc-data node)))
+        (setq n (1- n))
+        (setq last node))
+      (setq node (ewoc-next git-status node)))
+    (ewoc-goto-node git-status last)))
+
+(defun git-prev-unmerged-file (&optional n)
+  "Move the selection up N unmerged files."
+  (interactive "p")
+  (unless git-status (error "Not in git-status buffer."))
+  (let* ((last (ewoc-locate git-status))
+         (node (ewoc-prev git-status last)))
+    (while (and node (> n 0))
+      (when (eq 'unmerged (git-fileinfo->state (ewoc-data node)))
+        (setq n (1- n))
+        (setq last node))
+      (setq node (ewoc-prev git-status node)))
+    (ewoc-goto-node git-status last)))
+
 (defun git-add-file ()
   "Add marked file(s) to the index cache."
   (interactive)
@@ -967,7 +993,9 @@ and returns the process output as a stri
     (define-key map "m"   'git-mark-file)
     (define-key map "M"   'git-mark-all)
     (define-key map "n"   'git-next-file)
+    (define-key map "N"   'git-next-unmerged-file)
     (define-key map "p"   'git-prev-file)
+    (define-key map "P"   'git-prev-unmerged-file)
     (define-key map "q"   'git-status-quit)
     (define-key map "r"   'git-remove-file)
     (define-key map "R"   'git-resolve-file)
-- 
1.4.3.3.gf3240

-- 
Alexandre Julliard
