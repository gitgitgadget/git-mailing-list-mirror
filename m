Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6EC120986
	for <e@80x24.org>; Tue, 27 Sep 2016 15:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933805AbcI0PXh (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 11:23:37 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:41182 "EHLO
        homiemail-a15.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933459AbcI0PXe (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Sep 2016 11:23:34 -0400
Received: from homiemail-a15.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a15.g.dreamhost.com (Postfix) with ESMTP id E1DFF76C073;
        Tue, 27 Sep 2016 08:23:33 -0700 (PDT)
Received: from localhost.localdomain (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a15.g.dreamhost.com (Postfix) with ESMTPSA id 7E68B76C06F;
        Tue, 27 Sep 2016 08:23:33 -0700 (PDT)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org, peff@peff.net
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH v3 2/3] fsck: handle bad trees like other errors
Date:   Tue, 27 Sep 2016 11:23:25 -0400
Message-Id: <1474989806-5002-2-git-send-email-dturner@twosigma.com>
X-Mailer: git-send-email 2.8.0.rc4.22.g8ae061a
In-Reply-To: <1474989806-5002-1-git-send-email-dturner@twosigma.com>
References: <1474989806-5002-1-git-send-email-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying when fsck hits a malformed tree object, log the error
like any other and continue.  Now fsck can tell the user which tree is
bad, too.

Signed-off-by: David Turner <dturner@twosigma.com>
---
 fsck.c          | 18 ++++++++-----
 t/t1450-fsck.sh | 16 +++++++++--
 tree-walk.c     | 83 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 tree-walk.h     |  8 ++++++
 4 files changed, 106 insertions(+), 19 deletions(-)

diff --git a/fsck.c b/fsck.c
index c9cf3de..4a3069e 100644
--- a/fsck.c
+++ b/fsck.c
@@ -347,8 +347,9 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 		return -1;
 
 	name = get_object_name(options, &tree->object);
-	init_tree_desc(&desc, tree->buffer, tree->size);
-	while (tree_entry(&desc, &entry)) {
+	if (init_tree_desc_gently(&desc, tree->buffer, tree->size))
+		return -1;
+	while (tree_entry_gently(&desc, &entry)) {
 		struct object *obj;
 		int result;
 
@@ -520,7 +521,7 @@ static int verify_ordered(unsigned mode1, const char *name1, unsigned mode2, con
 
 static int fsck_tree(struct tree *item, struct fsck_options *options)
 {
-	int retval;
+	int retval = 0;
 	int has_null_sha1 = 0;
 	int has_full_path = 0;
 	int has_empty_name = 0;
@@ -535,7 +536,10 @@ static int fsck_tree(struct tree *item, struct fsck_options *options)
 	unsigned o_mode;
 	const char *o_name;
 
-	init_tree_desc(&desc, item->buffer, item->size);
+	if (init_tree_desc_gently(&desc, item->buffer, item->size)) {
+		retval += report(options, &item->object, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
+		return retval;
+	}
 
 	o_mode = 0;
 	o_name = NULL;
@@ -556,7 +560,10 @@ static int fsck_tree(struct tree *item, struct fsck_options *options)
 			       is_hfs_dotgit(name) ||
 			       is_ntfs_dotgit(name));
 		has_zero_pad |= *(char *)desc.buffer == '0';
-		update_tree_entry(&desc);
+		if (update_tree_entry_gently(&desc)) {
+			retval += report(options, &item->object, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
+			break;
+		}
 
 		switch (mode) {
 		/*
@@ -597,7 +604,6 @@ static int fsck_tree(struct tree *item, struct fsck_options *options)
 		o_name = name;
 	}
 
-	retval = 0;
 	if (has_null_sha1)
 		retval += report(options, &item->object, FSCK_MSG_NULL_SHA1, "contains entries pointing to null sha1");
 	if (has_full_path)
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 8f52da2..0fcd38a 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -188,8 +188,7 @@ test_expect_success 'commit with NUL in header' '
 	grep "error in commit $new.*unterminated header: NUL at offset" out
 '
 
-test_expect_success 'malformatted tree object' '
-	test_when_finished "git update-ref -d refs/tags/wrong" &&
+test_expect_success 'tree object with duplicate entries' '
 	test_when_finished "remove_object \$T" &&
 	T=$(
 		GIT_INDEX_FILE=test-index &&
@@ -208,6 +207,19 @@ test_expect_success 'malformatted tree object' '
 	grep "error in tree .*contains duplicate file entries" out
 '
 
+test_expect_success 'unparseable tree object' '
+	test_when_finished "git update-ref -d refs/heads/wrong" &&
+	test_when_finished "remove_object \$tree_sha1" &&
+	test_when_finished "remove_object \$commit_sha1" &&
+	tree_sha1=$(printf "100644 \0twenty-bytes-of-junk" | git hash-object -t tree --stdin -w --literally) &&
+	commit_sha1=$(git commit-tree $tree_sha1) &&
+	git update-ref refs/heads/wrong $commit_sha1 &&
+	test_must_fail git fsck 2>out &&
+	test_i18ngrep "error: empty filename in tree entry" out &&
+	test_i18ngrep "$tree_sha1" out &&
+	! test_i18ngrep "fatal: empty filename in tree entry" out
+'
+
 test_expect_success 'tag pointing to nonexistent' '
 	cat >invalid-tag <<-\EOF &&
 	object ffffffffffffffffffffffffffffffffffffffff
diff --git a/tree-walk.c b/tree-walk.c
index 24f9a0f..828f435 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -22,33 +22,60 @@ static const char *get_mode(const char *str, unsigned int *modep)
 	return str;
 }
 
-static void decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned long size)
+static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned long size, struct strbuf *err)
 {
 	const char *path;
 	unsigned int mode, len;
 
-	if (size < 23 || buf[size - 21])
-		die(_("too-short tree object"));
+	if (size < 23 || buf[size - 21]) {
+		strbuf_addstr(err, _("too-short tree object"));
+		return -1;
+	}
 
 	path = get_mode(buf, &mode);
-	if (!path)
-		die(_("malformed mode in tree entry for tree"));
-	if (!*path)
-		die(_("empty filename in tree entry for tree"));
+	if (!path) {
+		strbuf_addstr(err, _("malformed mode in tree entry"));
+		return -1;
+	}
+	if (!*path) {
+		strbuf_addstr(err, _("empty filename in tree entry"));
+		return -1;
+	}
 	len = strlen(path) + 1;
 
 	/* Initialize the descriptor entry */
 	desc->entry.path = path;
 	desc->entry.mode = canon_mode(mode);
 	desc->entry.oid  = (const struct object_id *)(path + len);
+
+	return 0;
 }
 
-void init_tree_desc(struct tree_desc *desc, const void *buffer, unsigned long size)
+static int init_tree_desc_internal(struct tree_desc *desc, const void *buffer, unsigned long size, struct strbuf *err)
 {
 	desc->buffer = buffer;
 	desc->size = size;
 	if (size)
-		decode_tree_entry(desc, buffer, size);
+		return decode_tree_entry(desc, buffer, size, err);
+	return 0;
+}
+
+void init_tree_desc(struct tree_desc *desc, const void *buffer, unsigned long size)
+{
+	struct strbuf err = STRBUF_INIT;
+	if (init_tree_desc_internal(desc, buffer, size, &err))
+		die("%s", err.buf);
+	strbuf_release(&err);
+}
+
+int init_tree_desc_gently(struct tree_desc *desc, const void *buffer, unsigned long size)
+{
+	struct strbuf err = STRBUF_INIT;
+	int result = init_tree_desc_internal(desc, buffer, size, &err);
+	if (result)
+		error("%s", err.buf);
+	strbuf_release(&err);
+	return result;
 }
 
 void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1)
@@ -75,7 +102,7 @@ static void entry_extract(struct tree_desc *t, struct name_entry *a)
 	*a = t->entry;
 }
 
-void update_tree_entry(struct tree_desc *desc)
+static int update_tree_entry_internal(struct tree_desc *desc, struct strbuf *err)
 {
 	const void *buf = desc->buffer;
 	const unsigned char *end = desc->entry.oid->hash + 20;
@@ -89,7 +116,30 @@ void update_tree_entry(struct tree_desc *desc)
 	desc->buffer = buf;
 	desc->size = size;
 	if (size)
-		decode_tree_entry(desc, buf, size);
+		return decode_tree_entry(desc, buf, size, err);
+	return 0;
+}
+
+void update_tree_entry(struct tree_desc *desc)
+{
+	struct strbuf err = STRBUF_INIT;
+	if (update_tree_entry_internal(desc, &err))
+		die("%s", err.buf);
+	strbuf_release(&err);
+}
+
+int update_tree_entry_gently(struct tree_desc *desc)
+{
+	struct strbuf err = STRBUF_INIT;
+	if (update_tree_entry_internal(desc, &err)) {
+		error("%s", err.buf);
+		strbuf_release(&err);
+		/* Stop processing this tree after error */
+		desc->size = 0;
+		return -1;
+	}
+	strbuf_release(&err);
+	return 0;
 }
 
 int tree_entry(struct tree_desc *desc, struct name_entry *entry)
@@ -102,6 +152,17 @@ int tree_entry(struct tree_desc *desc, struct name_entry *entry)
 	return 1;
 }
 
+int tree_entry_gently(struct tree_desc *desc, struct name_entry *entry)
+{
+	if (!desc->size)
+		return 0;
+
+	*entry = desc->entry;
+	if (update_tree_entry_gently(desc))
+		return 0;
+	return 1;
+}
+
 void setup_traverse_info(struct traverse_info *info, const char *base)
 {
 	int pathlen = strlen(base);
diff --git a/tree-walk.h b/tree-walk.h
index 97a7d69..68bb78b 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -25,14 +25,22 @@ static inline int tree_entry_len(const struct name_entry *ne)
 	return (const char *)ne->oid - ne->path - 1;
 }
 
+/*
+ * The _gently versions of these functions warn and return false on a
+ * corrupt tree entry rather than dying,
+ */
+
 void update_tree_entry(struct tree_desc *);
+int update_tree_entry_gently(struct tree_desc *);
 void init_tree_desc(struct tree_desc *desc, const void *buf, unsigned long size);
+int init_tree_desc_gently(struct tree_desc *desc, const void *buf, unsigned long size);
 
 /*
  * Helper function that does both tree_entry_extract() and update_tree_entry()
  * and returns true for success
  */
 int tree_entry(struct tree_desc *, struct name_entry *);
+int tree_entry_gently(struct tree_desc *, struct name_entry *);
 
 void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1);
 
-- 
2.8.0.rc4.22.g8ae061a

