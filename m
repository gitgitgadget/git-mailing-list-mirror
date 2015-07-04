From: Kevin Daudt <me@ikke.info>
Subject: [PATCH v4] pull: allow dirty tree when rebase.autostash enabled
Date: Sat,  4 Jul 2015 23:42:38 +0200
Message-ID: <1436046158-19426-1-git-send-email-me@ikke.info>
References: <1434538880-15608-1-git-send-email-me@ikke.info>
Cc: "Junio C. Hamano" <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>, Kevin Daudt <me@ikke.info>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 05 11:33:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBgIm-0004ld-QP
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jul 2015 11:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755105AbbGEJd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 05:33:28 -0400
Received: from ikke.info ([178.21.113.177]:40232 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753668AbbGEJdR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 05:33:17 -0400
Received: by vps892.directvps.nl (Postfix, from userid 182)
	id E6E744400B2; Sat,  4 Jul 2015 23:47:29 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on vps892.directvps.nl
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.1
Received: from io.home (unknown [10.8.0.30])
	by vps892.directvps.nl (Postfix) with ESMTP id A2914440082;
	Sat,  4 Jul 2015 23:47:24 +0200 (CEST)
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1434538880-15608-1-git-send-email-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273354>

rebase learned to stash changes when it encounters a dirty work tree, but
git pull --rebase does not.

Only verify if the working tree is dirty when rebase.autostash is not
enabled.

Signed-off-by: Kevin Daudt <me@ikke.info>
Helped-by: Paul Tan <pyokagan@gmail.com>
---
 git-pull.sh     |  3 ++-
 t/t5520-pull.sh | 11 +++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/git-pull.sh b/git-pull.sh
index a814bf6..ff28d3f 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -284,7 +284,8 @@ test true = "$rebase" && {
 		then
 			die "$(gettext "updating an unborn branch with changes added to the index")"
 		fi
-	else
+	elif test $(git config --bool --get rebase.autostash || echo false) = false
+	then
 		require_clean_work_tree "pull with rebase" "Please commit or stash them."
 	fi
 	oldremoteref= &&
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index f4a7193..a0013ee 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -245,6 +245,17 @@ test_expect_success '--rebase fails with multiple branches' '
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
2.4.5
