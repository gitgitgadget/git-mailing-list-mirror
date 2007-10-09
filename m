From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] Bisect: implement "bisect dunno" to mark untestable
 revisions.
Date: Tue, 9 Oct 2007 06:25:21 +0200
Message-ID: <20071009062521.a5416201.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 06:18:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If6YP-0000cs-28
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 06:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbXJIESQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 00:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbXJIESQ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 00:18:16 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:32797 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbXJIESP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 00:18:15 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E2F0B1AB2C0;
	Tue,  9 Oct 2007 06:18:12 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 988B11AB2BE;
	Tue,  9 Oct 2007 06:18:12 +0200 (CEST)
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60354>

When there are some dunno revisions, we add the '--bisect-all'
option to "git rev-list --bisect-vars". Then we filter out the
dunno revisions from the result of the rev-list command, and we
modify the "bisect_rev" var accordingly.

We don't always use "--bisect-all" because it is slower
than "--bisect-vars" or "--bisect".

When we cannot find for sure the first bad commit because of
dunno commits, we print the hash of each possible first bad
commit and then we exit with code 2.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-bisect.sh               |  115 ++++++++++++++++++++++++++++++++++++++++++-
 t/t6030-bisect-porcelain.sh |   71 ++++++++++++++++++++++++++
 2 files changed, 184 insertions(+), 2 deletions(-)

	I removed the "search_dunno" function that was in
	the previous version of this patch and replaced it
	with a "case" as suggested by Dscho.

	I did not removed the bisect_write_{bad,good,dunno}
	functions because some of them are used in more than
	one place. But I will factorise them in a following
	patch.

diff --git a/git-bisect.sh b/git-bisect.sh
index 436ccf6..022671d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -17,6 +17,8 @@ git bisect replay <logfile>
         replay bisection log.
 git bisect log
         show bisect log.
+git bisect dunno [<rev>...]
+        mark <rev>... untestable revisions.
 git bisect run <cmd>...
         use <cmd>... to automatically bisect.'
 
@@ -163,6 +165,28 @@ bisect_write_good() {
 	echo "# good: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
 }
 
+bisect_dunno() {
+	bisect_autostart
+	case "$#" in
+	0)    revs=$(git rev-parse --verify HEAD) || exit ;;
+	*)    revs=$(git rev-parse --revs-only --no-flags "$@") &&
+		test '' != "$revs" || die "Bad rev input: $@" ;;
+	esac
+	for rev in $revs
+	do
+		rev=$(git rev-parse --verify "$rev^{commit}") || exit
+		bisect_write_dunno "$rev"
+		echo "git-bisect dunno $rev" >>"$GIT_DIR/BISECT_LOG"
+	done
+	bisect_auto_next
+}
+
+bisect_write_dunno() {
+	rev="$1"
+	echo "$rev" >"$GIT_DIR/refs/bisect/dunno-$rev"
+	echo "# dunno: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
+}
+
 bisect_next_check() {
 	missing_good= missing_bad=
 	git show-ref -q --verify refs/bisect/bad || missing_bad=t
@@ -205,17 +229,97 @@ bisect_auto_next() {
 	bisect_next_check && bisect_next || :
 }
 
+filter_dunno() {
+	_eval="$1"
+	_dunno="$2"
+
+	if [ -z "$_dunno" ]; then
+		eval $_eval
+		return
+	fi
+
+	# Let's parse the output of:
+	# "git rev-list --bisect-vars --bisect-all ..."
+	eval $_eval | while read hash line
+	do
+		case "$VARS,$FOUND,$TRIED,$hash" in
+			# We display some vars.
+			1,*,*,*) echo "$hash $line" ;;
+
+			# Split line.
+			,*,*,---*) ;;
+
+			# We had nothing to search.
+			,,,bisect_rev*)
+				echo "bisect_rev="
+				VARS=1
+				;;
+
+			# We did not find a good bisect rev.
+			# This should happen only if the "bad"
+			# commit is also a "dunno" commit.
+			,,*,bisect_rev*)
+				echo "bisect_rev=$TRIED"
+				VARS=1
+				;;
+
+			# We are searching.
+			,,*,*)
+				TRIED="${TRIED:+$TRIED|}$hash"
+				case "$_dunno" in
+				*$hash*) ;;
+				*)
+					echo "bisect_rev=$hash"
+					echo "bisect_tried=\"$TRIED\""
+					FOUND=1
+					;;
+				esac
+				;;
+
+			# We have already found a rev to be tested.
+			,1,*,bisect_rev*) VARS=1 ;;
+			,1,*,*) ;;
+
+			# ???
+			*) die "filter_dunno error " \
+			    "VARS: '$VARS' " \
+			    "FOUND: '$FOUND' " \
+			    "TRIED: '$TRIED' " \
+			    "hash: '$hash' " \
+			    "line: '$line'"
+			;;
+		esac
+	done
+}
+
+exit_if_dunno_commits () {
+	_tried=$1
+	if expr "$_tried" : ".*[|].*" > /dev/null ; then
+		echo "There are only 'dunno' commit left to test."
+		echo "The first bad commit could be any of:"
+		echo "$_tried" | sed -e 's/[|]/\n/g'
+		echo "We cannot bisect more!"
+		exit 2
+	fi
+}
+
 bisect_next() {
 	case "$#" in 0) ;; *) usage ;; esac
 	bisect_autostart
 	bisect_next_check good
 
