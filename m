From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-format-patch-script and mailinfo updates.
Date: Fri, 22 Jul 2005 16:04:34 -0700
Message-ID: <7vackeigsd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 01:05:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw6ZQ-0001G7-5z
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 01:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVGVXEi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 19:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbVGVXEi
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 19:04:38 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:42468 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262217AbVGVXEg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 19:04:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050722230432.BDPN8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 19:04:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


 - avoid duplicating [PATCH] in the commit message body if the
   original commit has it already (happens for commits done from
   mails via applymbox).

 - check if the commit author is different from the one who is
   running the script, and emit an appropriate "From:" and
   "Date: " lines to the output.

 - with '--date', emit "Date: " line to preserve the original
   author date even for the user's own commit.

 - teach mailinfo to grok not just "From: " but "Date: ".

The patch e-mail output by format-patch starts with the first
line from the original commit message, prefixed with [PATCH],
and optionally a From: line if you are reformatting a patch
obtained from somebody else, a Date: line from the original
commit if (1) --date is specified or (2) for somebody else's
patch, and the rest of the commit message body.

Expected use of this is to move the title line from the commit
to Subject: when sending it via an e-mail, and leave the From:
and the Date: lines as the first lines of your message.

The mailinfo command has been changed to read Date: (in addition
to From: it already understands) and do sensible things when
running applymbox.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-format-patch-script |   38 +++++++++++++++++++++++++++++++-------
 tools/mailinfo.c        |   10 +++++++++-
 2 files changed, 40 insertions(+), 8 deletions(-)

70e9ebdaa9951183d2e4f9b569dafbc50012d8ec
diff --git a/git-format-patch-script b/git-format-patch-script
--- a/git-format-patch-script
+++ b/git-format-patch-script
@@ -30,6 +30,8 @@ outdir=./
 while case "$#" in 0) break;; esac
 do
     case "$1" in
+    -d|--d|--da|--dat|--date)
+    date=t ;;
     -n|--n|--nu|--num|--numb|--numbe|--number|--numbere|--numbered)
     numbered=t ;;
     -o=*|--o=*|--ou=*|--out=*|--outp=*|--outpu=*|--output=*|--output-=*|\
@@ -56,6 +58,8 @@ esac
 junio=`git-rev-parse --verify "$junio"`
 linus=`git-rev-parse --verify "$linus"`
 
+me=`git-var GIT_AUTHOR_IDENT | sed -e 's/>.*/>/'`
+
 case "$outdir" in
 */) ;;
 *) outdir="$outdir/" ;;
@@ -66,6 +70,7 @@ tmp=.tmp-series$$
 trap 'rm -f $tmp-*' 0 1 2 3 15
 
 series=$tmp-series
+commsg=$tmp-commsg
 
 titleScript='
 	/./d
@@ -82,6 +87,12 @@ titleScript='
 	q
 '
 
+whosepatchScript='
+/^author /{
+	s/author \(.*>\) \(.*\)$/au='\''\1'\'' ad='\''\2'\''/p
+	q
+}'
+
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 stripCommitHead='/^'"$_x40"' (from '"$_x40"')$/d'
@@ -91,9 +102,8 @@ total=`wc -l <$series`
 i=$total
 while read commit
 do
-    title=`git-cat-file commit "$commit" |
-    git-stripspace |
-    sed -ne "$titleScript"`
+    git-cat-file commit "$commit" | git-stripspace >$commsg
+    title=`sed -ne "$titleScript" <$commsg`
     case "$numbered" in
     '') num= ;;
     *)
@@ -102,6 +112,7 @@ do
 	*) num=' '`printf "%d/%d" $i $total` ;;
 	esac
     esac
+
     file=`printf '%04d-%stxt' $i "$title"`
     i=`expr "$i" - 1`
     echo "$file"
@@ -109,15 +120,28 @@ do
 	mailScript='
 	/./d
 	/^$/n
-	s|^|[PATCH'"$num"'] |
+	s|^\[PATCH[^]]*\] *||
+	s|^|[PATCH'"$num"'] |'
+
+	eval "$(sed -ne "$whosepatchScript" $commsg)"
+	test "$au" = "$me" || {
+		mailScript="$mailScript"'
+	a\
+From: '"$au"
+	}
+	test "$date,$au" = ",$me" || {
+		mailScript="$mailScript"'
+	a\
+Date: '"$ad"
+	}
+
+	mailScript="$mailScript"'
 	: body
 	p
 	n
 	b body'
 
-	git-cat-file commit "$commit" |
-	git-stripspace |
-	sed -ne "$mailScript"
+	sed -ne "$mailScript" <$commsg
 	echo '---'
 	echo
 	git-diff-tree -p $diff_opts "$commit" | git-apply --stat --summary
diff --git a/tools/mailinfo.c b/tools/mailinfo.c
--- a/tools/mailinfo.c
+++ b/tools/mailinfo.c
@@ -220,8 +220,9 @@ static int eatspace(char *line)
 static void handle_body(void)
 {
 	int has_from = 0;
+	int has_date = 0;
 
-	/* First line of body can be a From: */
+	/* First lines of body can have From: and Date: */
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		int len = eatspace(line);
 		if (!len)
@@ -232,6 +233,13 @@ static void handle_body(void)
 				continue;
 			}
 		}
+		if (!memcmp("Date:", line, 5) && isspace(line[5])) {
+			if (!has_date) {
+				handle_date(line+6);
+				has_date = 1;
+				continue;
+			}
+		}
 		line[len] = '\n';
 		handle_rest();
 		break;
