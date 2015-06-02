From: Kevin Daudt <me@ikke.info>
Subject: [PATCH] pull: allow dirty tree when rebase.autostash enabled
Date: Tue,  2 Jun 2015 23:55:57 +0200
Message-ID: <1433282157-8171-1-git-send-email-me@ikke.info>
Cc: git@vger.kernel.org, Kevin daudt <me@ikke.info>
To: "Junio C. Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 23:56:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzuAN-0000FL-N1
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 23:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbbFBV4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 17:56:04 -0400
Received: from ikke.info ([178.21.113.177]:49113 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbbFBV4C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 17:56:02 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
	id C9E7A1DCF70; Tue,  2 Jun 2015 23:56:00 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on vps892.directvps.nl
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.1
Received: from ikke-laptop.ikke (unknown [10.8.0.6])
	by vps892.directvps.nl (Postfix) with ESMTP id BCA061DCF6D;
	Tue,  2 Jun 2015 23:55:59 +0200 (CEST)
X-Mailer: git-send-email 2.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270612>

rebase learned to stash changes when it encounters a dirty work tree, but
git pull --rebase does not.

Only verify if the working tree is dirty when rebase.autostash is not
enabled.
---
 git-pull.sh     |  5 ++++-
 t/t5520-pull.sh | 17 +++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/git-pull.sh b/git-pull.sh
index 0917d0d..6b9e8a3 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -239,7 +239,10 @@ test true = "$rebase" && {
 			die "$(gettext "updating an unborn branch with changes added to the index")"
 		fi
 	else
-		require_clean_work_tree "pull with rebase" "Please commit or stash them."
+		if [ $(git config --bool --get rebase.autostash || echo false) = "false" ]
+		then
+			require_clean_work_tree "pull with rebase" "Please commit or stash them."
+		fi
 	fi
 	oldremoteref= &&
 	test -n "$curr_branch" &&
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 7efd45b..d849a19 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -297,6 +297,23 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
 
 '
 
+test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
+
+	test_when_finished "git rm -f file4" && 
+	git checkout to-rebase &&
+	git update-ref refs/remotes/me/copy copy^ &&
+	COPY=$(git rev-parse --verify me/copy) &&
+	git rebase --onto $COPY copy &&
+	test_config branch.to-rebase.remote me &&
+	test_config branch.to-rebase.merge refs/heads/copy &&
+	test_config branch.to-rebase.rebase true &&
+	test_config rebase.autostash true &&
+	echo dirty >> file4 &&
+	git add file4 &&
+	git pull
+
+'
+
 test_expect_success 'pull --rebase works on branch yet to be born' '
 	git rev-parse master >expect &&
 	mkdir empty_repo &&
-- 
2.4.2
