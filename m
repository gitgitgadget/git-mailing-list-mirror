From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Audit rev-parse users again.
Date: Wed, 24 Aug 2005 14:34:35 -0700
Message-ID: <7vll2rc93o.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0508231908170.3317@g5.osdl.org>
	<7v4q9fdv5w.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508241200500.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Aug 24 23:35:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E82tP-0004Vt-L8
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 23:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVHXVel (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 17:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVHXVel
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 17:34:41 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:38545 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932264AbVHXVek (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2005 17:34:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050824213436.VLDB17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 Aug 2005 17:34:36 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0508241200500.3317@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 24 Aug 2005 12:03:45 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7731>

Some callers to rev-parse were using the output selection flags
inconsistently.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-bisect-script       |    4 ++--
 git-branch-script       |    2 +-
 git-log-script          |    2 +-
 git-request-pull-script |    4 ++--
 git-revert-script       |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

ff84d327dfb8a9aa0634b0aaaca1c018cdc5117a
diff --git a/git-bisect-script b/git-bisect-script
--- a/git-bisect-script
+++ b/git-bisect-script
@@ -58,7 +58,7 @@ bisect_start() {
 bisect_bad() {
 	bisect_autostart
         case "$#" in 0 | 1) ;; *) usage ;; esac
-	rev=$(git-rev-parse --revs-only --verify --default HEAD "$@") || exit
+	rev=$(git-rev-parse --verify --default HEAD "$@") || exit
 	echo "$rev" > "$GIT_DIR/refs/bisect/bad"
 	bisect_auto_next
 }
@@ -67,7 +67,7 @@ bisect_good() {
 	bisect_autostart
         case "$#" in
 	0)    revs=$(git-rev-parse --verify HEAD) || exit ;;
-	*)    revs=$(git-rev-parse --revs-only "$@") || exit ;;
+	*)    revs=$(git-rev-parse --revs-only --no-flags "$@") || exit ;;
 	esac
 	for rev in $revs
 	do
diff --git a/git-branch-script b/git-branch-script
--- a/git-branch-script
+++ b/git-branch-script
@@ -25,7 +25,7 @@ case "$#" in
 	head="$2^0" ;;
 esac
 branchname="$1"
-rev=$(git-rev-parse --revs-only --verify "$head") || exit
+rev=$(git-rev-parse --verify "$head") || exit
 
 [ -e "$GIT_DIR/refs/heads/$branchname" ] && die "$branchname already exists"
 
diff --git a/git-log-script b/git-log-script
--- a/git-log-script
+++ b/git-log-script
@@ -1,4 +1,4 @@
 #!/bin/sh
-revs=$(git-rev-parse --revs-only --default HEAD "$@") || exit
+revs=$(git-rev-parse --revs-only --no-flags --default HEAD "$@") || exit
 [ "$revs" ] || die "No HEAD ref"
 git-rev-list --pretty $(git-rev-parse --default HEAD "$@") | LESS=-S ${PAGER:-less}
diff --git a/git-request-pull-script b/git-request-pull-script
--- a/git-request-pull-script
+++ b/git-request-pull-script
@@ -19,8 +19,8 @@ head=${3-HEAD}
 [ "$revision" ] || usage
 [ "$url" ] || usage
 
-baserev=`git-rev-parse --verify $revision^0` &&
-headrev=`git-rev-parse --verify $head^0` || exit
+baserev=`git-rev-parse --verify "$revision"^0` &&
+headrev=`git-rev-parse --verify "$head"^0` || exit
 
 echo "The following changes since commit $baserev:"
 git log --max-count=1 --pretty=short "$baserev" |
diff --git a/git-revert-script b/git-revert-script
--- a/git-revert-script
+++ b/git-revert-script
@@ -10,7 +10,7 @@ case "$status" in
 	die "Your working tree is dirty; cannot revert a previous patch." ;;
 esac
 
-rev=$(git-rev-parse --no-flags --verify --revs-only "$@") &&
+rev=$(git-rev-parse --verify "$@") &&
 commit=$(git-rev-parse --verify "$rev^0") || exit
 if git-diff-tree -R -M -p $commit | git-apply --index &&
    msg=$(git-rev-list --pretty=oneline --max-count=1 $commit)
