From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH 3/4] git-blame.el: Allow displaying author/commit times
Date: Tue,  2 Jul 2013 19:34:36 +0200
Message-ID: <1372786477-13122-4-git-send-email-sojkam1@fel.cvut.cz>
References: <1372786477-13122-1-git-send-email-sojkam1@fel.cvut.cz>
Cc: =?UTF-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>,
	Lawrence Mitchell <wence@gmx.li>,
	=?UTF-8?q?R=C3=BCdiger=20Sonderfeld?= <ruediger@c-plusplus.de>,
	Michal Sojka <sojkam1@fel.cvut.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 02 19:43:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu4c3-0007wY-6Z
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 19:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425Ab3GBRnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 13:43:18 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:55272 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754156Ab3GBRnP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 13:43:15 -0400
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id 9024019F343E;
	Tue,  2 Jul 2013 19:36:00 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id oPAmO2f_pe2o; Tue,  2 Jul 2013 19:35:56 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 0ED6D19F3618;
	Tue,  2 Jul 2013 19:35:56 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.80)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1Uu4Ud-0003Va-5c; Tue, 02 Jul 2013 19:35:55 +0200
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1372786477-13122-1-git-send-email-sojkam1@fel.cvut.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229406>

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 contrib/emacs/git-blame.el | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 573f408..5c8933e 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -110,8 +110,10 @@ mode. The format is passed to `format-spec' with the following format keys:
   %H - the full hash
   %a - the author name
   %A - the author email
+  %t - the author time (see `git-blame-time-format')
   %c - the committer name
   %C - the committer email
+  %T - the committer time (see `git-blame-time-format')
   %s - the commit summary
 "
   :group 'git-blame)
@@ -125,6 +127,14 @@ same length, i.e. the it causes the prefix to be either truncated
 or padded to 30 characters.
 "
   :group 'git-blame)
+
+(defcustom git-blame-time-format
+  "%Y-%m-%d"
+  "The format for date/time values. This format is passed to
+`format-time-string' function.
+"
+  :group 'git-blame)
+
 (defcustom git-blame-mouseover-format
   "%h %a %A: %s"
   "The format of the description shown when pointing at a line in
@@ -135,8 +145,10 @@ with the following format keys:
   %H - the full hash
   %a - the author name
   %A - the author email
+  %t - the author time (see `git-blame-time-format')
   %c - the committer name
   %C - the committer email
+  %T - the committer time (see `git-blame-time-format')
   %s - the commit summary
 "
   :group 'git-blame)
@@ -393,6 +405,9 @@ See also function `git-blame-mode'."
           (puthash hash info git-blame-cache)
           info))))
 
+(defun git-blame-format-time (seconds)
+  (format-time-string git-blame-time-format (seconds-to-time (string-to-number seconds))))
+
 (defun git-blame-create-overlay (info start-line num-lines)
   (with-current-buffer git-blame-file
     (save-excursion
@@ -408,8 +423,10 @@ See also function `git-blame-mode'."
                        (?H . ,hash)
                        (?a . ,(git-blame-get-info info 'author))
                        (?A . ,(git-blame-get-info info 'author-mail))
+                       (?t . ,(git-blame-format-time (git-blame-get-info info 'author-time)))
                        (?c . ,(git-blame-get-info info 'committer))
                        (?C . ,(git-blame-get-info info 'committer-mail))
+                       (?T . ,(git-blame-format-time (git-blame-get-info info 'committer-time)))
                        (?s . ,(git-blame-get-info info 'summary)))))
           (push ovl git-blame-overlays)
           (overlay-put ovl 'git-blame info)
-- 
1.8.3.1
