From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: What's cooking in git.git (Jan 2010, #01; Mon, 04)
Date: Wed, 06 Jan 2010 19:18:25 +0900
Message-ID: <20100106191825.6117@nanako3.lavabit.com>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org> <7vskal5c11.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 11:19:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSSyi-0006k9-RY
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 11:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755747Ab0AFKS4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jan 2010 05:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755595Ab0AFKS4
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 05:18:56 -0500
Received: from karen.lavabit.com ([72.249.41.33]:37332 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755430Ab0AFKSz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 05:18:55 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id B0AFD11B9C3;
	Wed,  6 Jan 2010 04:18:54 -0600 (CST)
Received: from 6427.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 4DXKT4F6QMTW; Wed, 06 Jan 2010 04:18:54 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=cTaRRmD3X2ErWmXRlWLRIgmf0NfJA9zEmQSUqAsl/tYBn1Si1CPwlLl+NqFgQ2R4Zkk7S7thUzkF+7GtxecijdzzST6XYmDS72JxTkJvGjDh2tWU7BzzciS9sjKI8FlI7psCKe41uAEyQj9nuhApmroT+UNbfKkVrCjeG6U7LvQ=;
  h=From:To:Cc:Subject:X-Draft-From:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
X-Draft-From: ("nnml:git-mail" 73479)
In-Reply-To: <7vskal5c11.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136258>

Quoting Junio C Hamano <gitster@pobox.com> writes:

> These need a bit more work to go forward.  Help and follow-up are
> appreciated.
>
>  * jc/checkout-merge-base (2009-11-20) 2 commits
>    Users of "rebase -i" might want to teach this to the command.
>    Volunteers?

Let me try. I'll let others to contribute documentation updates.

-- >8 --
Subject: [PATCH] Fix rebase --onto A...B and teach the same to interact=
ive rebase

Signed-off-by: =E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=AA=E3=
=81=93 <nanako3@lavabit.com>
---
 git-rebase--interactive.sh       |   21 +++++++++++-
 git-rebase.sh                    |    4 +-
 t/t3415-rebase-onto-threedots.sh |   68 ++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 90 insertions(+), 3 deletions(-)
 create mode 100755 t/t3415-rebase-onto-threedots.sh

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 23ded48..d42cc4f 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -482,6 +482,25 @@ get_saved_options () {
 	test -f "$DOTEST"/rebase-root && REBASE_ROOT=3Dt
 }
=20
+LF=3D'
+'
+parse_onto () {
+	if	expr "$1" : '.*\.\.\.' >/dev/null &&
+		left=3D${1%...*} right=3D${1#*...} &&
+		: ${left:=3DHEAD} ${right:=3DHEAD} &&
+		onto=3D$(git merge-base "$left" "$right")
+	then
+		case "$onto" in
+		?*"$LF"?* | '')
+			exit 1 ;;
+		esac
+		echo "$onto"
+		exit 0
+	else
+		git rev-parse --verify "$1^0"
+	fi
+}
+
 while test $# !=3D 0
 do
 	case "$1" in
@@ -589,7 +608,7 @@ first and then run 'git rebase --continue' again."
 		;;
 	--onto)
 		shift
-		ONTO=3D$(git rev-parse --verify "$1") ||
+		ONTO=3D$(parse_onto "$1") ||
 			die "Does not point to a valid commit: $1"
 		;;
 	--)
diff --git a/git-rebase.sh b/git-rebase.sh
index 6503113..43c62c0 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -419,8 +419,8 @@ fi
=20
 # Make sure the branch to rebase onto is valid.
 onto_name=3D${newbase-"$upstream_name"}
-if	left=3D$(expr "$onto_name" : '\(.*\)\.\.\.') &&
-	right=3D$(expr "$onto_name" : '\.\.\.\(.*\)$') &&
+if	expr "$onto_name" : '.*\.\.\.' >/dev/null &&
+	left=3D${onto_name%...*} right=3D${onto_name#*...} &&
 	: ${left:=3DHEAD} ${right:=3DHEAD} &&
 	onto=3D$(git merge-base "$left" "$right")
 then
diff --git a/t/t3415-rebase-onto-threedots.sh b/t/t3415-rebase-onto-thr=
eedots.sh
new file mode 100755
index 0000000..c243243
--- /dev/null
+++ b/t/t3415-rebase-onto-threedots.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+
+test_description=3D'git rebase --onto A...B'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-rebase.sh"
+
+#           F---G                     G'
+#          /          -->            /
+# A---B---C---D---E         A---B---C---D---E
+
+test_expect_success setup '
+	test_commit A &&
+	test_commit B &&
+	test_commit C &&
+	git branch topic &&
+	test_commit D &&
+	test_commit E &&
+	git checkout topic &&
+	test_commit F &&
+	test_commit G
+'
+
+test_expect_success 'rebase --onto A...B' '
+	git reset --hard &&
+	git checkout topic &&
+	git reset --hard G &&
+
+	git rebase --onto master...topic HEAD^ &&
+	git rev-parse HEAD^ >actual &&
+	git rev-parse C^0 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --onto A...' '
+	git reset --hard &&
+	git checkout topic &&
+	git reset --hard G &&
+
+	git rebase --onto master... HEAD^ &&
+	git rev-parse HEAD^ >actual &&
+	git rev-parse C^0 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase -i --onto A...B' '
+	git reset --hard &&
+	git checkout topic &&
+	git reset --hard G &&
+	set_fake_editor &&
+	EXPECT_COUNT=3D1 git rebase -i --onto master...topic HEAD^ &&
+	git rev-parse HEAD^ >actual &&
+	git rev-parse C^0 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase -i --onto A...' '
+	git reset --hard &&
+	git checkout topic &&
+	git reset --hard G &&
+	set_fake_editor &&
+	EXPECT_COUNT=3D1 git rebase -i --onto master... HEAD^ &&
+	git rev-parse HEAD^ >actual &&
+	git rev-parse C^0 >expect &&
+	test_cmp expect actual
+'
+
+test_done
--=20
1.6.6

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
