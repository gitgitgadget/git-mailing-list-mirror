From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH 4/4] git-rebase -i: New option to support rebase with merges
Date: Sun, 23 Mar 2008 22:42:42 +0100
Message-ID: <1206308562-31489-4-git-send-email-joerg@alea.gnuu.de>
References: <1206308562-31489-1-git-send-email-joerg@alea.gnuu.de>
 <1206308562-31489-2-git-send-email-joerg@alea.gnuu.de>
 <1206308562-31489-3-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, B.Steinbrink@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 23 22:47:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdY2W-0007dT-5U
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 22:47:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbYCWVq7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Mar 2008 17:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755312AbYCWVq7
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 17:46:59 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:4010 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754511AbYCWVqr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 17:46:47 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id CE15348802E; Sun, 23 Mar 2008 22:46:45 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JdXxk-0004pE-OR; Sun, 23 Mar 2008 22:42:48 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JdXxj-0008CV-1e; Sun, 23 Mar 2008 22:42:43 +0100
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1206308562-31489-3-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77964>

The option --preserve-merges does not allow to change the order of
commits or squash them. The new option --linear-history does support
this, but doing so it can only look at the commits reachable with throu=
gh
the first parent of each merge.

Joining merge commits with other commits leads to problems, because git
merge fails with a dirty index (the case =E2=80=9CCOMMIT squash MERGE=E2=
=80=9D) and
squashing a merge leads to the lost of the parents (case =E2=80=9CMERGE=
 squash
COMMIT=E2=80=9D). Therefore, I've prohibited these cases.

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 Documentation/git-rebase.txt  |    8 ++++
 git-rebase--interactive.sh    |   27 +++++++++++++++-
 t/t3404-rebase-interactive.sh |   72 +++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 106 insertions(+), 1 deletions(-)

I had no better idea for a name of this new option. Propositions are
welcome.

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index e0412e0..354b6f0 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 'git-rebase' [-i | --interactive] [-v | --verbose] [-m | --merge]
 	[-s <strategy> | --strategy=3D<strategy>]
 	[-C<n>] [ --whitespace=3D<option>] [-p | --preserve-merges]
+	[-l | --linear-history]
 	[--onto <newbase>] <upstream> [<branch>]
 'git-rebase' --continue | --skip | --abort
=20
@@ -247,6 +248,13 @@ OPTIONS
 	Instead of ignoring merges, try to recreate them.  This option
 	only works in interactive mode.
=20
+-l, \--linear-history::
+	Use only commits of the branch they are not merged in, i.e.
+	follow only the first parent of a merge. Merges are part of this
+	list and they will be redone. It's possible to move merges in the
+	history forward and backward, but they can't take part on a join
+	(squash). This option only works in interactive mode.
+
 include::merge-strategies.txt[]
=20
 NOTES
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 94c6827..a2a61f8 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -26,9 +26,11 @@ REWRITTEN=3D"$DOTEST"/rewritten
 PRESERVE_MERGES=3D
 STRATEGY=3D
 VERBOSE=3D
+LINEAR_HISTORY=3D
 test -d "$REWRITTEN" && PRESERVE_MERGES=3Dt
 test -f "$DOTEST"/strategy && STRATEGY=3D"$(cat "$DOTEST"/strategy)"
 test -f "$DOTEST"/verbose && VERBOSE=3Dt
+test -f "$DOTEST"/linear_history && LINEAR_HISTORY=3Dt
=20
 GIT_CHERRY_PICK_HELP=3D"  After resolving the conflicts,
 mark the corrected paths with 'git add <paths>', and
@@ -150,7 +152,18 @@ pick_one () {
 		sha1=3D$(git rev-parse --short $sha1)
 		output warn Fast forward to $sha1
 	else
-		output git cherry-pick "$@"
+		if test t =3D "$LINEAR_HISTORY" &&
+			other_parents=3D"$(parents_of_commit $sha1 | cut -s -d' ' -f2-)" &&
+			test -n "$other_parents"
+		then
+			if test a"$1" =3D a-n
+			then
+				merge_opt=3D--no-commit
+			fi
+			redo_merge $sha1 $no_commit $other_parents
+		else
+			output git cherry-pick "$@"
+		fi
 	fi
 }
=20
@@ -288,6 +301,11 @@ do_next () {
 		has_action "$DONE" ||
 			die "Cannot 'squash' without a previous commit"
=20
+		test t =3D "$LINEAR_HISTORY" &&
+			( test "$(parents_of_commit HEAD |wc -w)" -gt 1 ||
+				 test "$(parents_of_commit $sha1 |wc -w)" -gt 1) &&
+			die "Joining a merge with a commit is not supported"
+
 		mark_action_done
 		make_squash_message $sha1 > "$MSG"
 		case "$(peek_next_command)" in
@@ -459,6 +477,9 @@ do
 	-i|--interactive)
 		# yeah, we know
 		;;
