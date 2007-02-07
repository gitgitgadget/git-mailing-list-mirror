From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] git-blame: Change installation instructions
Date: Wed, 7 Feb 2007 13:59:27 +0100
Message-ID: <200702071359.28100.jnareb@gmail.com>
References: <200702071356.43020.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "David =?utf-8?q?K=C3=A5gedal?=" <davidk@lysator.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 13:58:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEmNK-0006GH-FG
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 13:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965474AbXBGM6L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 07:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965563AbXBGM6L
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 07:58:11 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:49358 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965474AbXBGM6J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 07:58:09 -0500
Received: by nf-out-0910.google.com with SMTP id o25so510182nfa
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 04:58:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=NbuhN134A1KY4CDSfV4vh+WHOIISMkEE2mtsEcbBB12GlWawdp/LEI1wmOMt2naaMig/t45j0Fzg7y1KX5z0iUlmaITTYO8uhaPuf8QUxezCmzC/JLfvyNsktQW/jhKQ9XLnGzULXzb+EvyK8f4BozgcpwsMhZ8vUCgMS/aOHXc=
Received: by 10.82.189.5 with SMTP id m5mr1321344buf.1170853079585;
        Wed, 07 Feb 2007 04:57:59 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id j1sm1175160ugf.2007.02.07.04.57.58;
        Wed, 07 Feb 2007 04:57:58 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200702071356.43020.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38921>

Change installation instructions to using either "(require 'git-blame)"
or appropriate autoload instruction in GNU Emacs init file, .emacs
This required adding "(provide 'git-blame)" at the end of git-blame.el
and adding [preliminary] docstring to `git-blame-mode' function for
consistency (to mark function as interactive in `autoload' we have to
provide docstring as DOCSTRING is third arg, and INTERACTIVE fourth,
and both are optional).  `git-blame-mode' is marked to autoload.

While at it ensure that we add `git-blame-mode' to `minor-mode-alist'
only once (in a way that does not depend on `cl' package).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 contrib/emacs/git-blame.el |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index cca0a77..7beeece 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -44,9 +44,20 @@
 
 ;;; Installation:
 ;;
-;;  1) Load into emacs: M-x load-file RET git-blame.el RET
-;;  2) Open a git-controlled file
-;;  3) Blame: M-x git-blame-mode
+;; To use this package, put it somewhere in `load-path' (or add
+;; directory with git-blame.el to `load-path'), and add the following
+;; line to your .emacs:
+;;
+;;    (require 'git-blame)
+;;
+;; If you do not want to load this package before it is necessary, you
+;; can make use of the `autoload' feature, e.g. by adding to your .emacs
+;; the following lines
+;;
+;;    (autoload 'git-blame-mode "git-blame"
+;;              "Minor mode for incremental blame for Git." t)
+;;
+;; Then first use of `M-x git-blame-mode' would load the package.
 
 ;;; Compatibility:
 ;;
@@ -102,9 +113,14 @@
 
 (defvar git-blame-mode nil)
 (make-variable-buffer-local 'git-blame-mode)
-(push (list 'git-blame-mode " blame") minor-mode-alist)
+(unless (assq 'git-blame-mode minor-mode-alist)
+  (setq minor-mode-alist
+	(cons (list 'git-blame-mode " blame")
+	      minor-mode-alist)))
 
+;;;###autoload
 (defun git-blame-mode (&optional arg)
+  "Minor mode for incremental blame for Git."
   (interactive "P")
   (if arg
       (setq git-blame-mode (eq arg 1))
@@ -244,4 +260,6 @@
    (format "git log -1 --pretty=oneline %s" (or hash
                                                 (git-blame-current-commit)))))
 
+(provide 'git-blame)
+
 ;;; git-blame.el ends here
-- 
1.4.4.4
