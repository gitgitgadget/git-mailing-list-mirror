From: David Turner <dturner@twopensource.com>
Subject: [PATCH 1/3] tree-walk: learn get_tree_entry_follow_symlinks
Date: Thu, 14 May 2015 17:58:13 -0400
Message-ID: <1431640695-24741-2-git-send-email-user@ubuntu>
References: <1431640695-24741-1-git-send-email-user@ubuntu>
Cc: David Turner <dturner@twitter.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 23:58:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt19R-0002TZ-OT
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 23:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422824AbbENV6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 17:58:40 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:33534 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422652AbbENV6k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 17:58:40 -0400
Received: by qcvo8 with SMTP id o8so47674737qcv.0
        for <git@vger.kernel.org>; Thu, 14 May 2015 14:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iPyF2j4qXp0QkK6NR3A9X+5dNpkHAQZTx+5U/fpPNHE=;
        b=PvFLD9HfPdmyHyXBs3Swze+PmXqWtJGFhsug6tvwyec2v3KtnRGlr5w9etJ1mbKEyO
         leu25h+9tFAlbCxVTd+WUEDZ1yrHlUe5kKUqpl2+M0X5JJDB2JsKRd6Lp7dq69KDFBE0
         0fdbV6QMLFnI/6+KlINtHWGH9jlrx+m2n2mFLgRhbmDLGCA462XgziVdpgakxTeMRd7j
         BfdpFj83+6rP6qVJKc4ED5wjCGACzxZy8BmYWfop+s85orgKV8WKnRG9PN+zGs8rWZuA
         KeOvubA3cDD0cC/Nfw1usmB6dPlGWFuv223TsHUiVjfw52j7fXNCX0Rf84OBD+qtxxrM
         HREQ==
X-Gm-Message-State: ALoCoQmdVaozIRKHKVnOpmof8zViBi1J/BCt1tsSn/toMM5hVTzUbmVxiBVLnXO0tcG3kgatsnjt
X-Received: by 10.140.132.80 with SMTP id 77mr8937863qhe.36.1431640719392;
        Thu, 14 May 2015 14:58:39 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by mx.google.com with ESMTPSA id o65sm237191qge.34.2015.05.14.14.58.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 May 2015 14:58:38 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twopensource>
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1431640695-24741-1-git-send-email-user@ubuntu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269110>

From: David Turner <dturner@twitter.com>

Add a new function, get_tree_entry_follow_symlinks, to tree-walk.[ch].
The function is not yet used.  It will be used to implement git
cat-file --batch --follow-symlinks.

The function locates an object by path, following symlinks in the
repository.  If the symlinks lead outside the repository, the function
reports this to the caller.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 tree-walk.c | 207 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tree-walk.h |  18 ++++++
 2 files changed, 225 insertions(+)

diff --git a/tree-walk.c b/tree-walk.c
index 5dd9a71..8031f3a 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -415,6 +415,12 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 	return error;
 }
 
