From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/9] resolve-undo: record resolved conflicts in a new index
 extension section
Date: Tue, 29 Dec 2009 13:42:31 -0800
Message-ID: <1262122958-9378-3-git-send-email-gitster@pobox.com>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 22:44:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPjqS-0003SS-TX
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 22:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbZL2Vmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 16:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbZL2Vms
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 16:42:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbZL2Vmp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 16:42:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE6AB8C7EA
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=akmh
	kCKVIXX1K3ZHiyw+VEBPr4o=; b=NXCZ7H+Annmg0vEoJzby4MYCs9MFloVc1dRr
	fE7ybYkrpxta1ZlgiPAz633q3ucIk+nngBh6giD9kikjWTVrMRbLpnVq3LNao9GV
	zmgmEr4smLIhw/unvD9bKERrqgRacdZDUhIx/QNA2G51P1FzLRkCY7uy7bY7AOoy
	lOxj0jI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=jwqksk
	VzMJvfh1FvXJgNW808hBFAZ4qGMioCzBnq8VFIKi1JsC0ECOg8c9NuArMiUtToxI
	t4twpYLAuBSrJxxld6QWM0yEYXaY6JsyPKRqU2qM92WxiIQ7qXlpJnAP/TS36XY7
	6NCF7JdY1xumf61gQIk7QrvaOtXr/hLh5yVUw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AAFC78C7E9
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCC698C7E7 for
 <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:43 -0500 (EST)
X-Mailer: git-send-email 1.6.6.60.gc2ff1
In-Reply-To: <1262122958-9378-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1935646E-F4C3-11DE-A51C-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135829>

When resolving a conflict using "git add" to create a stage #0 entry, or
"git rm" to remove entries at higher stages, remove_index_entry_at()
function is eventually called to remove unmerged (i.e. higher stage)
entries from the index.  Introduce a "resolve_undo_info" structure and
keep track of the removed cache entries, and save it in a new index
extension section in the index_state.

Operations like "read-tree -m", "merge", "checkout [-m] <branch>" and
"reset" are signs that recorded information in the index is no longer
necessary.  The data is removed from the index extension when operations
start; they may leave conflicted entries in the index, and later user
actions like "git add" will record their conflicted states afresh.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile            |    2 +
 builtin-checkout.c  |    2 +
 builtin-merge.c     |    4 +-
 builtin-read-tree.c |    2 +
 cache.h             |    2 +
 read-cache.c        |   18 ++++++++
 resolve-undo.c      |  117 +++++++++++++++++++++++++++++++++++++++++++++++++++
 resolve-undo.h      |   14 ++++++
 8 files changed, 160 insertions(+), 1 deletions(-)
 create mode 100644 resolve-undo.c
 create mode 100644 resolve-undo.h

diff --git a/Makefile b/Makefile
index 4a1e5bc..762898a 100644
--- a/Makefile
+++ b/Makefile
@@ -483,6 +483,7 @@ LIB_H += reflog-walk.h
 LIB_H += refs.h
 LIB_H += remote.h
 LIB_H += rerere.h
+LIB_H += resolve-undo.h
 LIB_H += revision.h
 LIB_H += run-command.h
 LIB_H += sha1-lookup.h
@@ -578,6 +579,7 @@ LIB_OBJS += refs.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
 LIB_OBJS += rerere.o
+LIB_OBJS += resolve-undo.o
 LIB_OBJS += revision.o
 LIB_OBJS += run-command.o
 LIB_OBJS += server-info.o
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 64f3a11..a0fe7a4 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -17,6 +17,7 @@
 #include "blob.h"
 #include "xdiff-interface.h"
 #include "ll-merge.h"
+#include "resolve-undo.h"
 
 static const char * const checkout_usage[] = {
 	"git checkout [options] <branch>",
@@ -370,6 +371,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 	if (read_cache_preload(NULL) < 0)
 		return error("corrupt index file");
 
+	resolve_undo_clear();
 	if (opts->force) {
 		ret = reset_tree(new->commit->tree, opts, 1);
 		if (ret)
diff --git a/builtin-merge.c b/builtin-merge.c
index 6cb804b..6bc2f7a 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -24,6 +24,7 @@
 #include "rerere.h"
 #include "help.h"
 #include "merge-recursive.h"
+#include "resolve-undo.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -604,6 +605,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		discard_cache();
 		if (read_cache() < 0)
 			die("failed to read the cache");
+		resolve_undo_clear();
 		return ret;
 	}
 }
