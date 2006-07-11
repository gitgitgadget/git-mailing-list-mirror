From: Shawn Pearce <spearce@spearce.org>
Subject: Re: reflog doesn't note that commit was --amend-ed, and doesn't record pulls
Date: Mon, 10 Jul 2006 23:38:35 -0400
Message-ID: <20060711033835.GA11332@spearce.org>
References: <e8uele$o7t$2@sea.gmane.org> <e8uhvg$5o1$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 05:38:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G095A-0008NY-6j
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 05:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbWGKDil (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 23:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbWGKDil
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 23:38:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53173 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965099AbWGKDik (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 23:38:40 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G094s-0007uY-22; Mon, 10 Jul 2006 23:38:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 693D620E43C; Mon, 10 Jul 2006 23:38:36 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e8uhvg$5o1$2@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23684>

Jakub Narebski <jnareb@gmail.com> wrote:
> Reflog doesn't seem also to record pulls (e.g. master branch): pulls has
> empty reflog message part.

Fixed with the patch below.  git-merge doesn't record the merges yet,
so some changes made by git-pull still aren't logged as nicely as
one would like.  But don't fear, that will be coming soon.  :-)

-->--
Log ref changes made by git-fetch and git-pull.

When git-fetch updates a reference record in the associated reflog
what type of update took place and who caused it (git-fetch or
git-pull, by invoking git-fetch).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-fetch.sh |   20 +++++++++++++++-----
 git-pull.sh  |    2 +-
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index 48818f8..5e4c4d6 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -11,6 +11,7 @@ LF='
 '
 IFS="$LF"
 
+rloga=fetch
 no_tags=
 tags=
 append=
@@ -51,6 +52,9 @@ do
 	-k|--k|--ke|--kee|--keep)
 		keep=--keep
 		;;
+	--reflog-action=*)
+		rloga=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		;;
 	-*)
 		usage
 		;;
@@ -75,6 +79,9 @@ refs=
 rref=
 rsync_slurped_objects=
 
+rloga="$rloga $remote_nick"
+test "$remote_nick" == "$remote" || rloga="$rloga $remote"
+
 if test "" = "$append"
 then
 	: >"$GIT_DIR/FETCH_HEAD"
@@ -149,11 +156,12 @@ fast_forward_local () {
 			[ "$verbose" ] && echo >&2 "* $1: same as $3"
 		else
 			echo >&2 "* $1: updating with $3"
+			git-update-ref -m "$rloga: updating tag" "$1" "$2"
 		fi
 	else
 		echo >&2 "* $1: storing $3"
+		git-update-ref -m "$rloga: storing tag" "$1" "$2"
 	fi
-	git-update-ref "$1" "$2"
 	;;
 
     refs/heads/* | refs/remotes/*)
@@ -174,7 +182,7 @@ fast_forward_local () {
 	    *,$local)
 		echo >&2 "* $1: fast forward to $3"
 		echo >&2 "  from $local to $2"
-		git-update-ref "$1" "$2" "$local"
+		git-update-ref -m "$rloga: fast-forward" "$1" "$2" "$local"
 		;;
 	    *)
 		false
@@ -184,7 +192,7 @@ fast_forward_local () {
 		case ",$force,$single_force," in
 		*,t,*)
 			echo >&2 "  forcing update."
-			git-update-ref "$1" "$2" "$local"
+			git-update-ref -m "$rloga: forced-update" "$1" "$2" "$local"
 			;;
 		*)
 			echo >&2 "  not updating."
@@ -194,7 +202,7 @@ fast_forward_local () {
 	    }
 	else
 	    echo >&2 "* $1: storing $3"
-	    git-update-ref "$1" "$2"
+	    git-update-ref -m "$rloga: storing head" "$1" "$2"
 	fi
 	;;
     esac
@@ -422,7 +430,9 @@ case ",$update_head_ok,$orig_head," in
 	curr_head=$(git-rev-parse --verify HEAD 2>/dev/null)
 	if test "$curr_head" != "$orig_head"
 	then
-	    	git-update-ref HEAD "$orig_head"
+	    git-update-ref \
+			-m "$rloga: Undoing incorrectly fetched HEAD." \
+			HEAD "$orig_head"
 		die "Cannot fetch into the current branch."
 	fi
 	;;
diff --git a/git-pull.sh b/git-pull.sh
index 076785c..d337bf4 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -45,7 +45,7 @@ do
 done
 
 orig_head=$(git-rev-parse --verify HEAD) || die "Pulling into a black hole?"
-git-fetch --update-head-ok "$@" || exit 1
+git-fetch --update-head-ok --reflog-action=pull "$@" || exit 1
 
 curr_head=$(git-rev-parse --verify HEAD)
 if test "$curr_head" != "$orig_head"
-- 
1.4.1.gc48f
