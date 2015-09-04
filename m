From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v7 1/3] worktree: add top-level worktree.c
Date: Fri,  4 Sep 2015 17:39:27 -0400
Message-ID: <1441402769-35897-2-git-send-email-rappazzo@gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Fri Sep 04 23:39:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXyi5-0000FJ-Iu
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 23:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933916AbbIDVjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 17:39:44 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34757 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933877AbbIDVjm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 17:39:42 -0400
Received: by igcpb10 with SMTP id pb10so25961652igc.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 14:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8+p+Tf52HY8U5muC8doQGfvrWIZKpLkcd8TU+YefdRs=;
        b=Ide0nxEStssKWOeFPOX8Klx4Gr5g3/WKcbHElFobmFfrpBL3pk28NxrI5Bo7WwR1AI
         r4ZixHbObsAqu7z4BTmayPBNC4vUFv5Uhj4HUUa2Ex3wHkQZDzwOsn8ZFWgaVVjCIRzy
         E7lYl/uAllDQxvNxb8D6U6wZ6eTDVJmBc2L0CTV9EQ/dZLhmWO8kNWpCijXXHUQYYff6
         hsscPXMTU0LguJeUR/W0BYFXCKe9UNfXcryzxz9WEzL9nn37SMbmFAJ7VIeTBzFKup2k
         sFIzAnZt3yLfEE4iLAMHLU5PyAApILfH0fWpVJmUo+scXX0VM/kq/1XjMxJNQxUsHEqG
         Jvww==
X-Received: by 10.50.1.82 with SMTP id 18mr11352303igk.65.1441402781922;
        Fri, 04 Sep 2015 14:39:41 -0700 (PDT)
Received: from localhost.localdomain (155.sub-70-208-71.myvzw.com. [70.208.71.155])
        by smtp.gmail.com with ESMTPSA id vk8sm2325936igb.4.2015.09.04.14.39.40
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Sep 2015 14:39:41 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277336>

Including functions to get the list of all worktrees, and to get
a specific worktree (primary or linked).

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 Makefile   |   1 +
 worktree.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 worktree.h |  48 +++++++++++++++++++
 3 files changed, 206 insertions(+)
 create mode 100644 worktree.c
 create mode 100644 worktree.h

diff --git a/Makefile b/Makefile
index e326fa0..0131fed 100644
--- a/Makefile
+++ b/Makefile
@@ -807,6 +807,7 @@ LIB_OBJS += version.o
 LIB_OBJS += versioncmp.o
 LIB_OBJS += walker.o
 LIB_OBJS += wildmatch.o
+LIB_OBJS += worktree.o
 LIB_OBJS += wrapper.o
 LIB_OBJS += write_or_die.o
 LIB_OBJS += ws.o
