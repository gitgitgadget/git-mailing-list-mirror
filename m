From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH v3] Advertise the ability to abort a commit
Date: Wed, 30 Jul 2008 19:53:11 +0200
Message-ID: <1217440391-13259-1-git-send-email-mail@cup.kalibalik.dk>
References: <20080730051059.GA4497@sigill.intra.peff.net>
Cc: gitster@pobox.com, peff@peff.net,
	Anders Melchiorsen <mail@cup.kalibalik.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 19:54:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOFsQ-0007p9-0j
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 19:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbYG3RxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 13:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753405AbYG3RxQ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 13:53:16 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:38466 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753434AbYG3RxP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 13:53:15 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 3DE0014062;
	Wed, 30 Jul 2008 19:53:10 +0200 (CEST)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 1C3EC1405A;
	Wed, 30 Jul 2008 19:53:10 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <20080730051059.GA4497@sigill.intra.peff.net>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90823>

An empty commit message is now treated as a normal situation, not an error.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---

So, I decided that I find it wrong to promote functionality
that results in an error. The error is now changed into a
normal exit (with status code 1.)


 builtin-commit.c  |    4 +++-
 t/t7502-commit.sh |    7 ++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 9a11ca0..bc59718 100644
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
@@ -1003,7 +1004,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		stripspace(&sb, cleanup_mode == CLEANUP_ALL);
 	if (sb.len < header_len || message_is_empty(&sb, header_len)) {
 		rollback_index_files();
-		die("no commit message?  aborting commit.");
+		fprintf(stderr, "Aborting commit due to empty commit message.\n");
+		exit(1);
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
