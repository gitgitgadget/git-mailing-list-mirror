From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] Add git-unresolve <paths>...
Date: Wed, 19 Apr 2006 16:57:49 -0700
Message-ID: <7vmzeh3ypu.fsf@assigned-by-dhcp.cox.net>
References: <7vu08p72sn.fsf@assigned-by-dhcp.cox.net>
	<87acah6zk6.wl%cworth@cworth.org>
	<7v8xq16y31.fsf@assigned-by-dhcp.cox.net>
	<87wtdl2o5o.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 01:57:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWMYU-0008Uf-9j
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 01:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWDSX5v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 19:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWDSX5v
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 19:57:51 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:38100 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751331AbWDSX5v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 19:57:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060419235750.FLOY8241.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Apr 2006 19:57:50 -0400
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87wtdl2o5o.wl%cworth@cworth.org> (Carl Worth's message of "Wed,
	19 Apr 2006 15:31:15 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18950>

Carl Worth <cworth@cworth.org> writes:

> Meanwhile, I still think it's worth re-considering the original
> problem. 
>
> After a failed merge, I get a multi-parent diff from "git
> diff". However, after updating the index, I can't find any way to get
> multi-parent diffs anymore.
>
> I'd still like to be able to do that, even when I know that what I
> have in the index is good, and I don't want to undo it. So the
> proposed unresolve (or update-index --unmerge, or whatever) is still
> not totally satisfactory.

I suspect this is just a misunderstanding caused by insufficient
explanation, so let's try this a bit differently.

With the patch applied (or use "next" branch I'll be pushing out
shortly), let's try the core-tutorial example up to the point
where we need to make a merge commit and get conflict.

The easiest way to do it is to interrupt the t/t1200-tutorial.sh
sequence, like this:

------------
diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index 16b3ea9..a51bb50 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -105,6 +105,8 @@ git commit -m 'Some fun.' -i hello examp
 
 test_expect_failure 'git resolve now fails' 'git resolve HEAD mybranch "Merge work in mybranch"'
 
+test_done
+
 cat > hello << EOF
 Hello World
 It's a new day for git
------------

Now, go to t/ directory and run this:

------------
$ cd t
$ ./t1200-tutorial.sh
------------

... which will stop after saying:

------------
*   ok 13: git resolve now fails
* passed all 13 test(s)
------------

Then go to t/trash directory to find the initial part of
Tutorial already run for us.  We have created a repository with
two files (`example` and `hello`), with two branches (`master`
and `mybranch`), and we are on `master`.  Both branches touched
`hello` in a conflicting way, and we have just pulled the other
branch into `master`, which conflicted, and hand resolved.

We can see the conflict like this:

------------
$ git diff
diff --cc hello
index ba42a2a,cc44c73..0000000
--- a/hello
+++ b/hello
@@@ -1,2 -1,3 +1,7 @@@
  Hello World
++<<<<<<< .merge_file_4wwUQv
 +Play, play, play
++=======
+ It's a new day for git
+ Work, work, work
++>>>>>>> .merge_file_6Ie4jx
------------

and we follow the tutorial to resolve it to see how the combined
diff looks like:

------------
$ cat >hello <<\EOF
Hello World
Play, play, play
It's a new day for git
Work, work, work
EOF
$ git diff
diff --cc hello
index ba42a2a,cc44c73..0000000
--- a/hello
+++ b/hello
@@@ -1,2 -1,3 +1,4 @@@
  Hello World
 +Play, play, play
+ It's a new day for git
+ Work, work, work
------------

Still with me so?  Now, let's say there was something wrong with
the above merge, but at this point we did not know about it.
For now, we are satisfied with this and run update-index:

------------
$ git update-index hello
$ git diff
------------

It was conflicting before, we hand-resolved and we said we are
done.  We do not see "git diff" output anymore, so we can
concentrate on other files.

But later (much later) we find out that there was something
wrong with this hand-resolve and now we would want to fix it.
The new command, "git unresolve" is designed to help us exactly
in this situation:

------------
$ git unresolve hello
$ git diff
diff --cc hello
index ba42a2a,cc44c73..0000000
--- a/hello
+++ b/hello
@@@ -1,2 -1,3 +1,4 @@@
  Hello World
 +Play, play, play
+ It's a new day for git
+ Work, work, work
------------

Then we realize that the "Play" line is not something we would
want in the merge result, because we are in serious business.
So let's drop it from the result and view the diff again:

------------
$ mv hello hellooo
$ sed -e '2d' <hellooo >hello
$ rm hellooo 
$ git diff
diff --cc hello
index ba42a2a,cc44c73..0000000
--- a/hello
+++ b/hello
------------

Oops, what happened?  There is no diff?

The default option "dense combined" (--cc) is stronger than
"combined" in that it omits hunks that have differences from
only one parent, and in this case we took "their" version, so
there is no interesting combined merge remaining to be seen.

If you want to view such not-so-interesting hunks, you could
give different option to "git diff", like so:

------------
$ git diff -c -p
diff --combined hello
index ba42a2a,cc44c73..0000000
--- a/hello
+++ b/hello
@@@ -1,2 -1,3 +1,3 @@@
  Hello World
- Play, play, play
+ It's a new day for git
+ Work, work, work
------------

Also we can use different options like '--ours' (view diff from
our branch) and '--theirs' (diff from their branch):

------------
$ git diff --ours hello
* Unmerged path hello
diff --git a/hello b/hello
index ba42a2a..cc44c73 100644
--- a/hello
+++ b/hello
@@ -1,2 +1,3 @@
 Hello World
-Play, play, play
+It's a new day for git
+Work, work, work
$ git diff --theirs hello
* Unmerged path hello
diff --git a/hello b/hello
------------
