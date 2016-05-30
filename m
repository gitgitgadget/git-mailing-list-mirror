From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/13] for_each_reflog(): reimplement using iterators
Date: Mon, 30 May 2016 09:55:34 +0200
Message-ID: <0e0bc1c4c503ebd0ba6978e63bbb6ac54efa8fdf.1464537050.git.mhagger@alum.mit.edu>
References: <cover.1464537050.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 30 09:56:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7I3o-0001Ni-8l
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 09:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbcE3H4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 03:56:24 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:46551 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932141AbcE3H4J (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 03:56:09 -0400
X-AuditID: 12074412-51bff700000009f7-1a-574bf2174d2f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 61.D0.02551.712FB475; Mon, 30 May 2016 03:56:07 -0400 (EDT)
Received: from michael.fritz.box (p508EADDB.dip0.t-ipconnect.de [80.142.173.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u4U7tgS4032144
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 30 May 2016 03:56:06 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464537050.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsUixO6iqCv+yTvcYN4bPYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHs969zB6XLyk7LHg+X12j8+b5ALY
	orhtkhJLyoIz0/P07RK4M+7MucJa0KpZcW75NZYGxuOKXYycHBICJhKbL29k6WLk4hAS2Moo
	ce/qWSYI5ySTxLHb35lAqtgEdCUW9TSD2SICERINr1oYQYqYBfYxSpxcN58FJCEs4Cqx7ccD
	1i5GDg4WAVWJy/fEQMK8AlES/a8uMEJsk5O4PP0BG4jNKWAhMXHWO7CZQgLmEstmnmSewMiz
	gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGumV5uZoleakrpJkZIQAntYFx/Uu4QowAHoxIP
	b4Gmd7gQa2JZcWXuIUZJDiYlUV43DqAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd63j4FyvCmJ
	lVWpRfkwKWkOFiVx3p+L1f2EBNITS1KzU1MLUotgsjIcHEoSvMIfgRoFi1LTUyvSMnNKENJM
	HJwgw7mkRIpT81JSixJLSzLiQTEQXwyMApAUD9De/R9A9hYXJOYCRSFaTzHqchzZf28tkxBL
	Xn5eqpQ4rz1IkQBIUUZpHtwKWPp4xSgO9LEw7wmQKh5g6oGb9ApoCRPQErNzXiBLShIRUlIN
	jP5yQo+uJ0UdFC6+fzBK27vx2Q/RNPsTS4xNulNPSLSsv5/2rcxCVHXqVnGFe0kc1v0Pb7H5
	JecXLtigO3Pl+SNveL5Okl0uP8Hg3KRNrU82fXY8xBjazHT9hdA1no7Tv//vji6o 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295866>

Allow references with reflogs to be iterated over using a ref_iterator.
The latter is implemented as a files_reflog_iterator, which in turn uses
dir_iterator to read the "logs" directory.

Note that reflog iteration doesn't correctly handle per-worktree
reflogs (either before or after this patch).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 113 ++++++++++++++++++++++++++++++++-------------------
 refs/refs-internal.h |   7 ++++
 2 files changed, 78 insertions(+), 42 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a7cc0e2..2e0d006 100644
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
@@ -3292,60 +3293,88 @@ int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_dat
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
+struct ref_iterator_vtable files_reflog_iterator_vtable = {
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
index f16a38e..87ad8b1 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -403,6 +403,13 @@ struct ref_iterator *files_ref_iterator_begin(const char *submodule,
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