diff --git a/worktree.c b/worktree.c
new file mode 100644
index 0000000..33d2e57
--- /dev/null
+++ b/worktree.c
@@ -0,0 +1,157 @@
+#include "worktree.h"
+#include "cache.h"
+#include "git-compat-util.h"
+#include "refs.h"
+#include "strbuf.h"
+
+void worktree_release(struct worktree *worktree)
+{
+	if (worktree) {
+		free(worktree->path);
+		free(worktree->git_dir);
+		if (!worktree->is_detached) {
+			/* could be headless */
+			free(worktree->head_ref);
+		}
+		free(worktree);
+	}
+}
+
+void worktree_list_release(struct worktree_list *worktree_list)
+{
+	while (worktree_list) {
+		struct worktree_list *next = worktree_list->next;
+		worktree_release(worktree_list->worktree);
+		free (worktree_list);
+		worktree_list = next;
+	}
+}
+
+/*
+ * read 'path_to_ref' into 'ref'.  Also set is_detached to 1 if the ref is detatched
+ *
+ * return 1 if the ref is not a proper ref, 0 otherwise (success)
+ */
+int _parse_ref(char *path_to_ref, struct strbuf *ref, int *is_detached)
+{
+	if (!strbuf_readlink(ref, path_to_ref, 0)) {
+		if (!starts_with(ref->buf, "refs/") || check_refname_format(ref->buf, 0)) {
+			/* invalid ref - something is awry with this repo */
+			return 1;
+		}
+	} else if (strbuf_read_file(ref, path_to_ref, 0) >= 0) {
+		if (starts_with(ref->buf, "ref:")) {
+			strbuf_remove(ref, 0, strlen("ref:"));
+			strbuf_trim(ref);
+		} else if (is_detached) {
+			*is_detached = 1;
+		}
+	}
+	return 0;
+}
+
+struct worktree *get_worktree(const char *id)
+{
+	struct worktree *worktree = NULL;
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf worktree_path = STRBUF_INIT;
+	struct strbuf git_dir = STRBUF_INIT;
+	struct strbuf head_ref = STRBUF_INIT;
+	int is_bare = 0;
+	int is_detached = 0;
+
+	if (id) {
+		strbuf_addf(&git_dir, "%s/worktrees/%s", absolute_path(get_git_common_dir()), id);
+		strbuf_addf(&path, "%s/gitdir", git_dir.buf);
+		if (strbuf_read_file(&worktree_path, path.buf, 0) <= 0) {
+			/* invalid git_dir file */
+			goto done;
+		}
+		strbuf_rtrim(&worktree_path);
+		if (!strbuf_strip_suffix(&worktree_path, "/.git")) {
+			strbuf_reset(&worktree_path);
+			strbuf_addstr(&worktree_path, absolute_path("."));
+			strbuf_strip_suffix(&worktree_path, "/.");
+		}
+
+		strbuf_reset(&path);
+		strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
+	} else {
+		strbuf_addf(&git_dir, "%s", absolute_path(get_git_common_dir()));
+		strbuf_addf(&worktree_path, "%s", absolute_path(get_git_common_dir()));
+		is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
+		if (is_bare)
+			strbuf_strip_suffix(&worktree_path, "/.");
+
+		strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
+	}
+
+	/*
+	 * $GIT_COMMON_DIR/$symref (e.g. HEAD) is practically outside $GIT_DIR so for linked worktrees,
+	 * `resolve_ref_unsafe()` won't work (it uses git_path). Parse the ref ourselves.
+	 */
+	if (_parse_ref(path.buf, &head_ref, &is_detached))
+		goto done;
+
+	worktree = malloc(sizeof(struct worktree));
+	worktree->path = strbuf_detach(&worktree_path, NULL);
+	worktree->git_dir = strbuf_detach(&git_dir, NULL);
+	worktree->is_bare = is_bare;
+	worktree->head_ref = NULL;
+	worktree->is_detached = is_detached;
+	if (strlen(head_ref.buf) > 0) {
+		if (!is_detached) {
+			resolve_ref_unsafe(head_ref.buf, 0, worktree->head_sha1, NULL);
+			worktree->head_ref = strbuf_detach(&head_ref, NULL);
+		} else {
+			get_sha1_hex(head_ref.buf, worktree->head_sha1);
+		}
+	}
+done:
+	strbuf_release(&path);
+	strbuf_release(&git_dir);
+	strbuf_release(&head_ref);
+	strbuf_release(&worktree_path);
+	return worktree;
+}
+
+struct worktree_list *get_worktree_list()
+{
+	struct worktree_list *list = NULL;
+	struct worktree_list *current_entry = NULL;
+	struct worktree *current_worktree = NULL;
+	struct strbuf path = STRBUF_INIT;
+	DIR *dir;
+	struct dirent *d;
+
+	current_worktree = get_worktree(NULL);
+	if (current_worktree) {
+		list = malloc(sizeof(struct worktree_list));
+		list->worktree = current_worktree;
+		list->next = NULL;
+		current_entry = list;
+	}
+	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
+	dir = opendir(path.buf);
+	strbuf_release(&path);
+	if (dir) {
+		while ((d = readdir(dir)) != NULL) {
+			if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+				continue;
+
+			current_worktree = get_worktree(d->d_name);
+			if (current_worktree) {
+				current_entry->next = malloc(sizeof(struct worktree_list));
+				current_entry = current_entry->next;
+				current_entry->worktree = current_worktree;
+				current_entry->next = NULL;
+			}
+		}
+		closedir(dir);
+	}
+
+done:
+
+	return list;
+}
+
diff --git a/worktree.h b/worktree.h
new file mode 100644
index 0000000..2bc0ab8
--- /dev/null
+++ b/worktree.h
@@ -0,0 +1,48 @@
+#ifndef WORKTREE_H
+#define WORKTREE_H
+
+struct worktree {
+	char *path;
+	char *git_dir;
+	char *head_ref;
+	unsigned char head_sha1[20];
+	int is_detached;
+	int is_bare;
+};
+
+struct worktree_list {
+	struct worktree *worktree;
+	struct worktree_list *next;
+};
+
+/* Functions for acting on the information about worktrees. */
+
+/*
+ * Get the list of all worktrees.  The primary worktree will always be
+ * the first in the list followed by any other (linked) worktrees created
+ * by `git worktree add`.  No specific ordering is done on the linked
+ * worktrees.
+ *
+ * The caller is responsible for freeing the memory from the returned list.
+ * (See worktree_list_release for this purpose).
+ */
+extern struct worktree_list *get_worktree_list();
+
+/*
+ * generic method to get a worktree
+ *   - if 'id' is NULL, get the from $GIT_COMMON_DIR
+ *   - if 'id' is not NULL, get the worktree found in $GIT_COMMON_DIR/worktrees/id if
+ *     such a worktree exists
+ *
+ * The caller is responsible for freeing the memory from the returned
+ * worktree.  (See worktree_release for this purpose)
+ */
+struct worktree *get_worktree(const char *id);
+
+/*
+ * Free up the memory for a worktree_list/worktree
+ */
+extern void worktree_list_release(struct worktree_list *);
+extern void worktree_release(struct worktree *);
+
+#endif
-- 
2.5.0
