From: David Kastrup <dak@gnu.org>
Subject: [PATCH] vc-git: support asynchronous annotations, and improve versioning.
Date: Mon, 16 Jul 2007 01:53:57 +0200
Organization: Organization?!?
Message-ID: <cfa5ed80635135dd7544f2b4c6df521a4353e90d.1184548803.git.dak@gnu.org>
References: <403842ba71506c7b194812cd9a4f669c847eb7bc.1184548803.git.dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 03:40:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAFZe-0007mt-Ut
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 03:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761085AbXGPBkL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 21:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761011AbXGPBkK
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 21:40:10 -0400
Received: from main.gmane.org ([80.91.229.2]:56181 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760551AbXGPBkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 21:40:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IAFZC-0003lx-KE
	for git@vger.kernel.org; Mon, 16 Jul 2007 03:40:03 +0200
Received: from dslb-084-061-039-155.pools.arcor-ip.net ([84.61.39.155])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 03:40:02 +0200
Received: from dak by dslb-084-061-039-155.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 03:40:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-039-155.pools.arcor-ip.net
X-From-Line: cfa5ed80635135dd7544f2b4c6df521a4353e90d Mon Sep 17 00:00:00 2001
In-Reply-To: <403842ba71506c7b194812cd9a4f669c847eb7bc.1184548803.git.dak@gnu.org>
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:Jef3KMul2N+fQcsX/1bnRSRValE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52623>

(vc-git-symbolic-commit): Allow nil to pass through.
(vc-git-previous-version): Use explicit parent argument.
(vc-git-next-version): Simplify.
(vc-git-annotate-command): Use `vc-do-command'.
(vc-git-annotate-extract-revision-at-line): Rename from
`vc-annotate-extract-revision-at-line'.
(vc-git-checkout): Make nicer way of ensuring encoding.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 contrib/emacs/vc-git.el |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index 2a0a0fe..d7ad314 100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -173,23 +173,22 @@ Returns nil if not possible."
       (let ((fullname (substring
                        (vc-git--run-command-string file "ls-files" "-z" "--full-name" "--")
                        0 -1))
-            (coding-system-for-read 'no-conversion)
-            coding-system-for-write)
+            (coding-system-for-read 'no-conversion))
         (with-temp-file destfile
-	  (prog1
-	      (eq 0 (call-process "git" nil t nil "cat-file" "blob"
-				  (concat (or rev "HEAD") ":" fullname)))
-	    (setq coding-system-for-write 'no-conversion))))
+	  (setq buffer-file-coding-system 'no-conversion)
+	  (eq 0 (call-process "git" nil t nil "cat-file" "blob"
+			      (concat (or rev "HEAD") ":" fullname)))))
     (vc-git--run-command file "checkout" (or rev "HEAD"))))
 
 (defun vc-git-annotate-command (file buffer &optional version)
   "Execute \"git blame\" on FILE, inserting the contents in BUFFER.
 Optional arg VERSION is a version to annotate from."
-  (vc-do-command buffer
-		 'async
-		 "git" file "blame"
-		 (or version "HEAD")
-		 "--"))
+  (let ((coding-system-for-read git-commits-coding-system))
+    (vc-do-command buffer
+		   'async
+		   "git" file "blame"
+		   (or version "HEAD")
+		   "--")))
 
 ;;(defun vc-git-annotate-command (file buf &optional rev)
 ;;  (let ((name (file-relative-name file)))
-- 
1.4.4.2
