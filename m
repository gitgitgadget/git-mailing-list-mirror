From: =?utf-8?Q?R=C3=A9mi?= Vanicat <vanicat@debian.org>
Subject: [PATCH 01/03] Add helper function for branch tag and commitish to git.el
Date: Sat, 16 Feb 2008 20:27:16 +0100
Message-ID: <87ejbcu2gb.dlv_-_@maison.homelinux.org>
References: <87wsp8u9m7.dlv@maison.homelinux.org>
	<20080213163002.GA5670@diana.vm.bytemark.co.uk>
	<20080213164356.GA5828@diana.vm.bytemark.co.uk>
	<87zlu4vhon.fsf@osv.gnss.ru> <87lk5ku2wn.dlv_-_@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Sergei Organov <osv@javad.com>,
	Alexandre Julliard <julliard@winehq.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 20:28:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQShl-00030U-HP
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 20:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755848AbYBPT1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 14:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755718AbYBPT1X
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 14:27:23 -0500
Received: from sp604003av.neufgp.fr ([84.96.92.124]:43284 "EHLO
	neuf-infra-smtp-out-sp604003av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755275AbYBPT1W (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Feb 2008 14:27:22 -0500
Received: from neuf-infra-smtp-out-sp604001av.neufgp.fr ([84.96.92.125])
	by neuf-infra-smtp-out-sp604003av.neufgp.fr with neuf telecom
	id q6yY1Y00j2iH3ss030Wf00; Sat, 16 Feb 2008 19:27:19 +0000
Received: from maison.homelinux.org ([84.103.71.93])
	by neuf-infra-smtp-out-sp604001av.neufgp.fr with neuf telecom
	id qKTJ1Y00m20lBGc0100000; Sat, 16 Feb 2008 20:27:19 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JQSgu-0004yP-Lm; Sat, 16 Feb 2008 20:27:18 +0100
In-Reply-To: <87lk5ku2wn.dlv_-_@maison.homelinux.org> (utf's message of "Sat\, 16 Feb 2008 20\:17\:28 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: moi@vanicat.homelinux.org
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on maison.homelinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NO_RELAYS autolearn=ham
	version=3.2.3
X-SA-Exim-Version: 4.2.1 (built Tue, 21 Aug 2007 23:39:36 +0000)
X-SA-Exim-Scanned: Yes (on maison.homelinux.org)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74067>


---
 contrib/emacs/git.el |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index a8bf0ef..16d9771 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1138,6 +1138,43 @@ Return the list of files that haven't been handled."
   (when (eq (window-buffer) (current-buffer))
     (shrink-window-if-larger-than-buffer)))
 
+(defun git-list-branches (&optional all)
+  "Return an alist of available branches
+if all is non-nil, return all branch, otherwise only local one
+cdr of assoc is non-nil for the current branch
+nil otherwise"
+  (let ((branches ()))
+    (with-temp-buffer
+      (if all
+	  (git-run-command-buffer (current-buffer) "branch" "-a")
+	  (git-run-command-buffer (current-buffer) "branch"))
+      (goto-char (point-min))
+      (while (re-search-forward "^\\([ *]\\) \\([^\n]*\\)$" () t)
+	(push (cons (match-string 2)
+		    (string= (match-string 1) "*"))
+	      branches)))
+    (nreverse branches)))
+
+(defun git-list-tags ()
+  "Return an list of available tags"
+  (let ((tags ()))
+    (with-temp-buffer
+      (git-run-command-buffer (current-buffer) "tag")
+      (goto-char (point-min))
+      (while (re-search-forward "^\\([^\n]+\\)$" () t)
+	(push (match-string 1)
+	      tags)))
+    (nreverse tags)))
+
+(defun git-read-commitish (prompt &optional default)
+  "ask user, with commpletion for a commit, branch, tag or any commitish"
+  (completing-read prompt (list* "HEAD"
+				 "ORIG_HEAD"
+				 "FETCH_HEAD"
+				 (append (git-list-branches t)
+					 (git-list-tags)))
+		   () () () () default))
+
 (defun git-diff-file ()
   "Diff the marked file(s) against HEAD."
   (interactive)
-- 
1.5.4.1.123.gcb68-dirty
