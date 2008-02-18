From: Remi Vanicat <vanicat@debian.org>
Subject: [PATCH v3 01/03] Add helpers functions for refs and commitish to git.el
Date: Mon, 18 Feb 2008 17:32:53 +0100
Message-ID: <87r6fap6mi.dlv@maison.homelinux.org>
References: <87zltyp717.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexandre Julliard <julliard@winehq.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 17:34:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR8w4-0005Xu-33
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 17:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755058AbYBRQdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 11:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755462AbYBRQdG
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 11:33:06 -0500
Received: from neuf-infra-smtp-out-sp604006av.neufgp.fr ([84.96.92.121]:33552
	"EHLO neuf-infra-smtp-out-sp604006av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755057AbYBRQdE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Feb 2008 11:33:04 -0500
Received: from neuf-infra-smtp-out-sp604001av.neufgp.fr ([84.96.92.125])
	by neuf-infra-smtp-out-sp604006av.neufgp.fr with neuf telecom
	id qulN1Y01v2iH3ss060UD00; Mon, 18 Feb 2008 17:32:56 +0100
Received: from maison.homelinux.org ([84.103.71.93])
	by neuf-infra-smtp-out-sp604001av.neufgp.fr with neuf telecom
	id r4Yw1Y00820lBGc0100000; Mon, 18 Feb 2008 17:32:56 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JR8vG-0003Y0-2q; Mon, 18 Feb 2008 17:32:55 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74308>

git-list-refs list refs
git-refs-build-menu is a function to build menu for refs
git-read-commitish ask the user a commitish, with completion for
branch, local and remote, and tags.
---
 contrib/emacs/git.el |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index a8bf0ef..5166fca 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1138,6 +1138,77 @@ Return the list of files that haven't been handled."
   (when (eq (window-buffer) (current-buffer))
     (shrink-window-if-larger-than-buffer)))
 
+(defun git-list-refs (&optional spec)
+  "return a list of refs using git-for-each-refs
+
+if type is nil or :all return all refs
+if it is :branches return local branches
+if it is :remotes return remote branches
+if it is :tags return tags"
+  (let ((ref-spec (cond
+		    ((or (eq spec :all) (eq spec ()))
+		     "*/*/*")
+		    ((eq spec :branches)
+		     "refs/heads")
+		    ((eq spec :remotes)
+		     "refs/remotes")
+		    ((eq spec :tags)
+		     "refs/tags")
+		    (t (error "don't know what to do with %s" spec))))
+	refs)
+    (with-temp-buffer
+      (git-call-process-env t nil "for-each-ref" ref-spec "--format=%(refname)")
+      (goto-char (point-min))
+      (while (re-search-forward "^[^/]+/[^/]+/\\([^\n]*\\)$" () t)
+	(push (cons (match-string 1)
+		    (match-string 0))
+	      refs)))
+    (nreverse refs)))
+
+(defun git-refs-build-menu-helper (refs fcts)
+  (let ((menu ()))
+    (dolist (branch (git-list-refs refs))
+      (push (funcall fcts (car branch) (cdr branch))
+	    menu))
+     (nreverse menu)))
+
+(defun git-refs-build-menu (&rest rest)
+  (let (before branch tag remote after)
+    (while (and rest
+		(cdr rest)
+		(keywordp (car rest)))
+      (cond
+	((eq :before (car rest))
+	 (setq before (cadr rest)))
+	((eq :branch (car rest))
+	 (setq branch (cadr rest)))
+	((eq :tag (car rest))
+	 (setq tag (cadr rest)))
+	((eq :remote (car rest))
+	 (setq remote (cadr rest)))
+	((eq :after (car rest))
+	 (setq after (cadr rest)))
+	((error "git-refs-build-menu: I don't know this keyword")))
+      (setq rest (cddr rest)))
+    (unless (and (not rest)
+		 remote tag branch)
+      (error "bad argument list"))
+    `(,@before
+      ,@(git-refs-build-menu-helper :branches branch)
+      "------"
+      ("Remotes" ,@(git-refs-build-menu-helper :remotes remote))
+      ("Tags" ,@(git-refs-build-menu-helper :tags remote))
+      "------"
+      ,@after)))
+
+(defun git-read-commitish (prompt &optional default)
+  "ask user a commitish, with commpletion for local branch, remote branch and tag"
+  (completing-read prompt (list* "HEAD"
+				 "ORIG_HEAD"
+				 "FETCH_HEAD"
+				 (git-list-refs :all))
+		   () () () () default))
+
 (defun git-diff-file ()
   "Diff the marked file(s) against HEAD."
   (interactive)
-- 
1.5.4.1.123.gcb68-dirty
