From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 09/45] builtin-am: implement committing applied patch
Date: Mon, 20 Jul 2015 00:10:01 +0800
Message-ID: <1437322237-29863-10-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:13:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrDX-0007A2-2Y
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbbGSQLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:11:16 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34918 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770AbbGSQLL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:11:11 -0400
Received: by pdrg1 with SMTP id g1so89723362pdr.2
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kp43Abfjww6RM/iwUQjcq5f/DVICRav79rNai6kVOYo=;
        b=H8fBva4YVGeF6w114UgyHiZTqXtoga8eTNGUD93jjGZDCYck6cXTETUywdijbFHuul
         OQ5Mn+0BLAMG4/Ds9IvX2tNIx9JdS90RfPr6vCRtFHt2ZihYzjVmwHkq+3ZCHxntjx/S
         /j5P0PC6IinDudyO58q9vuCPf2melsr8ob11MytDv3bK0zHH42JRPUZSFHFsHTZ6Qkgi
         fkYxNonXA3s3/iuVIThHi/TdlklMKZHVAarDKbIWdkT9CNwcxdHcKb7YUzoebBrH4HZe
         fl3vzOehJa42g/sKNECzhIg8Xqpun8xryXN3MBx3DrHffV0cViXexKlBXLA26S6HBb89
         /ILA==
X-Received: by 10.68.167.197 with SMTP id zq5mr49844011pbb.85.1437322271571;
        Sun, 19 Jul 2015 09:11:11 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.11.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:11:10 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274270>

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
2.5.0.rc2.110.gb39b692
