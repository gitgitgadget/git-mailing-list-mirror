From: Alex Bennee <kernel-hacker@bennee.com>
Subject: [RFC PATCH] Implement vc-git-annotate-show-diff-revision-at-line
	for emacs vc-git
Date: Fri, 22 Feb 2008 18:58:13 +0000
Message-ID: <1203706693.7552.56.camel@alexjb-desktop.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 20:56:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSdzt-0006C8-Vc
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 20:55:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757118AbYBVTzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 14:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755633AbYBVTzR
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 14:55:17 -0500
Received: from mx.transitive.com ([217.207.128.220]:47002 "EHLO
	pennyblack.transitives.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757057AbYBVTzP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2008 14:55:15 -0500
X-Greylist: delayed 3242 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Feb 2008 14:55:14 EST
Received: from [192.168.2.19] (helo=[192.168.2.19])
	by pennyblack.transitives.com with esmtp (Exim 4.50)
	id 1JSd8v-00088U-ID
	for git@vger.kernel.org; Fri, 22 Feb 2008 19:01:11 +0000
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74754>

Hi,

I've had an initial stab at doing this for jumping to the commit in
annotate mode. You can manually call it with M-x
vc-git-annotate-show-diff-revision-at-line and it all works fine.
However the vc logic wants vc-git-previous-version to exist before it
will call it directly from the mode. I considered evil key-rebinding
hacks but that seems to nasty.

Whats the easiest command to show the parent commit of a given commit id
(the closest analogy I can think of)? I tried:

 git-show 486a974a --pretty="format:%P"

But that shows the whole commit as well. Anyway here is the current form
of the patch. As you can probably tell elisp is not my first language:

>From 84ef7155339b60c21851eab72842cb5c4e8b3d47 Mon Sep 17 00:00:00 2001
From: Alex Bennee <alex@bennee.com>
Date: Fri, 22 Feb 2008 18:51:43 +0000
Subject: [PATCH] Attempt to implement annotate-jump-to-diff for vc-git.el

---
 contrib/emacs/vc-git.el |   46 ++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index b8f6be5..67cca95 100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -38,6 +38,16 @@
 (defvar git-commits-coding-system 'utf-8
   "Default coding system for git commits.")
 
+;; Helper functions
+;
+; These are helper functions that don't hook into vc-mode as git's
+; view of the versioned world is a little different to vc's
+
+(defun git-show-commit-diff (commit-id &optional buffer)
+  "Show a given commit id in patch form in a buffer"
+  (let ((buf (or buffer "*vc-diff*")))
+    (vc-do-command buf t "git" nil "show" commit-id)))
+
 (defun vc-git--run-command-string (file &rest args)
   "Run a git command on FILE and return its output as string."
   (let* ((ok t)
@@ -196,6 +206,34 @@ Returns nil if not possible."
                               (concat (or rev "HEAD") ":" fullname)))))
     (vc-git--run-command file "checkout" (or rev "HEAD"))))
 
+;; Not really useful since we can't do anything with the revision yet
+(defun vc-git-annotate-extract-revision-at-line ()
+  (save-excursion
+    (move-beginning-of-line 1)
+    (and (looking-at "[0-9a-f]+")
+         (buffer-substring (match-beginning 0) (match-end 0)))))
+
+;;Jump to the diff for a given revision
+;
+; The internal vc logic has the concept of prev and next, GIT worries
+; about commit ids. If we are in a git-annotate-view we really want to
+; be doing this ourselves.
+(defun vc-git-annotate-show-diff-revision-at-line ()
+  "Visit the diff of the version at line (git version)."
+  (interactive)
+  (if (not (equal major-mode 'vc-annotate-mode))
+      (message "Cannot be invoked outside of a vc annotate buffer")
+    (let ((rev-at-line (vc-annotate-extract-revision-at-line)))
+      (if (not rev-at-line)
+	  (message "Cannot extract revision number from the current line")
+	(save-window-excursion
+	  (git-show-commit-diff rev-at-line))
+	(switch-to-buffer "*vc-diff*")))))
+
+(defun vc-git-previous-version (file rev)
+  0)
+
+;; Do the annotate for VC
 (defun vc-git-annotate-command (file buf &optional rev)
   ; FIXME: rev is ignored
   (let ((name (file-relative-name file)))
@@ -206,11 +244,7 @@ Returns nil if not possible."
        (vc-annotate-convert-time
         (apply #'encode-time (mapcar (lambda (match) (string-to-number (match-string match))) '(6 5 4 3 2 1 7))))))
 
-;; Not really useful since we can't do anything with the revision yet
-;;(defun vc-annotate-extract-revision-at-line ()
-;;  (save-excursion
-;;    (move-beginning-of-line 1)
-;;    (and (looking-at "[0-9a-f]+")
-;;         (buffer-substring (match-beginning 0) (match-end 0)))))
+
+
 
 (provide 'vc-git)
-- 
1.5.2.5



-- 
Alex, homepage: http://www.bennee.com/~alex/
Hire me? http://www.bennee.com/~alex/cv.php
netgod: My calculator has more registers than the x86, and -- thats- sad
