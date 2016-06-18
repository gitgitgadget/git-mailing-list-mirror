Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C7F91FEAA
	for <e@80x24.org>; Sat, 18 Jun 2016 04:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbcFREPy (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 00:15:54 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:51408 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750977AbcFREPw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2016 00:15:52 -0400
X-AuditID: 1207440c-c3fff70000000b85-a4-5764caf7a358
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 74.69.02949.7FAC4675; Sat, 18 Jun 2016 00:15:51 -0400 (EDT)
Received: from michael.fritz.box (p4FEEA991.dip0.t-ipconnect.de [79.238.169.145])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5I4FLJo029401
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jun 2016 00:15:49 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
Cc:	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 13/13] for_each_reflog(): reimplement using iterators
Date:	Sat, 18 Jun 2016 06:15:19 +0200
Message-Id: <46d092aaeffe2be0f87b4cfae359ee540e342fd3.1466222921.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1466222921.git.mhagger@alum.mit.edu>
References: <cover.1466222921.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsUixO6iqPv9VEq4wbb98hbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2uLMm0ZGBw6Pv+8/MHnsnHWX3eNZ7x5Gj4uXlD32
	L93G5rH4gZfHguf32T0+b5IL4IjitklKLCkLzkzP07dL4M6YMu8Ae8FxzYpvB3uYGxiblboY
	OTkkBEwk/q98zdzFyMUhJLCVUWJh13kmCOckk8ST/vusIFVsAroSi3qamUBsEYEIiYZXLYwg
	RcwCc5gkbj/sBGrn4BAW8JA4fMELpIZFQFWi8e5SFhCbVyBK4tXMLmaIbXISl6c/YAOxOQUs
	JBZs2ccE0iokYC6xd7HhBEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0DfVyM0v0UlNK
	NzFCQo5nB+O3dTKHGAU4GJV4eAPsU8KFWBPLiitzDzFKcjApifJeqQQK8SXlp1RmJBZnxBeV
	5qQWH2KU4GBWEuHdcgIox5uSWFmVWpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoEk5Xh4FCS
	4F16EqhRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQB8cXAGABJ8QDtfQLSzltc
	kJgLFIVoPcWoKCXO+wwkIQCSyCjNgxsLSySvGMWBvhTmXQdSxQNMQnDdr4AGMwEN1pyXDDK4
	JBEhJdXAaCGfwn+ZxVS7Kj3ij/SeqobU1jg59//fP0iuFXvRYnp4/tNwuWk/8z7c6u27uubW
	UR79CReL3c4pBc9b+WCuz1rbUBWuXRM3Hjfes/jciQ/9xvsWbl/dcti76dSeJrHHWS2GjS+/
	JX+/0PTp1o21b+LTnhs/0FeyvzWdefL0na6uclxfqyVbIpVYijMSDbWYi4oTAT/8zU7/AgAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Allow references with reflogs to be iterated over using a ref_iterator.
The latter is implemented as a files_reflog_iterator, which in turn uses
dir_iterator to read the "logs" directory.

Note that reflog iteration doesn't correctly handle per-worktree
reflogs (either before or after this patch).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 113 ++++++++++++++++++++++++++++++++-------------------
 refs/refs-internal.h |   7 ++++
 2 files changed, 78 insertions(+), 42 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index ab40db3..a9ca003 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2,6 +2,7 @@
 #include "../refs.h"
 #include "refs-internal.h"
 #include "../iterator.h"
+#include "../dir-iterator.h"
 #include "../lockfile.h"
 #include "../object.h"
 #include "../dir.h"
@@ -3291,60 +3292,88 @@ int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_dat
 	strbuf_release(&sb);
 	return ret;
 }
