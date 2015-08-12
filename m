From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 2/4] path: optimize common dir checking
Date: Wed, 12 Aug 2015 17:57:23 -0400
Message-ID: <1439416645-19173-2-git-send-email-dturner@twopensource.com>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, chriscool@tuxfamily.org,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Aug 12 23:58:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPe29-0003d9-9H
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 23:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbbHLV5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 17:57:53 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36307 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbbHLV5w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 17:57:52 -0400
Received: by qgdd90 with SMTP id d90so20234224qgd.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 14:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h/g37IhaB13+869D2NdA6QC3I5PEabDPFNvOYPmsJmc=;
        b=md+ChJVRBN1VQAiDR+xFBQSIrswLzvAy+GEiLU2X1XnSC0ik1xazuLCNNybtrw8tvq
         igAIaFZ2+yj9s3wUs9mwaU26eINGTaLxSkOt499E11z+3g359027LICwbggmh64RO/xb
         DM3oN9vjHHd/GLfuDxDm6h3TwSbZ//rLlf4J3GM2uLWtKiMj9PD0ifzgdglJPGxbqFI7
         mYIpB72OpC6bvhErZca52MpLTLQaejrZFle4Vg6qPr+bFSnyemf6mq8nKkE63MB4HVxk
         P09JqSQ3YUL1hvvrgY/X0tmUFyYhotktk7ZNRwm8/t8bxkoQr9sO18D+3lKNr07IJZpQ
         R8eQ==
X-Gm-Message-State: ALoCoQlWyazEBMIH6457oml1SIvKMPm0I3ir7auehss5fctXn5Q++LmKKEbkZsv/1Npngis7vlck
X-Received: by 10.140.94.194 with SMTP id g60mr62964518qge.72.1439416671401;
        Wed, 12 Aug 2015 14:57:51 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f71sm110289qhe.7.2015.08.12.14.57.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Aug 2015 14:57:50 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1439416645-19173-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275817>

Instead of a linear search over common_list to check whether
a path is common, use a trie.  The trie search operates on
path prefixes, and handles excludes.

Signed-off-by: David Turner <dturner@twopensource.com>
---

Probably overkill, but maybe we could later use it for making exclude
or sparse-checkout matching faster (or maybe we have to go all the way
to McNaughton-Yamada for that to be truly worthwhile).

---
 path.c | 215 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 201 insertions(+), 14 deletions(-)

diff --git a/path.c b/path.c
index 236f797..21a4ce7 100644
--- a/path.c
+++ b/path.c
@@ -121,25 +121,212 @@ struct common_dir common_list[] = {
 	{ NULL, 0, 0, 0 }
 };
 
-static void update_common_dir(struct strbuf *buf, int git_dir_len)
+/*
+ * A compressed trie.  A trie node consists of zero or more characters that
+ * are common to all elements with this prefix, optionally followed by some
+ * children.  If value is not NULL, the trie node is a terminal node.
+ *
+ * For example, consider the following set of strings:
+ * abc
+ * def
+ * definite
+ * definition
+ *
+ * The trie would look look like:
+ * root: len = 0, value = (something), children a and d non-NULL.
+ *    a: len = 2, contents = bc
+ *    d: len = 2, contents = ef, children i non-NULL, value = (something)
+ *       i: len = 3, contents = nit, children e and i non-NULL, value = NULL
+ *           e: len = 0, children all NULL, value = (something)
+ *           i: len = 2, contents = on, children all NULL, value = (something)
+ */
+struct trie {
+	struct trie *children[256];
+	int len;
+	char *contents;
+	void *value;
+};
+
+static struct trie *make_trie_node(const char *key, void *value)
 {
-	char *base = buf->buf + git_dir_len;
-	const struct common_dir *p;
+	struct trie *new_node = xcalloc(1, sizeof(*new_node));
+	new_node->len = strlen(key);
+	if (new_node->len) {
+		new_node->contents = xmalloc(new_node->len);
+		memcpy(new_node->contents, key, new_node->len);
+	}
+	new_node->value = value;
+	return new_node;
+}
 
