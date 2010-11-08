From: Kevin Ballard <kevin@sb.org>
Subject: [PATCHv3 1/2] rebase: better rearranging of fixup!/squash! lines with --autosquash
Date: Mon,  8 Nov 2010 02:48:02 -0800
Message-ID: <1289213283-24294-1-git-send-email-kevin@sb.org>
References: <alpine.DEB.2.00.1011051401090.7611@ds9.cixit.se>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 08 11:48:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFPGt-0004Rd-1u
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 11:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292Ab0KHKsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 05:48:13 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45380 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab0KHKsM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 05:48:12 -0500
Received: by iwn41 with SMTP id 41so3935366iwn.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 02:48:12 -0800 (PST)
Received: by 10.42.149.66 with SMTP id u2mr3526097icv.408.1289213292073;
        Mon, 08 Nov 2010 02:48:12 -0800 (PST)
Received: from localhost.localdomain ([24.130.32.253])
        by mx.google.com with ESMTPS id d21sm5901520ibg.9.2010.11.08.02.48.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 02:48:10 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.195.gc69dde
In-Reply-To: <alpine.DEB.2.00.1011051401090.7611@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160921>

The current behvaior of --autosquash can duplicate fixup!/squash! lines
if they match multiple commits, and it can also apply them to commits
that come after them in the todo list. Even more oddly, a commit that
looks like "fixup! fixup!" will match itself and be duplicated in the
todo list.

Change the todo list rearranging to mark all commits as used as soon
as they are emitted, and to avoid emitting a fixup/squash commit if the
commit has already been marked as used.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---

This patch is unchanged from v2.

 git-rebase--interactive.sh   |    4 +++
 t/t3415-rebase-autosquash.sh |   43 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e29fd91..56cfdb5 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -707,8 +707,12 @@ rearrange_squash () {
 		*" $sha1 "*) continue ;;
 		esac
 		printf '%s\n' "$pick $sha1 $message"
+		used="$used$sha1 "
 		while read -r squash action msg
 		do
+			case " $used" in
+			*" $squash "*) continue ;;
+			esac
 			case "$message" in
 			"$msg"*)
 				printf '%s\n' "$action $squash $action! $msg"
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index fd2184c..712bbe8 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -94,4 +94,47 @@ test_expect_success 'misspelled auto squash' '
 	test 0 = $(git rev-list final-missquash...HEAD | wc -l)
 '
 
+test_expect_success 'auto squash that matches 2 commits' '
+	git reset --hard base &&
+	echo 4 >file4 &&
+	git add file4 &&
+	test_tick &&
+	git commit -m "first new commit" &&
+	echo 1 >file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "squash! first" &&
+	git tag final-multisquash &&
+	test_tick &&
+	git rebase --autosquash -i HEAD~4 &&
+	git log --oneline >actual &&
+	test 4 = $(wc -l <actual) &&
+	git diff --exit-code final-multisquash &&
+	test 1 = "$(git cat-file blob HEAD^^:file1)" &&
+	test 2 = $(git cat-file commit HEAD^^ | grep first | wc -l) &&
+	test 1 = $(git cat-file commit HEAD | grep first | wc -l)
+'
+
+test_expect_success 'auto squash that matches a commit after the squash' '
+	git reset --hard base &&
+	echo 1 >file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "squash! third" &&
+	echo 4 >file4 &&
+	git add file4 &&
+	test_tick &&
+	git commit -m "third commit" &&
+	git tag final-presquash &&
+	test_tick &&
+	git rebase --autosquash -i HEAD~4 &&
+	git log --oneline >actual &&
+	test 5 = $(wc -l <actual) &&
+	git diff --exit-code final-presquash &&
+	test 0 = "$(git cat-file blob HEAD^^:file1)" &&
+	test 1 = "$(git cat-file blob HEAD^:file1)" &&
+	test 1 = $(git cat-file commit HEAD | grep third | wc -l) &&
+	test 1 = $(git cat-file commit HEAD^ | grep third | wc -l)
+'
+
 test_done
-- 
1.7.3.2.195.gc69dde
