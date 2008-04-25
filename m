From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH v2.2] Teach rebase interactive the mark command
Date: Fri, 25 Apr 2008 11:44:48 +0200
Message-ID: <1209116688-12266-1-git-send-email-joerg@alea.gnuu.de>
References: <20080425091117.GA23726@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 11:48:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpKXd-0005VX-PD
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 11:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759185AbYDYJrn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Apr 2008 05:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759126AbYDYJrm
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 05:47:42 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:2485 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758602AbYDYJrg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 05:47:36 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 47305EC057; Fri, 25 Apr 2008 11:47:35 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JpKU4-0004gf-Nm; Fri, 25 Apr 2008 11:44:48 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JpKU4-0003CC-E5; Fri, 25 Apr 2008 11:44:48 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <20080425091117.GA23726@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80334>

This new command can be used to set symbolic marks for an commit while
doing a rebase. This symbolic name can later be used for merges or
resets.

The decision to use references for the marks and not files like done wi=
th
the rewritten commits for preserve merges was made to ensure no commit
objects get lost if prune is started while (a long term) rebase is
running. This also unifies the checking of the validity of marks and
references by using rev-parse for it.

The format of the marks is as close as possible to the format of the
marks used by fast-export and fast-import, i.e. :001 =3D=3D :1 and =E2=80=
=9C:12a=E2=80=9D is
an invalid mark. It differs from the format of fast-import in that poin=
t
that the colon is not required after the mark command, i.e. =E2=80=9Cma=
rk 12=E2=80=9D is
the same as =E2=80=9Cmark :12=E2=80=9D. This should ease the writing of=
 commads.

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 git-rebase--interactive.sh    |   31 +++++++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh |   17 +++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

That's the diff to the last version:
>diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>index eaf5563..1751b08 100755
>--- a/git-rebase--interactive.sh
>+++ b/git-rebase--interactive.sh
>@@ -105,13 +105,11 @@ die_with_patch () {
> }
>=20
> cleanup_before_quit () {
>-	rm -rf "$DOTEST" &&
>-	for ref in "$GIT_DIR/$mark_prefix"*
>+	for ref in $(git for-each-ref --format=3D'%(refname)' "${mark_prefix=
%/}")
> 	do
>-		test "$ref" =3D "$GIT_DIR/$mark_prefix*" && continue
>-		git update-ref -d "${ref#$GIT_DIR/}" "${ref#$GIT_DIR/}" || \
>-			return 1
>+		git update-ref -d "$ref" "$ref" || return 1
> 	done
>+	rm -rf "$DOTEST"
> }
>=20
> die_abort () {
>@@ -194,14 +192,12 @@ peek_next_command () {
> }
>=20
> mark_to_ref () {
>-	case "$1" in
>-	:[0-9]*)
>-		echo "$mark_prefix$(printf %d ${1#:} 2>/dev/null)"
>-		;;
>-	*)
>+	if expr match "$1" "^:[0-9][0-9]*$" >/dev/null
>+	then
>+		echo "$mark_prefix$(printf %d ${1#:})"
>+	else
> 		echo "$1"
>-		;;
>-	esac
>+	fi
> }
>=20
> do_next () {
>@@ -285,6 +281,8 @@ do_next () {
> 		mark_action_done
>=20
> 		mark=3D$(mark_to_ref :${sha1#:})
>+		test :${sha1#:} =3D "$mark" && die "Invalid mark '$sha1'"
>+
> 		git rev-parse --verify "$mark" > /dev/null 2>&1 && \
> 			warn "mark $sha1 already exist; overwriting it"
>=20


diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 531ee94..c0abc01 100755
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
@@ -105,6 +107,10 @@ die_with_patch () {
 }
=20
 cleanup_before_quit () {
+	for ref in $(git for-each-ref --format=3D'%(refname)' "${mark_prefix%=
/}")
+	do
+		git update-ref -d "$ref" "$ref" || return 1
+	done
 	rm -rf "$DOTEST"
 }
=20
@@ -244,6 +250,15 @@ peek_next_command () {
 	sed -n "1s/ .*$//p" < "$TODO"
 }
=20
+mark_to_ref () {
+	if expr match "$1" "^:[0-9][0-9]*$" >/dev/null
+	then
+		echo "$mark_prefix$(printf %d ${1#:})"
+	else
+		echo "$1"
+	fi
+}
+
 do_next () {
 	rm -f "$DOTEST"/message "$DOTEST"/author-script \
 		"$DOTEST"/amend || exit
@@ -321,6 +336,17 @@ do_next () {
 			die_with_patch $sha1 ""
 		fi
 		;;
+	mark)
+		mark_action_done
+
+		mark=3D$(mark_to_ref :${sha1#:})
+		test :${sha1#:} =3D "$mark" && die "Invalid mark '$sha1'"
+
+		git rev-parse --verify "$mark" > /dev/null 2>&1 && \
+			warn "mark $sha1 already exist; overwriting it"
+
+		git update-ref "$mark" HEAD || die "update-ref failed"
+		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
 		die_with_patch $sha1 "Please fix this in the file $TODO."
@@ -533,10 +559,15 @@ do
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
1.5.5.1
