From: =?utf-8?Q?R=C3=A9mi?= Vanicat <vanicat@debian.org>
Subject: [PATCH v3 03/03] Adding command for merging in git.el
Date: Mon, 18 Feb 2008 17:35:55 +0100
Message-ID: <87ir0mp6hg.dlv@maison.homelinux.org>
References: <87zltyp717.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexandre Julliard <julliard@winehq.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 17:37:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR8ze-0007Kj-Th
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 17:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759983AbYBRQgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 11:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759959AbYBRQgG
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 11:36:06 -0500
Received: from neuf-infra-smtp-out-sp604006av.neufgp.fr ([84.96.92.121]:35794
	"EHLO neuf-infra-smtp-out-sp604006av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759854AbYBRQgB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Feb 2008 11:36:01 -0500
Received: from neuf-infra-smtp-out-sp604001av.neufgp.fr ([84.96.92.125])
	by neuf-infra-smtp-out-sp604006av.neufgp.fr with neuf telecom
	id qulN1Y00B2iH3ss060US00; Mon, 18 Feb 2008 17:36:00 +0100
Received: from maison.homelinux.org ([84.103.71.93])
	by neuf-infra-smtp-out-sp604001av.neufgp.fr with neuf telecom
	id r4by1Y00620lBGc0100000; Mon, 18 Feb 2008 17:35:58 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JR8yC-0003ao-2B; Mon, 18 Feb 2008 17:35:57 +0100
In-Reply-To: <87zltyp717.dlv@maison.homelinux.org> (=?utf-8?Q?=22R=C3=A9mi?=
 Vanicat"'s message of "Mon\, 18 Feb 2008 17\:24\:04 +0100")
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74311>

M-x git-merge will ask for an commitish, and merge with it.
    key binding "C-cC-m"
A new submenu is also available for merging with local and remote
branch.
---
 contrib/emacs/git.el |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index d35f837..5c3fc01 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1254,6 +1254,26 @@ use a prefix arg if git should merge while checking out"
      :after `(["checkout any commitish" git-checkout t]
 	      ["change to new" git-branch t]))))
 
+(defun git-merge (commitish)
+  "merge with commitish
+
+Note that in case of conflict, after resolving everty conflict,
+one have to select every concerned file before commiting"
+  (interactive (list (git-read-commitish "Merge with: ")))
+  (git-call-process-display-error "merge" commitish)
+  (git-refresh-status))
+
+(defun git-merge-menu-filter (rest)
+  "define the change branch menu"
+  (git-refs-build-menu
+   :branch (lambda (short-name ref-name)
+	     `[,short-name (git-merge ,short-name)])
+   :remote (lambda (short-name ref-name)
+	     `[,short-name (git-merge ,short-name)])
+   :tag (lambda (short-name ref-name)
+	  `[,short-name (git-merge ,short-name)])
+   :after `(["merge with any commitish" git-merge t])))
+
 (defun git-diff-file ()
   "Diff the marked file(s) against HEAD."
   (interactive)
@@ -1578,6 +1598,7 @@ amended version of it."
     (define-key commit-map "\C-a" 'git-amend-commit)
     (define-key commit-map "\C-o" 'git-checkout)
     (define-key commit-map "\C-b" 'git-branch)
+    (define-key commit-map "\C-m" 'git-merge)
     ; the diff submap
     (define-key diff-map "b" 'git-diff-file-base)
     (define-key diff-map "c" 'git-diff-file-combined)
@@ -1599,7 +1620,8 @@ amended version of it."
       ["Refresh" git-refresh-status t]
       ["Commit" git-commit-file t]
       ("Checkout Branch" :filter git-checkout-menu-filter)
-      ("Merge"
+      ("Merge" :filter git-merge-menu-filter)
+      ("Resolve Merge"
 	["Next Unmerged File" git-next-unmerged-file t]
 	["Prev Unmerged File" git-prev-unmerged-file t]
 	["Mark as Resolved" git-resolve-file t]
-- 
1.5.4.1.123.gcb68-dirty
