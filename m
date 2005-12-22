From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-clone-pack: do not silently overwrite an existing
 branch 'origin'
Date: Thu, 22 Dec 2005 23:37:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512222325330.12241@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0512221859110.20025@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vu0d0hm53.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 23:37:38 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpZ40-0008Nu-99
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 23:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbVLVWh0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 17:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbVLVWh0
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 17:37:26 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:3518 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964987AbVLVWhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 17:37:25 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5D6F313F977; Thu, 22 Dec 2005 23:37:24 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 453949E3DF; Thu, 22 Dec 2005 23:37:24 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2DDA69E231; Thu, 22 Dec 2005 23:37:24 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1693413F977; Thu, 22 Dec 2005 23:37:24 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0d0hm53.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13976>

Hi,

On Thu, 22 Dec 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When cloning a repository which already contains a branch called 'origin',
> > do not silently overwrite it with the remote 'master' ref.
> 
> If we consider the "origin is special and is used to track
> upstream" convention pretty much ingrained, then unconditionally
> overwriting origin without saying anything is the right
> approach.  After all, you do not care what upstream your
> upstream is keeping track of, and you would want to use 'origin'
> for the usual purpose of keeping track of upstream.

As I said, I use git to keep track of a few CVS projects. I like to fetch 
all branches, one being the upstream branch, so that I can compare what 
changes not yet in upstream.

> I have a mild aversion to this change, though.

So don't.

> I'd much prefer the third approach I am too lazy to code, which lets you 
> say what local branch name instead of 'origin' to keep track of upstream 
> from 'git clone' command line.

---

[PATCH] git-clone: Support changing the origin branch with -o

Earlier, git-clone stored upstream's master in the branch named 'origin',
possibly overwriting an existing such branch.

Now you can change it by calling git-clone with '-o <other_name>'.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Totally untested, but obviously correct :-)

	It still overwrites any existing ref of the same name silently.

 git-clone.sh |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 280cc2e..87ad477 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -67,6 +67,7 @@ use_local=no
 local_shared=no
 no_checkout=
 upload_pack=
+origin=origin
 while
 	case "$#,$1" in
 	0,*) break ;;
@@ -75,6 +76,8 @@ while
         *,-s|*,--s|*,--sh|*,--sha|*,--shar|*,--share|*,--shared) 
           local_shared=yes; use_local=yes ;;
 	*,-q|*,--quiet) quiet=-q ;;
+	1,-o) usage;;
+	*,-o) origin="$2"; shift;;
 	1,-u|1,--upload-pack) usage ;;
 	*,-u|*,--upload-pack)
 		shift
@@ -208,14 +211,14 @@ then
 		mkdir -p .git/remotes &&
 		echo >.git/remotes/origin \
 		"URL: $repo
-Pull: $head_points_at:origin" &&
-		cp ".git/refs/heads/$head_points_at" .git/refs/heads/origin &&
+Pull: $head_points_at:$origin" &&
+		cp ".git/refs/heads/$head_points_at" .git/refs/heads/$origin &&
 		find .git/refs/heads -type f -print |
 		while read ref
 		do
 			head=`expr "$ref" : '.git/refs/heads/\(.*\)'` &&
 			test "$head_points_at" = "$head" ||
-			test "origin" = "$head" ||
+			test "$origin" = "$head" ||
 			echo "Pull: ${head}:${head}"
 		done >>.git/remotes/origin
 	esac
