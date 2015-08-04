From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v7 09/45] builtin-am: implement committing applied patch
Date: Tue,  4 Aug 2015 21:51:30 +0800
Message-ID: <1438696326-19590-10-git-send-email-pyokagan@gmail.com>
References: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 15:59:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMckK-00057h-9E
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 15:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934291AbbHDN7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 09:59:06 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34002 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934246AbbHDNxU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 09:53:20 -0400
Received: by pdber20 with SMTP id er20so4800339pdb.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 06:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SnuhyHitl+W6QbEuj23t7RnNjJORCl4NSLkcMl0OxOk=;
        b=Kh6MvkQOVdDI7mvSx7FW7xXgOKBDKgSGT2CAi1i7nWnMK+qbX4+f3jMORSpdTWjBbL
         9BIU6FMeHZmMB/tX7AlALvJw1VXccKVBjLZRvdn9ZZdhtEeIWvq2KzRtj1hlP85dPBZ6
         Miwi81nPcUUT/vHwvq6c9KsLxilsT4nuUyd3x5R6TKu0cnm0bBYdxHibG/RBjV/ueafs
         ZJ1qYLexH/0wX6I8o+rCbtd8hYug8L+/H6UmgNZXSYakwFKXeBPsLvMNftan6LYBnCYP
         rc2RwDT5B9kakgliQ4IBr6LmNOGkua1P56A9X7mr8unZpZpiKIPTiTxkWIeck6yN3HuA
         zfyQ==
X-Received: by 10.70.4.3 with SMTP id g3mr8049734pdg.73.1438696400050;
        Tue, 04 Aug 2015 06:53:20 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id ph4sm1580517pdb.43.2015.08.04.06.53.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Aug 2015 06:53:19 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.280.gd88bd6e
In-Reply-To: <1438696326-19590-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275317>

Implement do_commit(), which commits the index which contains the
results of applying the patch, along with the extracted commit message
and authorship information.

Since 29b6754 (am: remove rebase-apply directory before gc, 2010-02-22),
git gc --auto is also invoked to pack the loose objects that are created
from making the commits.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1f198e4..a2811b6 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -11,6 +11,9 @@
 #include "run-command.h"
 #include "quote.h"
 #include "lockfile.h"
+#include "cache-tree.h"
+#include "refs.h"
+#include "commit.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -674,10 +677,56 @@ static int run_apply(const struct am_state *state)
 }
 
 /**
+ * Commits the current index with state->msg as the commit message and
+ * state->author_name, state->author_email and state->author_date as the author
+ * information.
+ */
+static void do_commit(const struct am_state *state)
+{
+	unsigned char tree[GIT_SHA1_RAWSZ], parent[GIT_SHA1_RAWSZ],
+		      commit[GIT_SHA1_RAWSZ];
+	unsigned char *ptr;
+	struct commit_list *parents = NULL;
+	const char *reflog_msg, *author;
+	struct strbuf sb = STRBUF_INIT;
+
+	if (write_cache_as_tree(tree, 0, NULL))
+		die(_("git write-tree failed to write a tree"));
+
+	if (!get_sha1_commit("HEAD", parent)) {
+		ptr = parent;
+		commit_list_insert(lookup_commit(parent), &parents);
+	} else {
+		ptr = NULL;
+		fprintf_ln(stderr, _("applying to an empty history"));
+	}
+
+	author = fmt_ident(state->author_name, state->author_email,
+			state->author_date, IDENT_STRICT);
+
+	if (commit_tree(state->msg, state->msg_len, tree, parents, commit,
+				author, NULL))
+		die(_("failed to write commit object"));
+
+	reflog_msg = getenv("GIT_REFLOG_ACTION");
+	if (!reflog_msg)
+		reflog_msg = "am";
+
+	strbuf_addf(&sb, "%s: %.*s", reflog_msg, linelen(state->msg),
+			state->msg);
+
+	update_ref(sb.buf, "HEAD", commit, ptr, 0, UPDATE_REFS_DIE_ON_ERR);
+
+	strbuf_release(&sb);
+}
+
+/**
  * Applies all queued mail.
  */
 static void am_run(struct am_state *state)
 {
+	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
+
 	refresh_and_write_cache();
 
 	while (state->cur <= state->last) {
@@ -709,16 +758,14 @@ static void am_run(struct am_state *state)
 			exit(128);
 		}
 
-		/*
-		 * NEEDSWORK: After the patch has been applied to the index
-		 * with git-apply, we need to make commit as well.
-		 */
+		do_commit(state);
 
 next:
 		am_next(state);
 	}
 
 	am_destroy(state);
+	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 }
 
 /**
-- 
2.5.0.280.gd88bd6e
