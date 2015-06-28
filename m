From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 09/44] builtin-am: implement committing applied patch
Date: Sun, 28 Jun 2015 22:05:31 +0800
Message-ID: <1435500366-31700-10-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:07:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DFF-0001zf-Kv
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbbF1OHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:07:36 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36313 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbbF1OHU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:07:20 -0400
Received: by paceq1 with SMTP id eq1so91531996pac.3
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AQoxa6WXAH3nZiw/ZPo8q9EeIv9OS9z7FF0hTvWuobY=;
        b=vt2uhmBtT21M2+X5DqnPse1qJ2zZhdrhWUe8cW1CAxk2GjvI2W5Er5BeJE9faPjbqH
         hr3yHMCOt4k5vEcr8AFWms1D3NJMyx2dF6W+LHG44SqFL9mLWwMnac+18iExJdW58wta
         TmCSZDLMJPrzmXo6lmTmid2ux9VraahELDeEAMAhE0qceXSEtg+qbBCpJVbj12uMEmQ+
         oAsDhwvkbjTUUbnV0R3vsBM9AU02Yu2D7tlPe0m07Vhugtw6DyBiTZ4df6dZEwshzM0o
         npzuIZ5BKU5oLzW34jm61Ynunsg6iMTb3IGD47x88drQhIJscPUnerT+hcjWPeF4LpYz
         d6iw==
X-Received: by 10.70.40.164 with SMTP id y4mr22509725pdk.25.1435500439981;
        Sun, 28 Jun 2015 07:07:19 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.07.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:07:19 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272883>

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
index 0762c70..bbb540c 100644
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
@@ -696,10 +699,56 @@ static int run_apply(const struct am_state *state)
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
@@ -731,16 +780,14 @@ static void am_run(struct am_state *state)
 			exit(128);
 		}
 
-		/*
-		 * TODO: After the patch has been applied to the index with
-		 * git-apply, we need to make commit as well.
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
2.5.0.rc0.76.gb2c6e93
