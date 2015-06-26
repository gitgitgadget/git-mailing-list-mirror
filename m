From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v10 7/7] bisect: allow any terms set by user
Date: Fri, 26 Jun 2015 18:58:16 +0200
Message-ID: <1435337896-20709-8-git-send-email-Matthieu.Moy@imag.fr>
References: <1435337896-20709-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 26 18:58:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Wxt-00043P-Ik
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 18:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbbFZQ6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 12:58:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55198 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637AbbFZQ6g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 12:58:36 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5QGwRaU027687
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Jun 2015 18:58:27 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5QGwTYm013802;
	Fri, 26 Jun 2015 18:58:29 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z8WxR-0005ZP-P6; Fri, 26 Jun 2015 18:58:29 +0200
X-Mailer: git-send-email 2.4.4.414.g318df7a.dirty
In-Reply-To: <1435337896-20709-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 26 Jun 2015 18:58:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5QGwRaU027687
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1435942710.19572@Qa1fkIp+l2rhlc0pur/+jA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272796>

From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>

Introduction of the git bisect terms command. The user can set his own
terms. It will work exactly like before. The terms must be set before the
start.

Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Signed-off-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-bisect.txt | 36 +++++++++++++++++++-
 git-bisect.sh                | 65 +++++++++++++++++++++++++++++++++---
 t/t6030-bisect-porcelain.sh  | 79 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 24171a5..b1ef41c 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -19,6 +19,7 @@ on the subcommand:
  git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<paths>...]
  git bisect (bad|new) [<rev>]
  git bisect (good|old) [<rev>...]
+ git bisect terms <term-old> <term-new>
  git bisect skip [(<rev>|<range>)...]
  git bisect reset [<commit>]
  git bisect visualize
@@ -40,7 +41,7 @@ In fact, `git bisect` can be used to find the commit that changed
 *any* property of your project; e.g., the commit that fixed a bug, or
 the commit that caused a benchmark's performance to improve. To
 support this more general usage, the terms "old" and "new" can be used
-in place of "good" and "bad". See
+in place of "good" and "bad", or you can choose your own terms. See
 section "Alternate terms" below for more information.
 
 Basic bisect commands: start, bad, good
@@ -157,6 +158,31 @@ git bisect new [<rev>...]
 
 to indicate that it was after.
 
+If you would like to use your own terms instead of "bad"/"good" or
+"new"/"old", you can choose any names you like by typing
+
+------------------------------------------------
+git bisect terms <term-new> <term-old>
+------------------------------------------------
+
+before starting a bisection session. For example, if you are looking
+for a commit that introduced a performance regression, you might use
+
+------------------------------------------------
+git bisect terms slow fast
+------------------------------------------------
+
+Or if you are looking for the commit that fixed a bug, you might use
+
+------------------------------------------------
+git bisect terms fixed broken
+------------------------------------------------
+
+Only the bisection following the `git bisect terms` will use the
+terms. If you mistyped one of the terms you can do again `git bisect
+terms <term-new> <term-old>`, but that is possible only before you
+start the bisection.
+
 Bisect visualize
 ~~~~~~~~~~~~~~~~
 
@@ -440,6 +466,14 @@ $ git bisect start
 $ git bisect new HEAD    # current commit is marked as new
 $ git bisect old HEAD~10 # the tenth commit from now is marked as old
 ------------
++
+or:
+------------
+$ git bisect terms fixed broken
+$ git bisect start
+$ git bisect fixed
+$ git bisect broken HEAD~10
+------------
 
 Getting help
 ~~~~~~~~~~~~
diff --git a/git-bisect.sh b/git-bisect.sh
index 5769eaf..64ea122 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[help|start|bad|good|new|old|skip|next|reset|visualize|replay|log|run]'
+USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|replay|log|run]'
 LONG_USAGE='git bisect help
 	print this long help message.
 git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<pathspec>...]
@@ -11,6 +11,8 @@ git bisect (bad|new) [<rev>]
 git bisect (good|old) [<rev>...]
 	mark <rev>... known-good revisions/
 		revisions before change in a given property.
+git bisect terms <term-new> <term-old>
+	set up <term-new> and <term-old> as terms (default: bad, good)
 git bisect skip [(<rev>|<range>)...]
 	mark <rev>... untestable revisions.
 git bisect next
@@ -80,6 +82,16 @@ bisect_start() {
 	bad_seen=0
 	eval=''
 	must_write_terms=0
+	must_log_terms=0
+	if test -s "$GIT_DIR/BISECT_TERMS"
+	then
+		# We're going to restart from a clean state and the
+		# file will be deleted. Record the old state in
+		# variables and restore it below.
+		must_write_terms=1
+		must_log_terms=1
+		get_terms
+	fi
 	if test "z$(git rev-parse --is-bare-repository)" != zfalse
 	then
 		mode=--no-checkout
@@ -185,7 +197,12 @@ bisect_start() {
 	eval "$eval true" &&
 	if test $must_write_terms -eq 1
 	then
-		write_terms "$NAME_BAD" "$NAME_GOOD"
+		write_terms "$NAME_BAD" "$NAME_GOOD" &&
+		if test $must_log_terms -eq 1
+		then
+			echo "git bisect terms $NAME_BAD $NAME_GOOD" \
+			    >>"$GIT_DIR/BISECT_LOG"
+		fi
 	fi &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
@@ -449,6 +466,8 @@ bisect_replay () {
 			eval "$cmd" ;;
 		"$NAME_GOOD"|"$NAME_BAD"|skip)
 			bisect_write "$command" "$rev" ;;
+		terms)
+			bisect_terms $rev ;;
 		*)
 			die "$(gettext "?? what are you talking about?")" ;;
 		esac
