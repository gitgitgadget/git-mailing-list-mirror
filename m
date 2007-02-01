From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] detached HEAD -- finishing touches
Date: Thu, 01 Feb 2007 01:08:41 -0800
Message-ID: <7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home>
	<20070131231942.GB31145@coredump.intra.peff.net>
	<Pine.LNX.4.64.0701311907500.3021@xanadu.home>
	<20070201030030.GA1979@coredump.intra.peff.net>
	<7vd54ur26u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, cworth@cworth.org,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 10:08:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCXw0-0001Rd-OF
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 10:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422699AbXBAJIo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 04:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422700AbXBAJIo
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 04:08:44 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:61040 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422699AbXBAJIn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 04:08:43 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070201090842.FNXE20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Thu, 1 Feb 2007 04:08:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id J98h1W00C1kojtg0000000; Thu, 01 Feb 2007 04:08:42 -0500
In-Reply-To: <7vd54ur26u.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 31 Jan 2007 19:23:21 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38334>

This updates "git-checkout" to report which branch you are
switching to.  Especially for people who do not use __git_ps1
from contrib/completion/git-completion.bash this would give a
friendlier feedback of what is going on, and should make the
reminder message much less scary.

Here is a sample session (the prompt tells which branch I am on).

* I have some local modification and realize that the change deserves
  to be on its own new topic branch.

    [git.git (master)]$ git diff --stat
     git-checkout.sh |   10 ++++++++--
     1 files changed, 8 insertions(+), 2 deletions(-)

* So I switch to a new branch.  I get a listing of local modifications
  and assuring "Switched to a new branch" message.

    [git.git (master)]$ git checkout -b jc/checkout
    M       git-checkout.sh
    Switched to a new branch "jc/checkout"

* If I switch back to "master", I get essentially the same.

    [git.git (jc/checkout)]$ git checkout master
    M       git-checkout.sh
    Switched to branch "master"

* Detaching head would say which commit I am at and reminds me that
  I am not on any branch (not that I would detach my HEAD while keeping
  precious local changes around in any real-world workflow -- this is
  just a sample session).

    [git.git (master)]$ git checkout master^
    M       git-checkout.sh
    Note: you are not on any branch and are at commit "master^"
    If you want to create a new branch from this checkout, you may do so
    (now or later) by using -b with the checkout command again. Example:
      git checkout -b <new_branch_name>

* Coming back to an attached state can lose the detached HEAD, so
  I get warned and stopped.

    [git.git]$ git checkout master
    You are not on any branch and switching to branch 'master'
    may lose your changes.  At this point, you can do one of two things:
     (1) Decide it is Ok and say 'git checkout -f master';
     (2) Start a new branch from the current commit, by saying
         'git checkout -b <branch-name>'.
    Leaving your HEAD detached; not switching to branch 'master'.

* Moving around while my HEAD is detached is Ok.  I still get the list
  of local modifications.

    [git.git]$ git checkout master^0
    M       git-checkout.sh

* The previous step that switched to the tip commit is an obscure but
  useful trick.  My HEAD is still detached but now it is pointed at by
  an existing ref, so I can come back safely.

    [git.git]$ git checkout master
    M       git-checkout.sh
    Switched to branch "master"

* And we are back on the "master" branch.

    [git.git (master)]$ exit

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
Junio C Hamano <junkio@cox.net> writes:

> That sounds sensible.  Another thing I found slightly annoying
> about branch switching in git-checkout is that we list the paths
> with local changes only when the tip of the old branch and the
> new branch are different.  Very often I start hacking while on
> 'master' and later find the change forms a concrete "theme", and
> then say "git checkout -b that-theme" to switch a branch; in
> such a case I do want the list of locally modified paths.

 git-checkout.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index 0bae86e..deb4795 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -155,7 +155,7 @@ then
 	detached="$new"
 	if test -n "$oldbranch"
 	then
-		detach_warn="Note: you are not on ANY branch anymore.
+		detach_warn="Note: you are not on any branch and are at commit \"$new_name\"
 If you want to create a new branch from this checkout, you may do so
 (now or later) by using -b with the checkout command again. Example:
   git checkout -b <new_branch_name>"
@@ -228,7 +228,7 @@ else
     saved_err=$?
     if test "$saved_err" = 0
     then
-	test "$new" = "$old" || git diff-index --name-status "$new"
+	git diff-index --name-status "$new"
     fi
     (exit $saved_err)
 fi
@@ -251,6 +251,12 @@ if [ "$?" -eq 0 ]; then
 	if test -n "$branch"
 	then
 		GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD "refs/heads/$branch"
+		if test -n "$newbranch"
+		then
+			echo >&2 "Switched to a new branch \"$branch\""
+		else
+			echo >&2 "Switched to branch \"$branch\""
+		fi
 	elif test -n "$detached"
 	then
 		# NEEDSWORK: we would want a command to detach the HEAD
