From: Kevin Daudt <me@ikke.info>
Subject: [PATCH v3] pull: allow dirty tree when rebase.autostash enabled
Date: Wed, 17 Jun 2015 13:01:20 +0200
Message-ID: <1434538880-15608-1-git-send-email-me@ikke.info>
References: <1433625145-29668-2-git-send-email-me@ikke.info>
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Kevin daudt <me@ikke.info>
To: "Junio C. Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 13:01:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5B68-0003qa-7u
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 13:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbbFQLBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 07:01:31 -0400
Received: from ikke.info ([178.21.113.177]:57809 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859AbbFQLBb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 07:01:31 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
	id 127A84400B1; Wed, 17 Jun 2015 13:01:30 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on vps892.directvps.nl
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.1
Received: from ikke-laptop.ikke (unknown [10.8.0.6])
	by vps892.directvps.nl (Postfix) with ESMTP id 0002B44007E;
	Wed, 17 Jun 2015 13:01:28 +0200 (CEST)
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1433625145-29668-2-git-send-email-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271830>

rebase learned to stash changes when it encounters a dirty work tree, but
git pull --rebase does not.

Only verify if the working tree is dirty when rebase.autostash is not
enabled.

Signed-off-by: Kevin Daudt <me@ikke.info>
Helped-by: Paul Tan <pyokagan@gmail.com>
---
Changes to v2:
 - Dropped the change of the existing --rebase test
 - Improvements to the test.

Verified that the test fails before the change, and succeeds after the change.

 git-pull.sh     |  5 ++++-
 t/t5520-pull.sh | 11 +++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/git-pull.sh b/git-pull.sh
index 0917d0d..f0a3b6e 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -239,7 +239,10 @@ test true = "$rebase" && {
 			die "$(gettext "updating an unborn branch with changes added to the index")"
 		fi
 	else
-		require_clean_work_tree "pull with rebase" "Please commit or stash them."
+		if [ $(git config --bool --get rebase.autostash || echo false) = false ]
+		then
+			require_clean_work_tree "pull with rebase" "Please commit or stash them."
+		fi
 	fi
 	oldremoteref= &&
 	test -n "$curr_branch" &&
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index af31f04..aa247ec 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -233,6 +233,17 @@ test_expect_success '--rebase fails with multiple branches' '
 	test modified = "$(git show HEAD:file)"
 '
 
+test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
+	test_config rebase.autostash true &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	git pull --rebase . copy &&
+	test_cmp_rev HEAD^ copy &&
+	test "$(cat new_file)" = dirty &&
+	test "$(cat file)" = "modified again"
+'
+
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
-- 
2.4.3
