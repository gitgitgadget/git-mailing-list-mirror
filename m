From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [RFH PATCH] Teach the emacs git mode about core.excludesfile
Date: Tue, 31 Jul 2007 12:36:32 +0200
Message-ID: <87abtcvozz.fsf@wine.dyndns.org>
References: <20070731011100.23561.27554.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 12:36:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFp5k-0000s9-JJ
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 12:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279AbXGaKgg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 06:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754923AbXGaKgg
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 06:36:36 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:46891 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755266AbXGaKgf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2007 06:36:35 -0400
Received: from adsl-84-227-18-170.adslplus.ch ([84.227.18.170] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1IFp5e-0008Ib-1A; Tue, 31 Jul 2007 05:36:34 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 0E1B41E70D2; Tue, 31 Jul 2007 12:36:32 +0200 (CEST)
In-Reply-To: <20070731011100.23561.27554.stgit@yoghurt> ("Karl =?utf-8?Q?H?=
 =?utf-8?Q?asselstr=C3=B6m=22's?= message of "Tue\, 31 Jul 2007 03\:13\:50
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54331>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> This is a Request For Help. The patch works, but is clearly the work
> of someone who is not very fluent in elisp. Just look at all that
> duplicated code I've introduced!

I would do it this way:

=46rom: Alexandre Julliard <julliard@winehq.org>
Date: Tue, 31 Jul 2007 12:19:05 +0200
Subject: [PATCH] git.el: Take into account the core.excludesfile config=
 option.

Also don't require .git/info/exclude to exist in order to list unknown
files.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 53dd703..9bcd7c4 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -589,6 +589,16 @@ Return the list of files that haven't been handled=
=2E"
           (when node (push (ewoc-data node) unmerged-files))))
       (git-set-files-state unmerged-files 'unmerged))))
=20
+(defun git-get-exclude-files ()
+  "Get the list of exclude files to pass to git-ls-files."
+  (let (files
+        (config (git-config "core.excludesfile")))
+    (when (file-readable-p ".git/info/exclude")
+      (push ".git/info/exclude" files))
+    (when (and config (file-readable-p config))
+      (push config files))
+    files))
+
 (defun git-update-status-files (files &optional default-state)
   "Update the status of FILES from the index."
   (unless git-status (error "Not in git-status buffer."))
@@ -598,11 +608,11 @@ Return the list of files that haven't been handle=
d."
               (git-run-ls-files status files 'added "-c")
             (git-run-diff-index status files))))
     (git-run-ls-unmerged status files)
-    (when (and (or (not files) remaining-files)
-               (file-readable-p ".git/info/exclude"))
-      (setq remaining-files (git-run-ls-files status remaining-files
-                                              'unknown "-o" "--exclude=
-from=3D.git/info/exclude"
-                                              (concat "--exclude-per-d=
irectory=3D" git-per-dir-ignore-file))))
+    (when (or (not files) remaining-files)
+      (let ((exclude-files (git-get-exclude-files)))
+        (setq remaining-files (apply #'git-run-ls-files status remaini=
ng-files 'unknown "-o"
+                                     (concat "--exclude-per-directory=3D=
" git-per-dir-ignore-file)
+                                     (mapcar (lambda (f) (concat "--ex=
clude-from=3D" f)) exclude-files)))))
     ; mark remaining files with the default state (or remove them if n=
il)
     (when remaining-files
       (if default-state
--=20
1.5.3.rc3.92.g70c7b

--=20
Alexandre Julliard
julliard@winehq.org
