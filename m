From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] "test" in Solaris' /bin/sh does not support -e
Date: Mon, 26 Jun 2006 02:19:42 -0700
Message-ID: <7vwtb4i89d.fsf@assigned-by-dhcp.cox.net>
References: <20060625014703.29304.12715.stgit@machine.or.cz>
	<7vk676orjy.fsf@assigned-by-dhcp.cox.net>
	<20060626082428.G52c9608e@leonov.stosberg.net>
	<20060626082754.G6ec0a61e@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 11:19:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FunFz-0003B2-DV
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 11:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWFZJTo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 05:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWFZJTn
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 05:19:43 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:32151 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751310AbWFZJTn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 05:19:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060626091942.RMHI19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Jun 2006 05:19:42 -0400
To: Dennis Stosberg <dennis@stosberg.net>
In-Reply-To: <20060626082754.G6ec0a61e@leonov.stosberg.net> (Dennis Stosberg's
	message of "Mon, 26 Jun 2006 10:27:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22667>

Dennis Stosberg <dennis@stosberg.net> writes:

> Running "make clean" currently fails:
>   [ ! -e perl/Makefile ] || make -C perl/ clean
>   /bin/sh: test: argument expected
>   make: *** [clean] Error 1

Ah, _BAD_.  We seem to have the same in git-branch, git-checkout,
git-clone and git-tag.  You would probably need this on top of
"master".

-- >8 --
shell scripts: Avoid non-portable "test -e" where possible.

---
diff --git a/git-branch.sh b/git-branch.sh
index e0501ec..76971be 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -112,7 +112,7 @@ rev=$(git-rev-parse --verify "$head") ||
 git-check-ref-format "heads/$branchname" ||
 	die "we do not like '$branchname' as a branch name."
 
-if [ -e "$GIT_DIR/refs/heads/$branchname" ]
+if test -f "$GIT_DIR/refs/heads/$branchname"
 then
 	if test '' = "$force"
 	then
@@ -124,7 +124,7 @@ then
 fi
 if test "$create_log" = 'yes'
 then
-	mkdir -p $(dirname "$GIT_DIR/logs/refs/heads/$branchname")
+	mkdir -p "$(dirname "$GIT_DIR/logs/refs/heads/$branchname")"
 	touch "$GIT_DIR/logs/refs/heads/$branchname"
 fi
 git update-ref -m "branch: Created from $head" "refs/heads/$branchname" $rev
diff --git a/git-checkout.sh b/git-checkout.sh
index 77c2593..bfc2640 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -22,7 +22,7 @@ while [ "$#" != "0" ]; do
 		shift
 		[ -z "$newbranch" ] &&
 			die "git checkout: -b needs a branch name"
-		[ -e "$GIT_DIR/refs/heads/$newbranch" ] &&
+		[ -f "$GIT_DIR/refs/heads/$newbranch" ] &&
 			die "git checkout: branch $newbranch already exists"
 		git-check-ref-format "heads/$newbranch" ||
 			die "git checkout: we do not like '$newbranch' as a branch name."
diff --git a/git-clone.sh b/git-clone.sh
index 6fa0daa..b355441 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -202,7 +202,7 @@ fi
 dir="$2"
 # Try using "humanish" part of source repo if user didn't specify one
 [ -z "$dir" ] && dir=$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
-[ -e "$dir" ] && echo "$dir already exists." && usage
+[ -d "$dir" ] && echo "$dir already exists." && usage
 mkdir -p "$dir" &&
 D=$(cd "$dir" && pwd) &&
 trap 'err=$?; cd ..; rm -r "$D"; exit $err' 0
diff --git a/git-tag.sh b/git-tag.sh
index a0afa25..6118b00 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -63,7 +63,7 @@ done
 
 name="$1"
 [ "$name" ] || usage
-if [ -e "$GIT_DIR/refs/tags/$name" -a -z "$force" ]; then
+if [ -f "$GIT_DIR/refs/tags/$name" -a -z "$force" ]; then
     die "tag '$name' already exists"
 fi
 shift
