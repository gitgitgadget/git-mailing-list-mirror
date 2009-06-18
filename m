From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH v2] rebase -i --autosquash: auto-squash commits
Date: Fri, 19 Jun 2009 06:55:34 +0900
Message-ID: <20090619065534.6117@nanako3.lavabit.com>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	<43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	<7vvdmurfao.fsf@alter.siamese.dyndns.org>
	<20090618063348.6117@nanako3.lavabit.com>
	<7vvdmu15j0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Jakub Narebski <jnareb@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	John Tapsell <johnflux@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 23:56:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHPam-0006bP-A2
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 23:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879AbZFRV4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 17:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754761AbZFRV4H
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 17:56:07 -0400
Received: from karen.lavabit.com ([72.249.41.33]:34550 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754214AbZFRV4E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 17:56:04 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 4A07011B7BD;
	Thu, 18 Jun 2009 16:56:06 -0500 (CDT)
Received: from 8349.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id CUUCDA0Y5K69; Thu, 18 Jun 2009 16:56:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=5e6SOX8XtERukZv4GknWGvNjMiZu5mjlznHxtimUJ58NocndPU4E8tsK29oB8scbxYdHdc6KOoNWGgPzIOw4bvcZyijUSGMPStTJczQUvey40hsXhL0xlyebbWvgsOV1Oklf0/AAxifhHL7VNO8Ij0MzRrkNOro+fvaZk3DaAlg=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vvdmu15j0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121874>

Teach a new option, --autosquash, to the interactive rebase.
When the commit log message begins with "!fixup ...", and there
is a commit whose title begins with the same ..., automatically
modify the todo list of rebase -i so that the commit marked for
squashing come right after the commit to be modified, and change
the action of the moved commit from pick to squash.

This will help the use case outlined in

    From: Junio C Hamano <gitster@pobox.com>
    Date: Wed, 17 Jun 2009 09:33:19 -0700
    Subject: Re: git rebase --interactive squash/squish/fold/rollup
    Message-ID: <7vvdmurfao.fsf@alter.siamese.dyndns.org>

and further explained in

    From: Junio C Hamano <gitster@pobox.com>
    Date: Thu, 18 Jun 2009 00:54:47 -0700
    Subject: Re: [PATCH] rebase -i: auto-squash commits
    Message-ID: <7vws7ayo1k.fsf@alter.siamese.dyndns.org>

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

Changes from my yesterday's patch are as follows.

 * The feature is disabled by default; the user needs to explicitly ask for it with --autosquash option.
 * Squashing more than one commits to the same commit should work.
 * The commit message must begin with a more magic string "!fixup" instead of "squash to".
 * Commands in the test script are joined with &&.
 * The test examines the content of the file to verify that the commit was correctly squashed.
 * Add documentation.

 Documentation/git-rebase.txt |    9 +++++++++
 git-rebase--interactive.sh   |   35 +++++++++++++++++++++++++++++++++++
 t/t3414-rebase-autosquash.sh |   37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 0 deletions(-)
 create mode 100755 t/t3414-rebase-autosquash.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 26f3b7b..0c2f99e 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -293,6 +293,15 @@ OPTIONS
 	root commits will be rewritten to have <newbase> as parent
 	instead.
 
+--autosquash::
+	When the commit log message begins with "!fixup ...", and there
+	is a commit whose title begins with the same ..., automatically
+	modify the todo list of rebase -i so that the commit marked for
+	squashing come right after the commit to be modified, and change
+	the action of the moved commit from pick to squash.
++
+This option is only valid when '--interactive' option is used.
+
 include::merge-strategies.txt[]
 
 NOTES
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f96d887..6e223d5 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -28,6 +28,7 @@ abort              abort rebasing process and restore original branch
 skip               skip current patch and continue rebasing process
 no-verify          override pre-rebase hook from stopping the operation
 root               rebase all reachable commmits up to the root(s)
+autosquash         automatically squash commits that begin with !fixup
 "
 
 . git-sh-setup
@@ -46,6 +47,7 @@ ONTO=
 VERBOSE=
 OK_TO_SKIP_PRE_REBASE=
 REBASE_ROOT=
+AUTOSQUASH=
 
 GIT_CHERRY_PICK_HELP="  After resolving the conflicts,
 mark the corrected paths with 'git add <paths>', and
@@ -482,6 +484,35 @@ get_saved_options () {
 	test -f "$DOTEST"/rebase-root && REBASE_ROOT=t
 }
 
+# Rearrange the todo list that has both "pick sha1 msg" and
+# "pick sha1 !fixup msg" appears in it so that the latter
+# comes immediately after the former, and change "pick" to
+# "squash".
+rearrange_squash () {
+	sed -n -e 's/^pick \([0-9a-f]*\) !fixup /\1 /p' "$1" >"$1.sq"
+	test -s "$1.sq" || return
+
+	used=
+	while read pick sha1 message
+	do
+		case " $used" in
+		*" $sha1 "*) continue ;;
+		esac
+		echo "$pick $sha1 $message"
+		while read squash msg
+		do
+			case "$message" in
+			"$msg"*)
+				echo "squash $squash !fixup $msg"
+				used="$used$squash "
+				;;
+			esac
+		done <"$1.sq"
+	done <"$1" >"$1.rearranged"
+
+	cat "$1.rearranged" >"$1"
+}
+
 while test $# != 0
 do
 	case "$1" in
@@ -587,6 +618,9 @@ first and then run 'git rebase --continue' again."
 	--root)
 		REBASE_ROOT=t
 		;;
+	--autosquash)
+		AUTOSQUASH=t
+		;;
 	--onto)
 		shift
 		ONTO=$(git rev-parse --verify "$1") ||
@@ -746,6 +780,7 @@ first and then run 'git rebase --continue' again."
 		fi
 
 		test -s "$TODO" || echo noop >> "$TODO"
+		test -n "$AUTOSQUASH" && rearrange_squash "$TODO"
 		cat >> "$TODO" << EOF
 
 # Rebase $SHORTREVISIONS onto $SHORTONTO
diff --git a/t/t3414-rebase-autosquash.sh b/t/t3414-rebase-autosquash.sh
new file mode 100755
index 0000000..161cab4
--- /dev/null
+++ b/t/t3414-rebase-autosquash.sh
@@ -0,0 +1,37 @@
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
+	git commit -m "second commit"
+'
+
+test_expect_success 'auto squash' '
+	echo 1 > file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "!fixup first"
+	git tag final &&
+	test_tick &&
+	git rebase --autosquash -i HEAD^^^ &&
+	git log --oneline >actual &&
+	test 3 = $(wc -l <actual) &&
+	git diff --exit-code final &&
+	test 1 = "$(git cat-file blob HEAD^:file1)"
+'
+
+test_done
-- 
1.6.2.GIT

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