+	dunno=$(git for-each-ref --format='%(objectname)' \
+		"refs/bisect/dunno-*" | tr '[\012]' ' ') || exit
+
+	BISECT_OPT=''
+	test -n "$dunno" && BISECT_OPT='--bisect-all'
+
 	bad=$(git rev-parse --verify refs/bisect/bad) &&
 	good=$(git for-each-ref --format='^%(objectname)' \
 		"refs/bisect/good-*" | tr '[\012]' ' ') &&
-	eval="git rev-list --bisect-vars $good $bad --" &&
+	eval="git rev-list --bisect-vars $BISECT_OPT $good $bad --" &&
 	eval="$eval $(cat "$GIT_DIR/BISECT_NAMES")" &&
-	eval=$(eval "$eval") &&
+	eval=$(filter_dunno "$eval" "$dunno") &&
 	eval "$eval" || exit
 
 	if [ -z "$bisect_rev" ]; then
@@ -223,11 +327,16 @@ bisect_next() {
 		exit 1
 	fi
 	if [ "$bisect_rev" = "$bad" ]; then
+		exit_if_dunno_commits "$bisect_tried"
 		echo "$bisect_rev is first bad commit"
 		git diff-tree --pretty $bisect_rev
 		exit 0
 	fi
 
+	# We should exit here only if the "bad"
+	# commit is also a "dunno" commit (see above).
+	exit_if_dunno_commits "$bisect_rev"
+
 	echo "Bisecting: $bisect_nr revisions left to test after this"
 	echo "$bisect_rev" >"$GIT_DIR/refs/heads/new-bisect"
 	git checkout -q new-bisect || exit
@@ -362,6 +471,8 @@ case "$#" in
         bisect_bad "$@" ;;
     good)
         bisect_good "$@" ;;
+    dunno)
+        bisect_dunno "$@" ;;
     next)
         # Not sure we want "next" at the UI level anymore.
         bisect_next "$@" ;;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 03cdba5..7f41a46 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -71,6 +71,63 @@ test_expect_success 'bisect start with one bad and good' '
 	git bisect next
 '
 
+# $HASH1 is good, $HASH4 is bad, we dunno about $HASH3
+# but $HASH2 is bad,
+# so we should find $HASH2 as the first bad commit
+test_expect_success 'bisect dunno: successfull result' '
+	git bisect reset &&
+	git bisect start $HASH4 $HASH1 &&
+	git bisect dunno &&
+	git bisect bad > my_bisect_log.txt &&
+	grep "$HASH2 is first bad commit" my_bisect_log.txt &&
+	git bisect reset
+'
+
+# $HASH1 is good, $HASH4 is bad, we dunno about $HASH3 and $HASH2
+# so we should not be able to tell the first bad commit
+# among $HASH2, $HASH3 and $HASH4
+test_expect_success 'bisect dunno: cannot tell between 3 commits' '
+	git bisect start $HASH4 $HASH1 &&
+	git bisect dunno || return 1
+
+	if git bisect dunno > my_bisect_log.txt
+	then
+		echo Oops, should have failed.
+		false
+	else
+		test $? -eq 2 &&
+		grep "first bad commit could be any of" my_bisect_log.txt &&
+		! grep $HASH1 my_bisect_log.txt &&
+		grep $HASH2 my_bisect_log.txt &&
+		grep $HASH3 my_bisect_log.txt &&
+		grep $HASH4 my_bisect_log.txt &&
+		git bisect reset
+	fi
+'
+
+# $HASH1 is good, $HASH4 is bad, we dunno about $HASH3
+# but $HASH2 is good,
+# so we should not be able to tell the first bad commit
+# among $HASH3 and $HASH4
+test_expect_success 'bisect dunno: cannot tell between 2 commits' '
+	git bisect start $HASH4 $HASH1 &&
+	git bisect dunno || return 1
+
+	if git bisect good > my_bisect_log.txt
+	then
+		echo Oops, should have failed.
+		false
+	else
+		test $? -eq 2 &&
+		grep "first bad commit could be any of" my_bisect_log.txt &&
+		! grep $HASH1 my_bisect_log.txt &&
+		! grep $HASH2 my_bisect_log.txt &&
+		grep $HASH3 my_bisect_log.txt &&
+		grep $HASH4 my_bisect_log.txt &&
+		git bisect reset
+	fi
+'
+
 # We want to automatically find the commit that
 # introduced "Another" into hello.
 test_expect_success \
@@ -99,6 +156,20 @@ test_expect_success \
      grep "$HASH4 is first bad commit" my_bisect_log.txt &&
      git bisect reset'
 
+# $HASH1 is good, $HASH5 is bad, we dunno about $HASH3
+# but $HASH4 is good,
+# so we should find $HASH5 as the first bad commit
+HASH5=
+test_expect_success 'bisect dunno: add line and then a new test' '
+	add_line_into_file "5: Another new line." hello &&
+	HASH5=$(git rev-parse --verify HEAD) &&
+	git bisect start $HASH5 $HASH1 &&
+	git bisect dunno &&
+	git bisect good > my_bisect_log.txt &&
+	grep "$HASH5 is first bad commit" my_bisect_log.txt &&
+	git bisect reset
+'
+
 #
 #
 test_done
-- 
1.5.3.4.209.g5612
