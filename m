From: "Bernhard R. Link" <brlink@debian.org>
Subject: [PATCH 7/7] add support for creating equal tree markers to rebase
	-i
Date: Mon, 30 Nov 2009 15:45:55 +0100
Message-ID: <9039548d987e1b9be8385c646b2e6e5abf697d09.1259524136.git.brlink@debian.org>
References: <cover.1259524136.git.brlink@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 15:46:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF7Vo-0007fu-UC
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 15:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943AbZK3Opt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 09:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbZK3Opt
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 09:45:49 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:33535
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752938AbZK3Opt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 09:45:49 -0500
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF7Vj-00019L-7z
	for git@vger.kernel.org; Mon, 30 Nov 2009 15:45:55 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF7Vj-0000s0-6B
	for git@vger.kernel.org; Mon, 30 Nov 2009 15:45:55 +0100
Content-Disposition: inline
In-Reply-To: <cover.1259524136.git.brlink@debian.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134110>

With the new --eqt option, git rebase -i adds an equal tree marker,
so that the old branch can be fast-forwarded to the new one.
If the trees are not equal, a fake merge of the new base and
the old branch is created first.

TODO:
- manpage update,
- should --eqt have a better (longer more descriptive) name?
- the commit message of the merge should have a better default
  and presented to the user for editing
---
 git-rebase--interactive.sh |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3da9f3e..51cc5fa 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -20,6 +20,7 @@ v,verbose          display a diffstat of what changed upstream
 onto=              rebase onto given branch instead of upstream
 p,preserve-merges  try to recreate merges instead of ignoring them
 s,strategy=        use the given merge strategy
+eqt                create an equal tree marker to allow f-f from old tree
 m,merge            always used (no-op)
 i,interactive      always used (no-op)
  Actions:
@@ -46,6 +47,7 @@ ONTO=
 VERBOSE=
 OK_TO_SKIP_PRE_REBASE=
 REBASE_ROOT=
+EQUAL_TREE_MARKER=
 
 GIT_CHERRY_PICK_HELP="  After resolving the conflicts,
 mark the corrected paths with 'git add <paths>', and
@@ -325,6 +327,11 @@ peek_next_command () {
 	sed -n "1s/ .*$//p" < "$TODO"
 }
 
+# is there really no already existing function for this?
+tree_of_commit() {
+	git cat-file commit "$1" | grep '^tree ' | head -n 1 | sed -e 's/^tree //'
+}
+
 do_next () {
 	rm -f "$DOTEST"/message "$DOTEST"/author-script \
 		"$DOTEST"/amend || exit
@@ -426,6 +433,25 @@ do_next () {
 	esac
 	test -s "$TODO" && return
 
+	if test t = "$(cat "$DOTEST/eqt")" ; then
+		HEADNAME=$(cat "$DOTEST"/head-name)
+		OLDHEAD=$(cat "$DOTEST"/head)
+		ONTO=$(cat "$DOTEST"/onto)
+		NEWHEAD=$(git rev-parse HEAD)
+		OLDTREE=$(tree_of_commit "$OLDHEAD")
+		NEWTREE=$(tree_of_commit HEAD)
+		if test "$NEWTREE" = "$OLDTREE" ; then
+			OLDBRANCH="$OLDHEAD"
+		else
+			echo "Creating commit with differences of '$OLDHEAD' now that is applied to '$ONTO' (tree $NEWTREE)"
+			OLDBRANCH="$( (grep '^# Rebase' "$TODO".full \
+				; grep -v '^#' "$TODO".full ) \
+				| git-commit-tree "$NEWTREE" \
+				-p "$OLDHEAD" -p "$ONTO")"
+		fi
+		git equal-tree-marker "$OLDBRANCH"
+	fi
+
 	comment_for_reflog finish &&
 	HEADNAME=$(cat "$DOTEST"/head-name) &&
 	OLDHEAD=$(cat "$DOTEST"/head) &&
@@ -605,6 +631,9 @@ first and then run 'git rebase --continue' again."
 		ONTO=$(git rev-parse --verify "$1") ||
 			die "Does not point to a valid commit: $1"
 		;;
+	--eqt)
+		EQUAL_TREE_MARKER=t
+		;;
 	--)
 		shift
 		test -z "$REBASE_ROOT" -a $# -ge 1 -a $# -le 2 ||
@@ -656,6 +685,7 @@ first and then run 'git rebase --continue' again."
 			: >"$DOTEST"/rebase-root ;;
 		esac
 		echo $ONTO > "$DOTEST"/onto
+		echo "$EQUAL_TREE_MARKER" > "$DOTEST"/eqt
 		test -z "$STRATEGY" || echo "$STRATEGY" > "$DOTEST"/strategy
 		test t = "$VERBOSE" && : > "$DOTEST"/verbose
 		if test t = "$PRESERVE_MERGES"
@@ -787,6 +817,8 @@ EOF
 
 		test -d "$REWRITTEN" || skip_unnecessary_picks
 
+		cp "$TODO" "$TODO".full
+
 		git update-ref ORIG_HEAD $HEAD
 		output git checkout $ONTO && do_rest
 		;;
