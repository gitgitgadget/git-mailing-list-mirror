From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] git.el: Diff only file at point by default
Date: Wed, 27 Aug 2008 00:22:15 +0200
Message-ID: <871w0bmn6w.fsf@lysator.liu.se>
References: <87vdxtpjkd.fsf@lysator.liu.se>
	<7v3akvw7gz.fsf@gitster.siamese.dyndns.org>
	<87bpzh8msk.fsf@wine.dyndns.org> <873aktnsbf.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Alexandre Julliard <julliard@winehq.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 00:23:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY6wj-0000eu-Uv
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 00:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbYHZWWS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Aug 2008 18:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbYHZWWS
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 18:22:18 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:38780 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbYHZWWR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 18:22:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id A7B5E201D84F;
	Wed, 27 Aug 2008 00:22:16 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 31623-01-23; Wed, 27 Aug 2008 00:22:16 +0200 (CEST)
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id E906E2011874;
	Wed, 27 Aug 2008 00:22:15 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id 7D2937B4038; Wed, 27 Aug 2008 00:22:15 +0200 (CEST)
In-Reply-To: <873aktnsbf.fsf@lysator.liu.se> ("David =?utf-8?Q?K=C3=A5geda?=
 =?utf-8?Q?l=22's?= message of "Mon\, 25 Aug 2008 15\:21\:40 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93827>

Use prefix (C-u) to diff all marked files.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 contrib/emacs/git.el |   62 +++++++++++++++++++++++++++++-------------=
--------
 1 files changed, 36 insertions(+), 26 deletions(-)

Here is an updated patch that udpate the stage diff commands as
well. It doesn't touch git-diff-file-merge-head since that already
uses prefix arguments. Don't know if there is a solution to that.

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index c1cf1cb..de9d0f4 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -771,6 +771,11 @@ Return the list of files that haven't been handled=
=2E"
               (setq file (pop files))
             (setq node (ewoc-next status node))))))))
=20
+(defun git-current-file ()
+  "Return the file at point."
+  (unless git-status (error "Not in git-status buffer."))
+  (ewoc-data (ewoc-locate git-status)))
+
 (defun git-marked-files ()
   "Return a list of all marked files, or if none a list containing jus=
t the file at cursor position."
   (unless git-status (error "Not in git-status buffer."))
@@ -1137,10 +1142,11 @@ Return the list of files that haven't been hand=
led."
   (when (eq (window-buffer) (current-buffer))
     (shrink-window-if-larger-than-buffer)))
=20
-(defun git-diff-file ()
-  "Diff the marked file(s) against HEAD."
-  (interactive)
-  (let ((files (git-marked-files)))
+(defun git-diff-file (arg)
+  "Diff the current file against HEAD.
+With a prefix arg, diff the marked files instead."
+  (interactive "P")
+  (let ((files (if arg (git-marked-files) (list (git-current-file)))))
     (git-setup-diff-buffer
      (apply #'git-run-command-buffer "*git-diff*" "diff-index" "-p" "-=
M" "HEAD" "--" (git-get-filenames files)))))
=20
@@ -1154,31 +1160,35 @@ Return the list of files that haven't been hand=
led."
      (apply #'git-run-command-buffer "*git-diff*" "diff-index" "-p" "-=
M"
             (or (nth (1- arg) merge-heads) "HEAD") "--" (git-get-filen=
ames files)))))
=20
-(defun git-diff-unmerged-file (stage)
-  "Diff the marked unmerged file(s) against the specified stage."
-  (let ((files (git-marked-files)))
+(defun git-diff-unmerged-file (stage arg)
+  "Diff the files against the specified stage."
+  (let ((files (if arg (git-marked-files) (list (git-current-file)))))
     (git-setup-diff-buffer
      (apply #'git-run-command-buffer "*git-diff*" "diff-files" "-p" st=
age "--" (git-get-filenames files)))))
=20
-(defun git-diff-file-base ()
-  "Diff the marked unmerged file(s) against the common base file."
-  (interactive)
-  (git-diff-unmerged-file "-1"))
-
-(defun git-diff-file-mine ()
-  "Diff the marked unmerged file(s) against my pre-merge version."
-  (interactive)
-  (git-diff-unmerged-file "-2"))
-
-(defun git-diff-file-other ()
-  "Diff the marked unmerged file(s) against the other's pre-merge vers=
ion."
-  (interactive)
-  (git-diff-unmerged-file "-3"))
-
-(defun git-diff-file-combined ()
-  "Do a combined diff of the marked unmerged file(s)."
-  (interactive)
-  (git-diff-unmerged-file "-c"))
+(defun git-diff-file-base (arg)
+  "Diff the current file against the common base file.
+With a prefix arg, diff the marked files instead."
+  (interactive "P")
+  (git-diff-unmerged-file "-1" arg))
+
+(defun git-diff-file-mine (arg)
+  "Diff the current file against my pre-merge version.
+With a prefix arg, diff the marked files instead."
+  (interactive "P")
+  (git-diff-unmerged-file "-2" arg))
+
+(defun git-diff-file-other (arg)
+  "Diff the current file against the other's pre-merge version.
+With a prefix arg, diff the marked files instead."
+  (interactive "P")
+  (git-diff-unmerged-file "-3" arg))
+
+(defun git-diff-file-combined (arg)
+  "Do a combined diff of the marked unmerged file(s).
+With a prefix arg, diff the marked files instead."
+  (interactive "P")
+  (git-diff-unmerged-file "-c" arg))
=20
 (defun git-diff-file-idiff ()
   "Perform an interactive diff on the current file."
--=20
1.6.0.rc2.7.gbf8a


--=20
David K=C3=A5gedal
