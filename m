From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v7 10/13] commit --amend: copy notes to the new commit
Date: Fri, 12 Mar 2010 18:04:34 +0100
Message-ID: <b335e1b2939a465d9d85d9e29e4ef0bef562ca40.1268413246.git.trast@student.ethz.ch>
References: <cover.1268413246.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 12 18:06:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq8JS-00018m-FR
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 18:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758655Ab0CLRFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 12:05:36 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:30419 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758641Ab0CLRF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 12:05:27 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 12 Mar
 2010 18:05:27 +0100
Received: from localhost.localdomain (213.55.131.184) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 12 Mar
 2010 18:05:03 +0100
X-Mailer: git-send-email 1.7.0.2.417.gbc354
In-Reply-To: <cover.1268413246.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142052>

Teaches 'git commit --amend' to copy notes.  The catch is that this
must also be guarded by --no-post-rewrite, which we use to prevent
--amend from copying notes during a rebase -i 'edit'/'reword'.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---


 builtin/commit.c  |    6 ++++++
 t/t7501-commit.sh |   12 ++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0367412..8dd104e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
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
1.7.0.2.417.gbc354
