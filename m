From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 09/44] builtin-am: implement committing applied patch
Date: Tue,  7 Jul 2015 22:20:27 +0800
Message-ID: <1436278862-2638-10-git-send-email-pyokagan@gmail.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:22:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTl9-0004Mw-1F
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757593AbbGGOWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:22:00 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34174 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757510AbbGGOVn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:21:43 -0400
Received: by pabvl15 with SMTP id vl15so114103886pab.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rQFS2bXjkxgTR6CPLE7xi6IVSccZKTqoYtlBmxKhF2A=;
        b=AAUiNrZUwOphMqmpsgMwKM9tra4qY2QB71ndFAd7qQ6Q6R1dBnc8wPVCiAbvc3PxmX
         EG+IqfZzC0dGjIazMKYHl8mEtt/+vpPqksVgij3/G99f8PYk0p4H/9ICl+E0eNN340H7
         qbXFh7YQw1cNKVBNb/ycPuYbeh5FaI4KItlyfjOEBR/Vq20nDkVJuSHl0/bZ2/V96Mak
         g3cMx6nJI7k1Il37zLR6HZiAtoa6EorCDR7ni5S0P8Jb+Yz4JEm58lxd8Fh4mijn9pLA
         askBoj5irPzaLvpUspsd8GcI3gqHkGHrpMkCsOaC5jnh8HU/INamHAaDtgx+rxE+LBWm
         rWwQ==
X-Received: by 10.70.43.136 with SMTP id w8mr9414571pdl.157.1436278903005;
        Tue, 07 Jul 2015 07:21:43 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id z4sm3800359pdo.88.2015.07.07.07.21.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:21:41 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273527>

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
index 9c7a6c8..bbb540c 100644
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
2.5.0.rc1.76.gf60a929
