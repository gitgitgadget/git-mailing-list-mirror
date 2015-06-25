From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v9 0/5] bisect terms
Date: Thu, 25 Jun 2015 20:50:52 +0200
Message-ID: <1435258257-29047-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 25 20:51:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8CEy-00005a-Ky
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 20:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbbFYSvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 14:51:08 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46270 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbbFYSvG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 14:51:06 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5PIoukF023823
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Jun 2015 20:50:56 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5PIowH2024581;
	Thu, 25 Jun 2015 20:50:58 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z8CEk-0007zX-F7; Thu, 25 Jun 2015 20:50:58 +0200
X-Mailer: git-send-email 2.4.4.414.g318df7a.dirty
In-Reply-To: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 25 Jun 2015 20:50:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5PIoukF023823
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1435863057.92921@vwH5Lh3xvErVOvOLfQ4tdQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272707>

This version takes into account Junio's remark on the previous series,
and I did a much more thourough review of the whole, which led to a
few fixes (one forgotten strcmp(..., "bad") in addition to the other
noted by Junio), some style fixes, and some simplifications (the file
TERMS_DEFINED of PATCH 5 is gone, it was redundant with BISECT_TERMS
in all cases I could think of).

Hopefully, patches 1-4 are actually ready to be merged.

I'm hesitant about patch 5: I actually ended up spending some time
reviewing it and simplifying it, and I'm tempted to consider it as
finished. But it probably lacks more tests and review.

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index a37336e..e783f87 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -140,16 +140,21 @@ If the builtins terms bad/good and new/old do not satisfy you, you can
 set your own terms.
 
 ------------------------------------------------
-git bisect terms term1 term2
+git bisect terms <term-new> <term-old>
 ------------------------------------------------
 
-This command has to be used before a bisection has started.
-The term1 must be associated with the latest revisions and term2 with the
-ancestors of term1.
-
-Only the first bisection following the 'git bisect terms' will use the terms.
-If you mistyped one of the terms you can do again 'git bisect terms term1
-term2'.
+This command has to be used before a bisection has started. <term-old>
+must be associated with the latest revisions and <term-new> with the
+ancestors of <term-old>. For example, if something was buggy in the
+old part of the history, you know somewhere the bug was fixed, and you
+want to find the exact commit that fixed it, you may want to say `git
+bisect terms fixed broken`; this way, you would mark a commit that
+still has the bug with `broken`, and a newer one after the fix with
+`fixed`.
+
+Only the first bisection following the `git bisect terms` will use the
+terms. If you mistyped one of the terms you can do again `git bisect
+terms <term-old> <term-new>`.
 
 
 Bisect visualize
