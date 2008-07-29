From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH v2] Advertise the ability to abort a commit
Date: Tue, 29 Jul 2008 22:12:22 +0200
Message-ID: <1217362342-30370-1-git-send-email-mail@cup.kalibalik.dk>
References: <1217359925-30130-1-git-send-email-mail@cup.kalibalik.dk>
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 22:13:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNvZW-0006GZ-Uk
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 22:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbYG2UM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 16:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbYG2UM0
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 16:12:26 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:44529 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbYG2UMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 16:12:25 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id ABCE314062;
	Tue, 29 Jul 2008 22:12:22 +0200 (CEST)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 8142A1405A;
	Tue, 29 Jul 2008 22:12:22 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <1217359925-30130-1-git-send-email-mail@cup.kalibalik.dk>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90680>

This treats aborting a commit more like a feature.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---

Now includes updates to test file.

Incidentally, this change was proposed by pasky in #git.


 builtin-commit.c  |    3 ++-
 t/t7502-commit.sh |    7 ++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 9a11ca0..75eeb4b 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -555,6 +555,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 		fprintf(fp,
 			"\n"
 			"# Please enter the commit message for your changes.\n"
+			"# To abort the commit, use an empty commit message.\n"
 			"# (Comment lines starting with '#' will ");
 		if (cleanup_mode == CLEANUP_ALL)
 			fprintf(fp, "not be included)\n");
@@ -1003,7 +1004,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		stripspace(&sb, cleanup_mode == CLEANUP_ALL);
 	if (sb.len < header_len || message_is_empty(&sb, header_len)) {
 		rollback_index_files();
-		die("no commit message?  aborting commit.");
+		die("no commit message.  aborting commit.");
 	}
 	strbuf_addch(&sb, '\0');
 	if (is_encoding_utf8(git_commit_encoding) && !is_utf8(sb.buf))
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 4f2682e..f111263 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -142,6 +142,7 @@ test_expect_success 'cleanup commit messages (strip,-F)' '
 echo "sample
 
 # Please enter the commit message for your changes.
+# To abort the commit, use an empty commit message.
 # (Comment lines starting with '#' will not be included)" >expect
 
 test_expect_success 'cleanup commit messages (strip,-F,-e)' '
@@ -149,7 +150,7 @@ test_expect_success 'cleanup commit messages (strip,-F,-e)' '
 	echo >>negative &&
 	{ echo;echo sample;echo; } >text &&
 	git commit -e -F text -a &&
-	head -n 4 .git/COMMIT_EDITMSG >actual &&
+	head -n 5 .git/COMMIT_EDITMSG >actual &&
 	test_cmp expect actual
 
 '
@@ -162,7 +163,7 @@ test_expect_success 'author different from committer' '
 
 	echo >>negative &&
 	git commit -e -m "sample"
-	head -n 7 .git/COMMIT_EDITMSG >actual &&
+	head -n 8 .git/COMMIT_EDITMSG >actual &&
 	test_cmp expect actual
 '
 
@@ -181,7 +182,7 @@ test_expect_success 'committer is automatic' '
 		# must fail because there is no change
 		test_must_fail git commit -e -m "sample"
 	) &&
-	head -n 8 .git/COMMIT_EDITMSG |	\
+	head -n 9 .git/COMMIT_EDITMSG |	\
 	sed "s/^# Committer: .*/# Committer:/" >actual &&
 	test_cmp expect actual
 '
-- 
1.5.6.4