+	-l|--linear-history)
+		LINEAR_HISTORY=3Dt
+		;;
 	''|-h)
 		usage
 		;;
@@ -522,6 +543,10 @@ do
 					die "Could not init rewritten commits"
 			done
 			MERGES_OPTION=3D
+		elif test t =3D "$LINEAR_HISTORY"
+		then
+			: > "$DOTEST"/linear_history
+			MERGES_OPTION=3D--first-parent
 		else
 			MERGES_OPTION=3D--no-merges
 		fi
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 9cf873f..0476f6a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -361,4 +361,76 @@ test_expect_success 'rebase with a file named HEAD=
 in worktree' '
=20
 '
=20
+test_expect_success 'rebase linear history preserves merges' '
+	git tag linear-history-base to-be-preserved~2
+	git checkout -b linear-history linear-history-base &&
+	for i in 1 2 3
+	do
+		test $? -eq 0 &&
+		echo linear history test > lin-h-$i &&
+		git add lin-h-$i &&
+		test_tick &&
+	       	git commit -m "rebase linear history commit $i"
+	done
+	test_tick &&
+	git merge to-be-preserved &&
+	old_head=3D$(git rev-parse HEAD) &&
+	test_tick &&
+	EXPECT_COUNT=3D4 FAKE_LINES=3D"2 4 edit 1 3" \
+		git rebase -v -i -l linear-history-base &&
+	EXPECT_COUNT=3Dinvalid git rebase --continue &&
+	test "$(git rev-list --parents -1 HEAD~2 | cut -d" " -f3-)" =3D \
+		"$(git rev-parse to-be-preserved)" &&
+	test "$(git show HEAD~2: | grep ^lin-h- | cut -c7- | tr -d \\012)" =3D=
 2 &&
+	test "$(git show HEAD~1: | grep ^lin-h- | cut -c7- | tr -d \\012)" =3D=
 12 &&
+	test "$(git cat-file commit HEAD | sed -n "/^tree/{p;q;}")" =3D \
+		"$(git cat-file commit $old_head | sed -n "/^tree/{p;q;}")"
+'
+
+test_expect_success 'rebase linear history is noop, if base =3D base' =
'
+	old_head=3D$(git rev-parse HEAD) &&
+	test_tick &&
+	EXPECT_COUNT=3D4 git rebase -v -i -l linear-history-base &&
+	test "$(git rev-parse HEAD)" =3D $old_head
+'
+
+test_expect_success 'ensure rebase linear history persits across edits=
' '
+	old_head=3D$(git rev-parse HEAD) &&
+	test_tick &&
+	EXPECT_COUNT=3D4 FAKE_LINES=3D"edit 1 2 3 4" \
+		git rebase -v -i -l linear-history-base &&
+	EXPECT_COUNT=3Dinvalid git rebase --continue &&
+	test "$(git rev-parse HEAD)" =3D $old_head
+'
+
+test_str=3D'test_tick &&
+	(
+		outp=3D$(test_must_fail git rebase -v -i -l HEAD~3 2>&1)
+		rc=3D$?
+		echo "$outp"
+        	echo "$outp" | grep "^Joining .* not supported\$" >/dev/null =
&&
+		return $rc
+	) &&
+	git rebase --abort'
+
+test_expect_success 'rebase linear with squashing a merge fails' "
+	export EXPECT_COUNT=3D3 FAKE_LINES=3D'1 squash 2 3' &&
+	$test_str &&
+	FAKE_LINES=3D'2 squash 1 3' &&
+	$test_str
+"
+
+test_expect_success 'rebase linear history does a fast forward' '
+	old_head=3D$(git rev-parse HEAD) &&
+	test_tick &&
+	EXPECT_COUNT=3D4 FAKE_LINES=3D"2 3 4 1" \
+		git rebase -v -i -l linear-history-base &&
+	test "$(git rev-parse HEAD~3)" =3D "$(git rev-parse to-be-preserved)"=
 &&
+	test "$(git show HEAD~2: | grep ^lin-h- | cut -c7- | tr -d \\012)" =3D=
 1 &&
+	test "$(git show HEAD~1: | grep ^lin-h- | cut -c7- | tr -d \\012)" =3D=
 13 &&
+	test -z "$(git rev-list --parents -1 HEAD~3 | cut -d" " -f3-)" &&
+	test "$(git cat-file commit HEAD | sed -n "/^tree/{p;q;}")" =3D \
+		"$(git cat-file commit $old_head | sed -n "/^tree/{p;q;}")"
+'
+
 test_done
--=20
1.5.4.4