diff --git a/bisect.c b/bisect.c
index ab09650..d447b65 100644
--- a/bisect.c
+++ b/bisect.c
@@ -741,21 +741,21 @@ static void handle_bad_merge_base(void)
 	if (is_expected_rev(current_bad_oid)) {
 		char *bad_hex = oid_to_hex(current_bad_oid);
 		char *good_hex = join_sha1_array_hex(&good_revs, ' ');
-		if (!strcmp(name_bad, "bad")) {
+		if (!strcmp(name_bad, "bad") && !strcmp(name_good, "good")) {
 			fprintf(stderr, "The merge base %s is bad.\n"
 				"This means the bug has been fixed "
 				"between %s and [%s].\n",
 				bad_hex, bad_hex, good_hex);
-		} else if (!strcmp(name_bad, "new")) {
+		} else if (!strcmp(name_bad, "new") && !strcmp(name_good, "old")) {
 			fprintf(stderr, "The merge base %s is new.\n"
 				"The property has changed "
 				"between %s and [%s].\n",
 				bad_hex, bad_hex, good_hex);
 		} else {
 			fprintf(stderr, "The merge base %s is %s.\n"
-				"This means the first commit marked %s is "
+				"This means the first '%s' commit is "
 				"between %s and [%s].\n",
-				bad_hex, name_bad, name_bad, bad_hex, good_hex);
+				bad_hex, name_bad, name_good, bad_hex, good_hex);
 		}
 		exit(3);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
old mode 100644
new mode 100755
index 8ef2b94..8fee712
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -11,8 +11,8 @@ git bisect (bad|new) [<rev>]
 git bisect (good|old) [<rev>...]
 	mark <rev>... known-good revisions/
 		revisions before change in a given property.
-git bisect terms term1 term2
-	set up term1 and term2 as bisection terms.
+git bisect terms <term-new> <term-old>
+	set up <term-new> and <term-old> as terms (default: bad, good)
 git bisect skip [(<rev>|<range>)...]
 	mark <rev>... untestable revisions.
 git bisect next
@@ -81,15 +81,15 @@ bisect_start() {
 	orig_args=$(git rev-parse --sq-quote "$@")
 	bad_seen=0
 	eval=''
-	# revision_seen is true if a git bisect start
-	# has revision as arguments
-	revision_seen=0
-	# terms_defined is used to detect if the user
-	# defined his own terms with git bisect terms
-	terms_defined=0
-	if test -s "$GIT_DIR/TERMS_DEFINED"
+	must_write_terms=0
+	must_log_terms=0
+	if test -s "$GIT_DIR/BISECT_TERMS"
 	then
-		terms_defined=1
+		# We're going to restart from a clean state and the
+		# file will be deleted. Record the old state in
+		# variables and restore it below.
+		must_write_terms=1
+		must_log_terms=1
 		get_terms
 	fi
 	if test "z$(git rev-parse --is-bare-repository)" != zfalse
@@ -117,7 +117,12 @@ bisect_start() {
 				break
 			}
 
-			revision_seen=1
+			# The user ran "git bisect start <sha1>
+			# <sha1>", hence did not explicitly specify
+			# the terms, but we are already starting to
+			# set references named with the default terms,
+			# and won't be able to change afterwards.
+			must_write_terms=1
 
 			case $bad_seen in
 			0) state=$NAME_BAD ; bad_seen=1 ;;
@@ -190,13 +195,13 @@ bisect_start() {
 	} &&
 	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
 	eval "$eval true" &&
-	if test $revision_seen -eq 1 && test ! -s "$GIT_DIR/BISECT_TERMS" || test $terms_defined -eq 1
+	if test $must_write_terms -eq 1
 	then
-		echo "$NAME_BAD" >"$GIT_DIR/BISECT_TERMS" &&
-		echo "$NAME_GOOD" >>"$GIT_DIR/BISECT_TERMS" &&
-		if test $terms_defined -eq 1
+		write_terms "$NAME_BAD" "$NAME_GOOD" &&
+		if test $must_log_terms -eq 1
 		then
-			echo "git bisect terms $NAME_BAD $NAME_GOOD" >>"$GIT_DIR/BISECT_LOG" || exit
+			echo "git bisect terms $NAME_BAD $NAME_GOOD" \
+			    >>"$GIT_DIR/BISECT_LOG"
 		fi
 	fi &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
@@ -433,7 +438,6 @@ bisect_clean_state() {
 	rm -f "$GIT_DIR/BISECT_NAMES" &&
 	rm -f "$GIT_DIR/BISECT_RUN" &&
 	rm -f "$GIT_DIR/BISECT_TERMS" &&
-	rm -f "$GIT_DIR/TERMS_DEFINED" &&
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
 	git update-ref -d --no-deref BISECT_HEAD &&
@@ -558,16 +562,14 @@ check_and_set_terms () {
 		bad|good)
 			if ! test -s "$GIT_DIR/BISECT_TERMS"
 			then
-				echo "bad" >"$GIT_DIR/BISECT_TERMS" &&
-				echo "good" >>"$GIT_DIR/BISECT_TERMS"
+				write_terms bad good
 			fi
 			NAME_BAD="bad"
 			NAME_GOOD="good" ;;
 		new|old)
 			if ! test -s "$GIT_DIR/BISECT_TERMS"
 			then
-				echo "new" >"$GIT_DIR/BISECT_TERMS" &&
-				echo "old" >>"$GIT_DIR/BISECT_TERMS"
+				write_terms new old
 			fi
 			NAME_BAD="new"
 			NAME_GOOD="old" ;;
@@ -587,37 +589,40 @@ bisect_terms () {
 	0)
 		if test -s "$GIT_DIR/BISECT_TERMS"
 		then
-			{
-			read term1
-			read term2
-			}<"$GIT_DIR/BISECT_TERMS"
-			gettextln "Your current terms are $term1 and $term2."
+			get_terms
+			gettextln "Your current terms are $NAME_GOOD for the old state
+and $NAME_BAD for the new state."
 		else
 			die "$(gettext "No terms defined.")"
 		fi ;;
 	2)
-		check_term_format refs/bisect/"$1"
-		check_term_format refs/bisect/"$2"
 		if ! test -s "$GIT_DIR/BISECT_START"
 		then
-			echo $1 >"$GIT_DIR/BISECT_TERMS" &&
-			echo $2 >>"$GIT_DIR/BISECT_TERMS" &&
-			echo "1" >"$GIT_DIR/TERMS_DEFINED"
+			write_terms "$1" "$2"
 			echo "git bisect terms $NAME_BAD $NAME_GOOD" >>"$GIT_DIR/BISECT_LOG" || exit
 		else
 			die "$(gettext "A bisection has already started, and you can't change terms in the middle of it.
 Use 'git bisect terms' to see the current terms.
-Otherwise, to start a new bisection with new terms, please use 'git bisect reset' and set the terms before the start")"
+Otherwise, to start a new bisection with new terms, please use
+'git bisect reset' and set the terms before the start")"
 		fi ;;
 	*)
 		usage ;;
 	esac
 }
 
+write_terms () {
+	NAME_BAD=$1
+	NAME_GOOD=$2
+	check_term_format "$NAME_BAD"
+	check_term_format "$NAME_GOOD"
+	printf '%s\n%s\n' "$NAME_BAD" "$NAME_GOOD" >"$GIT_DIR/BISECT_TERMS"
+}
+
 check_term_format () {
-	arg="$1"
-	git check-ref-format $arg ||
-	die "$(eval_gettext "'\$arg' is not a valid term")"
+	term=$1
+	git check-ref-format refs/bisect/"$term" ||
+	die "$(eval_gettext "'\$term' is not a valid term")"
 }
 
 case "$#" in

Antoine Delaite (5):
  bisect: correction of typo
  bisect: replace hardcoded "bad|good" by variables
  bisect: simplify the addition of new bisect terms
  bisect: add the terms old/new
  bisect: allow any terms set by user

 Documentation/git-bisect.txt |  72 ++++++++++++++-
 bisect.c                     |  94 +++++++++++++++----
 git-bisect.sh                | 212 +++++++++++++++++++++++++++++++++++--------
 revision.c                   |  20 +++-
 t/t6030-bisect-porcelain.sh  |  83 ++++++++++++++++-
 5 files changed, 417 insertions(+), 64 deletions(-)

-- 
2.4.4.414.g318df7a.dirty
