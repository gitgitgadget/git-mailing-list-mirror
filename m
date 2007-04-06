From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] git-bisect: allow bisecting with only one bad commit.
Date: Thu, 05 Apr 2007 23:30:44 -0700
Message-ID: <7v7isqkoa3.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vzm5pw7ju.fsf@assigned-by-dhcp.cox.net>
	<20070404071202.483030b8.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Apr 06 08:31:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZhyV-0007T3-33
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 08:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbXDFGaq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 02:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753496AbXDFGaq
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 02:30:46 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:57949 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488AbXDFGap (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 02:30:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070406063044.VRGY27119.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 6 Apr 2007 02:30:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id jiWk1W0051kojtg0000000; Fri, 06 Apr 2007 02:30:44 -0400
In-Reply-To: <20070404071202.483030b8.chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 4 Apr 2007 07:12:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43902>

This allows you to say:

	git bisect start
	git bisect bad $bad
	git bisect next

to start bisection without knowing a good commit.  This would
have you try a commit that is half-way since the beginning of
the history, which is rather wasteful if you already know a good
commit, but if you don't (or your history is short enough that
you do not care), there is no reason not to allow this.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * These two are on top of your "bisect start [B [G G...] [--] [paths...]".

 git-bisect.sh         |   87 ++++++++++++++++++++++++++++++-------------------
 t/t6030-bisect-run.sh |   17 +++------
 2 files changed, 59 insertions(+), 45 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index c936533..85c374e 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -168,26 +168,40 @@ bisect_write_good() {
 }
 
 bisect_next_check() {
-	next_ok=no
-	git show-ref -q --verify refs/bisect/bad &&
-	test -n "$(git for-each-ref "refs/bisect/good-*")" &&
-	next_ok=yes
-
-	case "$next_ok,$1" in
-	no,) false ;;
-	no,fail)
-	    THEN=''
-	    test -d "$GIT_DIR/refs/bisect" || {
-		echo >&2 'You need to start by "git bisect start".'
-		THEN='then '
-	    }
-	    echo >&2 'You '$THEN'need to give me at least one good' \
-		'and one bad revisions.'
-	    echo >&2 '(You can use "git bisect bad" and' \
-		'"git bisect good" for that.)'
-	    exit 1 ;;
+	missing_good= missing_bad=
+	git show-ref -q --verify refs/bisect/bad || missing_bad=t
+	test -n "$(git for-each-ref "refs/bisect/good-*")" || missing_good=t
+
+	case "$missing_good,$missing_bad,$1" in
+	,,*)
+		: have both good and bad - ok
+		;;
+	*,)
+		# do not have both but not asked to fail - just report.
+		false
+		;;
+	t,,good)
+		# have bad but not good.  we could bisect although
+		# this is less optimum.
+		echo >&2 'Warning: bisecting only with a bad commit.'
+		if test -t 0
+		then
+			printf >&2 'Are you sure [Y/n]? '
+			case "$(read yesno)" in [Nn]*) exit 1 ;; esac
+		fi
+		: bisect without good...
+		;;
 	*)
-	    true ;;
+		THEN=''
+		test -d "$GIT_DIR/refs/bisect" || {
+			echo >&2 'You need to start by "git bisect start".'
+			THEN='then '
+		}
+		echo >&2 'You '$THEN'need to give me at least one good' \
+			'and one bad revisions.'
+		echo >&2 '(You can use "git bisect bad" and' \
+			'"git bisect good" for that.)'
+		exit 1 ;;
 	esac
 }
 
@@ -198,27 +212,32 @@ bisect_auto_next() {
 bisect_next() {
         case "$#" in 0) ;; *) usage ;; esac
 	bisect_autostart
-	bisect_next_check fail
+	bisect_next_check good
+
 	bad=$(git-rev-parse --verify refs/bisect/bad) &&
-	good=$(git-rev-parse --sq --revs-only --not \
-		$(cd "$GIT_DIR" && ls refs/bisect/good-*)) &&
-	rev=$(eval "git-rev-list --bisect $good $bad -- $(cat "$GIT_DIR/BISECT_NAMES")") || exit
-	if [ -z "$rev" ]; then
-	    echo "$bad was both good and bad"
-	    exit 1
+	good=$(git for-each-ref --format='^%(objectname)' \
+		"refs/bisect/good-*" | tr '[\012]' ' ') &&
+	eval="git-rev-list --bisect-vars $good $bad --" &&
+	eval="$eval $(cat "$GIT_DIR/BISECT_NAMES")" &&
+	eval=$(eval "$eval") &&
+	eval "$eval" || exit
+
+	if [ -z "$bisect_rev" ]; then
+		echo "$bad was both good and bad"
+		exit 1
 	fi
-	if [ "$rev" = "$bad" ]; then
-	    echo "$rev is first bad commit"
-	    git-diff-tree --pretty $rev
-	    exit 0
+	if [ "$bisect_rev" = "$bad" ]; then
+		echo "$bisect_rev is first bad commit"
+		git-diff-tree --pretty $bisect_rev
+		exit 0
 	fi
-	nr=$(eval "git-rev-list $rev $good -- $(cat $GIT_DIR/BISECT_NAMES)" | wc -l) || exit
-	echo "Bisecting: $nr revisions left to test after this"
-	echo "$rev" > "$GIT_DIR/refs/heads/new-bisect"
+
+	echo "Bisecting: $bisect_nr revisions left to test after this"
+	echo "$bisect_rev" >"$GIT_DIR/refs/heads/new-bisect"
 	git checkout -q new-bisect || exit
 	mv "$GIT_DIR/refs/heads/new-bisect" "$GIT_DIR/refs/heads/bisect" &&
 	GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD refs/heads/bisect
-	git-show-branch "$rev"
+	git-show-branch "$bisect_rev"
 }
 
 bisect_visualize() {
diff --git a/t/t6030-bisect-run.sh b/t/t6030-bisect-run.sh
index 1c38f08..7f41807 100755
--- a/t/t6030-bisect-run.sh
+++ b/t/t6030-bisect-run.sh
@@ -4,6 +4,8 @@
 #
 test_description='Tests git-bisect run functionality'
 
+exec </dev/null
+
 . ./test-lib.sh
 
 add_line_into_file()
@@ -37,21 +39,14 @@ test_expect_success \
      HASH3=$(git rev-list HEAD | head -2 | tail -1) &&
      HASH4=$(git rev-list HEAD | head -1)'
 
-test_expect_success 'bisect does not start with only one bad' '
+test_expect_success 'bisect starts with only one bad' '
 	git bisect reset &&
 	git bisect start &&
-	git bisect bad $HASH4 || return 1
-
-	if git bisect next
-	then
-		echo Oops, should have failed.
-		false
-	else
-		:
-	fi
+	git bisect bad $HASH4 &&
+	git bisect next
 '
 
-test_expect_success 'bisect does not start with only one good' '
+test_expect_success 'bisect starts with only one good' '
 	git bisect reset &&
 	git bisect start &&
 	git bisect good $HASH1 || return 1
-- 
1.5.1.53.g77e6f
