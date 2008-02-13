From: Remi Vanicat <vanicat@debian.org>
Subject: Re: [PATCH] Add function to checkout a branch in git.el
Date: Wed, 13 Feb 2008 19:09:50 +0100
Message-ID: <87hcgcu3rl.dlv@maison.homelinux.org>
References: <87wsp8u9m7.dlv@maison.homelinux.org>
	<20080213163002.GA5670@diana.vm.bytemark.co.uk>
	<20080213164356.GA5828@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?us-ascii?Q?=3D=3Futf-8=3Fq=3FR=3DC3=3DA9mi=3D20Vanicat=3F=3D?= 
	<vanicat@debian.org>, git@vger.kernel.org,
	Alexandre Julliard <julliard@winehq.org>
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 19:11:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPM4d-0005RX-Gl
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 19:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbYBMSKH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 13:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbYBMSKG
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 13:10:06 -0500
Received: from neuf-infra-smtp-out-sp604007av.neufgp.fr ([84.96.92.120]:36423
	"EHLO neuf-infra-smtp-out-sp604007av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750832AbYBMSKD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 13:10:03 -0500
Received: from neuf-infra-smtp-out-sp604012av.neufgp.fr ([84.96.92.115])
	by neuf-infra-smtp-out-sp604007av.neufgp.fr with neuf telecom
	id p69j1Y00C2VLLWC0700500; Wed, 13 Feb 2008 19:09:59 +0100
Received: from maison.homelinux.org ([84.103.71.93])
	by neuf-infra-smtp-out-sp604012av.neufgp.fr with neuf telecom
	id p69q1Y00N20lBGc0C00000; Wed, 13 Feb 2008 19:09:57 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JPM3K-0007AA-8g; Wed, 13 Feb 2008 19:09:50 +0100
In-Reply-To: <20080213164356.GA5828@diana.vm.bytemark.co.uk> ("Karl
 =?utf-8?Q?Hasselstr=C3=B6m=22's?= message of "Wed\, 13 Feb 2008 17\:43\:56
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: moi@vanicat.homelinux.org
X-SA-Exim-Scanned: No (on maison.homelinux.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73806>

M-x git-change-branch checkout branch, and ask for confirmation
if a new one is to be created
One could also use a new submenu in the Git menu for this.
---
Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2008-02-13 17:30:02 +0100, Karl Hasselstr=C3=B6m wrote:
>
>> Why the prefix? Wouldn't it be easier to just have one "switch
>> branch" prompt that would tab complete existing branch names, and

I didn't think of the other way, that seem simpler. Here is a
corrected patch

>   * if the user enters a name that's not the name of an existing
>     branch, display a prompt like this
>
>       Creating new branch "foo". Where should it start?
>
>     Tab complete on existing tags and branches, but accept any
>     committish. Create the new branch and switch to it.
Mmm seem cool, but I have no time for now. Patch are welcome,
otherwise I might look at it this weekend or next week.

Also one might want to do detached head checkout, it wont work for
now, but should not be very hard to do.
--=20
R=C3=A9mi Vanicat
 contrib/emacs/git.el |   45 ++++++++++++++++++++++++++++++++++++++++++=
+++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index a8bf0ef..bf0601d 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1138,6 +1138,50 @@ Return the list of files that haven't been handl=
ed."
   (when (eq (window-buffer) (current-buffer))
     (shrink-window-if-larger-than-buffer)))
=20
+(defun git-list-branch ()
+  "Return a list of available branch"
+  ;; should I check if I'm in a git repository ?
+  (let ((branchs ()))
+    (with-temp-buffer
+      (git-run-command-buffer (current-buffer) "branch")
+      (goto-char (point-min))
+      (while (re-search-forward "^\\([ *]\\) \\([^\n]*\\)$" () t)
+	(push (list (match-string 2)
+		    (string=3D (match-string 1) "*"))
+	      branchs)))
+    (nreverse branchs)))
+
+(defun git-change-branch (branch &optional new)
+  "Switch to another branch
+
+if new is non-nil, creating it if needed
+otherwise just checkout it"
+  (interactive
+   (let ((branch (completing-read "Branch: " (git-list-branch))))
+     (list branch
+	   (and (not (assoc branch (git-list-branch)))
+		(or (y-or-n-p "create a new branch? ")
+		    (error "branch does not exist"))))))
+  (with-temp-buffer
+    (if new
+	(git-call-process-display-error "checkout" "-b" branch)
+	(git-call-process-display-error "checkout" branch "--"))
+    (goto-char (point-min))))
+
+(defun git-change-new-branch-menu (branch)
+  "Switch to new branch"
+  (interactive "MBranch: ")
+  (git-change-branch branch 't))
+
+(defun git-change-branch-menu-filter (rest)
+  "define the change branch menu"
+  (append
+   (mapcar
+    (lambda (branch)
+      `[,(car branch) (git-change-branch ,(car branch)) t])
+    (git-list-branch))
+   (list ["change to new" git-change-new-branch-menu t])))
+
 (defun git-diff-file ()
   "Diff the marked file(s) against HEAD."
   (interactive)
@@ -1486,6 +1530,7 @@ amended version of it."
 	["Diff Against Merge Head" git-diff-file-merge-head t]
 	["Diff Against Mine" git-diff-file-mine t]
 	["Diff Against Other" git-diff-file-other t])
+      ("Change branch" :filter git-change-branch-menu-filter)
       "--------"
       ["Add File" git-add-file t]
       ["Revert File" git-revert-file t]
--=20
1.5.4.1.101.gacba
