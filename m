From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Tue, 08 Dec 2009 12:13:14 +0900
Message-ID: <20091208121314.6117@nanako3.lavabit.com>
References: <cover.1259934977.git.mhagger@alum.mit.edu> <4B192701.4000308@drmicha.warpmail.net> <vpqfx7qocwl.fsf@bauges.imag.fr> <7vws12r5v2.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0912041945161.21557@intel-tinevez-2-302> <20091205062708.6117@nanako3.lavabit.com> <7vd42t6f9i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 04:13:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHqWD-0007IY-Bl
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 04:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934378AbZLHDNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 22:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934184AbZLHDNU
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 22:13:20 -0500
Received: from karen.lavabit.com ([72.249.41.33]:48674 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933138AbZLHDNT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 22:13:19 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 1F651157554;
	Mon,  7 Dec 2009 21:13:26 -0600 (CST)
Received: from 7809.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id IQV0V8F9ZW7W; Mon, 07 Dec 2009 21:13:26 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=VxKzOkUf3+4HsY/z/MfDDb5ERvhyRf2TruuWq7TEydf0wkSOyVVkx8nY7lrot0TbMLda3RWxGCvp6xe+N66vkSuOnGdMZkuLX1NLt9wQA2L8LiV7wXcZfscsiFVnzzSYEp/Jbo6inC/zchYthh17Xr4xqEOm1JsD8h/Mbnucu+k=;
  h=From:To:Cc:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vd42t6f9i.fsf@alter.siamese.dyndns.org>
Subject: [PATCH] rebase -i --autosquash: auto-squash commits
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134807>

Teach a new option, --autosquash, to the interactive rebase.
When the commit log message begins with "!fixup ...", and there
is a commit whose title begins with the same ..., automatically
modify the todo list of rebase -i so that the commit marked for
squashing come right after the commit to be modified, and change
the action of the moved commit from pick to squash.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

 Junio C Hamano <gitster@pobox.com> writes:

 > If Michael rolls his second round with your "--autosquash", or you do so
 > yourself on top of his patch, I think it _might_ be safer to mark the ones
 > automatically moved as "squash", and not as "fix", and have the users
 > explicitly change the "squash" they want to "fix" themselves.
 > Alternatively, you can also use two magic tokens (i.e. instead of one
 > "fixup!", allow people to use "squash!" and "fixup!")  and change the
 > action chosen for the moved commits to "squash" and "fixup" respectively.

 Here is a rebased and updated version of my patch from June 
 2009. It should apply cleanly on top of Michael's patch.

 Documentation/git-rebase.txt |   10 +++++++
 git-rebase--interactive.sh   |   43 +++++++++++++++++++++++++++++++
 t/t3415-rebase-autosquash.sh |   58 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 0 deletions(-)
 create mode 100755 t/t3415-rebase-autosquash.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 9b648ec..87cb62d 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -308,6 +308,16 @@ which makes little sense.
 	root commits will be rewritten to have <newbase> as parent
 	instead.
 
+--autosquash::
+	When the commit log message begins with "!squash ..." (or
+	"!fixup ..."), and there is a commit whose title begins with
+	the same ..., automatically modify the todo list of rebase -i
+	so that the commit marked for quashing come right after the 
+	commit to be modified, and change the action of the moved 
+	commit from `pick` to `squash` (or `fixup`).
++
+This option is only valid when '--interactive' option is used.
+
 include::merge-strategies.txt[]
 
 NOTES
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 30de96e..b014231 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -28,6 +28,7 @@ abort              abort rebasing process and restore original branch
 skip               skip current patch and continue rebasing process
 no-verify          override pre-rebase hook from stopping the operation
 root               rebase all reachable commmits up to the root(s)
+autosquash         move commits that begin with !squash/!fixup
 "
 
 . git-sh-setup
@@ -46,6 +47,7 @@ ONTO=
 VERBOSE=
 OK_TO_SKIP_PRE_REBASE=
 REBASE_ROOT=
+AUTOSQUASH=
 
 GIT_CHERRY_PICK_HELP="  After resolving the conflicts,
 mark the corrected paths with 'git add <paths>', and
@@ -519,6 +521,43 @@ get_saved_options () {
 	test -f "$DOTEST"/rebase-root && REBASE_ROOT=t
 }
 
+# Rearrange the todo list that has both "pick sha1 msg" and
+# "pick sha1 !fixup/!squash msg" appears in it so that the latter
+# comes immediately after the former, and change "pick" to
+# "fixup"/"squash".
+rearrange_squash () {
+	sed -n -e 's/^pick \([0-9a-f]*\) !\(squash\) /\1 \2 /p' \
+		-e 's/^pick \([0-9a-f]*\) !\(fixup\) /\1 \2 /p' \
+		"$1" >"$1.sq"
+	test -s "$1.sq" || return
+
+	sed -e '/^pick [0-9a-f]* !squash /d' \
+		-e '/^pick [0-9a-f]* !fixup /d' \
+		"$1" |
+	(
+		used=
+		while read pick sha1 message
+		do
+			echo "$pick $sha1 $message"
+			while read squash action msg
+			do
+				case " $used" in
+				*" $squash "*)
+					continue ;;
+				esac
+				case "$message" in
+				"$msg"*)
+					echo "$action $squash !$action $msg"
+					used="$used$squash "
+					;;
+				esac
+			done <"$1.sq"
+		done >"$1.rearranged"
+	)
+	cat "$1.rearranged" >"$1"
+	rm -f "$1.sq"
+}
+
 while test $# != 0
 do
 	case "$1" in
