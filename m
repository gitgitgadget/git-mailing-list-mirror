From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Omit patches that have already been merged from format-patch output.
Date: Sun, 11 Sep 2005 13:32:41 -0700
Message-ID: <7voe6zqr9y.fsf@assigned-by-dhcp.cox.net>
References: <46a038f905091101529e045af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin.langhoff@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 11 22:34:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEYVg-0001dS-1S
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 22:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbVIKUco (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 16:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbVIKUco
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 16:32:44 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:58546 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750849AbVIKUcn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 16:32:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050911203243.FSKW17436.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Sep 2005 16:32:43 -0400
To: git@vger.kernel.org
In-Reply-To: <46a038f905091101529e045af@mail.gmail.com> (Martin Langhoff's
	message of "Sun, 11 Sep 2005 20:52:51 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8326>

This switches the logic to pick which commits to include in the output
from git-rev-list to git-cherry; as a side effect, 'format-patch ^up mine'
would stop working, although up..mine would continue to work.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Martin Langhoff <martin.langhoff@gmail.com> writes:

 > When I run git-format-patch, it insists on outputting merges that have
 > already been merged upstream, regardless of the fact that
 > git-merge-base knows better.
 >
 > Is there a way to get it to skip merged-in patches that git already
 > has detected as merged upstream?
 >
 > cheers,
 >
 > martin

 This is what the format-patch should have been from the beginning,
 although for hysterical raisins it was not the case (it predates
 git-cherry).  One thing I am reluctant about this is it breaks the
 exact example Johannes just posted.

 git-format-patch.sh |   38 +++++++++++++++++++++++++++-----------
 1 files changed, 27 insertions(+), 11 deletions(-)

9798f6dad84c9c3e39ed05c91d8e97fe4abc9222
diff --git a/git-format-patch.sh b/git-format-patch.sh
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -27,8 +27,6 @@ with applymbox.
 }
 
 diff_opts=
-IFS='
-'
 LF='
 '
 
@@ -61,7 +59,10 @@ do
     --output-directo|--output-director|--output-directory)
     case "$#" in 1) usage ;; esac; shift
     outdir="$1" ;;
-    -*)	diff_opts="$diff_opts$LF$1" ;;
+    -*' '* | -*"$LF"* | -*'	'*)
+	# Ignore diff option that has whitespace for now.
+	;;
+    -*)	diff_opts="$diff_opts$1 " ;;
     *) break ;;
     esac
     shift
@@ -72,16 +73,20 @@ tt)
 	die '--keep-subject and --numbered are incompatible.' ;;
 esac
 
-revpair=
+rev1= rev2=
 case "$#" in
 2)
-    revpair="$1..$2" ;;
+    rev1="$1" rev2="$2" ;;
 1)
     case "$1" in
     *..*)
-    	revpair="$1";;
+	rev1=`expr "$1" : '\(.*\)\.\.'`
+	rev2=`expr "$1" : '.*\.\.\(.*\)'`
+	;;
     *)
-	revpair="$1..HEAD";;
+        rev1="$1"
+	rev2="HEAD"
+	;;
     esac ;;
 *)
     usage ;;
@@ -127,10 +132,21 @@ _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 stripCommitHead='/^'"$_x40"' (from '"$_x40"')$/d'
 
-git-rev-list --no-merges --merge-order \
-	$(git-rev-parse --revs-only "$revpair") >$series
+git-cherry -v "$rev1" "$rev2" |
+while read sign rev comment
+do
+	case "$sign" in
+	'-')
+		echo >&2 "Merged already: $comment"
+		;;
+	*)
+		echo $rev
+		;;
+	esac
+done >$series
+
 total=`wc -l <$series | tr -dc "[0-9]"`
-i=$total
+i=1
 while read commit
 do
     git-cat-file commit "$commit" | git-stripspace >$commsg
@@ -145,7 +161,7 @@ do
     esac
 
     file=`printf '%04d-%stxt' $i "$title"`
-    i=`expr "$i" - 1`
+    i=`expr "$i" + 1`
     echo "* $file"
     {
 	mailScript='
