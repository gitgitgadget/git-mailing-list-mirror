From: Johan Herland <johan@herland.net>
Subject: [PATCH 3/3] Move create_notes_commit() from notes-merge.c into notes-utils.c
Date: Wed, 12 Jun 2013 02:13:01 +0200
Message-ID: <1370995981-1553-4-git-send-email-johan@herland.net>
References: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
 <1370995981-1553-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	artagnon@gmail.com, john@keeping.me.uk, vfr@lyx.org, peff@peff.net,
	felipe.contreras@gmail.com, torvalds@linux-foundation.org,
	johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 12 02:13:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmYhB-0005IF-CD
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 02:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756508Ab3FLANo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 20:13:44 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:36066 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642Ab3FLANn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 20:13:43 -0400
Received: by mail-la0-f43.google.com with SMTP id gw10so7353463lab.2
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 17:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wO0xeW6WjD45YK8DXv2tVR0uYMJlpFsIeM4gxeT3LcM=;
        b=VsykbZ0D9JxaZan/pwQg5URicQlDwDi4TqFd0buxFaQtJZZEugk/E/QeqLBaJZHBNY
         C3/0mwg5kQbXfeVRImDgpX/rFHgTJopxeTG+my43NQkweq2fp4zQorix7yueRyUNPW0D
         h2yF2DqOckJnrssLuUtyvmSTf9KyQ6gh67wULuyNTM6AWfiwr9svsIUdpcO4nrZtLtH0
         9VcxQYTfJorIkUW05N1ncRbU/ELBpPq3fodS7dUXlja2RILc6p77olcMdZhWdulbRrrR
         qtTSoMziWY2r/dndAsBtKq0CMdqhlfz3PSAhGDq0cqWTIwcECVJuR1zMihrtjA5lEu4j
         iTOg==
X-Received: by 10.112.61.199 with SMTP id s7mr3992488lbr.53.1370996021326;
        Tue, 11 Jun 2013 17:13:41 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPSA id x3sm7102525lag.6.2013.06.11.17.13.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 11 Jun 2013 17:13:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1370995981-1553-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227583>

create_notes_commit() is needed by both the notes-merge code, and by
commit_notes() in notes-utils. Since it is generally useful, and not
bound to the notes-merge machinery, we move it from (the more specific)
notes-merge to (the more general) notes-utils.

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes-merge.c | 27 +--------------------------
 notes-merge.h | 14 --------------
 notes-utils.c | 27 ++++++++++++++++++++++++++-
 notes-utils.h | 14 ++++++++++++++
 4 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index 0f67bd3..ab18857 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -9,6 +9,7 @@
 #include "notes.h"
 #include "notes-merge.h"
 #include "strbuf.h"
+#include "notes-utils.h"
 
 struct notes_merge_pair {
 	unsigned char obj[20], base[20], local[20], remote[20];
@@ -530,32 +531,6 @@ static int merge_from_diffs(struct notes_merge_options *o,
 	return conflicts ? -1 : 1;
 }
 
-void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
-			 const struct strbuf *msg, unsigned char *result_sha1)
-{
-	unsigned char tree_sha1[20];
-
-	assert(t->initialized);
-
-	if (write_notes_tree(t, tree_sha1))
-		die("Failed to write notes tree to database");
-
-	if (!parents) {
-		/* Deduce parent commit from t->ref */
-		unsigned char parent_sha1[20];
-		if (!read_ref(t->ref, parent_sha1)) {
-			struct commit *parent = lookup_commit(parent_sha1);
-			if (!parent || parse_commit(parent))
-				die("Failed to find/parse commit %s", t->ref);
-			commit_list_insert(parent, &parents);
-		}
-		/* else: t->ref points to nothing, assume root/orphan commit */
-	}
-
-	if (commit_tree(msg, tree_sha1, parents, result_sha1, NULL, NULL))
-		die("Failed to commit notes tree to database");
-}
-
 int notes_merge(struct notes_merge_options *o,
 		struct notes_tree *local_tree,
 		unsigned char *result_sha1)
diff --git a/notes-merge.h b/notes-merge.h
index 0c11b17..1d01f6a 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -26,20 +26,6 @@ struct notes_merge_options {
 void init_notes_merge_options(struct notes_merge_options *o);
 
 /*
- * Create new notes commit from the given notes tree
- *
- * Properties of the created commit:
- * - tree: the result of converting t to a tree object with write_notes_tree().
- * - parents: the given parents OR (if NULL) the commit referenced by t->ref.
- * - author/committer: the default determined by commmit_tree().
- * - commit message: msg
- *
- * The resulting commit SHA1 is stored in result_sha1.
- */
-void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
-			 const struct strbuf *msg, unsigned char *result_sha1);
-
-/*
  * Merge notes from o->remote_ref into o->local_ref
  *
  * The given notes_tree 'local_tree' must be the notes_tree referenced by the
diff --git a/notes-utils.c b/notes-utils.c
index 2ae5cb2..9107c37 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -2,7 +2,32 @@
 #include "commit.h"
 #include "refs.h"
 #include "notes-utils.h"
-#include "notes-merge.h" // need create_notes_commit()
+
+void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
+			 const struct strbuf *msg, unsigned char *result_sha1)
+{
+	unsigned char tree_sha1[20];
+
+	assert(t->initialized);
+
+	if (write_notes_tree(t, tree_sha1))
+		die("Failed to write notes tree to database");
+
+	if (!parents) {
+		/* Deduce parent commit from t->ref */
+		unsigned char parent_sha1[20];
+		if (!read_ref(t->ref, parent_sha1)) {
+			struct commit *parent = lookup_commit(parent_sha1);
+			if (!parent || parse_commit(parent))
+				die("Failed to find/parse commit %s", t->ref);
+			commit_list_insert(parent, &parents);
+		}
+		/* else: t->ref points to nothing, assume root/orphan commit */
+	}
+
+	if (commit_tree(msg, tree_sha1, parents, result_sha1, NULL, NULL))
+		die("Failed to commit notes tree to database");
+}
 
 void commit_notes(struct notes_tree *t, const char *msg)
 {
diff --git a/notes-utils.h b/notes-utils.h
index 0661e99..b4cb1bf 100644
--- a/notes-utils.h
+++ b/notes-utils.h
@@ -3,6 +3,20 @@
 
 #include "notes.h"
 
+/*
+ * Create new notes commit from the given notes tree
+ *
+ * Properties of the created commit:
+ * - tree: the result of converting t to a tree object with write_notes_tree().
+ * - parents: the given parents OR (if NULL) the commit referenced by t->ref.
+ * - author/committer: the default determined by commmit_tree().
+ * - commit message: msg
+ *
+ * The resulting commit SHA1 is stored in result_sha1.
+ */
+void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
+			 const struct strbuf *msg, unsigned char *result_sha1);
+
 void commit_notes(struct notes_tree *t, const char *msg);
 
 struct notes_rewrite_cfg {
-- 
1.8.1.3.704.g33f7d4f
