From: =?utf-8?Q?R=C3=A9mi?= Vanicat <vanicat@debian.org>
Subject: [PATCH v3 02/03] Adding checkout function for commitish in git.el
Date: Mon, 18 Feb 2008 17:34:30 +0100
Message-ID: <87mypyp6jt.dlv@maison.homelinux.org>
References: <87zltyp717.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexandre Julliard <julliard@winehq.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 17:35:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR8xT-0006Hu-Gj
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 17:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbYBRQeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 11:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbYBRQeg
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 11:34:36 -0500
Received: from neuf-infra-smtp-out-sp604006av.neufgp.fr ([84.96.92.121]:50527
	"EHLO neuf-infra-smtp-out-sp604006av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750741AbYBRQef (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Feb 2008 11:34:35 -0500
Received: from neuf-infra-smtp-out-sp604011av.neufgp.fr ([84.96.92.116])
	by neuf-infra-smtp-out-sp604006av.neufgp.fr with neuf telecom
	id qulN1Y0182We0qU060US00; Mon, 18 Feb 2008 17:34:33 +0100
Received: from maison.homelinux.org ([84.103.71.93])
	by neuf-infra-smtp-out-sp604011av.neufgp.fr with neuf telecom
	id r4aY1Y00Q20lBGc0B00000; Mon, 18 Feb 2008 17:34:33 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JR8wo-0003YM-EH; Mon, 18 Feb 2008 17:34:32 +0100
In-Reply-To: <87zltyp717.dlv@maison.homelinux.org> (=?utf-8?Q?=22R=C3=A9mi?=
 Vanicat"'s message of "Mon\, 18 Feb 2008 17\:24\:04 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: moi@vanicat.homelinux.org
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on maison.homelinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NO_RELAYS autolearn=ham
	version=3.2.3
X-SA-Exim-Version: 4.2.1 (built Tue, 21 Aug 2007 23:39:36 +0000)
X-SA-Exim-Scanned: Yes (on maison.homelinux.org)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74310>

M-x git-checkout ask for a commitish, and checkout it as in
  git checkout commitish --
  key binding: "C-cC-o"
M-x git-branch ask for the name of a new branch, create it and
checkout it as in
  git checkout -b name
  key binding: "C-cC-b"
M-x git-create-branch ask for a new branchname, a startpoint (a
commitish) and create a new branch as in
  git branch branchname startpoint
  key binding "B C"
A menu is also available for just switching branch
---
 contrib/emacs/git.el |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 5166fca..d35f837 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1209,6 +1209,51 @@ if it is :tags return tags"
 				 (git-list-refs :all))
 		   () () () () default))
 
+(defun git-checkout (branch &optional merge)
+  "checkout a branch, tag, or any commitish
+
+use a prefix arg if git should merge while checking out"
+  (interactive
+   (list (git-read-commitish "Branch: ")
+	 current-prefix-arg))
+  (let ((args (list branch "--")))
+    (if merge (push "-m" args))
+    (if (apply #'git-call-process-display-error "checkout" args)
+	(git-refresh-status))))
+
+(defun git-branch (branch)
+  "branch from current commit and checkout the new branch"
+  (interactive "MBranch: ")
+  (if (git-call-process-display-error "checkout" "-b" branch)
+      (git-refresh-status)))
+
+(defun git-create-branch (branch start-point)
+  "create a new branch named [branch] from the [start-point]"
+  (interactive
+   (list (read-string "New branch: ")
+	 (git-read-commitish "Start point(HEAD): " "HEAD")))
+  (git-call-process-display-error "branch" branch start-point))
+
+(defun git-checkout-menu-filter (rest)
+  "define the change branch menu"
+  (let ((head (git-symbolic-ref "HEAD")))
+    (git-refs-build-menu
+     :before `(["detached head" ignore
+				:visible ,(not head)
+				:selected ,(not head)
+				:style radio
+				:key-sequence nil])
+     :branch (lambda (short-name ref-name)
+	       `[,short-name (git-checkout ,short-name)
+			      :style radio
+			      :selected ,(string= head ref-name)])
+     :remote (lambda (short-name ref-name)
+	       `[,short-name (git-checkout ,ref-name)])
+     :tag (lambda (short-name ref-name)
+	    `[,short-name (git-checkout ,ref-name)])
+     :after `(["checkout any commitish" git-checkout t]
+	      ["change to new" git-branch t]))))
+
 (defun git-diff-file ()
   "Diff the marked file(s) against HEAD."
   (interactive)
@@ -1491,6 +1536,7 @@ amended version of it."
 (unless git-status-mode-map
   (let ((map (make-keymap))
         (commit-map (make-sparse-keymap))
+        (branch-map (make-sparse-keymap))
         (diff-map (make-sparse-keymap))
         (toggle-map (make-sparse-keymap)))
     (suppress-keymap map)
@@ -1498,6 +1544,7 @@ amended version of it."
     (define-key map "h"   'git-help)
     (define-key map " "   'git-next-file)
     (define-key map "a"   'git-add-file)
+    (define-key map "B"    branch-map)
     (define-key map "c"   'git-commit-file)
     (define-key map "\C-c" commit-map)
     (define-key map "d"    diff-map)
@@ -1525,8 +1572,12 @@ amended version of it."
     (define-key map "x"   'git-remove-handled)
     (define-key map "\C-?" 'git-unmark-file-up)
     (define-key map "\M-\C-?" 'git-unmark-all)
+    ; the branch map
+    (define-key branch-map "C" 'git-create-branch)
     ; the commit submap
     (define-key commit-map "\C-a" 'git-amend-commit)
+    (define-key commit-map "\C-o" 'git-checkout)
+    (define-key commit-map "\C-b" 'git-branch)
     ; the diff submap
     (define-key diff-map "b" 'git-diff-file-base)
     (define-key diff-map "c" 'git-diff-file-combined)
@@ -1547,6 +1598,7 @@ amended version of it."
     `("Git"
       ["Refresh" git-refresh-status t]
       ["Commit" git-commit-file t]
+      ("Checkout Branch" :filter git-checkout-menu-filter)
       ("Merge"
 	["Next Unmerged File" git-next-unmerged-file t]
 	["Prev Unmerged File" git-prev-unmerged-file t]
-- 
1.5.4.1.123.gcb68-dirty
