From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Accept -m and friends for initial commits and merge commits.
Date: Thu, 25 Aug 2005 19:03:27 -0700
Message-ID: <7vzmr5laj4.fsf@assigned-by-dhcp.cox.net>
References: <46a038f905082420323b025e3b@mail.gmail.com>
	<Pine.LNX.4.58.0508251053000.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 07:06:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8TZY-0000ov-Ij
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 04:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbVHZCD3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 22:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbVHZCD3
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 22:03:29 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:46563 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S965047AbVHZCD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 22:03:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050826020327.DNYF12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 Aug 2005 22:03:27 -0400
To: GIT <git@vger.kernel.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7786>

Yes it was irritating.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

    Linus Torvalds <torvalds@osdl.org> writes:
    > [ Junio, the fact that you can't script the initial commit with "git 
    >   commit" is _really_ irritating. ]

 git-commit-script |   86 ++++++++++++++++++++++++-----------------------------
 1 files changed, 39 insertions(+), 47 deletions(-)

c038244ac9260c8c895bf791ff587103bacadaba
diff --git a/git-commit-script b/git-commit-script
--- a/git-commit-script
+++ b/git-commit-script
@@ -110,57 +110,51 @@ t)
 	fi
 esac
 
+if [ ! -r "$GIT_DIR/HEAD" ]
+then
+	echo "#"
+	echo "# Initial commit"
+	echo "#"
+	git-ls-files | sed 's/^/# New file: /'
+	echo "#"
+elif [ -f "$GIT_DIR/MERGE_HEAD" ]; then
+	echo "#"
+	echo "# It looks like your may be committing a MERGE."
+	echo "# If this is not correct, please remove the file"
+	echo "#	$GIT_DIR/MERGE_HEAD"
+	echo "# and try again"
+	echo "#"
+fi >.editmsg
+if test "$log_message" != ''
+then
+	echo "$log_message"
+elif test "$logfile" != ""
+then
+	if test "$logfile" = -
+	then
+		test -t 0 &&
+		echo >&2 "(reading log message from standard input)"
+		cat
+	else
+		cat <"$logfile"
+	fi
+elif test "$use_commit" != ""
+then
+	git-cat-file commit "$use_commit" | sed -e '1,/^$/d'
+fi | git-stripspace >>.editmsg
+
 PARENTS="-p HEAD"
 if [ ! -r "$GIT_DIR/HEAD" ]; then
 	if [ -z "$(git-ls-files)" ]; then
 		echo Nothing to commit 1>&2
 		exit 1
 	fi
-	{
-		echo "#"
-		echo "# Initial commit"
-		case "$no_edit" in
-		t) echo "# (ignoring your commit message for initial commit)"
-		   no_edit= 
-		esac
-		echo "#"
-		git-ls-files | sed 's/^/# New file: /'
-		echo "#"
-	} >.editmsg
 	PARENTS=""
-	no_edit=
 else
 	if [ -f "$GIT_DIR/MERGE_HEAD" ]; then
-		{
-		echo "#"
-		echo "# It looks like your may be committing a MERGE."
-		echo "# If this is not correct, please remove the file"
-		echo "#	$GIT_DIR/MERGE_HEAD"
-		echo "# and try again"
-		case "$no_edit" in
-		t) echo "# (ignoring your commit message for merge commit)"
-		   no_edit= 
-		esac
-		echo "#"
-		} |
-		git-stripspace >.editmsg
 		PARENTS="-p HEAD -p MERGE_HEAD"
-	elif test "$log_message" != ''
-	then
-		echo "$log_message" |
-		git-stripspace >.editmsg
-	elif test "$logfile" != ""
-	then
-		if test "$logfile" = -
-		then
-			test -t 0 &&
-			echo >&2 "(reading log message from standard input)"
-			cat
-		else
-			cat <"$logfile"
-		fi |
-		git-stripspace >.editmsg
-	elif test "$use_commit" != ""
+	fi
+	if test "$use_commit" != ""
 	then
 		pick_author_script='
 		/^author /{
@@ -188,22 +182,20 @@ else
 		export GIT_AUTHOR_NAME
 		export GIT_AUTHOR_EMAIL
 		export GIT_AUTHOR_DATE
-		git-cat-file commit "$use_commit" |
-		sed -e '1,/^$/d' |
-		git-stripspace >.editmsg
 	fi
-
 	case "$signoff" in
 	t)
 		git-var GIT_COMMITTER_IDENT | sed -e '
 			s/>.*/>/
-			s/^/Signed-off-by: /' >>.editmsg ;;
+			s/^/Signed-off-by: /
+		' >>.editmsg
+		;;
 	esac
 	git-status-script >>.editmsg
 fi
 if [ "$?" != "0" -a ! -f $GIT_DIR/MERGE_HEAD ]
 then
-	cat .editmsg
+	sed -ne '/^#/p' .editmsg
 	rm .editmsg
 	exit 1
 fi
