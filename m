From: dturner@twopensource.com
Subject: [PATCH 1/3] tree-walk: learn get_tree_enty_follow_symlinks
Date: Fri,  8 May 2015 14:13:37 -0400
Message-ID: <1431108819-6831-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 08 20:14:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqmme-0001gA-Ac
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 20:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbbEHSNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 14:13:55 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34374 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbbEHSNx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 14:13:53 -0400
Received: by qgfi89 with SMTP id i89so40410831qgf.1
        for <git@vger.kernel.org>; Fri, 08 May 2015 11:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uaPnSRndahdtLq5l9Wn5NI8qGbNh2+YuMya0NCVi0gM=;
        b=I167f+hbhzoMjyobD3xG8Y/nkCdhdT3iPC4DsWaBuGkNj5zLuodR+oGKyZpThRAw+k
         HdU6R4FsdgszEN1RnMqd4xVtW42I0yS3LuVCvw/MZYMcydZz3N/XRGdYd0GiYz9V66fk
         Fdocgdwcz7ssKS/snHX2bt23upwO2hHuSB/0CHKoFqfVXu41Qos0Mru5DDMuDWb7dlm9
         q3CmuXWXsZri5m2gDn0eNcUmEOAC3ks59fW1s/EWnqfDogqkfCDv5IZqTt7RvxHmf2P7
         9n+01kwJSu4+KAZlKeN8pr2yetC8ioHrTl7dSUMVBEs4168mnuGj9+O+Is/I7t+XM3P0
         /6Ww==
X-Gm-Message-State: ALoCoQk7P/13WebEdme06QNdtS/xWUMnHcuBlyH1IEUv+yRi91uAxlgp2B8PhFRmaSO4PJiohYwU
X-Received: by 10.55.24.215 with SMTP id 84mr11077366qky.8.1431108833150;
        Fri, 08 May 2015 11:13:53 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by mx.google.com with ESMTPSA id 69sm4099966qhv.17.2015.05.08.11.13.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 May 2015 11:13:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268638>

From: David Turner <dturner@twitter.com>

Add a new function, get_tree_entry_follow_symlinks, to tree-walk.[ch].
The function is not yet used.  It will be used to implement git
cat-file --batch --follow-symlinks.

The function locates an object by path, following symlinks in the
repository.  If the symlinks lead outside the repository, the function
reports this to the caller.

Signed-off-by: David Turner <dturner@twitter.com>
---
 tree-walk.c | 222 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tree-walk.h |   2 +
 2 files changed, 224 insertions(+)

diff --git a/tree-walk.c b/tree-walk.c
index 5dd9a71..6fb4b7d 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -415,6 +415,228 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 	return error;
 }
 
