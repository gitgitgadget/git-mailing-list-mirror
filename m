From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-clone-pack: do not silently overwrite an existing branch 'origin'
Date: Thu, 22 Dec 2005 13:12:08 -0800
Message-ID: <7vu0d0hm53.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512221859110.20025@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Dec 22 22:12:24 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpXjS-0004L8-GO
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 22:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbVLVVML (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 16:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbVLVVML
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 16:12:11 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:52975 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965179AbVLVVMK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 16:12:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051222211118.DZYT20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Dec 2005 16:11:18 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512221859110.20025@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 22 Dec 2005 18:59:30 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13972>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When cloning a repository which already contains a branch called 'origin',
> do not silently overwrite it with the remote 'master' ref.

If we consider the "origin is special and is used to track
upstream" convention pretty much ingrained, then unconditionally
overwriting origin without saying anything is the right
approach.  After all, you do not care what upstream your
upstream is keeping track of, and you would want to use 'origin'
for the usual purpose of keeping track of upstream.

Otherwise, if we do not treat "origin" specially, we could
do something like this.  If "origin" exists, then we do not
overwrite upon clone, nor subsequent fetch.

I have a mild aversion to this change, though.  I'd much prefer
the third approach I am too lazy to code, which lets you say
what local branch name instead of 'origin' to keep track of
upstream from 'git clone' command line.

---

diff --git a/git-clone.sh b/git-clone.sh
index 280cc2e..edebee7 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -206,17 +206,22 @@ then
 	refs/heads/*)
 		head_points_at=`expr "$head_points_at" : 'refs/heads/\(.*\)'`
 		mkdir -p .git/remotes &&
-		echo >.git/remotes/origin \
-		"URL: $repo
-Pull: $head_points_at:origin" &&
-		cp ".git/refs/heads/$head_points_at" .git/refs/heads/origin &&
+		echo "URL: $repo" >.git/remotes/origin &&
+		if test -f ".git/refs/heads/origin"
+		then
+		    echo "Pull: $head_points_at:"
+		else
+		    echo "Pull: $head_points_at:origin"
+		    cp ".git/refs/heads/$head_points_at" \
+		        .git/refs/heads/origin &&
+		fi >>.git/remotes/origin &&
 		find .git/refs/heads -type f -print |
 		while read ref
 		do
-			head=`expr "$ref" : '.git/refs/heads/\(.*\)'` &&
-			test "$head_points_at" = "$head" ||
-			test "origin" = "$head" ||
-			echo "Pull: ${head}:${head}"
+		    head=`expr "$ref" : '.git/refs/heads/\(.*\)'` &&
+		    test "$head_points_at" = "$head" ||
+		    test "origin" = "$head" ||
+		    echo "Pull: ${head}:${head}"
 		done >>.git/remotes/origin
 	esac
 
