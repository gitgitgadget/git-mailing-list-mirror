From: David Kastrup <dak@gnu.org>
Subject: [PATCH] Add missing functions to contrib/emacs/vc-git.el
Date: Thu, 12 Jul 2007 16:48:48 +0200
Message-ID: <86lkdlu0tr.fsf_-_@lola.quinscape.zz>
References: <86abu3dv9o.fsf@lola.quinscape.zz> <A084830C-F1CD-4EDC-A13D-573DFC68DF77@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 16:57:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I906o-00019a-B2
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 16:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177AbXGLO5b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 10:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755239AbXGLO5b
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 10:57:31 -0400
Received: from main.gmane.org ([80.91.229.2]:36803 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755087AbXGLO5a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 10:57:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I906h-0007HI-3G
	for git@vger.kernel.org; Thu, 12 Jul 2007 16:57:27 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 16:57:27 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 16:57:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:gwXavvp1wZjYQhycMV6YHxR1Agw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52296>


This is necessary to make several editing functions work, like
C-u C-x v =

Signed-off-by: David Kastrup <dak@gnu.org>

---
 contrib/emacs/vc-git.el |   65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index e456ab9..b8f6be5 100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -81,6 +81,71 @@
         (match-string 2 str)
       str)))
 
+(defun vc-git-symbolic-commit (commit)
+  "Translate COMMIT string into symbolic form.
+Returns nil if not possible."
+  (and commit
+       (with-temp-buffer
+	 (and
+	  (zerop
+	   (call-process "git" nil '(t nil) nil "name-rev"
+			 "--name-only" "--tags"
+			 commit))
+	  (goto-char (point-min))
+	  (= (forward-line 2) 1)
+	  (bolp)
+	  (buffer-substring-no-properties (point-min) (1- (point-max)))))))
+
+(defun vc-git-previous-version (file rev)
+  "git-specific version of `vc-previous-version'."
+  (let ((default-directory (file-name-directory (expand-file-name file)))
+	(file (file-name-nondirectory file)))
+    (vc-git-symbolic-commit
+     (with-temp-buffer
+       (and
+	(zerop
+	 (call-process "git" nil '(t nil) nil "rev-list"
+		       "-2" rev "--" file))
+	(goto-char (point-max))
+	(bolp)
+	(zerop (forward-line -1))
+	(not (bobp))
+	(buffer-substring-no-properties
+	   (point)
+	   (1- (point-max))))))))
+
+(defun vc-git-next-version (file rev)
+  "git-specific version of `vc-next-version'."
+  (let* ((default-directory (file-name-directory
+			     (expand-file-name file)))
+	(file (file-name-nondirectory file))
+	(current-rev
+	 (with-temp-buffer
+	   (and
+	    (zerop
+	     (call-process "git" nil '(t nil) nil "rev-list"
+			   "-1" rev "--" file))
+	    (goto-char (point-max))
+	    (bolp)
+	    (zerop (forward-line -1))
+	    (bobp)
+	    (buffer-substring-no-properties
+	     (point)
+	     (1- (point-max)))))))
+    (and current-rev
+	 (vc-git-symbolic-commit
+	  (with-temp-buffer
+	    (and
+	     (zerop
+	      (call-process "git" nil '(t nil) nil "rev-list"
+			    "HEAD" "--" file))
+	     (goto-char (point-min))
+	     (search-forward current-rev nil t)
+	     (zerop (forward-line -1))
+	     (buffer-substring-no-properties
+	      (point)
+	      (progn (forward-line 1) (1- (point))))))))))
+
 (defun vc-git-revert (file &optional contents-done)
   "Revert FILE to the version stored in the git repository."
   (if contents-done
-- 
1.5.3.rc0.51.gb0b1f


-- 
David Kastrup
