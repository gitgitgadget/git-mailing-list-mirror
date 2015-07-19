From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 13/45] builtin-am: implement --skip
Date: Mon, 20 Jul 2015 00:10:05 +0800
Message-ID: <1437322237-29863-14-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:11:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrBd-0006Dz-6M
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbbGSQL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:11:28 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33115 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855AbbGSQLV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:11:21 -0400
Received: by pdbnt7 with SMTP id nt7so18808194pdb.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KXIzRfQeoWP2IunllKIHWzjoPSwvU9JWaSfr0ABymwE=;
        b=KTEGcOl1YFBzxtAjgyputZ84kyVrSt7UqwQfWj4N9MCDxuAOQZo2wjmO68TNJpxwBE
         LSF9bP8604STjc1mn/NiuREQkzzmPtdp5bmnRiDg5X8UtbVEQP2jJACZNfPjLK+vp+0o
         zDzuCJ1EPSA+r7e+vJp+fr4VQYT1ETBFPOPxk+4s9cdHkAb8C2yeYYSRWl0ClGpxiPg0
         fPoyyWKkycbe3CvDG78HKZIygkF8/ejcdrEWPUGOoePbIm3y0qspmPUgfNR4U9NQLcQq
         O7mnml/nZ2o0MzyXUEMMAD0Pj7XnkVpZRykAuDlysOS4O7kvuuzdAL4nBSm3apAYFGhg
         t1HA==
X-Received: by 10.66.66.172 with SMTP id g12mr49768507pat.74.1437322281378;
        Sun, 19 Jul 2015 09:11:21 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.11.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:11:20 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274237>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
supported resuming from a failed patch application by skipping the
current patch. Re-implement this feature by introducing am_skip().

Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v6
    
    * Moved lock_file memory allocation to just before the
      hold_locked_index() to prevent memory leaks.

 builtin/am.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index ec579a6..765844b 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -16,6 +16,8 @@
 #include "commit.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "unpack-trees.h"
+#include "branch.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -868,6 +870,116 @@ static void am_resolve(struct am_state *state)
 }
 
 /**
+ * Performs a checkout fast-forward from `head` to `remote`. If `reset` is
+ * true, any unmerged entries will be discarded. Returns 0 on success, -1 on
+ * failure.
+ */
+static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
+{
+	struct lock_file *lock_file;
+	struct unpack_trees_options opts;
+	struct tree_desc t[2];
+
+	if (parse_tree(head) || parse_tree(remote))
+		return -1;
+
+	lock_file = xcalloc(1, sizeof(struct lock_file));
+	hold_locked_index(lock_file, 1);
+
+	refresh_cache(REFRESH_QUIET);
+
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = 1;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	opts.update = 1;
+	opts.merge = 1;
+	opts.reset = reset;
+	opts.fn = twoway_merge;
+	init_tree_desc(&t[0], head->buffer, head->size);
+	init_tree_desc(&t[1], remote->buffer, remote->size);
+
+	if (unpack_trees(2, t, &opts)) {
+		rollback_lock_file(lock_file);
+		return -1;
+	}
+
+	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
+		die(_("unable to write new index file"));
+
+	return 0;
+}
+
+/**
+ * Clean the index without touching entries that are not modified between
+ * `head` and `remote`.
+ */
+static int clean_index(const unsigned char *head, const unsigned char *remote)
+{
+	struct lock_file *lock_file;
+	struct tree *head_tree, *remote_tree, *index_tree;
+	unsigned char index[GIT_SHA1_RAWSZ];
+	struct pathspec pathspec;
+
+	head_tree = parse_tree_indirect(head);
+	if (!head_tree)
+		return error(_("Could not parse object '%s'."), sha1_to_hex(head));
+
+	remote_tree = parse_tree_indirect(remote);
+	if (!remote_tree)
+		return error(_("Could not parse object '%s'."), sha1_to_hex(remote));
+
+	read_cache_unmerged();
+
+	if (fast_forward_to(head_tree, head_tree, 1))
+		return -1;
+
+	if (write_cache_as_tree(index, 0, NULL))
+		return -1;
+
+	index_tree = parse_tree_indirect(index);
+	if (!index_tree)
+		return error(_("Could not parse object '%s'."), sha1_to_hex(index));
+
+	if (fast_forward_to(index_tree, remote_tree, 0))
+		return -1;
+
+	memset(&pathspec, 0, sizeof(pathspec));
+
+	lock_file = xcalloc(1, sizeof(struct lock_file));
+	hold_locked_index(lock_file, 1);
+
+	if (read_tree(remote_tree, 0, &pathspec)) {
+		rollback_lock_file(lock_file);
+		return -1;
+	}
+
+	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
+		die(_("unable to write new index file"));
+
+	remove_branch_state();
+
+	return 0;
+}
+
+/**
+ * Resume the current am session by skipping the current patch.
+ */
+static void am_skip(struct am_state *state)
+{
+	unsigned char head[GIT_SHA1_RAWSZ];
+
+	if (get_sha1("HEAD", head))
+		hashcpy(head, EMPTY_TREE_SHA1_BIN);
+
+	if (clean_index(head, head))
+		die(_("failed to clean index"));
+
+	am_next(state);
+	am_run(state, 0);
+}
+
+/**
  * parse_options() callback that validates and sets opt->value to the
  * PATCH_FORMAT_* enum value corresponding to `arg`.
  */
@@ -885,7 +997,8 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 enum resume_mode {
 	RESUME_FALSE = 0,
 	RESUME_APPLY,
-	RESUME_RESOLVED
+	RESUME_RESOLVED,
+	RESUME_SKIP
 };
 
 int cmd_am(int argc, const char **argv, const char *prefix)
@@ -896,7 +1009,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	const char * const usage[] = {
 		N_("git am [options] [(<mbox>|<Maildir>)...]"),
-		N_("git am [options] --continue"),
+		N_("git am [options] (--continue | --skip)"),
 		NULL
 	};
 
@@ -910,6 +1023,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('r', "resolved", &resume,
 			N_("synonyms for --continue"),
 			RESUME_RESOLVED),
+		OPT_CMDMODE(0, "skip", &resume,
+			N_("skip the current patch"),
+			RESUME_SKIP),
 		OPT_END()
 	};
 
@@ -971,6 +1087,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 	case RESUME_RESOLVED:
 		am_resolve(&state);
 		break;
+	case RESUME_SKIP:
+		am_skip(&state);
+		break;
 	default:
 		die("BUG: invalid resume value");
 	}
-- 
2.5.0.rc2.110.gb39b692
