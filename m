From: Kevin Ballard <kevin@sb.org>
Subject: [PATCHv2 1/2] rebase: better rearranging of fixup!/squash! lines with --autosquash
Date: Thu,  4 Nov 2010 15:36:31 -0700
Message-ID: <1288910192-10247-1-git-send-email-kevin@sb.org>
References: <7vr5f0vrbn.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 23:36:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE8QM-000358-3r
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 23:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287Ab0KDWgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 18:36:42 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56986 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237Ab0KDWgl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 18:36:41 -0400
Received: by pzk28 with SMTP id 28so363951pzk.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 15:36:41 -0700 (PDT)
Received: by 10.142.156.15 with SMTP id d15mr941442wfe.384.1288910201380;
        Thu, 04 Nov 2010 15:36:41 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id y42sm591214wfd.22.2010.11.04.15.36.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 15:36:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.202.g3b863.dirty
In-Reply-To: <7vr5f0vrbn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160787>

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
This patch is unchanged from the previous version.

 git-rebase--interactive.sh   |    4 +++
 t/t3415-rebase-autosquash.sh |   43 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a27952d..379bbac 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -687,8 +687,12 @@ rearrange_squash () {
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
1.7.3.2.202.g3b863.dirty
