From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Pass options to underlying git-rev-list from show-branches.
Date: Tue, 16 Aug 2005 22:34:10 -0700
Message-ID: <7vzmrh2kkt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Aug 17 07:35:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5GZj-0005cW-Qr
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 07:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbVHQFeN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 01:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbVHQFeN
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 01:34:13 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:13018 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750855AbVHQFeM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 01:34:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817053410.FQDF19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 Aug 2005 01:34:10 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This lets you say "git show-branches --max-count=30".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

    And this is how --symbolic is used to pick out the named rev
    parameters.

 git-show-branches-script |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

34ac753b1b26d52ac502ec6ca5c2eb021818cfaa
diff --git a/git-show-branches-script b/git-show-branches-script
--- a/git-show-branches-script
+++ b/git-show-branches-script
@@ -5,15 +5,23 @@
 
 . git-sh-setup-script || die "Not a git repository"
 
+usage () {
+    die "usage: $0 <ref>..."
+}
+
 headref=`readlink $GIT_DIR/HEAD`
-case "$#" in
-0)
-	set x `cd $GIT_DIR/refs &&
-	    find heads -type f -print |
-	    sed -e 's|heads/||' |
-	    sort`
+
+case "$(git-rev-parse --no-revs)" in '') ;; *) usage ;; esac
+revs=$(git-rev-parse --revs-only --symbolic --no-flags "$@")
+flags=$(git-rev-parse --revs-only --flags "$@")
+case "$revs" in
+'')
+	revs=$(git-rev-parse --symbolic --all | sed -ne 's|^refs/heads/||p' |
+	       sort)
 	shift ;;
 esac
+set x $revs
+shift
 
 hh= in=
 for ref
@@ -22,7 +30,7 @@ do
 	*/"$ref") H='*' ;;
 	*) H='!' ;;
 	esac
-	h=`git-rev-parse --verify "$ref^0"` || exit
+	h=`git-rev-parse --verify "$ref^0" 2>/dev/null` || continue
 	l=`git-log-script --max-count=1 --pretty=oneline "$h" |
 		sed -e 's/^[^ ]* //'`
 	hh="$hh $h"
@@ -32,7 +40,7 @@ done
 set x $hh
 shift
 
-git-rev-list --pretty=oneline "$@" |
+git-rev-list --pretty=oneline $flags $@ |
 while read v l
 do
 	in=''
