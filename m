From: =?ISO-8859-1?Q?R=FCdiger?= Sonderfeld <ruediger@c-plusplus.de>
Subject: [PATCH] git-blame.el: Fix compilation warnings.
Date: Thu, 12 Jan 2012 16:44:19 +0100
Message-ID: <2608010.fNV39qBMLu@descartes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: davidk@lysator.liu.se
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 16:52:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlMxC-0006Ye-Md
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 16:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109Ab2ALPwe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 10:52:34 -0500
Received: from ptmx.org ([178.63.28.110]:52564 "EHLO ptmx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753861Ab2ALPwd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2012 10:52:33 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jan 2012 10:52:33 EST
Received: from localhost (localhost [127.0.0.1])
	by ptmx.org (Postfix) with ESMTP id 0634D25765;
	Thu, 12 Jan 2012 16:44:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ptmx.org
Received: from ptmx.org ([127.0.0.1])
	by localhost (ptmx.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aaf2b9BpWWFv; Thu, 12 Jan 2012 16:44:24 +0100 (CET)
Received: from descartes.localnet (93-82-12-214.adsl.highway.telekom.at [93.82.12.214])
	by ptmx.org (Postfix) with ESMTPSA id 5A5F5201B8;
	Thu, 12 Jan 2012 16:44:24 +0100 (CET)
User-Agent: KMail/4.7.3 (Linux/3.0.0-14-generic; KDE/4.7.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188450>

=46rom 4958c1b43d7a66654e15c92cbb878b38533d626e Mon Sep 17 00:00:00 200=
1
=46rom: =3D?UTF-8?q?R=3DC3=3DBCdiger=3D20Sonderfeld?=3D <ruediger@c-plu=
splus.de>
Date: Thu, 12 Jan 2012 16:37:06 +0100
Subject: [PATCH] git-blame.el: Fix compilation warnings.
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Replace mapcar with mapc because accumulation of the results was not
needed. (git-blame-cleanup)

Replace two occurrences of (save-excursion (set-buffer buf) ...)
with (with-current-buffer buf ...). (git-blame-filter and
git-blame-create-overlay)

Replace goto-line with (goto-char (point-min)) (forward-line (1-
start-line)). According to the documentation of goto-line it should
not be called from elisp code. (git-blame-create-overlay)

Signed-off-by: R=C3=BCdiger Sonderfeld <ruediger@c-plusplus.de>
---
 contrib/emacs/git-blame.el |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index d351cfb..2e53fc6 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -304,7 +304,7 @@ See also function `git-blame-mode'."
=20
 (defun git-blame-cleanup ()
   "Remove all blame properties"
-    (mapcar 'delete-overlay git-blame-overlays)
+    (mapc 'delete-overlay git-blame-overlays)
     (setq git-blame-overlays nil)
     (remove-git-blame-text-properties (point-min) (point-max)))
=20
@@ -337,8 +337,7 @@ See also function `git-blame-mode'."
 (defvar in-blame-filter nil)
=20
 (defun git-blame-filter (proc str)
-  (save-excursion
-    (set-buffer (process-buffer proc))
+  (with-current-buffer (process-buffer proc)
     (goto-char (process-mark proc))
     (insert-before-markers str)
     (goto-char 0)
@@ -385,11 +384,10 @@ See also function `git-blame-mode'."
           info))))
=20
 (defun git-blame-create-overlay (info start-line num-lines)
-  (save-excursion
-    (set-buffer git-blame-file)
+  (with-current-buffer git-blame-file
     (let ((inhibit-point-motion-hooks t)
           (inhibit-modification-hooks t))
-      (goto-line start-line)
+      (goto-char (point-min)) (forward-line (1- start-line))
       (let* ((start (point))
              (end (progn (forward-line num-lines) (point)))
              (ovl (make-overlay start end))
--=20
1.7.8.3
