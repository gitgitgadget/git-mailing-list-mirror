From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v2 13/19] am: implement --skip
Date: Thu, 11 Jun 2015 18:21:59 +0800
Message-ID: <1434018125-31804-14-git-send-email-pyokagan@gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 12:23:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2zda-00083A-7H
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 12:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbbFKKW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 06:22:59 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33146 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbbFKKWy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 06:22:54 -0400
Received: by padev16 with SMTP id ev16so1895789pad.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 03:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SQMHM2QK2P7zFL7hA6aR+5FECdukoYaF6i1gIG5D8L0=;
        b=jYV4p7CvHTX9/07IL2L7FbBaNC5z6I45YDDEzltVK5uYdWnk7VO02Lgu7kRdfYNHjY
         c4iOOl1mRzAskIfuXwsfIbrzuHCixUHevaaI50VKDICsUEZg+xXlZenCJiTrt7EVXP+r
         3xNbmX+/H3y09i6jIyWfutTDVtCBm3p+S/u3x87m8vKM80XB4M4hqHtUGfGTqSqd/SJt
         lrbThJUAIIvts/A7dQaal8bZWflOIbjlP0YhhB/E/44p6bvBMO3Nsq1mEqw2zvc7gOle
         g09b1H6AbKmUMo1erBUJu67ZYIvA8BHl3fOujs9gywKmNRTgEC9QpsNvZkNRBBgYiDWx
         uQdA==
X-Received: by 10.70.61.68 with SMTP id n4mr13892002pdr.78.1434018174183;
        Thu, 11 Jun 2015 03:22:54 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id q4sm300488pdo.42.2015.06.11.03.22.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 03:22:52 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271394>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
supported resuming from a failed patch application by skipping the
current patch. Re-implement this feature by introducing am_skip().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 935ffcb..1434e68 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -16,6 +16,8 @@
 #include "lockfile.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "unpack-trees.h"
+#include "branch.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -725,6 +727,114 @@ static void am_resolve(struct am_state *state)
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
@@ -741,7 +851,8 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 
 enum resume_mode {
 	RESUME_FALSE = 0,
-	RESUME_RESOLVED
+	RESUME_RESOLVED,
+	RESUME_SKIP
 };
 
 static struct am_state state;
@@ -750,7 +861,7 @@ static enum resume_mode opt_resume;
 
 static const char * const am_usage[] = {
 	N_("git am [options] [(<mbox>|<Maildir>)...]"),
-	N_("git am [options] --continue"),
+	N_("git am [options] (--continue | --skip)"),
 	NULL
 };
 
@@ -763,6 +874,9 @@ static struct option am_options[] = {
 	OPT_CMDMODE('r', "resolved", &opt_resume,
 		N_("synonyms for --continue"),
 		RESUME_RESOLVED),
+	OPT_CMDMODE(0, "skip", &opt_resume,
+		N_("skip the current patch"),
+		RESUME_SKIP),
 	OPT_END()
 };
 
@@ -810,6 +924,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
2.1.4
