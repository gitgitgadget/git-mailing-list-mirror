From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Re: keeping remote repo checked out?
Date: Mon, 28 Nov 2005 22:40:33 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511282208050.25300@iabervon.org>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
 <7vbr051ad1.fsf@assigned-by-dhcp.cox.net> <20051128105736.GO22159@pasky.or.cz>
 <7vsltgtvk4.fsf@assigned-by-dhcp.cox.net> <20051128212804.GV22159@pasky.or.cz>
 <Pine.LNX.4.64.0511281420390.3263@g5.osdl.org> <Pine.LNX.4.64.0511281845280.25300@iabervon.org>
 <Pine.LNX.4.64.0511281637480.3177@g5.osdl.org> <Pine.LNX.4.64.0511282027360.25300@iabervon.org>
 <Pine.LNX.4.64.0511281837040.3177@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 04:42:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgwMg-0002cS-RL
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 04:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVK2DkH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 22:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVK2DkH
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 22:40:07 -0500
Received: from iabervon.org ([66.92.72.58]:21256 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932354AbVK2DkF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 22:40:05 -0500
Received: (qmail 4061 invoked by uid 1000); 28 Nov 2005 22:40:33 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Nov 2005 22:40:33 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511281837040.3177@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12916>

On Mon, 28 Nov 2005, Linus Torvalds wrote:

> On Mon, 28 Nov 2005, Daniel Barkalow wrote:
> > > 
> > > but if you use a special git branch for the checked-out state, then you 
> > > have to realize that nobody can push directly to it.
> > 
> > The idea is to have something which is private, to match the working tree, 
> > which is obviously private (because it doesn't even exist from the point 
> > of view of the database).
> 
> Sure. It's private because it has its own name, and you can make _sure_ 
> that nobody tries to push to it by having a trigger that refuses to update 
> that branch.
> 
> Now, if you want to make it also be _invisible_ (so that when others don't 
> clone, they don't see what the checked-out state was when they cloned), 
> you'd have to make some new rules to git. We could have rules like "branch 
> names that start with '.' aren't listed", which would effectively do 
> exactly that..

I was planning to keep it in .git (instead of .git/refs/...), because it's 
information about the working tree, not properly part of the repository. 
It's like MERGE_HEAD in being about what the user is in the middle of.

I actually have a bit of a patch now, which only updates checkout and 
commit (anything that updates HEAD should also update CHECKED_OUT, and 
some things probably ought to read CHECKED_OUT instead of HEAD), but 
should serve to give an idea of what I mean. Essentially, if somebody's 
messed with your HEAD, than "git checkout" will update to that, and "git 
commit" will give an error message until you do (I added a check so it 
happens before you write a message, but the third argument to 
"git-update-ref HEAD" would also complain).

Obviously, not for application, since it breaks things like "git resolve" 
which are supposed to change what your working tree contains and aren't 
updated to make CHECKED_OUT match.

---

Keep a private copy of the commit whose tree corresponds to the
git-provided state of the working tree, in case somebody changes the
branch we're on behind our backs.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---

 git-checkout.sh |    5 ++++-
 git-commit.sh   |   10 +++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

applies-to: fe523a4df93cce3e5c5b0266b9d3f1cbea009afa
8831e2595f29c90a259586250d5c6d044e9d7c8c
diff --git a/git-checkout.sh b/git-checkout.sh
index 4cf30e2..503b34f 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -5,7 +5,8 @@ usage () {
     die "usage: git checkout [-f] [-b <new_branch>] [<branch>] [<paths>...]"
 }
 
-old=$(git-rev-parse HEAD)
+old=$(git-rev-parse --revs-only CHECKED_OUT)
+[ -z $old ] && old=$(git-rev-parse HEAD)
 new=
 force=
 branch=
@@ -117,6 +118,8 @@ else
     git-read-tree -m -u $old $new
 fi
 
+git-update-ref CHECKED_OUT $new
+
 # 
 # Switch the HEAD pointer to the new branch if it we
 # checked out a branch head, and remove any potential
diff --git a/git-commit.sh b/git-commit.sh
index 3d250ec..e73003b 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -108,6 +108,13 @@ t,*)
 esac || exit 1
 git-update-index -q --refresh || exit 1
 
+current=$(git-rev-parse --revs-only CHECKED_OUT)
+if test ! -z "$current" -a "$current" != "$(git-rev-parse HEAD)"
+then
+	echo "Changes have been pushed to this branch since you checked it out"
+	exit 1
+fi
+
 case "$verify" in
 t)
 	if test -x "$GIT_DIR"/hooks/pre-commit
@@ -232,7 +239,8 @@ then
 	tree=$(git-write-tree) &&
 	commit=$(cat "$GIT_DIR"/COMMIT_MSG | git-commit-tree $tree $PARENTS) &&
 	git-update-ref HEAD $commit $current &&
-	rm -f -- "$GIT_DIR/MERGE_HEAD"
+	rm -f -- "$GIT_DIR/MERGE_HEAD" &&
+	git-update-ref CHECKED_OUT $commit
 else
 	echo >&2 "* no commit message?  aborting commit."
 	false
---
0.99.9.GIT
