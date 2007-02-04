From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/2] Let git-checkout always drop any detached head
Date: Sat, 03 Feb 2007 21:50:39 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702032149200.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 03:50:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDXSk-0008B4-0z
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 03:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbXBDCuk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 21:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbXBDCuk
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 21:50:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:42311 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbXBDCuk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 21:50:40 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCX006HZ3WFR9A0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 03 Feb 2007 21:50:39 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38639>


We used to refuse leaving a detached HEAD when it wasn't matching an
existing ref so not to lose any commit that might have been performed
while not on any branch (unless -f was provided).

But this protection was completely bogus since it was still possible
to move to HEAD^ while still remaining detached but losing the last
commit anyway if there was one.

Now that we have a proper reflog for HEAD it is best to simply remove
that bogus (and admitedly annoying) protection and simply display the
last HEAD position instead.  If one wants to recover a lost detached
state then it can be retrieved from the HEAD reflog.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 git-checkout.sh |   17 ++---------------
 1 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index 99b8779..e4cce06 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -164,22 +164,9 @@ If you want to create a new branch from this checkout, you may do so
 (now or later) by using -b with the checkout command again. Example:
   git checkout -b <new_branch_name>"
 	fi
-elif test -z "$oldbranch" && test -n "$branch"
+elif test -z "$oldbranch" && && test -z "$quiet"
 then
-	# Coming back...
-	if test -z "$force"
-	then
-		git show-ref -d -s | grep "$old" >/dev/null || {
-			echo >&2 \
-"You are not on any branch and switching to branch '$new_name'
-may lose your changes.  At this point, you can do one of two things:
- (1) Decide it is Ok and say 'git checkout -f $new_name';
- (2) Start a new branch from the current commit, by saying
-     'git checkout -b <branch-name>'.
-Leaving your HEAD detached; not switching to branch '$new_name'."
-			exit 1;
-		}
-	fi
+	echo >&2 "Previous HEAD position was $old"
 fi
 
 if [ "X$old" = X ]
-- 
1.5.0.rc2.651.g3924-dirty
