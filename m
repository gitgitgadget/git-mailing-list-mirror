From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Mon, 14 Apr 2008 02:21:00 +0200
Message-ID: <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 02:53:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlCwy-0004J2-Nv
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 02:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbYDNAwO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 20:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753988AbYDNAwN
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 20:52:13 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1651 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753745AbYDNAv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 20:51:57 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id ED8844880A7; Mon, 14 Apr 2008 02:51:55 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRZ-0006II-PF; Mon, 14 Apr 2008 02:21:10 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRZ-0006ta-Cf; Mon, 14 Apr 2008 02:21:09 +0200
X-Mailer: git-send-email 1.5.5
In-Reply-To: <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79441>

This new command can be used to set symbolic marks for an commit while
doing a rebase. This symbolic name can later be used for merges or
resets.

The decision to use references for the marks and not files like done wi=
th
the rewritten commits for preserve merges was made to ensure no commit
objects get lost if prune is started while (a long term) rebase is
running. This also unifies the checking of the validity of marks and
references by using rev-parse for it.

The usage of : as the sign for marks conforms with the tag sign of
fast-export and fast-import.

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 git-rebase--interactive.sh    |   37 +++++++++++++++++++++++++++++++++=
+++-
 t/t3404-rebase-interactive.sh |   17 +++++++++++++++++
 2 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 531ee94..6ac316a 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -35,6 +35,8 @@ mark the corrected paths with 'git add <paths>', and
 run 'git rebase --continue'"
 export GIT_CHERRY_PICK_HELP
=20
+mark_prefix=3Drefs/rebase-marks/
+
 warn () {
 	echo "$*" >&2
 }
@@ -105,7 +107,13 @@ die_with_patch () {
 }
=20
 cleanup_before_quit () {
-	rm -rf "$DOTEST"
+	rm -rf "$DOTEST" &&
+	for ref in "$GIT_DIR/$mark_prefix"*
+	do
+		test "$ref" =3D "$GIT_DIR/$mark_prefix*" && continue
+		git update-ref -d "${ref#$GIT_DIR/}" "${ref#$GIT_DIR/}" || \
+			return 1
+	done
 }
=20
 die_abort () {
@@ -244,6 +252,19 @@ peek_next_command () {
 	sed -n "1s/ .*$//p" < "$TODO"
 }
=20
+mark_to_ref () {
+	case "$1" in
+	:[!/]*)
+		# :/SOMETHING is a reference for the last commit whose
+                # message starts with SOMETHING
+		echo "$mark_prefix${1#:}"
+		;;
+	*)
+		echo "$1"
+		;;
+	esac
+}
+
 do_next () {
 	rm -f "$DOTEST"/message "$DOTEST"/author-script \
 		"$DOTEST"/amend || exit
@@ -321,6 +342,15 @@ do_next () {
 			die_with_patch $sha1 ""
 		fi
 		;;
+	mark)
+		mark_action_done
+
+		mark=3D$(mark_to_ref :${sha1#:})
+		git rev-parse --verify "$mark" > /dev/null 2>&1 && \
+			warn "mark $sha1 already exist; overwriting it"
+
+		git update-ref "$mark" HEAD || die "update-ref failed"
+		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
 		die_with_patch $sha1 "Please fix this in the file $TODO."
@@ -533,10 +563,15 @@ do
=20
 # Rebase $SHORTUPSTREAM..$SHORTHEAD onto $SHORTONTO
 #
+# In the todo insn whenever you need to refer to a commit, in addition
+# to the usual commit object name, you can use ':mark' syntax to refer
+# to a commit previously marked with the 'mark' insn.
+#
 # Commands:
 #  pick =3D use commit
 #  edit =3D use commit, but stop for amending
 #  squash =3D use commit, but meld into previous commit
+#  mark :mark =3D mark the current HEAD for later reference
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 8d29878..fa3560e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -82,6 +82,9 @@ for line in $FAKE_LINES; do
 	case $line in
 	squash|edit)
 		action=3D"$line";;
+	mark*)
+		echo "mark ${line#mark}"
+		echo "mark ${line#mark}" >> "$1";;
 	*)
 		echo sed -n "${line}s/^pick/$action/p"
 		sed -n "${line}p" < "$1".tmp
@@ -189,6 +192,20 @@ test_expect_success '-p handles "no changes" grace=
fully' '
 	test $HEAD =3D $(git rev-parse HEAD)
 '
=20
+test_expect_success 'setting marks works' '
+	git checkout master &&
+	FAKE_LINES=3D"mark:0 2 1 mark:42 3 edit 4" git rebase -i HEAD~4 &&
+	marks_dir=3D.git/refs/rebase-marks &&
+	test -d $marks_dir &&
+	test $(ls $marks_dir | wc -l) -eq 2 &&
+	test "$(git rev-parse HEAD~4)" =3D \
+		"$(git rev-parse refs/rebase-marks/0)" &&
+	test "$(git rev-parse HEAD~2)" =3D \
+		"$(git rev-parse refs/rebase-marks/42)" &&
+	git rebase --abort &&
+	ls $marks_dir | wc -l | grep -Fx 0
+'
+
 test_expect_success 'preserve merges with -p' '
 	git checkout -b to-be-preserved master^ &&
 	: > unrelated-file &&
--=20
1.5.5
