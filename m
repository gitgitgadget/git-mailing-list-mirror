From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 13/31] am: implement --skip
Date: Thu, 18 Jun 2015 19:25:25 +0800
Message-ID: <1434626743-8552-14-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:27:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XyG-000505-QS
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755541AbbFRL0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:26:55 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34166 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511AbbFRL0r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:26:47 -0400
Received: by pdbki1 with SMTP id ki1so64750638pdb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2j7Si6e24LS4qZD4HV5bQuNgeYM+rnA7qkMDXkssVtw=;
        b=KXN4EpTiHkNQe0xd1AxEsjcBW7FOuWnoa+1bSAtBFNB6G639M4nnSjhWUwyd4Un5c6
         ipMZhMDg7DgvIinemJ5ohZiUYvkSKRyQPPMdvz8w0NyP1mUoNZHJ5JYGTbLFfTGHyEY4
         4ismINeN6vNH1PnNVoPV+w8aijMgDhcbo6zMFbIA1FGLrEs4cBBEdx6Vd5KctWJhW429
         ujlLujvEKE4SMrtV6rzNkdszKX8MH57B/HyGSmNeOYd+peDvkDm115+ORdMD4VJaItTr
         jWFTpxw+KxbfAeYkWgfzTVZtizIAFuozUTUdMGQ7g0DonXvNqUd40L7RRuSCFKl+Wcff
         G6Zw==
X-Received: by 10.70.37.9 with SMTP id u9mr20222477pdj.50.1434626807393;
        Thu, 18 Jun 2015 04:26:47 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.26.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:26:46 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271976>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
supported resuming from a failed patch application by skipping the
current patch. Re-implement this feature by introducing am_skip().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4381164..0d7af19 100644
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
@@ -735,6 +737,114 @@ static void am_resolve(struct am_state *state)
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
@@ -751,7 +861,8 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 
 enum resume_mode {
 	RESUME_FALSE = 0,
-	RESUME_RESOLVED
+	RESUME_RESOLVED,
+	RESUME_SKIP
 };
 
 static struct am_state state;
@@ -760,7 +871,7 @@ static enum resume_mode opt_resume;
 
 static const char * const am_usage[] = {
 	N_("git am [options] [(<mbox>|<Maildir>)...]"),
-	N_("git am [options] --continue"),
+	N_("git am [options] (--continue | --skip)"),
 	NULL
 };
 
@@ -773,6 +884,9 @@ static struct option am_options[] = {
 	OPT_CMDMODE('r', "resolved", &opt_resume,
 		N_("synonyms for --continue"),
 		RESUME_RESOLVED),
+	OPT_CMDMODE(0, "skip", &opt_resume,
+		N_("skip the current patch"),
+		RESUME_SKIP),
 	OPT_END()
 };
 
@@ -831,6 +945,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
