From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] git-checkout: disable guides how to switch branches with ui.guide
Date: Thu, 1 Feb 2007 19:44:03 +0100
Message-ID: <20070201184403.GA6326@moooo.ath.cx>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home> <20070131231942.GB31145@coredump.intra.peff.net> <Pine.LNX.4.64.0701311907500.3021@xanadu.home> <20070201030030.GA1979@coredump.intra.peff.net> <7vd54ur26u.fsf@assigned-by-dhcp.cox.net> <7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 19:44:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCguq-00080U-3H
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 19:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422933AbXBASoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 13:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422934AbXBASoI
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 13:44:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:54545 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422933AbXBASoH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 13:44:07 -0500
Received: (qmail invoked by alias); 01 Feb 2007 18:44:05 -0000
Received: from pD9EB9AC1.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.154.193]
  by mail.gmx.net (mp019) with SMTP; 01 Feb 2007 19:44:05 +0100
X-Authenticated: #5358227
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38386>

---
Junio C Hamano <junkio@cox.net> wrote:
> * Detaching head would say which commit I am at and reminds me that
>   I am not on any branch (not that I would detach my HEAD while keeping
>   precious local changes around in any real-world workflow -- this is
>   just a sample session).
> 
>     [git.git (master)]$ git checkout master^
>     M       git-checkout.sh
>     Note: you are not on any branch and are at commit "master^"
>     If you want to create a new branch from this checkout, you may do so
>     (now or later) by using -b with the checkout command again. Example:
>       git checkout -b <new_branch_name>
> 
> * Coming back to an attached state can lose the detached HEAD, so
>   I get warned and stopped.
> 
>     [git.git]$ git checkout master
>     You are not on any branch and switching to branch 'master'
>     may lose your changes.  At this point, you can do one of two things:
>      (1) Decide it is Ok and say 'git checkout -f master';
>      (2) Start a new branch from the current commit, by saying
>          'git checkout -b <branch-name>'.
>     Leaving your HEAD detached; not switching to branch 'master'.
I think these two are too long, after a few times one knows exactly
what to do and all this text is not necessary anymore.

Perhaps the name (ui.guide) should be different, I just did not find
any category to put this in.  The variable could become a general
variable to enable/disable very verbose explanations what to do in a
situation.
---
 git-checkout.sh |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index deb4795..1eb8b06 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -5,6 +5,8 @@ SUBDIRECTORY_OK=Sometimes
 . git-sh-setup
 require_work_tree
 
+guide=$(git repo-config --bool --get ui.guide)
+[ -z "$guide" ] && guide=true
 old_name=HEAD
 old=$(git-rev-parse --verify $old_name 2>/dev/null)
 oldbranch=$(git-symbolic-ref $old_name 2>/dev/null)
@@ -155,10 +157,13 @@ then
 	detached="$new"
 	if test -n "$oldbranch"
 	then
-		detach_warn="Note: you are not on any branch and are at commit \"$new_name\"
+		detach_warn="Note: you are not on any branch and are at commit \"$new_name\""
+		if test "$guide" = true; then
+			detach_warn="$detach_warn
 If you want to create a new branch from this checkout, you may do so
 (now or later) by using -b with the checkout command again. Example:
   git checkout -b <new_branch_name>"
+		fi
 	fi
 elif test -z "$oldbranch" && test -n "$branch"
 then
@@ -166,13 +171,18 @@ then
 	if test -z "$force"
 	then
 		git show-ref -d -s | grep "$old" >/dev/null || {
-			echo >&2 \
+			if test "$guide" = true; then
+				echo >&2 \
 "You are not on any branch and switching to branch '$new_name'
 may lose your changes.  At this point, you can do one of two things:
  (1) Decide it is Ok and say 'git checkout -f $new_name';
  (2) Start a new branch from the current commit, by saying
      'git checkout -b <branch-name>'.
 Leaving your HEAD detached; not switching to branch '$new_name'."
+			else
+				echo >&2 \
+"HEAD detached; use -f to switch to branch '$new_name'."
+			fi
 			exit 1;
 		}
 	fi
-- 
1.5.0.rc3.g4a88