@@ -624,6 +663,9 @@ first and then run 'git rebase --continue' again."
 	--root)
 		REBASE_ROOT=t
 		;;
+	--autosquash)
+		AUTOSQUASH=t
+		;;
 	--onto)
 		shift
 		ONTO=$(git rev-parse --verify "$1") ||
@@ -783,6 +825,7 @@ first and then run 'git rebase --continue' again."
 		fi
 
 		test -s "$TODO" || echo noop >> "$TODO"
+		test -n "$AUTOSQUASH" && rearrange_squash "$TODO"
 		cat >> "$TODO" << EOF
 
 # Rebase $SHORTREVISIONS onto $SHORTONTO
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
new file mode 100755
index 0000000..5ea2073
--- /dev/null
+++ b/t/t3415-rebase-autosquash.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+
+test_description='auto squash'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo 0 > file0 &&
+	git add . &&
+	test_tick &&
+	git commit -m "initial commit" &&
+	echo 0 > file1 &&
+	echo 2 > file2 &&
+	git add . &&
+	test_tick &&
+	git commit -m "first commit" &&
+	echo 3 > file3 &&
+	git add . &&
+	test_tick &&
+	git commit -m "second commit" &&
+	git tag base
+'
+
+test_expect_success 'auto fixup' '
+	git reset --hard base &&
+	echo 1 > file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "!fixup first"
+
+	git tag final-fixup &&
+	test_tick &&
+	git rebase --autosquash -i HEAD^^^ &&
+	git log --oneline >actual &&
+	test 3 = $(wc -l <actual) &&
+	git diff --exit-code final-fixup &&
+	test 1 = "$(git cat-file blob HEAD^:file1)" &&
+	test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
+'
+
+test_expect_success 'auto squash' '
+	git reset --hard base &&
+	echo 1 > file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "!squash first"
+
+	git tag final-squash &&
+	test_tick &&
+	git rebase --autosquash -i HEAD^^^ &&
+	git log --oneline >actual &&
+	test 3 = $(wc -l <actual) &&
+	git diff --exit-code final-squash &&
+	test 1 = "$(git cat-file blob HEAD^:file1)" &&
+	test 2 = $(git cat-file commit HEAD^ | grep first | wc -l)
+'
+
+test_done
-- 
1.6.6.rc0.60.g4926




-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
