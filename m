From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-clone: fix handling of upsteram whose HEAD does not point at master.
Date: Sun, 02 Apr 2006 21:22:01 -0700
Message-ID: <7vvetrgufq.fsf@assigned-by-dhcp.cox.net>
References: <7vu09bimj9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 03 06:22:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQGZr-0007sZ-NU
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 06:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWDCEWE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 00:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWDCEWE
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 00:22:04 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:30922 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751244AbWDCEWD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Apr 2006 00:22:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060403042202.VWEW26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Apr 2006 00:22:02 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18311>

Junio C Hamano <junkio@cox.net> writes:

> When cloning from a remote repository that has master, main, and
> origin branches _and_ with the HEAD pointing at main branch, we
> did quite confused things during clone.  So this cleans things
> up.  The behaviour is a bit different between separate remotes/
> layout and the mixed branches layout.
>
> The newer layout with $GIT_DIR/refs/remotes/$origin/, things are
> simpler and more transparent:
>
>  - remote branches are copied to refs/remotes/$origin/.
>  - HEAD points at refs/heads/master, which starts at where the
>    remote HEAD points at.
>  - $GIT_DIR/remotes/$origin file is set up to fetch all remote
>    branches, and merge the branch HEAD pointed at at the time of
>    the cloning.

BTW, the behaviour under --use-separate-remote may be made more
consistent with the traditional layout case by using the same
branch name as the original repository even in that case.

On top of the previous patch, something like the attached one.
I'll put this in "next" and see how it goes, unless anybody
complains.

---

diff --git a/git-clone.sh b/git-clone.sh
index 9cc374e..c013e48 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -376,15 +376,11 @@ then
 	case "$head_points_at" in
 	?*)
 		mkdir -p "$GIT_DIR/remotes" &&
+		git-symbolic-ref HEAD "refs/heads/$head_points_at" &&
 		case "$use_separate_remote" in
-		# With separete-remote, our primary branch is always
-		# at 'master'
 		t)	origin_track="$remote_top/$head_points_at"
 			git-update-ref HEAD "$head_sha1" ;;
-		# Otherwise our primary branch is the same as the remote;
-		# we track upstream with $origin.
 		*)	origin_track="$remote_top/$origin"
-			git-symbolic-ref HEAD "refs/heads/$head_points_at"
 			git-update-ref "refs/heads/$origin" "$head_sha1" ;;
 		esac &&
 		echo >"$GIT_DIR/remotes/$origin" \