@@ -851,7 +853,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (read_cache_unmerged())
 		die("You are in the middle of a conflicted merge."
 				" (index unmerged)");
-
+	resolve_undo_clear();
 	/*
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
 	 * current branch.
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 2a3a32c..7d378b7 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -13,6 +13,7 @@
 #include "dir.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "resolve-undo.h"
 
 static int nr_trees;
 static struct tree *trees[MAX_UNPACK_TREES];
@@ -122,6 +123,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			die("You need to resolve your current index first");
 		stage = opts.merge = 1;
 	}
+	resolve_undo_clear();
 
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/cache.h b/cache.h
index bf468e5..310d9e6 100644
--- a/cache.h
+++ b/cache.h
@@ -282,6 +282,7 @@ static inline int ce_to_dtype(const struct cache_entry *ce)
 struct index_state {
 	struct cache_entry **cache;
 	unsigned int cache_nr, cache_alloc, cache_changed;
+	struct string_list *resolve_undo;
 	struct cache_tree *cache_tree;
 	struct cache_time timestamp;
 	void *alloc;
@@ -336,6 +337,7 @@ static inline void remove_name_hash(struct cache_entry *ce)
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
 #define cache_name_exists(name, namelen, igncase) index_name_exists(&the_index, (name), (namelen), (igncase))
 #define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))
+#define resolve_undo_clear() resolve_undo_clear_index(&the_index)
 #endif
 
 enum object_type {
diff --git a/read-cache.c b/read-cache.c
index 1bbaf1c..9e0fb04 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -14,6 +14,7 @@
 #include "diffcore.h"
 #include "revision.h"
 #include "blob.h"
+#include "resolve-undo.h"
 
 /* Index extensions.
  *
@@ -26,6 +27,7 @@
 
 #define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) )
 #define CACHE_EXT_TREE 0x54524545	/* "TREE" */
+#define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUN" */
 
 struct index_state the_index;
 
