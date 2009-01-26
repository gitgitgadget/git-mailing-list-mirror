From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] rebase -i: correctly remember --root flag across --continue
Date: Mon, 26 Jan 2009 10:05:22 +0100
Message-ID: <1232960722-17480-1-git-send-email-trast@student.ethz.ch>
References: <7vtz7ma9z1.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 10:07:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRNRN-000681-86
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 10:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbZAZJFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 04:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbZAZJFv
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 04:05:51 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:24603 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbZAZJFu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 04:05:50 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 26 Jan 2009 10:05:48 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 26 Jan 2009 10:05:48 +0100
X-Mailer: git-send-email 1.6.1.469.g6f3d5
In-Reply-To: <7vtz7ma9z1.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 26 Jan 2009 09:05:48.0420 (UTC) FILETIME=[478F5440:01C97F95]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107179>

From: Junio C Hamano <gitster@pobox.com>

d911d14 (rebase -i: learn to rebase root commit, 2009-01-02) tried to
remember the --root flag across a merge conflict in a broken way.
Introduce a flag file $DOTEST/rebase-root to fix and clarify.

While at it, also make sure $UPSTREAM is always initialized to guard
against existing values in the environment.

[tr: added tests]

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Junio C Hamano wrote:
> Since you never use the value stored in "$DOTEST/upstream" for anything
> else anyway, how about doing something like this instead?  It would make
> the meaning of the file used as a state variable much clearer.

Yes, thanks, a patch precisely "like this" is in fact the right fix.

I came up with some tests that try a conflicted --root rebase of each
flavour, to guard against the problem in the future.  I wasn't
entirely sure how to shape this into a patch, but here's a version
that forges patch message and sign-off in your name.

Dscho, with that confusion cleared, you can add my Ack to your 1/2
(unchanged, though I'm afraid you'll get a textual conflict).


 git-rebase--interactive.sh |   10 ++++-
 t/t3412-rebase-root.sh     |   88 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 21ac20c..17cf0e5 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -456,7 +456,7 @@ get_saved_options () {
 	test -d "$REWRITTEN" && PRESERVE_MERGES=t
 	test -f "$DOTEST"/strategy && STRATEGY="$(cat "$DOTEST"/strategy)"
 	test -f "$DOTEST"/verbose && VERBOSE=t
-	test ! -s "$DOTEST"/upstream && REBASE_ROOT=t
+	test -f "$DOTEST"/rebase-root && REBASE_ROOT=t
 }
 
 while test $# != 0
@@ -585,6 +585,7 @@ first and then run 'git rebase --continue' again."
 			test -z "$ONTO" && ONTO=$UPSTREAM
 			shift
 		else
+			UPSTREAM=
 			UPSTREAM_ARG=--root
 			test -z "$ONTO" &&
 				die "You must specify --onto when using --root"
@@ -611,7 +612,12 @@ first and then run 'git rebase --continue' again."
 			echo "detached HEAD" > "$DOTEST"/head-name
 
 		echo $HEAD > "$DOTEST"/head
-		echo $UPSTREAM > "$DOTEST"/upstream
+		case "$REBASE_ROOT" in
+		'')
+			rm -f "$DOTEST"/rebase-root ;;
+		*)
+			: >"$DOTEST"/rebase-root ;;
+		esac
 		echo $ONTO > "$DOTEST"/onto
 		test -z "$STRATEGY" || echo "$STRATEGY" > "$DOTEST"/strategy
 		test t = "$VERBOSE" && : > "$DOTEST"/verbose
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 6359580..29bb6d0 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -184,4 +184,92 @@ test_expect_success 'pre-rebase hook stops rebase -i' '
 	test 0 = $(git rev-list other...stops2 | wc -l)
 '
 
+test_expect_success 'remove pre-rebase hook' '
+	rm -f .git/hooks/pre-rebase
+'
+
+test_expect_success 'set up a conflict' '
+	git checkout master &&
+	echo conflict > B &&
+	git add B &&
+	git commit -m conflict
+'
+
+test_expect_success 'rebase --root with conflict (first part)' '
+	git checkout -b conflict1 other &&
+	test_must_fail git rebase --root --onto master &&
+	git ls-files -u | grep "B$"
+'
+
+test_expect_success 'fix the conflict' '
+	echo 3 > B &&
+	git add B
+'
+
+cat > expect-conflict <<EOF
+6
+5
+4
+3
+conflict
+2
+1
+EOF
+
+test_expect_success 'rebase --root with conflict (second part)' '
+	git rebase --continue &&
+	git log --pretty=tformat:"%s" > conflict1 &&
+	test_cmp expect-conflict conflict1
+'
+
+test_expect_success 'rebase -i --root with conflict (first part)' '
+	git checkout -b conflict2 other &&
+	GIT_EDITOR=: test_must_fail git rebase -i --root --onto master &&
+	git ls-files -u | grep "B$"
+'
+
+test_expect_success 'fix the conflict' '
+	echo 3 > B &&
+	git add B
+'
+
+test_expect_success 'rebase -i --root with conflict (second part)' '
+	git rebase --continue &&
+	git log --pretty=tformat:"%s" > conflict2 &&
+	test_cmp expect-conflict conflict2
+'
+
+sed 's/#/ /g' > expect-conflict-p <<'EOF'
+*   Merge branch 'third' into other
+|\##
+| * 6
+* |   Merge branch 'side' into other
+|\ \##
+| * | 5
+* | | 4
+|/ /##
+* | 3
+|/##
+* conflict
+* 2
+* 1
+EOF
+
+test_expect_success 'rebase -i -p --root with conflict (first part)' '
+	git checkout -b conflict3 other &&
+	GIT_EDITOR=: test_must_fail git rebase -i -p --root --onto master &&
+	git ls-files -u | grep "B$"
+'
+
+test_expect_success 'fix the conflict' '
+	echo 3 > B &&
+	git add B
+'
+
+test_expect_success 'rebase -i -p --root with conflict (second part)' '
+	git rebase --continue &&
+	git log --graph --topo-order --pretty=tformat:"%s" > conflict3 &&
+	test_cmp expect-conflict-p conflict3
+'
+
 test_done
-- 
1.6.1.469.g6f3d5