@@ -533,13 +552,22 @@ get_terms () {
 write_terms () {
 	NAME_BAD=$1
 	NAME_GOOD=$2
+	check_term_format "$NAME_BAD"
+	check_term_format "$NAME_GOOD"
 	printf '%s\n%s\n' "$NAME_BAD" "$NAME_GOOD" >"$GIT_DIR/BISECT_TERMS"
 }
 
+check_term_format () {
+	term=$1
+	git check-ref-format refs/bisect/"$term" ||
+	die "$(eval_gettext "'\$term' is not a valid term")"
+}
+
 check_and_set_terms () {
 	cmd="$1"
 	case "$cmd" in
-	bad|good|new|old)
+	skip|start|terms) ;;
+	*)
 		if test -s "$GIT_DIR/BISECT_TERMS" && test "$cmd" != "$NAME_BAD" && test "$cmd" != "$NAME_GOOD"
 		then
 			die "$(eval_gettext "Invalid command: you're currently in a \$NAME_BAD/\$NAME_GOOD bisect.")"
@@ -568,6 +596,33 @@ bisect_voc () {
 	esac
 }
 
+bisect_terms () {
+	case "$#" in
+	0)
+		if test -s "$GIT_DIR/BISECT_TERMS"
+		then
+			get_terms
+			gettextln "Your current terms are $NAME_GOOD for the old state
+and $NAME_BAD for the new state."
+		else
+			die "$(gettext "No terms defined.")"
+		fi ;;
+	2)
+		if ! test -s "$GIT_DIR/BISECT_START"
+		then
+			write_terms "$1" "$2"
+			echo "git bisect terms $NAME_BAD $NAME_GOOD" >>"$GIT_DIR/BISECT_LOG" || exit
+		else
+			die "$(gettext "A bisection has already started, and you can't change terms in the middle of it.
+Use 'git bisect terms' to see the current terms.
+Otherwise, to start a new bisection with new terms, please use
+'git bisect reset' and set the terms before the start")"
+		fi ;;
+	*)
+		usage ;;
+	esac
+}
+
 case "$#" in
 0)
 	usage ;;
@@ -580,7 +635,7 @@ case "$#" in
 		git bisect -h ;;
 	start)
 		bisect_start "$@" ;;
-	bad|good|new|old)
+	bad|good|new|old|"$NAME_BAD"|"$NAME_GOOD")
 		bisect_state "$cmd" "$@" ;;
 	skip)
 		bisect_skip "$@" ;;
@@ -597,6 +652,8 @@ case "$#" in
 		bisect_log ;;
 	run)
 		bisect_run "$@" ;;
+	terms)
+		bisect_terms "$@" ;;
 	*)
 		usage ;;
 	esac
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 983c503..83254d2 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -797,4 +797,83 @@ test_expect_success 'bisect cannot mix old/new and good/bad' '
 	test_must_fail git bisect old $HASH1
 '
 
+test_expect_success 'bisect start with one term1 and term2' '
+	git bisect reset &&
+	git bisect terms term1 term2 &&
+	git bisect start &&
+	git bisect term2 $HASH1 &&
+	git bisect term1 $HASH4 &&
+	git bisect term1 &&
+	git bisect term1 >bisect_result &&
+	grep "$HASH2 is the first term1 commit" bisect_result &&
+	git bisect log >log_to_replay.txt &&
+	git bisect reset
+'
+
+test_expect_success 'bisect replay with term1 and term2' '
+	git bisect replay log_to_replay.txt >bisect_result &&
+	grep "$HASH2 is the first term1 commit" bisect_result &&
+	git bisect reset
+'
+
+test_expect_success 'bisect start term1 term2' '
+	git bisect reset &&
+	git bisect terms term1 term2 &&
+	git bisect start $HASH4 $HASH1 &&
+	git bisect term1 &&
+	git bisect term1 >bisect_result &&
+	grep "$HASH2 is the first term1 commit" bisect_result &&
+	git bisect log >log_to_replay.txt &&
+	git bisect reset
+'
+
+test_expect_success 'bisect cannot mix terms' '
+	git bisect reset &&
+	git bisect terms a b &&
+	git bisect terms term1 term2 &&
+	git bisect start $HASH4 $HASH1 &&
+	test_must_fail git bisect a &&
+	test_must_fail git bisect b &&
+	test_must_fail git bisect bad &&
+	test_must_fail git bisect good &&
+	test_must_fail git bisect new &&
+	test_must_fail git bisect old
+'
+
+test_expect_success 'bisect terms rejects invalid terms' '
+	git bisect reset &&
+	test_must_fail git bisect terms invalid..term term2 &&
+	test_must_fail git bisect terms term1 invalid..term &&
+	test_path_is_missing .git/BISECT_TERMS
+'
+
+test_expect_success 'bisect terms needs 0 or 2 arguments' '
+	git bisect reset &&
+	test_must_fail git bisect terms only-one &&
+	test_must_fail git bisect terms 1 2 3 &&
+	test_must_fail git bisect terms 2>actual
+'
+
+test_expect_success 'bisect terms does store terms' '
+	echo "No terms defined." >expected &&
+	test_cmp expected actual &&
+	git bisect terms one two &&
+	git bisect terms >actual &&
+	cat <<-EOF >expected &&
+	Your current terms are two for the old state
+	and one for the new state.
+	EOF
+	test_cmp expected actual'
+
+test_expect_success 'bisect start keeps defined terms' '
+	git bisect terms one two &&
+	git bisect start &&
+	git bisect terms >actual &&
+	cat <<-EOF >expected &&
+	Your current terms are two for the old state
+	and one for the new state.
+	EOF
+	test_cmp expected actual
+'
+
 test_done
-- 
2.4.4.414.g318df7a.dirty
