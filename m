From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Set up remotes/origin to track all remote branches.
Date: Sun, 06 Nov 2005 01:23:53 -0800
Message-ID: <7v1x1u1652.fsf@assigned-by-dhcp.cox.net>
References: <E1EXpN9-00034x-7g@jdl.com>
	<7vy8453zhu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511041745480.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Nov 06 10:25:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYgl4-0003Gv-0z
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 10:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVKFJXz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 04:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbVKFJXz
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 04:23:55 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:63134 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932338AbVKFJXz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 04:23:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051106092310.XGEV29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Nov 2005 04:23:10 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11199>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Thu, 3 Nov 2005, Junio C Hamano wrote:
>
>> My "guinea pig" repository has this in $GIT_DIR/remotes/origin:
>> 
>>         URL: git://git.kernel.org/pub/scm/git/git.git
>>         Pull: master:origin
>>         Pull: +pu:pu
>>         Pull: maint:maint
>
> Shouldn't approximately this be what git-clone sets up for you? If it's 
> getting those heads initially, it should keep the information for future 
> use. The only thing it wouldn't know would be the "+" on pu.

I think this makes sense, and especially so, once we later
change the default behaviour of 'git clone' to clone but rename
the remote refs to somewhere else.

-- >8 -- cut here -- >8 --

This implements the idea Daniel Barkalow came up with, to match
the remotes/origin created by clone by default to the workflow I
use myself in my guinea pig repository, to have me eat my own
dog food.

We probably would want to use either .git/refs/local/heads/*
(idea by Linus) or .git/refs/heads/origin/* instead to reduce
the local ref namespace pollution.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Documentation/git-clone.txt |    3 ++-
 git-clone.sh                |   12 ++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

applies-to: 9cc3928769f8f4e3597fa446321112c0568514df
a0b45ee2b1362d664cca2d81f2915ed3b903b252
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index cbd83f3..fefd298 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -25,7 +25,8 @@ This is to help the typical workflow of 
 remote `master` branch.  Every time `git pull` without argument
 is run, the progress on the remote `master` branch is tracked by
 copying it into the local `origin` branch, and merged into the
-branch you are currently working on.
+branch you are currently working on.  Remote branches other than
+`master` are also added there to be tracked.
 
 
 OPTIONS
diff --git a/git-clone.sh b/git-clone.sh
index 1adf604..4fdd652 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -202,8 +202,16 @@ then
 		mkdir -p .git/remotes &&
 		echo >.git/remotes/origin \
 		"URL: $repo
-Pull: $head_points_at:origin"
-		cp ".git/refs/heads/$head_points_at" .git/refs/heads/origin
+Pull: $head_points_at:origin" &&
+		cp ".git/refs/heads/$head_points_at" .git/refs/heads/origin &&
+		find .git/refs/heads -type f -print |
+		while read ref
+		do
+			head=`expr "$ref" : '.git/refs/heads/\(.*\)'` &&
+			test "$head_points_at" = "$head" ||
+			test "origin" = "$head" ||
+			echo "Pull: ${head}:${head}"
+		done >>.git/remotes/origin
 	esac
 
 	case "$no_checkout" in
---
0.99.9.GIT
