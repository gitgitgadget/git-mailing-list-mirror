From: Lawrence Mitchell <wence@gmx.li>
Subject: Re: [BUG?] git.el: M-x git-commit-file produces error if font lock is disabled
Date: Fri, 04 Feb 2011 11:40:18 +0000
Message-ID: <pvhpbp2s58pp.fsf@gmx.li>
References: <87lkkgw9mg.fsf@wine.dyndns.org> <20110204001016.GC16688@elie>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kevin Ryde <user42@zip.com.au>,
	David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Alexandre Julliard <julliard@winehq.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 04 12:45:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlK6C-0005j8-W5
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 12:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377Ab1BDLpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 06:45:07 -0500
Received: from lo.gmane.org ([80.91.229.12]:48581 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046Ab1BDLpF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 06:45:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PlK64-0005fd-DP
	for git@vger.kernel.org; Fri, 04 Feb 2011 12:45:04 +0100
Received: from garnet.epcc.ed.ac.uk ([129.215.56.222])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 12:45:04 +0100
Received: from wence by garnet.epcc.ed.ac.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 12:45:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: garnet.epcc.ed.ac.uk
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (usg-unix-v)
Cancel-Lock: sha1:jNT63QqY7LrBNzTIeGS6qvpmsts=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166038>

Jonathan Nieder wrote:
> Hi,

> Kevin Ryde reports[1]:

[...] bug in git.el

> and suggests a patch[2].  Does it make sense?

font-lock-add-keywords isn't supported in the stable Xemacs
version (21.4).  But really, we don't want to /add/ keywords, but
set up our own, so we should define a major mode appropriately
and use that in log-edit.  Something like the patch below, I think.


>From 6333cd09f1a921757680f1376eeb0a6389d75449 Mon Sep 17 00:00:00 2001
From: Lawrence Mitchell <wence@gmx.li>
Date: Fri, 4 Feb 2011 10:59:18 +0000
Subject: [PATCH] git.el: Don't use font-lock-compile-keywords

If font-lock is disabled, font-lock-compile-keywords complains.
Really what we want to do is to replace log-edit's font-lock
definitions with our own, so define a major mode deriving from
log-edit and set up font-lock-defaults there.  We then use the option
MODE argument to log-edit to set up the major mode of the commit
buffer appropriately.

Signed-Off-By: Lawrence Mitchell <wence@gmx.li>
---
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
