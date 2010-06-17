From: Peter Krefting <peter@softwolves.pp.se>
Subject: [PATCH] Allow hashes in git rebase --interactive --autosquash.
Date: Thu, 17 Jun 2010 13:55:22 +0100
Message-ID: <20100617125746.E86B42FC00@perkele>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 17 15:00:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPEhk-0000KN-OA
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 15:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168Ab0FQNAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 09:00:16 -0400
Received: from smtp.getmail.no ([84.208.15.66]:49532 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752716Ab0FQNAP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 09:00:15 -0400
Received: from get-mta-scan03.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L450068STCBGBA0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 17 Jun 2010 14:57:47 +0200 (MEST)
Received: from get-mta-scan03.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 63ED61EEED9B_C1A1BCBB	for <git@vger.kernel.org>; Thu,
 17 Jun 2010 12:57:47 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan03.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 27B3C1EEC257_C1A1BCBF	for <git@vger.kernel.org>; Thu,
 17 Jun 2010 12:57:47 +0000 (GMT)
Received: from perkele ([84.215.142.63]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L450055STCB1S00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 17 Jun 2010 14:57:47 +0200 (MEST)
Received: by perkele (Postfix, from userid 501)	id E86B42FC00; Thu,
 17 Jun 2010 14:57:46 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149303>

In addition to matching the "fixup!" and "squash!" commits to the commit
message, also match the commit hash. This allows a commit message like
"fixup! e83c5163316f89bfbde7d9ab23ca2e25604af290" to be detected as a
fixup commit.

Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
---

I actually misread the git-rebase manual page to think that this was how
"fixup!" and "squash!" was supposed to be used, and now I have so many
"fixup! <hash>" commits to rebase that I felt it worth it to implement
support for it... :-)

 Documentation/git-rebase.txt |    8 ++++----
 git-rebase--interactive.sh   |   12 +++++++++---
 t/t3415-rebase-autosquash.sh |   17 +++++++++++++++++
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0d07b1b..e28d742 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -318,10 +318,10 @@ link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To] for details).
 --autosquash::
 	When the commit log message begins with "squash! ..." (or
 	"fixup! ..."), and there is a commit whose title begins with
-	the same ..., automatically modify the todo list of rebase -i
-	so that the commit marked for squashing comes right after the
-	commit to be modified, and change the action of the moved
-	commit from `pick` to `squash` (or `fixup`).
+	the same ..., or whose hash is ..., automatically modify the
+        todo list of rebase -i so that the commit marked for squashing
+        comes right after the commit to be modified, and change the
+        action of the moved commit from `pick` to `squash` (or `fixup`).
 +
 This option is only valid when the '--interactive' option is used.
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 436b7f5..d639ee6 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -634,9 +634,9 @@ get_saved_options () {
 }
 
 # Rearrange the todo list that has both "pick sha1 msg" and
-# "pick sha1 fixup!/squash! msg" appears in it so that the latter
-# comes immediately after the former, and change "pick" to
-# "fixup"/"squash".
+# "pick sha1 fixup!/squash! msg" or "pick sha1 fixup!/squash!
+# sha1" appears in it so that the latter comes immediately
+# after the former, and change "pick" to "fixup"/"squash".
 rearrange_squash () {
 	sed -n -e 's/^pick \([0-9a-f]*\) \(squash\)! /\1 \2 /p' \
 		-e 's/^pick \([0-9a-f]*\) \(fixup\)! /\1 \2 /p' \
@@ -658,6 +658,12 @@ rearrange_squash () {
 				used="$used$squash "
 				;;
 			esac
+			case "$msg" in
+			"$sha1"*)
+				echo "$action $squash $action! $msg"
+				used="$used$squash "
+				;;
+			esac
 		done <"$1.sq"
 	done >"$1.rearranged" <"$1"
 	cat "$1.rearranged" >"$1"
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index b63f4e2..2f1a1b4 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -38,6 +38,23 @@ test_expect_success 'auto fixup' '
 	test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
 '
 
+test_expect_success 'auto fixup with hash' '
+	git reset --hard base &&
+	echo 1 >file1 &&
+	git add -u &&
+	test_tick &&
+	git log -1 --pretty="fixup! %h" HEAD^ | git commit -F -
+
+	git tag final-fixup-hash &&
+	test_tick &&
+	git rebase --autosquash -i HEAD^^^ &&
+	git log --oneline >actual &&
+	test 3 = $(wc -l <actual) &&
+	git diff --exit-code final-fixup-hash &&
+	test 1 = "$(git cat-file blob HEAD^:file1)" &&
+	test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
+'
+
 test_expect_success 'auto squash' '
 	git reset --hard base &&
 	echo 1 >file1 &&
-- 
1.7.1
