From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 12/44] builtin-am: implement --skip
Date: Tue,  7 Jul 2015 22:20:30 +0800
Message-ID: <1436278862-2638-13-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:22:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTla-0004dj-Du
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757687AbbGGOWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:22:21 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33989 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757576AbbGGOVv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:21:51 -0400
Received: by pdbep18 with SMTP id ep18so126719211pdb.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ER2Z535mjP2okeGr4L4Lsx9QsEs+0HX12u84nOJes8s=;
        b=MUarVexqconoH0d82LXPgXFAuAWIZ39QMZW7L4c1VAovPe3/Cq5A2Posb2Ud1/anDj
         LiUMffv4imnx2FRf9qW4jmd4l45CAJDnpFbijxUFjVvyW1V5vScxfD0UJuBjuSiM2cH8
         0DmTEaM0EuDy3WEGvZeJcurvYd0QqS4VfweOsLmnQIkjNQwxLdgEASCI3IqVDbpFj6Cq
         /1AcD3Bsphm5Fpa3iLILAzSO5V1dydecOddSgwOKYx2PGS4VijO6A/OTrDrj4a1dfynr
         j0ntNFVdbaCtGj14ce3jLq4ra/pSVE9F5vj6ReTZ46zqwk35P5atR38pSMWG7zk/zhxW
         4+fA==
X-Received: by 10.66.216.161 with SMTP id or1mr9523824pac.34.1436278911161;
        Tue, 07 Jul 2015 07:21:51 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.21.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:21:49 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273531>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
supported resuming from a failed patch application by skipping the
current patch. Re-implement this feature by introducing am_skip().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index f21565b..5087094 100644
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
@@ -872,6 +874,114 @@ static void am_resolve(struct am_state *state)
 }
 
 /**
+ * Performs a checkout fast-forward from `head` to `remote`. If `reset` is
+ * true, any unmerged entries will be discarded. Returns 0 on success, -1 on
+ * failure.
+ */
+static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
+{
+	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
+	struct unpack_trees_options opts;
+	struct tree_desc t[2];
+
+	if (parse_tree(head) || parse_tree(remote))
+		return -1;
+
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
+	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
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
+	am_run(state);
+}
+
+/**
  * parse_options() callback that validates and sets opt->value to the
  * PATCH_FORMAT_* enum value corresponding to `arg`.
  */
@@ -888,7 +998,8 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 
 enum resume_mode {
 	RESUME_FALSE = 0,
-	RESUME_RESOLVED
+	RESUME_RESOLVED,
+	RESUME_SKIP
 };
 
 int cmd_am(int argc, const char **argv, const char *prefix)
@@ -899,7 +1010,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	const char * const usage[] = {
 		N_("git am [options] [(<mbox>|<Maildir>)...]"),
-		N_("git am [options] --continue"),
+		N_("git am [options] (--continue | --skip)"),
 		NULL
 	};
 
@@ -913,6 +1024,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('r', "resolved", &resume,
 			N_("synonyms for --continue"),
 			RESUME_RESOLVED),
+		OPT_CMDMODE(0, "skip", &resume,
+			N_("skip the current patch"),
+			RESUME_SKIP),
 		OPT_END()
 	};
 
@@ -968,6 +1082,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.5.0.rc1.76.gf60a929
