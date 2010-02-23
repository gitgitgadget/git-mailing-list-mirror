From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v5 10/11] commit --amend: copy notes to the new commit
Date: Tue, 23 Feb 2010 01:42:28 +0100
Message-ID: <c5db2ed2e3215b3e84cc335301eddcbb21dfd5c7.1266885599.git.trast@student.ethz.ch>
References: <cover.1266885599.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 01:43:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njirw-0002hf-O5
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 01:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896Ab0BWAnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 19:43:09 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:48627 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752871Ab0BWAnG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 19:43:06 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 01:42:52 +0100
Received: from localhost.localdomain (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 01:42:34 +0100
X-Mailer: git-send-email 1.7.0.218.g73a398
In-Reply-To: <cover.1266885599.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140750>

Teaches 'git commit --amend' to copy notes.  The catch is that this
must also be guarded by --no-post-rewrite, which we use to prevent
--amend from copying notes during a rebase -i 'edit'/'reword'.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---


 builtin-commit.c  |    6 ++++++
 t/t7501-commit.sh |   12 ++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 1c3aa7d..3f1708b 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1340,6 +1340,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	rerere(0);
 	run_hook(get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
+		struct notes_rewrite_cfg *cfg;
+		cfg = init_copy_notes_for_rewrite("amend");
+		if (cfg) {
+			copy_note_for_rewrite(cfg, head_sha1, commit_sha1);
+			finish_copy_notes_for_rewrite(cfg);
+		}
 		run_rewrite_hook(head_sha1, commit_sha1);
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
1.7.0.218.g73a398
