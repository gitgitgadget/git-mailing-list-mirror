From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 17/19] pull --rebase: exit early when the working directory is dirty
Date: Sun, 14 Jun 2015 16:42:04 +0800
Message-ID: <1434271326-11349-18-git-send-email-pyokagan@gmail.com>
References: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 10:43:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z43WC-0006gG-Vq
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbbFNInr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:43:47 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35237 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbbFNInT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:43:19 -0400
Received: by pdbnf5 with SMTP id nf5so51493124pdb.2
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 01:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pMVlu7/PT1J8aOYoizCk/NmDFZ+CJ0Q7uYgRF09JwOM=;
        b=MsK2PqWbPfPRHhtVHzTQjuvWEm0rLfMSvQpyjw3ddxNVjJRFGVjmyJxxAVH4wv8rDL
         7CadHA4M140er+S7OzncB8BL+LktStvrfrzFrn1EAMsl18NNnXA3iV/CY7YIGrFP0QFA
         ChxTgQ2OSYSCsYDcotsphPs227CNuhpb3+0ZxIqLEpdxi5avE2oKeGOW7mMmIL1Eb2Zt
         t+pyyI6Zx0aFtyK18hQwVnJ89OjVSxdMNi7O8V3pvRuy6HXT83wO0aMntDx8NnzOSIv3
         c0jcrvHlNVQQ+KaHXlTDOCNrYYXdvYyayV3wKvATOM7Tli3sf4/JEz3pghTpx9pjaQhd
         G1Aw==
X-Received: by 10.66.222.161 with SMTP id qn1mr38566137pac.66.1434271398288;
        Sun, 14 Jun 2015 01:43:18 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id kk6sm8622549pdb.94.2015.06.14.01.43.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jun 2015 01:43:17 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271631>

Re-implement the behavior introduced by f9189cf (pull --rebase: exit
early when the working directory is dirty, 2008-05-21).

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index e4098d0..a379c1f 100644
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
@@ -295,6 +297,73 @@ static enum rebase_type config_get_rebase(void)
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
@@ -750,9 +819,15 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
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
