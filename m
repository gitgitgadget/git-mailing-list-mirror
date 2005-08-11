From: Junio C Hamano <junkio@cox.net>
Subject: Re: bisect gives strange answer
Date: Thu, 11 Aug 2005 15:07:45 -0700
Message-ID: <7vk6isgma6.fsf@assigned-by-dhcp.cox.net>
References: <E1E3HoN-0002ET-Ht@approximate.corpus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 00:09:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3LDM-0000Q7-Sv
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 00:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVHKWHu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 18:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVHKWHu
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 18:07:50 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:40113 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932282AbVHKWHu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 18:07:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050811220745.HBFI3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 11 Aug 2005 18:07:45 -0400
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
In-Reply-To: <E1E3HoN-0002ET-Ht@approximate.corpus.cam.ac.uk> (Sanjoy
	Mahajan's message of "Thu, 11 Aug 2005 14:29:51 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk> writes:

> I'm having doing a stupidity with git, but here's what is confusing me
> about using bisect:
>
> If I start with a clean directory except for a 2.6 .git/ (where master =
> d95a1b4818f2fe38a3cfc9a7d5817dc9a1a69329), then do
>
> $ cd linux-2.6
> $ ls
> $ cat .git/HEAD
> d95a1b4818f2fe38a3cfc9a7d5817dc9a1a69329
> $ git bisect start
> $ git bisect good 17af691cd19765b782d891fc50c1568d0f1276b3
> $ git bisect bad c101f3136cc98a003d0d16be6fab7d0d950581a6  
> Bisecting: 42 revisions left to test after this
> $ ls
> arch	 Documentation	include  kernel       Makefile	README	  sound
> CREDITS  drivers	init	 lib	      mm	scripts
> crypto	 fs		ipc	 MAINTAINERS  net	security
>
> What happened to, for example, COPYING?  Maybe I am doing something
> silly (which I did before so I didn't get the right kernel trees to
> compile?).  If I do 'git reset' first, then COPYING is there.

Although I think what you saw is pathological, I do not think it
is what you did that is wrong.  The same thing happens if you
have .git/HEAD pointing at some version, you have nothing
checked out, and "git pull" from the upstream which results in a
fast forward merge.  Only the files that have been changed
between ORIG_HEAD and FETCH_HEAD are checked out.

What is happening is that git-checkout-script, which uses
"git-read-tree -m -u", checks out only the files that have
changed between the "current suspect" version and "next suspect"
version, leaving other paths untouched.  This means that if
"other paths" were not in the working tree to begin with, they
are left not-checked-out.

This is because the 'git-read-tree -m A B' is designed to allow
two-tree fast-forward merge work safely in a working tree that
has local modifications.  The local modification in your case is
that "you removed all files".  This is further complicated by
that the low-level git design wants to work in a non-populated
tree and treats not having a file in the working tree a bit
differently from having a file that is modified in the working
tree.  read-tree.c::verify_uptodate() function says when you
removed a file that is recorded in the index, it does not
consider you have a local modification on that path.

The paths that were not checked out fall in the case 14 in the
Documentation/git-read-tree.txt "Two Tree Merge" table, and the
path is not marked for update in "keep index" cases.

Although I think what git-read-tree currently does is
defensible, I do not think what "git checkout" does is.  The
user is asking things to be checked out so it is not a "work
without files in working tree" case anymore.

Maybe we should check if the working tree is clean before using
git-read-tree -m -u and require --force if it is not, perhaps?

The following patch is not tested at all but I am throwing it
out in the open early, in case the approach I am taking is
totally going in the wrong direction.


---
cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-diff
# - pu: Debian packaging fixes.
# + (working tree)
diff --git a/git-checkout-script b/git-checkout-script
--- a/git-checkout-script
+++ b/git-checkout-script
@@ -56,7 +56,9 @@ then
     git-read-tree --reset $new &&
 	git-checkout-cache -q -f -u -a
 else
-    git-read-tree -m -u $old $new
+    git-update-cache --refresh &&
+    git-read-tree -m -u $old $new ||
+    	die "git checkout: your working tree is dirty"
 fi
 
 # 
diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -86,7 +86,7 @@ static void verify_uptodate(struct cache
 			return;
 		errno = 0;
 	}
-	if (errno == ENOENT)
+	if (errno == ENOENT && !update)
 		return;
 	die("Entry '%s' not uptodate. Cannot merge.", ce->name);
 }
