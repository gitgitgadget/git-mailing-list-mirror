From: Lawrence Mitchell <wence@gmx.li>
Subject: [PATCH] git.el: Don't use font-lock-compile-keywords
Date: Fri, 4 Feb 2011 10:59:18 +0000
Message-ID: <m3oc501rja.fsf@e4300lm.epcc.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alexandre Julliard <julliard@winehq.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 16:12:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2mDT-0004AW-5R
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 16:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab1CXPMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 11:12:43 -0400
Received: from lo.gmane.org ([80.91.229.12]:59337 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564Ab1CXPMm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 11:12:42 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Q2mDG-00043G-RL
	for git@vger.kernel.org; Thu, 24 Mar 2011 16:12:38 +0100
Received: from e4300lm.epcc.ed.ac.uk ([129.215.63.156])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 16:12:38 +0100
Received: from wence by e4300lm.epcc.ed.ac.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 16:12:38 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: e4300lm.epcc.ed.ac.uk
User-Agent: Gnus/5.110014 (No Gnus v0.14) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:hfX52jRBIOmtZ317HoaLL/L8AxI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169924>

If font-lock is disabled, font-lock-compile-keywords complains.
Really what we want to do is to replace log-edit's font-lock
definitions with our own, so define a major mode deriving from
log-edit and set up font-lock-defaults there.  We then use the
optional MODE argument to log-edit to set up the major mode of the
commit buffer appropriately.

Signed-Off-By: Lawrence Mitchell <wence@gmx.li>
---
I sent this before, in response to Johnathan's message of 4th Feb
(http://thread.gmane.org/gmane.comp.version-control.git/36088/focus=166038),
but it's possible it got lost in the noise.  So here it is
again.  The originally proposed patch from Debian is to use
font-lock-add-keywords rather than font-lock-compile-keywords.
However, it doesn't exist in XEmacs, if one is looking to
maintain compatibility, I believe this patch is the right thing
to do.

 contrib/emacs/git.el |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 214930a..65c95d9 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1310,6 +1310,13 @@ The FILES list must be sorted."
       (when sign-off (git-append-sign-off committer-name committer-email)))
     buffer))
 
+(define-derived-mode git-log-edit-mode log-edit-mode "Git-Log-Edit"
+  "Major mode for editing git log messages.
+
+Set up git-specific `font-lock-keywords' for `log-edit-mode'."
+  (set (make-local-variable 'font-lock-defaults)
+       '(git-log-edit-font-lock-keywords t t)))
+
 (defun git-commit-file ()
   "Commit the marked file(s), asking for a commit message."
   (interactive)
@@ -1335,9 +1342,9 @@ The FILES list must be sorted."
         (git-setup-log-buffer buffer (git-get-merge-heads) author-name author-email subject date))
       (if (boundp 'log-edit-diff-function)
 	  (log-edit 'git-do-commit nil '((log-edit-listfun . git-log-edit-files)
-					 (log-edit-diff-function . git-log-edit-diff)) buffer)
-	(log-edit 'git-do-commit nil 'git-log-edit-files buffer))
-      (setq font-lock-keywords (font-lock-compile-keywords git-log-edit-font-lock-keywords))
+					 (log-edit-diff-function . git-log-edit-diff)) buffer 'git-log-edit-mode)
+	(log-edit 'git-do-commit nil 'git-log-edit-files buffer
+                  'git-log-edit-mode))
       (setq paragraph-separate (concat (regexp-quote git-log-msg-separator) "$\\|Author: \\|Date: \\|Merge: \\|Signed-off-by: \\|\f\\|[ 	]*$"))
       (setq buffer-file-coding-system coding-system)
       (re-search-forward (regexp-quote (concat git-log-msg-separator "\n")) nil t))))
-- 
1.7.4.rc2.18.gb20e9
