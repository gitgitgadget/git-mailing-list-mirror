From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [RFH PATCH] Teach the emacs git mode about core.excludesfile
Date: Tue, 31 Jul 2007 03:13:50 +0200
Message-ID: <20070731011100.23561.27554.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 03:43:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFgly-0008Nn-Dj
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 03:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763623AbXGaBnj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 30 Jul 2007 21:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbXGaBnj
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 21:43:39 -0400
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:45894 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762046AbXGaBni (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2007 21:43:38 -0400
X-Greylist: delayed 1784 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jul 2007 21:43:38 EDT
Received: from c83-250-130-90.bredband.comhem.se ([83.250.130.90]:41674 helo=yoghurt)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1IFgL4-0004sO-7G; Tue, 31 Jul 2007 03:15:54 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.63)
	(envelope-from <kha@treskal.com>)
	id 1IFgJ4-00069h-4h; Tue, 31 Jul 2007 03:13:50 +0200
User-Agent: StGIT/0.12
X-Originating-IP: 83.250.130.90
X-Scan-Result: No virus found in message 1IFgL4-0004sO-7G.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1IFgL4-0004sO-7G 4da8d3a13ba4d65b7075ae3800ce289d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54306>

If there is a core.excludesfile option specified, let the emacs git
mode take exclude patterns from that file, since that's what the docs
say, and what everyone else is already doing.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

This is a Request For Help. The patch works, but is clearly the work
of someone who is not very fluent in elisp. Just look at all that
duplicated code I've introduced!

 contrib/emacs/git.el |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 53dd703..357e6d2 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -589,6 +589,13 @@ Return the list of files that haven't been handled=
=2E"
           (when node (push (ewoc-data node) unmerged-files))))
       (git-set-files-state unmerged-files 'unmerged))))
=20
+(defun git-core-excludesfile ()
+  "The file core.excludesfile, or nil if it isn't specified."
+  (let ((fn (git-config "core.excludesfile")))
+    (if (and fn (file-readable-p fn))
+        fn
+      nil)))
+
 (defun git-update-status-files (files &optional default-state)
   "Update the status of FILES from the index."
   (unless git-status (error "Not in git-status buffer."))
@@ -600,9 +607,15 @@ Return the list of files that haven't been handled=
=2E"
     (git-run-ls-unmerged status files)
     (when (and (or (not files) remaining-files)
                (file-readable-p ".git/info/exclude"))
-      (setq remaining-files (git-run-ls-files status remaining-files
-                                              'unknown "-o" "--exclude=
-from=3D.git/info/exclude"
-                                              (concat "--exclude-per-d=
irectory=3D" git-per-dir-ignore-file))))
+      (let ((ce (git-core-excludesfile)))
+        (if ce
+            (setq remaining-files (git-run-ls-files status remaining-f=
iles
+                                                    'unknown "-o" "--e=
xclude-from=3D.git/info/exclude"
+                                                    (concat "--exclude=
-per-directory=3D" git-per-dir-ignore-file)
+                                                    (concat "--exclude=
-from=3D" ce)))
+          (setq remaining-files (git-run-ls-files status remaining-fil=
es
+                                                  'unknown "-o" "--exc=
lude-from=3D.git/info/exclude"
+                                                  (concat "--exclude-p=
er-directory=3D" git-per-dir-ignore-file))))))
     ; mark remaining files with the default state (or remove them if n=
il)
     (when remaining-files
       (if default-state
