From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] format-patch: fix skipping of blank-lines (take 2)
Date: Fri, 08 Jul 2005 19:27:15 -0700
Message-ID: <7vhdf43e9o.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vu0j44xi4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507081838560.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 04:28:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dr54b-0004UO-UY
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 04:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263083AbVGIC16 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 22:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbVGIC16
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 22:27:58 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:2967 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S263084AbVGIC1m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2005 22:27:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050709022716.DUEY22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 8 Jul 2005 22:27:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507081838560.17536@g5.osdl.org> (Linus Torvalds's message of "Fri, 8 Jul 2005 18:42:26 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

If it is fed a commit with more than one leading blank lines,
the sed scripts git-format-patch-script used looped forever.
Using git-stripspace upfront makes the sed script somewhat
simpler to work around this problem.

Also use git-rev-parse so that we can say

    $ git-format-patch-script HEAD^^^^

to prepare the latest four patches for e-mail submission.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 >>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

 LT> How about using "git-stripspace"?

 I first thought it would be an overkill, but it lets me cheat in
 the sed script.  Thanks for the suggestion.

 git-format-patch-script |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

3006f6c35d08a0f060e021573771b3cfc70c0682
diff --git a/git-format-patch-script b/git-format-patch-script
--- a/git-format-patch-script
+++ b/git-format-patch-script
@@ -53,6 +53,8 @@ case "$#" in
 1)    linus="$1" junio=HEAD ;;
 *)    usage ;;
 esac
+junio=`git-rev-parse --verify "$junio"`
+linus=`git-rev-parse --verify "$linus"`
 
 case "$outdir" in
 */) ;;
@@ -66,9 +68,9 @@ trap 'rm -f $tmp-*' 0 1 2 3 15
 series=$tmp-series
 
 titleScript='
-	1,/^$/d
-	: loop
-	/^$/b loop
+	/./d
+	/^$/n
+	s/^\[PATCH[^]]*\] *//
 	s/[^-a-z.A-Z_0-9]/-/g
         s/\.\.\.*/\./g
 	s/\.*$//
@@ -76,6 +78,7 @@ titleScript='
 	s/^-//
 	s/-$//
 	s/$/./
+	p
 	q
 '
 
@@ -88,7 +91,9 @@ total=`wc -l <$series`
 i=$total
 while read commit
 do
-    title=`git-cat-file commit "$commit" | sed -e "$titleScript"`
+    title=`git-cat-file commit "$commit" |
+    git-stripspace |
+    sed -ne "$titleScript"`
     case "$numbered" in
     '') num= ;;
     *)
@@ -102,16 +107,17 @@ do
     echo "$file"
     {
 	mailScript='
-	1,/^$/d
-	: loop
-	/^$/b loop
+	/./d
+	/^$/n
 	s|^|[PATCH'"$num"'] |
 	: body
 	p
 	n
 	b body'
 
-	git-cat-file commit "$commit" | sed -ne "$mailScript"
+	git-cat-file commit "$commit" |
+	git-stripspace |
+	sed -ne "$mailScript"
 	echo '---'
 	echo
 	git-diff-tree -p $diff_opts "$commit" | git-apply --stat --summary
