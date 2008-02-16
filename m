From: =?utf-8?Q?R=C3=A9mi?= Vanicat <vanicat@debian.org>
Subject: [PATCH 03/03] Adding command for merging in git.el
Date: Sat, 16 Feb 2008 20:35:00 +0100
Message-ID: <8763wou23f.dlv_-_@maison.homelinux.org>
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
X-From: git-owner@vger.kernel.org Sat Feb 16 20:35:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQSp6-0005NH-Gb
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 20:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbYBPTfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 14:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbYBPTfI
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 14:35:08 -0500
Received: from neuf-infra-smtp-out-sp604007av.neufgp.fr ([84.96.92.120]:56614
	"EHLO neuf-infra-smtp-out-sp604007av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751458AbYBPTfH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Feb 2008 14:35:07 -0500
Received: from neuf-infra-smtp-out-sp604012av.neufgp.fr ([84.96.92.115])
	by neuf-infra-smtp-out-sp604007av.neufgp.fr with neuf telecom
	id q8QK1Y0062VLLWC071U700; Sat, 16 Feb 2008 20:35:03 +0100
Received: from maison.homelinux.org ([84.103.71.93])
	by neuf-infra-smtp-out-sp604012av.neufgp.fr with neuf telecom
	id qKb21Y00L20lBGc0C00000; Sat, 16 Feb 2008 20:35:03 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JQSoO-00051i-9A; Sat, 16 Feb 2008 20:35:01 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74069>

M-x git-merge will ask for an commitish, and merge with it.
A new submenu is also available for merging with local and remote
branch.
---
The problem here, which is similar to the one that exist now when one
merge from outside Emacs, is that in case of conflict, Emacs doesn't
look to the index, and so, when one commit the resolved conflict,
one might forget to select all file that should be selected for the
commit to be what is needed.

This problem could be even worse with rebasing, as rebasing is a more
destructive action than merging.


 contrib/emacs/git.el |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index f180421..60553d3 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1213,6 +1213,25 @@ use a prefix arg if git should merge while checking out"
    (list ["checkout any commitish" git-checkout t]
 	 ["change to new" git-branch t])))
 
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
+  "define the merge branch menu"
+  (append
+   (mapcar
+    (lambda (branch)
+      `[,(car branch)
+	 (git-merge ,(car branch)) :visible ,(not (cdr branch))])
+    (git-list-branches :all))
+   (list ["merge with any commitish" git-merge t])))
+
 (defun git-diff-file ()
   "Diff the marked file(s) against HEAD."
   (interactive)
@@ -1555,7 +1574,8 @@ amended version of it."
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
