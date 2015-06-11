From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v2 09/19] am: commit applied patch
Date: Thu, 11 Jun 2015 18:21:55 +0800
Message-ID: <1434018125-31804-10-git-send-email-pyokagan@gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 12:22:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2zdL-0007sw-Aj
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 12:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851AbbFKKWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 06:22:46 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33924 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbbFKKWn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 06:22:43 -0400
Received: by pdbki1 with SMTP id ki1so1996043pdb.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 03:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LMxz/fDR1t2I38gREED6FIBWHE119A2m77QSFCBBjSk=;
        b=nATZ/AL/H98O2W6BhH/xbkcqirU6rj7GRzX43DRAI2gkyPkIKX4+UytVaucVO57Hyp
         5/R90WeqJ76kygaVgGptgfu5H/JG6lYYFCar1wgEwShFukzFOLp4auzKDWVY9cTCUJCo
         l9qjeHydQNeuZCh4d8XK6AtIwEub/Vdw7HFsqKcWpEW6fCwYo6m98x3dFb1p7fL0hEYk
         /mP51hNRpRFZ5SGVkkqVhZOYr6vA59nAsV+enoKr6+BbOI3UUcJ05dH7cxEvPm+XbvzN
         tmuahEXZhwdOCYJ7zh+rq8+GP65sUyYETKvCiXy6EFev6E1ArjbBVn2HRmNIsBysgQZH
         zFhg==
X-Received: by 10.68.130.226 with SMTP id oh2mr13523862pbb.156.1434018162904;
        Thu, 11 Jun 2015 03:22:42 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id q4sm300488pdo.42.2015.06.11.03.22.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 03:22:42 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271391>

Implement do_commit(), which commits the index which contains the
results of applying the patch, along with the extracted commit message
and authorship information.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index b725a74..ecc6d29 100644
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
@@ -548,6 +551,48 @@ static int run_apply(const struct am_state *state)
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
@@ -579,10 +624,7 @@ static void am_run(struct am_state *state)
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
