From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 17/19] pull --rebase: exit early when the working directory is dirty
Date: Thu, 18 Jun 2015 18:54:10 +0800
Message-ID: <1434624852-6869-18-git-send-email-pyokagan@gmail.com>
References: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:07:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XfY-0004Lc-Cg
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbbFRLHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:07:25 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35953 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139AbbFRKzg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:55:36 -0400
Received: by paceq1 with SMTP id eq1so34545579pac.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J6r2TsDg9FQLPct4ExPK0POCIUgHeXXxpPn5wNMHnrA=;
        b=XO8UnePWA2Q5i/vHZWcVGb2U7rcrHJjwML7cBUN0oRDCEMPdOwtss6tqpNPR+2mK0s
         P9DU66KlYBkpW3DKB6RxWDCA8gVa/oJXGjuSGFyo0eTjc68riz7pqLMqbRkRDl3LfU6A
         HJsbW2u04dAjf8g328ytd+r36zFurNhzCHkarCNS9A++XKQ4k7J142oBUGB6imd1601e
         eyEybPY5w187opUi6Ne8iDpXftLz5E5TqJR2hOcUxXXP7a/D0mbq9+iitr4pNbufG6wu
         d1ZPNEjNoeTkWoghkkR9aWYwD1hkR3MOUWlVEy/QFePy7S9HYKpPot7LkW0zPu8/G7vv
         H5CA==
X-Received: by 10.70.87.195 with SMTP id ba3mr20338137pdb.154.1434624935039;
        Thu, 18 Jun 2015 03:55:35 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id eu5sm7735063pac.37.2015.06.18.03.55.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 03:55:34 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271959>

Re-implement the behavior introduced by f9189cf (pull --rebase: exit
early when the working directory is dirty, 2008-05-21).

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 1c4fb44..eb2a28f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -14,6 +14,8 @@
 #include "remote.h"
 #include "dir.h"
 #include "refs.h"
+#include "revision.h"
+#include "lockfile.h"
 
 enum rebase_type {
 	REBASE_INVALID = -1,
@@ -296,6 +298,73 @@ static enum rebase_type config_get_rebase(void)
 }
 
 /**
+ * Returns 1 if there are unstaged changes, 0 otherwise.
+ */
+static int has_unstaged_changes(const char *prefix)
+{
+	struct rev_info rev_info;
+	int result;
+
+	init_revisions(&rev_info, prefix);
+	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
+	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
+	diff_setup_done(&rev_info.diffopt);
+	result = run_diff_files(&rev_info, 0);
+	return diff_result_code(&rev_info.diffopt, result);
+}
+
+/**
+ * Returns 1 if there are uncommitted changes, 0 otherwise.
+ */
+static int has_uncommitted_changes(const char *prefix)
+{
+	struct rev_info rev_info;
+	int result;
+
+	if (is_cache_unborn())
+		return 0;
+
+	init_revisions(&rev_info, prefix);
+	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
+	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
+	add_head_to_pending(&rev_info);
+	diff_setup_done(&rev_info.diffopt);
+	result = run_diff_index(&rev_info, 1);
+	return diff_result_code(&rev_info.diffopt, result);
+}
+
+/**
+ * If the work tree has unstaged or uncommitted changes, dies with the
+ * appropriate message.
+ */
+static void die_on_unclean_work_tree(const char *prefix)
+{
+	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
+	int do_die = 0;
+
+	hold_locked_index(lock_file, 0);
+	refresh_cache(REFRESH_QUIET);
+	update_index_if_able(&the_index, lock_file);
+	rollback_lock_file(lock_file);
+
+	if (has_unstaged_changes(prefix)) {
+		error(_("Cannot pull with rebase: You have unstaged changes."));
+		do_die = 1;
+	}
+
+	if (has_uncommitted_changes(prefix)) {
+		if (do_die)
+			error(_("Additionally, your index contains uncommitted changes."));
+		else
+			error(_("Cannot pull with rebase: Your index contains uncommitted changes."));
+		do_die = 1;
+	}
+
+	if (do_die)
+		exit(1);
+}
+
+/**
  * Appends merge candidates from FETCH_HEAD that are not marked not-for-merge
  * into merge_heads.
  */
@@ -751,9 +820,15 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_sha1("HEAD", orig_head))
 		hashclr(orig_head);
 
-	if (opt_rebase)
+	if (opt_rebase) {
+		if (is_null_sha1(orig_head) && !is_cache_unborn())
+			die(_("Updating an unborn branch with changes added to the index."));
+
+		die_on_unclean_work_tree(prefix);
+
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 			hashclr(rebase_fork_point);
+	}
 
 	if (run_fetch(repo, refspecs))
 		return 1;
-- 
2.1.4