@@ -449,6 +451,7 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 {
 	struct cache_entry *ce = istate->cache[pos];
 
+	record_resolve_undo(istate, ce);
 	remove_name_hash(ce);
 	istate->cache_changed = 1;
 	istate->cache_nr--;
@@ -1170,6 +1173,9 @@ static int read_index_extension(struct index_state *istate,
 	case CACHE_EXT_TREE:
 		istate->cache_tree = cache_tree_read(data, sz);
 		break;
+	case CACHE_EXT_RESOLVE_UNDO:
+		istate->resolve_undo = resolve_undo_read(data, sz);
+		break;
 	default:
 		if (*ext < 'A' || 'Z' < *ext)
 			return error("index uses %.4s extension, which we do not understand",
@@ -1349,6 +1355,7 @@ int is_index_unborn(struct index_state *istate)
 
 int discard_index(struct index_state *istate)
 {
+	resolve_undo_clear_index(istate);
 	istate->cache_nr = 0;
 	istate->cache_changed = 0;
 	istate->timestamp.sec = 0;
@@ -1574,6 +1581,17 @@ int write_index(struct index_state *istate, int newfd)
 		if (err)
 			return -1;
 	}
+	if (istate->resolve_undo) {
+		struct strbuf sb = STRBUF_INIT;
+
+		resolve_undo_write(&sb, istate->resolve_undo);
+		err = write_index_ext_header(&c, newfd, CACHE_EXT_RESOLVE_UNDO,
+					     sb.len) < 0
+			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
+		strbuf_release(&sb);
+		if (err)
+			return -1;
+	}
 
 	if (ce_flush(&c, newfd) || fstat(newfd, &st))
 		return -1;
diff --git a/resolve-undo.c b/resolve-undo.c
new file mode 100644
index 0000000..86e8547
--- /dev/null
+++ b/resolve-undo.c
@@ -0,0 +1,117 @@
+#include "cache.h"
+#include "resolve-undo.h"
+#include "string-list.h"
+
+/* The only error case is to run out of memory in string-list */
+void record_resolve_undo(struct index_state *istate, struct cache_entry *ce)
+{
+	struct string_list_item *lost;
+	struct resolve_undo_info *ui;
+	struct string_list *resolve_undo;
+	int stage = ce_stage(ce);
+
+	if (!stage)
+		return;
+
+	if (!istate->resolve_undo) {
+		resolve_undo = xcalloc(1, sizeof(*resolve_undo));
+		resolve_undo->strdup_strings = 1;
+		istate->resolve_undo = resolve_undo;
+	}
+	resolve_undo = istate->resolve_undo;
+	lost = string_list_insert(ce->name, resolve_undo);
+	if (!lost->util)
+		lost->util = xcalloc(1, sizeof(*ui));
+	ui = lost->util;
+	hashcpy(ui->sha1[stage - 1], ce->sha1);
+	ui->mode[stage - 1] = ce->ce_mode;
+}
+
+static int write_one(struct string_list_item *item, void *cbdata)
+{
+	struct strbuf *sb = cbdata;
+	struct resolve_undo_info *ui = item->util;
+	int i;
+
+	if (!ui)
+		return 0;
+	strbuf_addstr(sb, item->string);
+	strbuf_addch(sb, 0);
+	for (i = 0; i < 3; i++)
+		strbuf_addf(sb, "%o%c", ui->mode[i], 0);
+	for (i = 0; i < 3; i++) {
+		if (!ui->mode[i])
+			continue;
+		strbuf_add(sb, ui->sha1[i], 20);
+	}
+	return 0;
+}
+
+void resolve_undo_write(struct strbuf *sb, struct string_list *resolve_undo)
+{
+	for_each_string_list(write_one, resolve_undo, sb);
+}
+
+struct string_list *resolve_undo_read(void *data, unsigned long size)
+{
+	struct string_list *resolve_undo;
+	size_t len;
+	char *endptr;
+	int i;
+
+	resolve_undo = xcalloc(1, sizeof(*resolve_undo));
+	resolve_undo->strdup_strings = 1;
+
+	while (size) {
+		struct string_list_item *lost;
+		struct resolve_undo_info *ui;
+
+		len = strlen(data) + 1;
+		if (size <= len)
+			goto error;
+		lost = string_list_insert(data, resolve_undo);
+		if (!lost->util)
+			lost->util = xcalloc(1, sizeof(*ui));
+		ui = lost->util;
+		size -= len;
+		data += len;
+
+		for (i = 0; i < 3; i++) {
+			ui->mode[i] = strtoul(data, &endptr, 8);
+			if (!endptr || endptr == data || *endptr)
+				goto error;
+			len = (endptr + 1) - (char*)data;
+			if (size <= len)
+				goto error;
+			size -= len;
+			data += len;
+		}
+
+		for (i = 0; i < 3; i++) {
+			if (!ui->mode[i])
+				continue;
+			if (size < 20)
+				goto error;
+			hashcpy(ui->sha1[i], data);
+			size -= 20;
+			data += 20;
+		}
+	}
+	return resolve_undo;
+
+error:
+	string_list_clear(resolve_undo, 1);
+	error("Index records invalid resolve-undo information");
+	return NULL;
+}
+
+void resolve_undo_clear_index(struct index_state *istate)
+{
+	struct string_list *resolve_undo = istate->resolve_undo;
+	if (!resolve_undo)
+		return;
+	string_list_clear(resolve_undo, 1);
+	free(resolve_undo);
+	istate->resolve_undo = NULL;
+	istate->cache_changed = 1;
+}
diff --git a/resolve-undo.h b/resolve-undo.h
new file mode 100644
index 0000000..74194d0
--- /dev/null
+++ b/resolve-undo.h
@@ -0,0 +1,14 @@
+#ifndef RESOLVE_UNDO_H
+#define RESOLVE_UNDO_H
+
+struct resolve_undo_info {
+	unsigned int mode[3];
+	unsigned char sha1[3][20];
+};
+
+extern void record_resolve_undo(struct index_state *, struct cache_entry *);
+extern void resolve_undo_write(struct strbuf *, struct string_list *);
+extern struct string_list *resolve_undo_read(void *, unsigned long);
+extern void resolve_undo_clear_index(struct index_state *);
+
+#endif
-- 
1.6.6
