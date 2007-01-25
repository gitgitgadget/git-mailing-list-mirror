From: Sam Vilain <sam@vilain.net>
Subject: [PATCH] contrib/emacs/vc-git.el: support vc-version-other-window
Date: Fri, 26 Jan 2007 12:41:23 +1300
Message-ID: <20060126.manual2@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 03:14:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAGbw-0008SD-Un
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 03:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030707AbXAZCOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 21:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030708AbXAZCOi
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 21:14:38 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:53794 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030707AbXAZCOh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 21:14:37 -0500
X-Greylist: delayed 1069 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jan 2007 21:14:37 EST
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003)
	id 9B10D13A287; Fri, 26 Jan 2007 14:56:45 +1300 (NZDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37791>

Currently, the vc-git-checkout function uses `git checkout' to fetch a
file from the git repository to the working copy.  However, it is
completely ignoring the input argument that specifies the destination
file.  `git-checkout' does not support specifying this, so we have to
use `git-cat-file', capture the output in a buffer and then save it.
---
 contrib/emacs/vc-git.el |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

(this is a second re-send, the original patch got dropped, probably
because it had an unsubscribed sender) 

diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index 8b63619..35a0e76 100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -53,6 +53,10 @@
   (let ((name (file-relative-name file)))
     (eq 0 (apply #'call-process "git" nil (get-buffer "*Messages") nil (append args (list name))))))
 
+(defun vc-git--run-command-out (output &rest args)
+  "Run a git command, output to output."
+  (eq 0 (apply #'call-process "git" nil output nil (append args))))
+
 (defun vc-git-registered (file)
   "Check whether FILE is registered with git."
   (with-temp-buffer
@@ -119,7 +123,28 @@
     (vc-git--run-command file "commit" "-m" comment "--only" "--")))
 
 (defun vc-git-checkout (file &optional editable rev destfile)
-  (vc-git--run-command file "checkout" (or rev "HEAD")))
+  (if destfile
+      (let ((mybuff (get-buffer-create "vc-git-checkout-tmp")))
+	(let ((rv
+	       (vc-git--run-command-out
+		mybuff "cat-file" "blob"
+		(concat (or rev "HEAD")
+			":"
+			(let ((output (vc-git--run-command-string
+				       (file-relative-name file)
+				       "ls-files" "--full-name")))
+			  (string-match "\\(.*\\)" output)
+			  (match-string 1 output))
+			)))
+	      )
+	  (if rv
+	      (save-current-buffer
+		(set-buffer mybuff)
+		(set-visited-file-name destfile t)
+		(save-buffer)
+		)
+	    rv)))
+    (vc-git--run-command file "checkout" (or rev "HEAD"))))
 
 (defun vc-git-annotate-command (file buf &optional rev)
   ; FIXME: rev is ignored
-- 
1.4.4.1.g6a1a-dirty