-	if (is_dir_file(base, "logs", "HEAD") ||
-	    is_dir_file(base, "info", "sparse-checkout"))
-		return;	/* keep this in $GIT_DIR */
-	for (p = common_list; p->dirname; p++) {
-		const char *path = p->dirname;
-		if (p->is_dir && dir_prefix(base, path)) {
-			replace_dir(buf, git_dir_len, get_git_common_dir());
-			return;
+/*
+ * Add a key/value pair to a trie.  The key is assumed to be \0-terminated.
+ * If there was an existing value for this key, return it.
+ */
+static void *add_to_trie(struct trie *root, const char *key, void *value)
+{
+	struct trie *child;
+	void *old;
+	int i;
+
+	if (!*key) {
+		/* we have reached the end of the key */
+		old = root->value;
+		root->value = value;
+		return old;
+	}
+
+	for (i = 0; i < root->len; ++i) {
+		if (root->contents[i] == key[i])
+			continue;
+
+		/*
+		 * Split this node: child will contain this node's
+		 * existing children.
+		 */
+		child = malloc(sizeof(*child));
+		memcpy(child->children, root->children, sizeof(root->children));
+
+		child->len = root->len - i - 1;
+		if (child->len) {
+			child->contents = strndup(root->contents + i + 1,
+						   child->len);
 		}
-		if (!p->is_dir && !strcmp(base, path)) {
-			replace_dir(buf, git_dir_len, get_git_common_dir());
-			return;
+		child->value = root->value;
+		root->value = NULL;
+		root->len = i;
+
+		memset(root->children, 0, sizeof(root->children));
+		root->children[(unsigned char)root->contents[i]] = child;
+
+		/* This is the newly-added child. */
+		root->children[(unsigned char)key[i]] =
+			make_trie_node(key + i + 1, value);
+		return NULL;
+	}
+
+	/* We have matched the entire compressed section */
+	if (key[i]) {
+		child = root->children[(unsigned char)key[root->len]];
+		if (child) {
+			return add_to_trie(child, key + root->len + 1, value);
+		} else {
+			child = make_trie_node(key + root->len + 1, value);
+			root->children[(unsigned char)key[root->len]] = child;
+			return NULL;
 		}
 	}
+
+	old = root->value;
+	root->value = value;
+	return old;
+}
+
+typedef int (*match_fn)(const char *unmatched, void *data, void *baton);
+
+/*
+ * Search a trie for some key.  Find the longest /-or-\0-terminated
+ * prefix of the key for which the trie contains a value.  Call fn
+ * with the unmatched portion of the key and the found value, and
+ * return its return value.  If there is no such prefix, return -1.
+ *
+ * For example, consider the trie containing only [refs,
+ * refs/worktree] (both with values).
+ *
+ * | key             | unmatched  | val from node | return value |
+ * |-----------------|------------|---------------|--------------|
+ * | a               | not called | n/a           | -1           |
+ * | refs            | \0         | refs          | as per fn    |
+ * | refs/           | /          | refs          | as per fn    |
+ * | refs/w          | /w         | refs          | as per fn    |
+ * | refs/worktree   | \0         | refs/worktree | as per fn    |
+ * | refs/worktree/  | /          | refs/worktree | as per fn    |
+ * | refs/worktree/a | /a         | refs/worktree | as per fn    |
+ * |-----------------|------------|---------------|--------------|
+ *
+ */
+static int trie_find(struct trie *root, const char *key, match_fn fn,
+		     void *baton)
+{
+	int i;
+	int result;
+	struct trie *child;
+
+	if (!*key) {
+		/* we have reached the end of the key */
+		if (root->value && !root->len)
+			return fn(key, root->value, baton);
+		else
+			return -1;
+	}
+
+	for (i = 0; i < root->len; ++i) {
+		if (root->contents[i] != key[i])
+			return -1;
+	}
+
+	/* Matched the entire compressed section */
+	key += i;
+	if (!*key)
+		/* End of key */
+		return fn(key, root->value, baton);
+
+	child = root->children[(unsigned char)*key];
+	if (child)
+		result = trie_find(child, key + 1, fn, baton);
+	else
+		result = -1;
+
+	if (result >= 0 || (*key != '/' && *key != 0))
+		return result;
+	if (root->value)
+		return fn(key, root->value, baton);
+	else
+		return -1;
+}
+
+static struct trie common_trie;
+static int common_trie_done_setup;
+
+static void init_common_trie(void)
+{
+	struct common_dir *p;
+
+	if (common_trie_done_setup)
+		return;
+
+	for (p = common_list; p->dirname; p++)
+		add_to_trie(&common_trie, p->dirname, p);
+
+	common_trie_done_setup = 1;
+}
+
+/*
+ * Helper function for update_common_dir: returns 1 if the dir
+ * prefix is common.
+ */
+static int check_common(const char *unmatched, void *value, void *baton)
+{
+	struct common_dir *dir = value;
+
+	if (!dir)
+		return 0;
+
+	if (dir->is_dir && (unmatched[0] == 0 || unmatched[0] == '/'))
+		return !dir->exclude;
+
+	if (!dir->is_dir && unmatched[0] == 0)
+		return !dir->exclude;
+
+	return 0;
+}
+
+static void update_common_dir(struct strbuf *buf, int git_dir_len)
+{
+	char *base = buf->buf + git_dir_len;
+	init_common_trie();
+	if (trie_find(&common_trie, base, check_common, NULL) > 0)
+		replace_dir(buf, git_dir_len, get_git_common_dir());
 }
 
 void report_linked_checkout_garbage(void)
-- 
2.0.4.315.gad8727a-twtrsrc
