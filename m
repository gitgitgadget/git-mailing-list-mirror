From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 2/3] path: optimize common dir checking
Date: Mon, 31 Aug 2015 22:13:10 -0400
Message-ID: <1441073591-639-3-git-send-email-dturner@twopensource.com>
References: <1441073591-639-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu,
	Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 04:13:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWb4s-0005Rm-D5
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 04:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758AbbIACNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 22:13:35 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36246 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722AbbIACNe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 22:13:34 -0400
Received: by qkbp67 with SMTP id p67so26709465qkb.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 19:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8AAYSnJOTgoKdAi0sgWqOPxE9bNwv+My3M+hQAggUAI=;
        b=hKxSTjL6tTyd1VEMB1TFVzk9MvLxT+Jgx5tlooQW1vP8bFuOU97wbDNoYlUf5Eekal
         543oPVUYiWocSL9OWbztR846asXGflP/+JdAH/NfVqumj5tONRvCm71bAyLut1mcIKx9
         7EqWuq3awEup1kDB1yoXuzz62AuXAvJAxgi6bbH2MKaj9ZDC1NDaVTSfHj29tp35tZLy
         hxVjwsgGdWpbO1T/m3nVDjZLWNfJewX3EiVoXM8lviQB9nGTzdkbhABA7pf1TYkg1trM
         LVgVvkeQ7VzMWn/EsttZEXmNGzGtwcJU8pk3S9INSfTL9wCc90bjGw2+0K5tZXxg2lRs
         G4bg==
X-Gm-Message-State: ALoCoQmgosERoqGQ9t83hdFCUYirLwvmaDEKdChGfddenyHA3TqRin0ixCC6T/1xJmH84D7vjar9
X-Received: by 10.55.15.3 with SMTP id z3mr14695430qkg.29.1441073613257;
        Mon, 31 Aug 2015 19:13:33 -0700 (PDT)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id j207sm9926375qhc.17.2015.08.31.19.13.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Aug 2015 19:13:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441073591-639-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276962>

Instead of a linear search over common_list to check whether
a path is common, use a trie.  The trie search operates on
path prefixes, and handles excludes.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 path.c                | 227 ++++++++++++++++++++++++++++++++++++++++++++++----
 t/t0060-path-utils.sh |   1 +
 2 files changed, 214 insertions(+), 14 deletions(-)

diff --git a/path.c b/path.c
index f1ffe37..c87f44a 100644
--- a/path.c
+++ b/path.c
@@ -121,25 +121,224 @@ struct common_dir common_list[] = {
 	{ 0, 0, 0, NULL }
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
+ * root: len = 0, children a and d non-NULL, value = NULL.
+ *    a: len = 2, contents = bc, value = (data for "abc")
+ *    d: len = 2, contents = ef, children i non-NULL, value = (data for "def")
+ *       i: len = 3, contents = nit, children e and i non-NULL, value = NULL
+ *           e: len = 0, children all NULL, value = (data for "definite")
+ *           i: len = 2, contents = on, children all NULL,
+ *              value = (data for "definition")
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
+	for (i = 0; i < root->len; i++) {
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
+			child->contents = xstrndup(root->contents + i + 1,
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
+ * The key is partially normalized: consecutive slashes are skipped.
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
+	for (i = 0; i < root->len; i++) {
+		/* Partial path normalization: skip consecutive slashes. */
+		if (key[i] == '/' && key[i+1] == '/') {
+			key++;
+			continue;
+		}
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
+	/* Partial path normalization: skip consecutive slashes */
+	while (key[0] == '/' && key[1] == '/')
+		key++;
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
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 93605f4..1ca49e1 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -271,6 +271,7 @@ test_git_path GIT_COMMON_DIR=bar objects/bar              bar/objects/bar
 test_git_path GIT_COMMON_DIR=bar info/exclude             bar/info/exclude
 test_git_path GIT_COMMON_DIR=bar info/grafts              bar/info/grafts
 test_git_path GIT_COMMON_DIR=bar info/sparse-checkout     .git/info/sparse-checkout
+test_git_path GIT_COMMON_DIR=bar info//sparse-checkout    .git/info//sparse-checkout
 test_git_path GIT_COMMON_DIR=bar remotes/bar              bar/remotes/bar
 test_git_path GIT_COMMON_DIR=bar branches/bar             bar/branches/bar
 test_git_path GIT_COMMON_DIR=bar logs/refs/heads/master   bar/logs/refs/heads/master
-- 
2.0.4.315.gad8727a-twtrsrc
