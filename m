From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Use git-merge in git-pull (second try).
Date: Fri, 23 Sep 2005 02:01:15 -0700
Message-ID: <7vr7bgdup0.fsf@assigned-by-dhcp.cox.net>
References: <E1EIWUv-0004HR-F6@jdl.com>
	<Pine.LNX.4.58.0509221413400.2553@g5.osdl.org>
	<Pine.LNX.4.58.0509221427520.2553@g5.osdl.org>
	<Pine.LNX.4.63.0509221747340.23242@iabervon.org>
	<Pine.LNX.4.58.0509221500150.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 11:02:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIjQm-0007Fz-BO
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 11:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVIWJBS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 05:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVIWJBS
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 05:01:18 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:12695 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750822AbVIWJBR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 05:01:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050923090117.QRAY1974.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Sep 2005 05:01:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9165>

This again makes git-pull to use git-merge, so that different merge
strategy can be specified from the command line.  Without explicit
strategy parameter, it defaults to git-merge-resolve if only one
remote is pulled, and git-merge-octopus otherwise, to keep the
default behaviour of the command the same as the original.

Also this brings another usability measure: -n flag from the command
line, if given, is passed to git-merge to prevent it from running the
diffstat at the end of the merge.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 I tested this at least once with a dirty working tree ;-).  The
 main difference from the one that was backed out is that only
 one strategy is used by default -- this is to avoid any
 'stashing away old states' done on the git-merge side.

 git-pull.sh |   48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 44 insertions(+), 4 deletions(-)

9c078a16523a2aae224a99e70f41eeb3d05a470c
diff --git a/git-pull.sh b/git-pull.sh
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -6,6 +6,38 @@
 
 . git-sh-setup || die "Not a git archive"
 
+usage () {
+    die "git pull [-n] [-s strategy]... <repo> <head>..."
+}
+
+strategy_args= no_summary=
+while case "$#,$1" in 0) break ;; *,-*) ;; *) break ;; esac
+do
+	case "$1" in
+	-n|--n|--no|--no-|--no-s|--no-su|--no-sum|--no-summ|\
+		--no-summa|--no-summar|--no-summary)
+		no_summary=-n ;;
+	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
+		--strateg=*|--strategy=*|\
+	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
+		case "$#,$1" in
+		*,*=*)
+			strategy=`expr "$1" : '-[^=]*=\(.*\)'` ;;
+		1,*)
+			usage ;;
+		*)
+			strategy="$2"
+			shift ;;
+		esac
+		strategy_args="${strategy_args}-s $strategy "
+		;;
+	-*)
+		usage
+		;;
+	esac
+	shift
+done
+
 orig_head=$(cat "$GIT_DIR/HEAD") || die "Pulling into a black hole?"
 git-fetch --update-head-ok "$@" || exit 1
 
@@ -31,11 +63,19 @@ case "$merge_head" in
 	echo >&2 "No changes."
 	exit 0
 	;;
-*' '?*)
-	echo >&2 "Pulling more than one heads; making an Octopus."
-	exec git-octopus
+?*' '?*)
+	strategy_default_args='-s octopus'
+	;;
+*)
+	strategy_default_args='-s resolve'
+	;;
+esac
+
+case "$strategy_args" in
+'')
+	strategy_args=$strategy_default_args
 	;;
 esac
 
 merge_name=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_HEAD")
-git-resolve "$(cat "$GIT_DIR"/HEAD)" $merge_head "$merge_name"
+git-merge $no_summary $strategy_args "$merge_name" HEAD $merge_head
