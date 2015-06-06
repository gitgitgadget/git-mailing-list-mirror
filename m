From: Kevin Daudt <me@ikke.info>
Subject: [PATCH v2 2/2] pull: allow dirty tree when rebase.autostash enabled
Date: Sat,  6 Jun 2015 23:12:25 +0200
Message-ID: <1433625145-29668-2-git-send-email-me@ikke.info>
References: <1433625145-29668-1-git-send-email-me@ikke.info>
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Kevin daudt <me@ikke.info>, Kevin Daudt <compufreak@gmail.com>
To: "Junio C. Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 23:12:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1LOh-0001zM-DG
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 23:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbbFFVMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 17:12:46 -0400
Received: from ikke.info ([178.21.113.177]:51654 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932432AbbFFVMo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 17:12:44 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
	id A5E7E1DCF6F; Sat,  6 Jun 2015 23:12:43 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on vps892.directvps.nl
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.1
Received: from ikke-laptop.ikke (unknown [10.8.0.6])
	by vps892.directvps.nl (Postfix) with ESMTP id 70CED1DCF6E;
	Sat,  6 Jun 2015 23:12:39 +0200 (CEST)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433625145-29668-1-git-send-email-me@ikke.info>
In-Reply-To: <1433282157-8171-1-git-send-email-me@ikke.info>
References: <1433282157-8171-1-git-send-email-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270954>

From: Kevin Daudt <compufreak@gmail.com>

rebase learned to stash changes when it encounters a dirty work tree, but
git pull --rebase does not.

Only verify if the working tree is dirty when rebase.autostash is not
enabled.

Signed-off-by: Kevin Daudt <me@ikke.info>
Helped-by: Paul Tan <pyokagan@gmail.com>
---
 git-pull.sh     |  5 ++++-
 t/t5520-pull.sh | 12 ++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

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
index 925ad49..d06119f 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -135,6 +135,18 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
 	test_cmp file expect
 '
 
+test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
+	test_config branch.to-rebase.rebase true &&
+	test_config rebase.autostash true &&
+	git checkout HEAD -- file &&
+	echo dirty > new_file &&
+	git add new_file &&
+	git pull . copy &&
+	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
+	test $(cat new_file) = dirty &&
+	test "$(cat file)" = "modified again"
+'
+
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
-- 
2.4.2
