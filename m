From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 09/31] am: commit applied patch
Date: Thu, 18 Jun 2015 19:25:21 +0800
Message-ID: <1434626743-8552-10-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:27:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xy7-0004tB-2E
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755510AbbFRL0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:26:46 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:32799 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280AbbFRL0h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:26:37 -0400
Received: by pdjn11 with SMTP id n11so64830145pdj.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P1LQJVbutywxkKXIOEhkl2u6VSLlPy12r0WYHuNVN6I=;
        b=nafz9BDV1YHkTzKYyHgI+KwbjVFuChouBd1g9G+0m0xS/DP8ANnIP0LPo7p+hUgcr4
         v0A3aAZJKQ6nNq7WJg2Us1xjxxjtLy1+uzU1yfagknxK7BWc0uKXw8RzkLrQAn+27APD
         ww7ZXfKkKbMwNc2fQBnDf9xMg3WDOXsL2HiPlP7GxJLWRw6NhbYJ4Re+dke3GJH6X/D8
         jVkoR5LJWXiculi4Mv8kK1YK8Ko1OQ2Ka2o/Z/jZQuxYu8n0nXU9OvET6DZw0XxyXPg7
         lPozhLYUEjuyiHj0D6CNPBvujAJa4ChMR2M8LJgfELJ0AAEVZrQ+/ouNLhhuYR4pDlN9
         Qbzw==
X-Received: by 10.70.38.33 with SMTP id d1mr19982923pdk.99.1434626796717;
        Thu, 18 Jun 2015 04:26:36 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.26.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:26:35 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271974>

Implement do_commit(), which commits the index which contains the
results of applying the patch, along with the extracted commit message
and authorship information.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 296a5fc..dfb6f7e 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -10,6 +10,9 @@
 #include "dir.h"
 #include "run-command.h"
 #include "quote.h"
+#include "cache-tree.h"
+#include "refs.h"
+#include "commit.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -557,6 +560,49 @@ static int run_apply(const struct am_state *state)
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
@@ -588,10 +634,7 @@ static void am_run(struct am_state *state)
 			exit(128);
 		}
 
-		/*
-		 * TODO: After the patch has been applied to the index with
-		 * git-apply, we need to make commit as well.
-		 */
+		do_commit(state);
 
 next:
 		am_next(state);
-- 
2.1.4
