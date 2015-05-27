From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP 8/8] am: commit applied patch
Date: Wed, 27 May 2015 21:33:38 +0800
Message-ID: <1432733618-25629-9-git-send-email-pyokagan@gmail.com>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 15:35:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxbUO-0006UN-Dp
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 15:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbbE0Neu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 09:34:50 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33770 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbbE0Neq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 09:34:46 -0400
Received: by pdbqa5 with SMTP id qa5so15513673pdb.0
        for <git@vger.kernel.org>; Wed, 27 May 2015 06:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qsc4WIBhAkd7N2OhLhd8n/t5DApbOVt8s/9Jl7NU57E=;
        b=BvhuAQIe8mMTtuhcpqimkCrm/AcHuCxJXr9Kgy/1yyDRhyXWV0dW2WYCDHdGU/TPYx
         AawuokOqHgcvTAmQYmv3ez2T+xftIeMLw82PZ6XzdNwiv9IJDwzWXLzcCAn+lobYkXJS
         QyIEa0zleifXG3kX3wzM3CYeQGtB5NoE5RvZWmZcEz+1aaWXoE7Gr8MI4eFnZRFbmPlC
         6O6duaXfYUT58nS/1kW9VefuIGunRLedLDQyIybBxyQKHukEip1qMXYE6u5nxDRgonMl
         qIDioFAg34sI1UEJEAExEHYoscczgbkvxOJejIumkYdAJX6ngHzAa0yef8OLEGAi7AA0
         /vcQ==
X-Received: by 10.66.222.161 with SMTP id qn1mr59887228pac.66.1432733685554;
        Wed, 27 May 2015 06:34:45 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id e5sm16301395pdc.94.2015.05.27.06.34.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 May 2015 06:34:44 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270054>

Implement do_commit(), which commits the index which contains the
results of applying the patch, along with the extracted commit message
and authorship information.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 7126df3..3174327 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -8,6 +8,9 @@
 #include "dir.h"
 #include "run-command.h"
 #include "quote.h"
+#include "cache-tree.h"
+#include "refs.h"
+#include "commit.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -539,6 +542,48 @@ static int run_apply(const struct am_state *state)
 }
 
 /**
+ * Commits the current index with state->msg as the commit message and
+ * state->author_name, state->author_email and state->author_date as the author
+ * information.
+ */
+static void do_commit(const struct am_state *state)
+{
+	unsigned char tree[20], parent[20], commit[20];
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
+	author = fmt_ident(state->author_name.buf, state->author_email.buf,
+			state->author_date.buf, IDENT_STRICT);
+
+	if (commit_tree(state->msg.buf, state->msg.len, tree, parents, commit,
+				author, NULL))
+		die(_("failed to write commit object"));
+
+	reflog_msg = getenv("GIT_REFLOG_ACTION");
+	if (!reflog_msg)
+		reflog_msg = "am";
+
+	strbuf_addf(&sb, "%s: %s", reflog_msg, firstline(state->msg.buf));
+
+	update_ref(sb.buf, "HEAD", commit, ptr, 0, UPDATE_REFS_DIE_ON_ERR);
+
+	strbuf_release(&sb);
+}
+
+/**
  * Applies all queued patches.
  */
 static void am_run(struct am_state *state)
@@ -570,6 +615,7 @@ static void am_run(struct am_state *state)
 			exit(128);
 		}
 
+		do_commit(state);
 next:
 		am_next(state);
 	}
-- 
2.1.4