+static int find_tree_entry_nonrecursive(struct tree_desc *t, char *name, unsigned char *result, unsigned *mode) {
+	int namelen = strlen(name);
+
+	while (t->size) {
+		const char *entry;
+		const unsigned char *sha1;
+		int entrylen, cmp;
+
+		sha1 = tree_entry_extract(t, &entry, mode);
+		entrylen = tree_entry_len(&t->entry);
+		update_tree_entry(t);
+		if (entrylen > namelen)
+			continue;
+		cmp = memcmp(name, entry, entrylen);
+		if (cmp > 0)
+			continue;
+		if (cmp < 0)
+			break;
+		if (entrylen == namelen) {
+			hashcpy(result, sha1);
+			return 0;
+		}
+		if (name[entrylen] != '/')
+			continue;
+		if (!S_ISDIR(*mode))
+			break;
+		hashcpy(result, sha1);
+		return 0;
+	}
+	return -1;
+}
+
+struct dir_state {
+	void *tree;
+	unsigned long size;
+	unsigned char sha1[20];
+};
+
+#define GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS 40
+
+/**
+ * Find a tree entry by following symlinks in tree_sha (which is
+ * assumed to be the root of the repository).  In the event that a
+ * symlink points outside the repository (e.g. a link to /foo or a
+ * root-level link to ../foo), the portion of the link which is
+ * outside the repository will be copied into result_path (which is
+ * assumed to hold at least PATH_MAX bytes), and *mode will be set to
+ * 0.  Otherwise, result will be filled in with the sha1 of the found
+ * object, and *mode will hold the mode of the object.
+ */
+int get_tree_enty_follow_symlinks(unsigned char *tree_sha1, const char *name, unsigned char *result, unsigned char *result_path, unsigned *mode)
+{
+	int retval = -1;
+	void *tree;
+	struct dir_state *parents = NULL;
+	size_t parents_cap = 0;
+	ssize_t parents_len = 0;
+	unsigned long size;
+	unsigned char root[20];
+	unsigned char current_tree_sha1[20];
+	struct strbuf namebuf = STRBUF_INIT;
+	enum object_type type;
+	int already_have_tree = 0;
+	struct tree_desc t = {0};
+	int follows_remaining = GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS;
+	int i;
+
+	strbuf_addstr(&namebuf, name);
+	hashcpy(current_tree_sha1, tree_sha1);
+
+	while (1) {
+		char *first_slash;
+		char *remainder = NULL;
+		int find_result;
+
+		if (!t.buffer) {
+			tree = read_object_with_reference(current_tree_sha1,
+							  tree_type, &size,
+							  root);
+			if (!tree)
+				goto done;
+
+			ALLOC_GROW(parents, parents_len + 1, parents_cap);
+			parents[parents_len].tree = tree;
+			parents[parents_len].size = size;
+			hashcpy(parents[parents_len].sha1, root);
+
+			parents_len++;
+
+			if (namebuf.buf[0] == '\0') {
+				hashcpy(result, root);
+				retval = 0;
+				goto done;
+			}
+
+			if (!size)
+				goto done;
+
+			/* descend */
+			init_tree_desc(&t, tree, size);
+		}
+
+		/* Handle symlinks to e.g. a//b by removing leading slashes */
+		while (namebuf.buf[0] == '/') {
+			strbuf_remove(&namebuf, 0, 1);
+		}
+
+		/* Split namebuf into a first component and a
+		 * remainder */
+		if ((first_slash = strchr(namebuf.buf, '/'))) {
+			*first_slash = 0;
+			remainder = first_slash + 1;
+		}
+
+		if (!strcmp(namebuf.buf, "..")) {
+			struct dir_state *parent;
+			/* We could end up with .. in the namebuf if
+			 * it appears in a symlink. */
+
+			if (parents_len == 1) {
+				if (remainder)
+					*first_slash = '/';
+				if (strlcpy(result_path, namebuf.buf,
+					    PATH_MAX) < PATH_MAX) {
+					*mode = 0;
+					retval = 0;
+				}
+				goto done;
+			}
+			parent = &parents[parents_len - 1];
+			free(parent->tree);
+			parents_len--;
+			parent = &parents[parents_len - 1];
+			init_tree_desc(&t, parent->tree, parent->size);
+			strbuf_remove(&namebuf, 0, remainder ? 3 : 2);
+			continue;
+		}
+
+		/* We could end up here via a symlink to dir/.. */
+		if (namebuf.buf[0] == '\0') {
+			hashcpy(result, parents[parents_len - 1].sha1);
+			retval = 0;
+			goto done;
+		}
+
+		/* Look up the first (or only) path component
+		 * in the tree. */
+		find_result = find_tree_entry_nonrecursive(&t, namebuf.buf,
+							   current_tree_sha1,
+							   mode);
+		if (find_result) {
+			retval = find_result;
+			goto done;
+		}
+
+		if (S_ISDIR(*mode)) {
+			if (!remainder) {
+				hashcpy(result, current_tree_sha1);
+				retval = 0;
+				goto done;
+			}
+			/* Descend the tree */
+			t.buffer = NULL;
+			strbuf_remove(&namebuf, 0,
+				      1 + first_slash - namebuf.buf);
+		} else if (S_ISREG(*mode)) {
+			if (!remainder) {
+				hashcpy(result, current_tree_sha1);
+				retval = 0;
+			}
+			goto done;
+		} else if (S_ISLNK(*mode)) {
+			/* Follow a symlink */
+			size_t link_len, len;
+			char *contents, *contents_start;
+			struct dir_state *parent;
+
+			if (follows_remaining-- == 0)
+				/* Too many symlinks followed */
+				goto done;
+
+			contents = read_sha1_file(current_tree_sha1, &type,
+						  &link_len);
+
+			if (!contents)
+				goto done;
+
+			if (contents[0] == '/') {
+				if (strlcpy(result_path,
+					    contents, PATH_MAX) < PATH_MAX) {
+					*mode = 0;
+					retval = 0;
+				}
+				goto done;
+			}
+
+			if (remainder)
+				len = first_slash - namebuf.buf;
+			else
+				len = namebuf.len;
+
+			contents_start = contents;
+
+			parent = &parents[parents_len - 1];
+			init_tree_desc(&t, parent->tree, parent->size);
+			strbuf_splice(&namebuf, 0, len,
+				      contents_start, link_len);
+			if (remainder)
+				namebuf.buf[link_len] = '/';
+			free(contents);
+		}
+	}
+done:
+	for (i = 0; i < parents_len; ++i) {
+		free(parents[i].tree);
+	}
+	free(parents);
+
+	strbuf_release(&namebuf);
+	return retval;
+}
+
 static int find_tree_entry(struct tree_desc *t, const char *name, unsigned char *result, unsigned *mode)
 {
 	int namelen = strlen(name);
diff --git a/tree-walk.h b/tree-walk.h
index ae7fb3a..002e5a9 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -40,6 +40,8 @@ struct traverse_info;
 typedef int (*traverse_callback_t)(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *);
 int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info);
 
+int get_tree_enty_follow_symlinks(unsigned char *tree_sha1, const char *name, unsigned char *result, unsigned char *result_path, unsigned *mode);
+
 struct traverse_info {
 	struct traverse_info *prev;
 	struct name_entry name;
-- 
2.0.4.315.gad8727a-twtrsrc
