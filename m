From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH 1/2] rebase: better rearranging of fixup!/squash! lines with --autosquash
Date: Wed,  3 Nov 2010 19:41:43 -0700
Message-ID: <1288838504-69114-1-git-send-email-kevin@sb.org>
Cc: Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 03:42:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDpm6-00066a-3y
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 03:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987Ab0KDClz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 22:41:55 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61896 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824Ab0KDCly (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 22:41:54 -0400
Received: by pwj7 with SMTP id 7so88034pwj.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 19:41:54 -0700 (PDT)
Received: by 10.142.218.15 with SMTP id q15mr58725wfg.405.1288838514169;
        Wed, 03 Nov 2010 19:41:54 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id e36sm14620504wfj.14.2010.11.03.19.41.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 19:41:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.201.g24941.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160679>

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
1.7.3.2.201.g24941.dirty
