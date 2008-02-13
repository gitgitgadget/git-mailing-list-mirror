From: =?us-ascii?Q?=3D=3Futf-8=3Fq=3FR=3DC3=3DA9mi=3D20Vanicat=3F=3D?= 
	<vanicat@debian.org>
Subject: [PATCH] Add function to checkout a branch in git.el
Date: Wed, 13 Feb 2008 16:53:12 +0100
Message-ID: <87wsp8u9m7.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexandre Julliard <julliard@winehq.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 17:04:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPK5u-0000zz-2Z
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 17:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547AbYBMQDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 11:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755793AbYBMQDp
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 11:03:45 -0500
Received: from neuf-infra-smtp-out-sp604006av.neufgp.fr ([84.96.92.121]:52454
	"EHLO neuf-infra-smtp-out-sp604006av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755288AbYBMQDo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Feb 2008 11:03:44 -0500
Received: from neuf-infra-smtp-out-sp604001av.neufgp.fr ([84.96.92.125])
	by neuf-infra-smtp-out-sp604006av.neufgp.fr with neuf telecom
	id ouuq1Y00N2iH3ss060Pw00; Wed, 13 Feb 2008 17:03:41 +0100
Received: from maison.homelinux.org ([84.103.71.93])
	by neuf-infra-smtp-out-sp604001av.neufgp.fr with neuf telecom
	id p43W1Y00420lBGc0100000; Wed, 13 Feb 2008 17:03:41 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JPK52-0006W8-Qp; Wed, 13 Feb 2008 17:03:28 +0100
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: moi@vanicat.homelinux.org
X-SA-Exim-Scanned: No (on maison.homelinux.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73799>

One can now:
- checkout an existing branch with M-x git-change-branch
- create and checkout a new branch with C-u M-x git-change-branch
- do all this from the Git menu
---
It could also be interesting to add some  key biding for those

Also one might want to update the *git-status* buffer after checkout,
but this is not done by this patch
 contrib/emacs/git.el |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index a8bf0ef..404c8e6 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1138,6 +1138,50 @@ Return the list of files that haven't been handled."
   (when (eq (window-buffer) (current-buffer))
     (shrink-window-if-larger-than-buffer)))
 
+(defun git-list-branch ()
+  "Return a list of available branch"
+  ;; should I check if I'm in a git repository ?
+  (let ((branchs ()))
+    (with-temp-buffer
+      (git-run-command-buffer (current-buffer) "branch")
+      (goto-char (point-min))
+      (while (re-search-forward "^\\([ *]\\) \\([^\n]*\\)$" () t)
+	(push (list (match-string 2)
+		    (string= (match-string 1) "*"))
+	      branchs)))
+    (nreverse branchs)))
+
+(defun git-change-branch (branch &optional new)
+  "Switch to another branch
+
+With a prefix argument, switch to a new branch, ortherwise use
+an existing one"
+  (interactive
+   (if current-prefix-arg
+       (list (read-from-minibuffer "Branch: ")
+	     current-prefix-arg)
+       (list (completing-read "Branch: " (git-list-branch) () t)
+	     current-prefix-arg)))
+  (with-temp-buffer
+    (if new
+	(git-call-process-display-error "checkout" "-b" branch)
+	(git-call-process-display-error "checkout" branch))
+    (goto-char (point-min))))
+
+(defun git-change-new-branch-menu (branch)
+  "Switch to new branch"
+  (interactive "MBranch: ")
+  (git-change-branch branch 't))
+
+(defun git-change-branch-menu-filter (rest)
+  "define the change branch menu"
+  (append
+   (mapcar
+    (lambda (branch)
+      `[,(car branch) (git-change-branch ,(car branch)) t])
+    (git-list-branch))
+   (list ["change to new" git-change-new-branch-menu t])))
+
 (defun git-diff-file ()
   "Diff the marked file(s) against HEAD."
   (interactive)
@@ -1486,6 +1530,7 @@ amended version of it."
 	["Diff Against Merge Head" git-diff-file-merge-head t]
 	["Diff Against Mine" git-diff-file-mine t]
 	["Diff Against Other" git-diff-file-other t])
+      ("Change branch" :filter git-change-branch-menu-filter)
       "--------"
       ["Add File" git-add-file t]
       ["Revert File" git-revert-file t]
-- 
1.5.4.1.101.gacba
