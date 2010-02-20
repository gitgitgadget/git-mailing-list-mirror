From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v3 09/12] commit --amend: copy notes to the new commit
Date: Sat, 20 Feb 2010 23:16:30 +0100
Message-ID: <a51b55e5d872bbd9c6a89cac0c453505a27fb7b1.1266703765.git.trast@student.ethz.ch>
References: <cover.1266703765.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 20 23:42:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nixdb-0006LF-Mg
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 23:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756904Ab0BTWRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 17:17:15 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:6942 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756869Ab0BTWRO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 17:17:14 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 23:16:57 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 23:16:39 +0100
X-Mailer: git-send-email 1.7.0.137.gfe3f1
In-Reply-To: <cover.1266703765.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140562>

Teaches 'git commit --amend' to copy notes.  The catch is that this
must also be guarded by --no-post-rewrite, which we use to prevent
--amend from copying notes during a rebase -i 'edit'/'reword'.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 builtin-commit.c  |    6 ++++++
 t/t7501-commit.sh |   12 ++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 9b67649..1943615 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1341,9 +1341,15 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	run_hook(get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		struct commit *commit;
+		struct notes_rewrite_cfg *cfg;
 		commit = lookup_commit(head_sha1);
 		if (!commit || parse_commit(commit))
 			die("HEAD commit disappeared right under my eyes?");
+		cfg = init_copy_notes_for_rewrite("amend");
+		if (cfg) {
+			copy_note_for_rewrite(cfg, commit->object.sha1, commit_sha1);
+			finish_copy_notes_for_rewrite(cfg);
+		}
 		run_rewrite_hook(commit->object.sha1, commit_sha1);
 	}
 	if (!quiet)
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 7940901..8297cb4 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -425,4 +425,16 @@ test_expect_success 'amend using the message from a commit named with tag' '
 
 '
 
+test_expect_success 'amend can copy notes' '
+
+	git config notes.rewrite.amend true &&
+	git config notes.rewriteRef "refs/notes/*" &&
+	test_commit foo &&
+	git notes add -m"a note" &&
+	test_tick &&
+	git commit --amend -m"new foo" &&
+	test "$(git notes show)" = "a note"
+
+'
+
 test_done
-- 
1.7.0.59.g783f8
