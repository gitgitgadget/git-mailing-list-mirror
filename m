From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] git.el: Only show completions from refs/heads
Date: Tue, 24 Feb 2009 21:39:10 +0100
Message-ID: <87vdqztvrl.fsf_-_@krank.kagedal.org>
References: <1235464350-23383-1-git-send-email-davidk@lysator.liu.se>
	<87fxi4ut2p.fsf@krank.kagedal.org> <87ocwrx527.fsf@wine.dyndns.org>
	<871vtnvo55.fsf@krank.kagedal.org> <87fxi3x2es.fsf@wine.dyndns.org>
	<87y6vvu8sa.fsf@krank.kagedal.org> <87bpsrx1j1.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 21:40:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc455-00041t-9o
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 21:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515AbZBXUjP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 15:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754764AbZBXUjO
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 15:39:14 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:46302 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734AbZBXUjO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 15:39:14 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 31FE640022;
	Tue, 24 Feb 2009 21:39:04 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 23B7940029; Tue, 24 Feb 2009 21:39:04 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id D7EB340022;
	Tue, 24 Feb 2009 21:39:03 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id AEB52DC2B0; Tue, 24 Feb 2009 21:39:10 +0100 (CET)
In-Reply-To: <87bpsrx1j1.fsf@wine.dyndns.org> (Alexandre Julliard's message of "Tue\, 24 Feb 2009 17\:06\:26 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111338>

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

Here is a version that can to both commit name lookup and branch name
lookup, and with a configuration parameter that determines how to find
branch names to complete on.

contrib/emacs/git.el |   34 +++++++++++++++++++++++++---------
 1 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index feb229c..a5138d7 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -118,6 +118,12 @@ if there is already one that displays the same dir=
ectory."
   :group 'git
   :type 'boolean)
=20
+(defcustom git-complete-branch-patterns
+  '("refs/heads" "refs/tags" "refs/remotes")
+  "Which patterns to use when completing branch names."
+  :group 'git
+  :type '(repeat string))
+
=20
 (defface git-status-face
   '((((class color) (background light)) (:foreground "purple"))
@@ -1385,17 +1391,27 @@ With a prefix arg, diff the marked files instea=
d."
         (push (match-string 1) files)))
     files))
=20
-(defun git-read-commit-name (prompt &optional default)
-  "Ask for a commit name, with completion for local branch, remote bra=
nch and tag."
-  (completing-read prompt
-                   (list* "HEAD" "ORIG_HEAD" "FETCH_HEAD" (mapcar #'ca=
r (git-for-each-ref)))
-		   nil nil nil nil default))
+(defun git-read-commit-name (prompt specials &optional ref-patterns)
+  "Ask for a commit name, with completion.
+If SPECIALS is non-nil, add HEAD and similar names to the list of poss=
ible
+completions. The patterns in REF-PATTERNS are passed to `git-for-each-=
ref'
+to get a list of completions."
+  (let ((refs (apply #'git-for-each-ref ref-patterns)))
+    (completing-read prompt (if specials (list* '("HEAD" . nil)
+                                                '("FETCH_HEAD" . nil)
+                                                '("ORIG_HEAD" . nil)
+                                                refs)
+                              refs))))
+
+(defun git-read-branch-name (prompt)
+  "Ask for a branch name, with completion."
+  (git-read-commit-name prompt nil git-complete-branch-patterns))
=20
 (defun git-checkout (branch &optional merge)
   "Checkout a branch, tag, or any commit.
 Use a prefix arg if git should merge while checking out."
   (interactive
-   (list (git-read-commit-name "Checkout: ")
+   (list (git-read-branch-name "Checkout: ")
          current-prefix-arg))
   (unless git-status (error "Not in git-status buffer."))
   (let ((args (list branch "--")))
@@ -1405,7 +1421,7 @@ Use a prefix arg if git should merge while checki=
ng out."
=20
 (defun git-branch (branch)
   "Create a branch from the current HEAD and switch to it."
-  (interactive (list (git-read-commit-name "Branch: ")))
+  (interactive (list (git-read-branch-name "Branch: ")))
   (unless git-status (error "Not in git-status buffer."))
   (if (git-rev-parse (concat "refs/heads/" branch))
       (if (yes-or-no-p (format "Branch %s already exists, replace it? =
" branch))
@@ -1433,7 +1449,7 @@ amended version of it."
=20
 (defun git-cherry-pick-commit (arg)
   "Cherry-pick a commit."
-  (interactive (list (git-read-commit-name "Cherry-pick commit: ")))
+  (interactive (list (git-read-commit-name "Cherry-pick commit: " t)))
   (unless git-status (error "Not in git-status buffer."))
   (let ((commit (git-rev-parse (concat arg "^0"))))
     (unless commit (error "Not a valid commit '%s'." arg))
@@ -1452,7 +1468,7 @@ amended version of it."
=20
 (defun git-revert-commit (arg)
   "Revert a commit."
-  (interactive (list (git-read-commit-name "Revert commit: ")))
+  (interactive (list (git-read-commit-name "Revert commit: " t)))
   (unless git-status (error "Not in git-status buffer."))
   (let ((commit (git-rev-parse (concat arg "^0"))))
     (unless commit (error "Not a valid commit '%s'." arg))
--=20
1.6.2.rc1.21.gda6d


--=20
David K=C3=A5gedal