+struct dir_state {
+	void *tree;
+	unsigned long size;
+	unsigned char sha1[20];
+};
+
 static int find_tree_entry(struct tree_desc *t, const char *name, unsigned char *result, unsigned *mode)
 {
 	int namelen = strlen(name);
@@ -478,6 +484,207 @@ int get_tree_entry(const unsigned char *tree_sha1, const char *name, unsigned ch
 	return retval;
 }
 
+/*
+ * This is Linux's built-in max for the number of symlinks to follow.
+ * That limit, of course, does not affect git, but it's a reasonable
+ * choice.
+ */
+#define GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS 40
+
+/**
+ * Find a tree entry by following symlinks in tree_sha (which is
+ * assumed to be the root of the repository).  In the event that a
+ * symlink points outside the repository (e.g. a link to /foo or a
+ * root-level link to ../foo), the portion of the link which is
+ * outside the repository will be returned in result_path, and *mode
+ * will be set to 0.  It is assumed that result_path is uninitialized.
+ * If there are no symlinks, or the end result of the symlink chain
+ * points to an object inside the repository, result will be filled in
+ * with the sha1 of the found object, and *mode will hold the mode of
+ * the object.
+ *
+ * See the code for enum follow_symlink_result for a description of
+ * the return values.
+ */
+enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_sha1, const char *name, unsigned char *result, struct strbuf *result_path, unsigned *mode)
+{
+	int retval = MISSING_OBJECT;
+	struct dir_state *parents = NULL;
+	size_t parents_alloc = 0;
+	ssize_t parents_nr = 0;
+	unsigned char current_tree_sha1[20];
+	struct strbuf namebuf = STRBUF_INIT;
+	struct tree_desc t = {0};
+	int follows_remaining = GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS;
+	int i;
+
+	result_path->buf = 0;
+	result_path->alloc = 0;
+	result_path->len = 0;
+	strbuf_addstr(&namebuf, name);
+	hashcpy(current_tree_sha1, tree_sha1);
+
+	while (1) {
+		int find_result;
+		char *first_slash;
+		char *remainder = NULL;
+
+		if (!t.buffer) {
+			void *tree;
+			unsigned char root[20];
+			unsigned long size;
+			tree = read_object_with_reference(current_tree_sha1,
+							  tree_type, &size,
+							  root);
+			if (!tree)
+				goto done;
+
+			ALLOC_GROW(parents, parents_nr + 1, parents_alloc);
+			parents[parents_nr].tree = tree;
+			parents[parents_nr].size = size;
+			hashcpy(parents[parents_nr].sha1, root);
+			parents_nr++;
+
+			if (namebuf.buf[0] == '\0') {
+				hashcpy(result, root);
+				retval = FOUND;
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
+		/* Split namebuf into a first component and a remainder */
+		if ((first_slash = strchr(namebuf.buf, '/'))) {
+			*first_slash = 0;
+			remainder = first_slash + 1;
+		}
+
+		if (!strcmp(namebuf.buf, "..")) {
+			struct dir_state *parent;
+			/*
+			 * We could end up with .. in the namebuf if it
+			 * appears in a symlink.
+			 */
+
+			if (parents_nr == 1) {
+				if (remainder)
+					*first_slash = '/';
+				strbuf_add(result_path, namebuf.buf,
+					   namebuf.len);
+				*mode = 0;
+				retval = FOUND;
+				goto done;
+			}
+			parent = &parents[parents_nr - 1];
+			free(parent->tree);
+			parents_nr--;
+			parent = &parents[parents_nr - 1];
+			init_tree_desc(&t, parent->tree, parent->size);
+			strbuf_remove(&namebuf, 0, remainder ? 3 : 2);
+			continue;
+		}
+
+		/* We could end up here via a symlink to dir/.. */
+		if (namebuf.buf[0] == '\0') {
+			hashcpy(result, parents[parents_nr - 1].sha1);
+			retval = FOUND;
+			goto done;
+		}
+
+		/* Look up the first (or only) path component in the tree. */
+		find_result = find_tree_entry(&t, namebuf.buf,
+					      current_tree_sha1, mode);
+		if (find_result) {
+			goto done;
+		}
+
+		if (S_ISDIR(*mode)) {
+			if (!remainder) {
+				hashcpy(result, current_tree_sha1);
+				retval = FOUND;
+				goto done;
+			}
+			/* Descend the tree */
+			t.buffer = NULL;
+			strbuf_remove(&namebuf, 0,
+				      1 + first_slash - namebuf.buf);
+		} else if (S_ISREG(*mode)) {
+			if (!remainder) {
+				hashcpy(result, current_tree_sha1);
+				retval = FOUND;
+			} else {
+				retval = NOT_DIR;
+			}
+			goto done;
+		} else if (S_ISLNK(*mode)) {
+			/* Follow a symlink */
+			unsigned long link_len;
+			size_t len;
+			char *contents, *contents_start;
+			struct dir_state *parent;
+			enum object_type type;
+
+			if (follows_remaining-- == 0) {
+				/* Too many symlinks followed */
+				retval = SYMLINK_LOOP;
+				goto done;
+			}
+
+			/*
+			 * At this point, we have followed at a least
+			 * one symlink, so on error we need to report this.
+			 */
+			retval = DANGLING_SYMLINK;
+
+			contents = read_sha1_file(current_tree_sha1, &type,
+						  &link_len);
+
+			if (!contents)
+				goto done;
+
+			if (contents[0] == '/') {
+				strbuf_addstr(result_path, contents);
+				free(contents);
+				*mode = 0;
+				retval = FOUND;
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
+			parent = &parents[parents_nr - 1];
+			init_tree_desc(&t, parent->tree, parent->size);
+			strbuf_splice(&namebuf, 0, len,
+				      contents_start, link_len);
+			if (remainder)
+				namebuf.buf[link_len] = '/';
+			free(contents);
+		}
+	}
+done:
+	for (i = 0; i < parents_nr; i++)
+		free(parents[i].tree);
+	free(parents);
+
+	strbuf_release(&namebuf);
+	return retval;
+}
+
 static int match_entry(const struct pathspec_item *item,
 		       const struct name_entry *entry, int pathlen,
 		       const char *match, int matchlen,
diff --git a/tree-walk.h b/tree-walk.h
index ae7fb3a..3b2f7bf 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -40,6 +40,24 @@ struct traverse_info;
 typedef int (*traverse_callback_t)(int n, unsigned long mask, unsigned long dirmask, struct name_entry *entry, struct traverse_info *);
 int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info);
 
+enum follow_symlinks_result {
+	FOUND = 0, /* This includes out-of-tree links */
+	MISSING_OBJECT = -1, /* The initial symlink is missing */
+	DANGLING_SYMLINK = -2, /*
+				* The initial symlink is there, but
+				* (transitively) points to a missing
+				* in-tree file
+				*/
+	SYMLINK_LOOP = -3,
+	NOT_DIR = -4, /*
+		       * Somewhere along the symlink chain, a path is
+		       * requested which contains a file as a
+		       * non-final element.
+		       */
+};
+
+enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_sha1, const char *name, unsigned char *result, struct strbuf *result_path, unsigned *mode);
+
 struct traverse_info {
 	struct traverse_info *prev;
 	struct name_entry name;
-- 
2.0.4.315.gad8727a-twtrsrc
