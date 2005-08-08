From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Teach format-patch, rebase and cherry a..b format
Date: Sun, 07 Aug 2005 23:09:52 -0700
Message-ID: <7vpsspgdsf.fsf@assigned-by-dhcp.cox.net>
References: <20050807205342.8497.qmail@web26304.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Mon Aug 08 08:11:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E20qj-0005EV-T0
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 08:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVHHGJz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 02:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVHHGJz
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 02:09:55 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:55192 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750734AbVHHGJy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 02:09:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050808060955.YFHK7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 02:09:55 -0400
To: git@vger.kernel.org
In-Reply-To: <20050807205342.8497.qmail@web26304.mail.ukl.yahoo.com> (Marco
	Costalba's message of "Sun, 7 Aug 2005 13:53:42 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Although these commands take only begin and end, not necessarily
generic SHA1 expressions rev-parse supports, supporting a..b
notation is good for consistency.  This commit adds such without
breaking backward compatibility.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Unlike the outline I suggested in an earlier message, this adds
support for only a single parameter "a..b" format, while
retaining the original code which takes two parameters.  Meant
to be fully backward compatible not to break qgit and friends.

 git-cherry              |   25 +++++++++++++++++--------
 git-format-patch-script |   21 +++++++++++++++------
 git-rebase-script       |   23 +++++++++++++++--------
 3 files changed, 47 insertions(+), 22 deletions(-)

c67e91fad243565423b08a55f63947bd3e36c5a3
diff --git a/git-cherry b/git-cherry
--- a/git-cherry
+++ b/git-cherry
@@ -3,6 +3,8 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
+. git-sh-setup-script || die "Not a git archive."
+
 usage="usage: $0 "'<upstream> [<head>]
 
              __*__*__*__*__> <upstream>
@@ -18,8 +20,8 @@ upstream, it is shown on the standard ou
 The output is intended to be used as:
 
     OLD_HEAD=$(git-rev-parse HEAD)
-    git-rev-parse linus >${GIT_DIR-.}/HEAD
-    git-cherry linus OLD_HEAD |
+    git-rev-parse upstream >${GIT_DIR-.}/HEAD
+    git-cherry upstream $OLD_HEAD |
     while read commit
     do
         GIT_EXTERNAL_DIFF=git-apply-patch-script git-diff-tree -p "$commit" &&
@@ -27,20 +29,27 @@ The output is intended to be used as:
     done
 '
 
+case "$#,$1" in
+1,*..*)
+    upstream=$(expr "$1" : '\(.*\)\.\.') ours=$(expr "$1" : '.*\.\.\(.*\)$')
+    set x "$upstream" "$ours"
+    shift ;;
+esac
+
 case "$#" in
-1) linus=`git-rev-parse --verify "$1"` &&
-   junio=`git-rev-parse --verify HEAD` || exit
+1) upstream=`git-rev-parse --verify "$1"` &&
+   ours=`git-rev-parse --verify HEAD` || exit
    ;;
-2) linus=`git-rev-parse --verify "$1"` &&
-   junio=`git-rev-parse --verify "$2"` || exit
+2) upstream=`git-rev-parse --verify "$1"` &&
+   ours=`git-rev-parse --verify "$2"` || exit
    ;;
 *) echo >&2 "$usage"; exit 1 ;;
 esac
 
 # Note that these list commits in reverse order;
 # not that the order in inup matters...
-inup=`git-rev-list ^$junio $linus` &&
-ours=`git-rev-list $junio ^$linus` || exit
+inup=`git-rev-list ^$ours $upstream` &&
+ours=`git-rev-list $ours ^$upstream` || exit
 
 tmp=.cherry-tmp$$
 patch=$tmp-patch
diff --git a/git-format-patch-script b/git-format-patch-script
--- a/git-format-patch-script
+++ b/git-format-patch-script
@@ -3,6 +3,8 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
+. git-sh-setup-script || die "Not a git archive."
+
 usage () {
     echo >&2 "usage: $0"' [-n] [-o dir] [--mbox] [--check] [-<diff options>...] upstream [ our-head ]
 
@@ -60,13 +62,20 @@ do
     shift
 done
 
+revpair=
 case "$#" in
-2)    linus="$1" junio="$2" ;;
-1)    linus="$1" junio=HEAD ;;
-*)    usage ;;
+2)
+    revpair="$1..$2" ;;
+1)
+    case "$1" in
+    *..*)
+    	revpair="$1";;
+    *)
+	revpair="$1..HEAD";;
+    esac ;;
+*)
+    usage ;;
 esac
-junio=`git-rev-parse --verify "$junio"`
-linus=`git-rev-parse --verify "$linus"`
 
 me=`git-var GIT_AUTHOR_IDENT | sed -e 's/>.*/>/'`
 
@@ -108,7 +117,7 @@ _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 stripCommitHead='/^'"$_x40"' (from '"$_x40"')$/d'
 
-git-rev-list --merge-order "$junio" "^$linus" >$series
+git-rev-list --merge-order $(git-rev-parse --revs-only "$revpair") >$series
 total=`wc -l <$series | tr -dc "[0-9]"`
 i=$total
 while read commit
diff --git a/git-rebase-script b/git-rebase-script
--- a/git-rebase-script
+++ b/git-rebase-script
@@ -3,25 +3,32 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
+. git-sh-setup-script || die "Not a git archive."
+
 usage="usage: $0 "'<upstream> [<head>]
 
 Uses output from git-cherry to rebase local commits to the new head of
 upstream tree.'
 
-: ${GIT_DIR=.git}
+case "$#,$1" in
+1,*..*)
+    upstream=$(expr "$1" : '\(.*\)\.\.') ours=$(expr "$1" : '.*\.\.\(.*\)$')
+    set x "$upstream" "$ours"
+    shift ;;
+esac
 
 case "$#" in
-1) linus=`git-rev-parse --verify "$1"` &&
-   junio=`git-rev-parse --verify HEAD` || exit
+1) upstream=`git-rev-parse --verify "$1"` &&
+   ours=`git-rev-parse --verify HEAD` || exit
    ;;
-2) linus=`git-rev-parse --verify "$1"` &&
-   junio=`git-rev-parse --verify "$2"` || exit
+2) upstream=`git-rev-parse --verify "$1"` &&
+   ours=`git-rev-parse --verify "$2"` || exit
    ;;
 *) echo >&2 "$usage"; exit 1 ;;
 esac
 
-git-read-tree -m -u $junio $linus &&
-echo "$linus" >"$GIT_DIR/HEAD" || exit
+git-read-tree -m -u $ours $upstream &&
+echo "$upstream" >"$GIT_DIR/HEAD" || exit
 
 tmp=.rebase-tmp$$
 fail=$tmp-fail
@@ -29,7 +36,7 @@ trap "rm -rf $tmp-*" 0 1 2 3 15
 
 >$fail
 
-git-cherry $linus $junio |
+git-cherry $upstream $ours |
 while read sign commit
 do
 	case "$sign" in
