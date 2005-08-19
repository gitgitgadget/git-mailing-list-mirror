From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add hooks to tools/git-applypatch.
Date: Fri, 19 Aug 2005 14:41:50 -0700
Message-ID: <7v4q9lvc2p.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050816214707.6842.qmail@web26302.mail.ukl.yahoo.com>
	<7vek8t7bva.fsf@assigned-by-dhcp.cox.net>
	<7vk6il2jz8.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508170830050.3553@g5.osdl.org>
	<20050818172646.GA18459@mars.ravnborg.org>
	<Pine.LNX.4.58.0508181257320.3412@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Aug 19 23:43:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6Ece-0002ZX-Bb
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 23:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbVHSVlw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 17:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbVHSVlw
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 17:41:52 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:30699 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965128AbVHSVlv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 17:41:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050819214151.IEMV8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 19 Aug 2005 17:41:51 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0508181257320.3412@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 18 Aug 2005 13:07:41 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This teachs git-applypatch, which is used from git-applymbox, three
hooks, similar to what git-commit-script uses.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

    This is still in the proposed updates branch, along with the
    hooks for "git commit".  Are people comfortable with the
    three-hook arrangements these two commands use?

 templates/hooks--applypatch-msg |   14 ++++++
 templates/hooks--pre-applypatch |   14 ++++++
 tools/git-applypatch            |   87 +++++++++++++++++++++++++++++++--------
 3 files changed, 97 insertions(+), 18 deletions(-)
 create mode 100644 templates/hooks--applypatch-msg
 create mode 100644 templates/hooks--pre-applypatch

b5df0d94bf045627e74cf7faef3f51ce5e567aa4
diff --git a/templates/hooks--applypatch-msg b/templates/hooks--applypatch-msg
new file mode 100644
--- /dev/null
+++ b/templates/hooks--applypatch-msg
@@ -0,0 +1,14 @@
+#!/bin/sh
+#
+# An example hook script to check the commit log message taken by
+# applypatch from an e-mail message.
+#
+# The hook should exit with non-zero status after issuing an
+# appropriate message if it wants to stop the commit.  The hook is
+# allowed to edit the commit message file.
+#
+# To enable this hook, make this file executable.
+
+test -x "$GIT_DIR/hooks/commit-msg" &&
+	exec "$GIT_DIR/hooks/commit-msg" ${1+"$@"}
+:
diff --git a/templates/hooks--pre-applypatch b/templates/hooks--pre-applypatch
new file mode 100644
--- /dev/null
+++ b/templates/hooks--pre-applypatch
@@ -0,0 +1,14 @@
+#!/bin/sh
+#
+# An example hook script to verify what is about to be committed
+# by applypatch from an e-mail message.
+#
+# The hook should exit with non-zero status after issuing an
+# appropriate message if it wants to stop the commit.
+#
+# To enable this hook, make this file executable.
+
+test -x "$GIT_DIR/hooks/pre-commit" &&
+	exec "$GIT_DIR/hooks/pre-commit" ${1+"$@"}
+:
+
diff --git a/tools/git-applypatch b/tools/git-applypatch
--- a/tools/git-applypatch
+++ b/tools/git-applypatch
@@ -10,58 +10,109 @@
 ##	$3 - "info" file with Author, email and subject
 ##	$4 - optional file containing signoff to add
 ##
-signoff="$4"
+. git-sh-setup-script || die "Not a git archive."
+
 final=.dotest/final-commit
 ##
 ## If this file exists, we ask before applying
 ##
 query_apply=.dotest/.query_apply
+
+## We do not munge the first line of the commit message too much
+## if this file exists.
 keep_subject=.dotest/.keep_subject
+
+
 MSGFILE=$1
 PATCHFILE=$2
 INFO=$3
-EDIT=${VISUAL:-$EDITOR}
-EDIT=${EDIT:-vi}
+SIGNOFF=$4
+EDIT=${VISUAL:-${EDITOR:-vi}}
 
 export GIT_AUTHOR_NAME="$(sed -n '/^Author/ s/Author: //p' .dotest/info)"
 export GIT_AUTHOR_EMAIL="$(sed -n '/^Email/ s/Email: //p' .dotest/info)"
 export GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' .dotest/info)"
 export SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' .dotest/info)"
 
-if [ -n "$signoff" -a -f "$signoff" ]; then
-	cat $signoff >> $MSGFILE
+if test '' != "$SIGNOFF"
+then
+	if test -f "$SIGNOFF"
+	then
+		SIGNOFF=`cat "$SIGNOFF"` || exit
+	elif case "$SIGNOFF" in yes | true | me | please) : ;; *) false ;; esac
+	then
+		SIGNOFF=`git-var GIT_COMMITTER_IDENT | sed -e '
+				s/>.*/>/
+				s/^/Signed-off-by: /'
+		`
+	else
+		SIGNOFF=
+	fi
+	if test '' != "$SIGNOFF"
+	then
+		LAST_SIGNED_OFF_BY=`
+			sed -ne '/^Signed-off-by: /p' "$MSGFILE" |
+			tail -n 1
+		`
+		test "$LAST_SIGNED_OFF_BY" = "$SIGNOFF" ||
+		echo "$SIGNOFF" >>"$MSGFILE"
+	fi
 fi
+
 patch_header=
 test -f "$keep_subject" || patch_header='[PATCH] '
 
-(echo "$patch_header$SUBJECT" ; if [ -s $MSGFILE ]; then echo ; cat $MSGFILE; fi ) > $final
+{
+	echo "$patch_header$SUBJECT"
+	if test -s "$MSGFILE"
+	then
+		echo
+		cat "$MSGFILE"
+	fi
+} >"$final"
 
-f=0
-[ -f $query_apply ] || f=1
+interactive=yes
+test -f "$query_apply" || interactive=no
 
-while [ $f -eq 0 ]; do
+while [ "$interactive" = yes ]; do
 	echo "Commit Body is:"
 	echo "--------------------------"
-	cat $final
+	cat "$final"
 	echo "--------------------------"
 	echo -n "Apply? [y]es/[n]o/[e]dit/[a]ccept all "
 	read reply
-	case $reply in
-		y|Y) f=1;;
+	case "$reply" in
+		y|Y) interactive=no;;
 		n|N) exit 2;;	# special value to tell dotest to keep going
-		e|E) $EDIT $final;;
-		a|A) rm -f $query_apply
-		     f=1;;
+		e|E) "$EDIT" "$final";;
+		a|A) rm -f "$query_apply"
+		     interactive=no ;;
 	esac
 done
 
+if test -x "$GIT_DIR"/hooks/applypatch-msg
+then
+	"$GIT_DIR"/hooks/applypatch-msg "$final" || exit
+fi
+
 echo
 echo Applying "'$SUBJECT'"
 echo
 
-git-apply --index $PATCHFILE || exit 1
+git-apply --index "$PATCHFILE" || exit 1
+
+if test -x "$GIT_DIR"/hooks/pre-applypatch
+then
+	"$GIT_DIR"/hooks/pre-applypatch || exit
+fi
+
 tree=$(git-write-tree) || exit 1
 echo Wrote tree $tree
-commit=$(git-commit-tree $tree -p $(cat .git/HEAD) < $final) || exit 1
+commit=$(git-commit-tree $tree -p $(cat "$GIT_DIR"/HEAD) < "$final") || exit 1
 echo Committed: $commit
-echo $commit > .git/HEAD
+echo $commit > "$GIT_DIR"/HEAD
+
+if test -x "$GIT_DIR"/hooks/post-applypatch
+then
+	"$GIT_DIR"/hooks/post-applypatch
+fi
