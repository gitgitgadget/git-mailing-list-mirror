From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] git.el: Diff only file at point by default
Date: Fri, 22 Aug 2008 09:58:42 +0200
Message-ID: <87vdxtpjkd.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 10:00:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWRZC-0007Ps-C8
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 10:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442AbYHVH6q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Aug 2008 03:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752940AbYHVH6p
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 03:58:45 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:52585 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755406AbYHVH6o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 03:58:44 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 2DD422236DCC
	for <git@vger.kernel.org>; Fri, 22 Aug 2008 09:58:43 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 18756-01-40; Fri, 22 Aug 2008 09:58:42 +0200 (CEST)
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id C16B02235DB0;
	Fri, 22 Aug 2008 09:58:42 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id 78313E4801A; Fri, 22 Aug 2008 09:58:42 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93269>

Use prefix (C-u) to diff all marked files instead.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 contrib/emacs/git.el |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

=46or anyone who has used pcvs (or dsvn) this makes much more sense. Th=
e
typical usage scenario is that you want to mark the files that are
relevant, and you do it incrementally by checking if file A is
relevant and has no strange changes by pressing =3D and then marking it=
,
proceeding to check file B by pressing =3D on it and potentially markin=
g
it as well and so on.

The current way that =3D works means that you have to check each file
first and remember which one you want to mark. Or diff everything and
then read through the whole diff and find match the output against the
files to mark. It is possible to do it like that as well, but it is
much more convenient to do it as described above, and there is a
strong precedent in emacs frontends to make the diff command only diff
the current file by default.

The old behaviour can be restored by using C-u =3D.

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index c30d20a..a3477a4 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -772,6 +772,11 @@ Return the list of files that haven't been handled=
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
@@ -1138,10 +1143,10 @@ Return the list of files that haven't been hand=
led."
   (when (eq (window-buffer) (current-buffer))
     (shrink-window-if-larger-than-buffer)))
=20
-(defun git-diff-file ()
-  "Diff the marked file(s) against HEAD."
-  (interactive)
-  (let ((files (git-marked-files)))
+(defun git-diff-file (arg)
+  "Diff the marked file(s) against HEAD, or the marked files if a pref=
ix arg is given."
+  (interactive "P")
+  (let ((files (if arg (git-marked-files) (list (git-current-file)))))
     (git-setup-diff-buffer
      (apply #'git-run-command-buffer "*git-diff*" "diff-index" "-p" "-=
M" "HEAD" "--" (git-get-filenames files)))))
=20
--=20
1.6.0.rc2.7.gbf8a


--=20
David K=C3=A5gedal
