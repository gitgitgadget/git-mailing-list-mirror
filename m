From: =?utf-8?Q?R=C3=A9mi?= Vanicat <vanicat@debian.org>
Subject: [PATCH/RFC] git.el: Add a git-log command
Date: Fri, 28 Mar 2008 17:53:26 +0100
Message-ID: <87bq4ydc3d.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexandre Julliard <julliard@winehq.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 17:54:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfHqU-0006T9-PT
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 17:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbYC1Qxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 12:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753417AbYC1Qxp
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 12:53:45 -0400
Received: from neuf-infra-smtp-out-sp604003av.neufgp.fr ([84.96.92.124]:41495
	"EHLO neuf-infra-smtp-out-sp604003av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753344AbYC1Qxo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Mar 2008 12:53:44 -0400
Received: from neuf-infra-smtp-out-sp604011av.neufgp.fr ([84.96.92.116])
	by neuf-infra-smtp-out-sp604003av.neufgp.fr with neuf telecom
	id 6gtS1Z0022We0qU0300100; Fri, 28 Mar 2008 16:53:40 +0000
Received: from maison.homelinux.org ([84.101.56.178])
	by neuf-infra-smtp-out-sp604011av.neufgp.fr with neuf telecom
	id 6gtU1Z00V3qimmk0B00000; Fri, 28 Mar 2008 17:53:39 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <vanicat.remi@neuf.fr>)
	id 1JfHpW-0001gm-78; Fri, 28 Mar 2008 17:53:28 +0100
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: vanicat.remi@neuf.fr
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on maison.homelinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=5.0 tests=AWL,BAYES_00,NO_RELAYS
	autolearn=ham version=3.2.4
X-SA-Exim-Version: 4.2.1 (built Tue, 21 Aug 2007 23:39:36 +0000)
X-SA-Exim-Scanned: Yes (on maison.homelinux.org)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78429>

The git-log-files command only give log relative to selected files, or
relative to the file under cursor if there is no selected files, so
git.el could not give the full log.  This new command do it.

There is no key-binding for now.
---
Do I need a key binding for this? No idea where to put it. 
Another way to do it may be to use a prefix arg to git-log-file

 contrib/emacs/git.el |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 4fa853f..6cf55dc 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1191,11 +1191,10 @@ Return the list of files that haven't been handled."
            (buff2 (git-run-command-buffer (concat filename ".~HEAD~") "cat-file" "blob" (concat "HEAD:" filename))))
       (ediff-buffers buff1 buff2))))
 
-(defun git-log-file ()
+(defun git-log-file (files)
   "Display a log of changes to the marked file(s)."
-  (interactive)
-  (let* ((files (git-marked-files))
-         (coding-system-for-read git-commits-coding-system)
+  (interactive (list (git-marked-files)))
+  (let* ((coding-system-for-read git-commits-coding-system)
          (buffer (apply #'git-run-command-buffer "*git-log*" "rev-list" "--pretty" "HEAD" "--" (git-get-filenames files))))
     (with-current-buffer buffer
       ; (git-log-mode)  FIXME: implement log mode
@@ -1203,6 +1202,11 @@ Return the list of files that haven't been handled."
       (setq buffer-read-only t))
     (display-buffer buffer)))
 
+(defun git-log ()
+  "Display a log of changes."
+  (interactive)
+  (git-log-file ()))
+
 (defun git-log-edit-files ()
   "Return a list of marked files for use in the log-edit buffer."
   (with-current-buffer log-edit-parent-buffer
@@ -1495,7 +1499,9 @@ amended version of it."
       ["View File" git-view-file t]
       ["Diff File" git-diff-file t]
       ["Interactive Diff File" git-diff-file-idiff t]
-      ["Log" git-log-file t]
+      ["Log file" git-log-file t]
+      ["Log" git-log t]
+      ,@(if (featurep 'grep) (list ["Grep" git-grep t]) ())
       "--------"
       ["Mark" git-mark-file t]
       ["Mark All" git-mark-all t]
-- 
1.5.5.rc0.19.g4b856