-/*
- * Call fn for each reflog in the namespace indicated by name.  name
- * must be empty or end with '/'.  Name will be used as a scratch
- * space, but its contents will be restored before return.
- */
-static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data)
+
+struct files_reflog_iterator {
+	struct ref_iterator base;
+
+	struct dir_iterator *dir_iterator;
+	struct object_id oid;
+};
+
+static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 {
-	DIR *d = opendir(git_path("logs/%s", name->buf));
-	int retval = 0;
-	struct dirent *de;
-	int oldlen = name->len;
+	struct files_reflog_iterator *iter =
+		(struct files_reflog_iterator *)ref_iterator;
+	struct dir_iterator *diter = iter->dir_iterator;
+	int ok;
 
-	if (!d)
-		return name->len ? errno : 0;
+	while ((ok = dir_iterator_advance(diter)) == ITER_OK) {
+		int flags;
 
-	while ((de = readdir(d)) != NULL) {
-		struct stat st;
-
-		if (de->d_name[0] == '.')
+		if (!S_ISREG(diter->st.st_mode))
+			continue;
+		if (diter->basename[0] == '.')
 			continue;
-		if (ends_with(de->d_name, ".lock"))
+		if (ends_with(diter->basename, ".lock"))
 			continue;
-		strbuf_addstr(name, de->d_name);
-		if (stat(git_path("logs/%s", name->buf), &st) < 0) {
-			; /* silently ignore */
-		} else {
-			if (S_ISDIR(st.st_mode)) {
-				strbuf_addch(name, '/');
-				retval = do_for_each_reflog(name, fn, cb_data);
-			} else {
-				struct object_id oid;
 
-				if (read_ref_full(name->buf, 0, oid.hash, NULL))
-					error("bad ref for %s", name->buf);
-				else
-					retval = fn(name->buf, &oid, 0, cb_data);
-			}
-			if (retval)
-				break;
+		if (read_ref_full(diter->relative_path, 0,
+				  iter->oid.hash, &flags)) {
+			error("bad ref for %s", diter->path.buf);
+			continue;
 		}
-		strbuf_setlen(name, oldlen);
+
+		iter->base.refname = diter->relative_path;
+		iter->base.oid = &iter->oid;
+		iter->base.flags = flags;
+		return ITER_OK;
 	}
-	closedir(d);
-	return retval;
+
+	iter->dir_iterator = NULL;
+	if (ref_iterator_abort(ref_iterator) == ITER_ERROR)
+		ok = ITER_ERROR;
+	return ok;
+}
+
+static int files_reflog_iterator_peel(struct ref_iterator *ref_iterator,
+				   struct object_id *peeled)
+{
+	die("BUG: ref_iterator_peel() called for reflog_iterator");
+}
+
+static int files_reflog_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct files_reflog_iterator *iter =
+		(struct files_reflog_iterator *)ref_iterator;
+	int ok = ITER_DONE;
+
+	if (iter->dir_iterator)
+		ok = dir_iterator_abort(iter->dir_iterator);
+
+	base_ref_iterator_free(ref_iterator);
+	return ok;
+}
+
+static struct ref_iterator_vtable files_reflog_iterator_vtable = {
+	files_reflog_iterator_advance,
+	files_reflog_iterator_peel,
+	files_reflog_iterator_abort
+};
+
+struct ref_iterator *files_reflog_iterator_begin(void)
+{
+	struct files_reflog_iterator *iter = xcalloc(1, sizeof(*iter));
+	struct ref_iterator *ref_iterator = &iter->base;
+
+	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
+	iter->dir_iterator = dir_iterator_begin(git_path("logs"));
+	return ref_iterator;
 }
 
 int for_each_reflog(each_ref_fn fn, void *cb_data)
 {
-	int retval;
-	struct strbuf name;
-	strbuf_init(&name, PATH_MAX);
-	retval = do_for_each_reflog(&name, fn, cb_data);
-	strbuf_release(&name);
-	return retval;
+	return do_for_each_ref_iterator(files_reflog_iterator_begin(),
+					fn, cb_data);
 }
 
 static int ref_update_reject_duplicates(struct string_list *refnames,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f73e022..efe5847 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -404,6 +404,13 @@ struct ref_iterator *files_ref_iterator_begin(const char *submodule,
 					      const char *prefix,
 					      unsigned int flags);
 
+/*
+ * Iterate over the references in the main ref_store that have a
+ * reflog. The paths within a directory are iterated over in arbitrary
+ * order.
+ */
+struct ref_iterator *files_reflog_iterator_begin(void);
+
 /* Internal implementation of reference iteration: */
 
 /*
-- 
2.8.1

