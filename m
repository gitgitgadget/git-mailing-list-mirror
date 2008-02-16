From: =?utf-8?Q?R=C3=A9mi?= Vanicat <vanicat@debian.org>
Subject: [PATCH 02/03] Adding checkout function for commitish in git.el
Date: Sat, 16 Feb 2008 20:30:39 +0100
Message-ID: <87abm0u2ao.dlv_-_@maison.homelinux.org>
References: <87wsp8u9m7.dlv@maison.homelinux.org>
	<20080213163002.GA5670@diana.vm.bytemark.co.uk>
	<20080213164356.GA5828@diana.vm.bytemark.co.uk>
	<87zlu4vhon.fsf@osv.gnss.ru> <87lk5ku2wn.dlv_-_@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Sergei Organov <osv@javad.com>,
	Alexandre Julliard <julliard@winehq.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 20:31:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQSkp-0003yn-Ob
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 20:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445AbYBPTap convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Feb 2008 14:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755851AbYBPTap
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 14:30:45 -0500
Received: from neuf-infra-smtp-out-sp604007av.neufgp.fr ([84.96.92.120]:37841
	"EHLO neuf-infra-smtp-out-sp604007av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754306AbYBPTao convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 14:30:44 -0500
Received: from neuf-infra-smtp-out-sp604012av.neufgp.fr ([84.96.92.115])
	by neuf-infra-smtp-out-sp604007av.neufgp.fr with neuf telecom
	id q7do1Y00M2VLLWC071bS00; Sat, 16 Feb 2008 20:30:43 +0100
Received: from maison.homelinux.org ([84.103.71.93])
	by neuf-infra-smtp-out-sp604012av.neufgp.fr with neuf telecom
	id qKWi1Y00D20lBGc0C00000; Sat, 16 Feb 2008 20:30:42 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JQSkB-00051E-IF; Sat, 16 Feb 2008 20:30:41 +0100
In-Reply-To: <87lk5ku2wn.dlv_-_@maison.homelinux.org> (utf's message of "Sat\, 16 Feb 2008 20\:17\:28 +0100")
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74068>

M-x git-checkout ask for a commitish, and checkout it as in
  git checkout commitish --
  key binding: "C"
M-x git-branch ask for the name of a new branch, create it and
checkout it as in
  git checkout -b name
  key binding: "b"
M-x git-create-branch ask for a new branchname, a startpoint (a
commitish) and create a new branch as in
  git branch branchname startpoint
  key binding "B"
A menu is also available for just switching branch
---
The main problem that I still see, is the error message when one try
to checkout a branch/tag... that doesn't exist: it is a cryptic error
message...=20

 contrib/emacs/git.el |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 16d9771..f180421 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1175,6 +1175,44 @@ nil otherwise"
 					 (git-list-tags)))
 		   () () () () default))
=20
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
+  (append
+   (mapcar
+    (lambda (branch)
+      `[,(car branch)
+	 (git-checkout ,(car branch))
+	 :style radio
+	 :selected ,(cdr branch)])
+    (git-list-branches))
+   (list ["checkout any commitish" git-checkout t]
+	 ["change to new" git-branch t])))
+
 (defun git-diff-file ()
   "Diff the marked file(s) against HEAD."
   (interactive)
@@ -1466,6 +1504,9 @@ amended version of it."
     (define-key map "a"   'git-add-file)
     (define-key map "c"   'git-commit-file)
     (define-key map "\C-c" commit-map)
+    (define-key map "C"   'git-checkout)
+    (define-key map "b"   'git-branch)
+    (define-key map "B"   'git-create-branch)
     (define-key map "d"    diff-map)
     (define-key map "=3D"   'git-diff-file)
     (define-key map "f"   'git-find-file)
@@ -1513,6 +1554,7 @@ amended version of it."
     `("Git"
       ["Refresh" git-refresh-status t]
       ["Commit" git-commit-file t]
+      ("Checkout Branch" :filter git-checkout-menu-filter)
       ("Merge"
 	["Next Unmerged File" git-next-unmerged-file t]
 	["Prev Unmerged File" git-prev-unmerged-file t]
--=20
1.5.4.1.123.gcb68-dirty


--=20
R=C3=A9mi Vanicat
