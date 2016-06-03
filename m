From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/13] dir_iterator: new API for iterating over a directory tree
Date: Fri,  3 Jun 2016 14:33:52 +0200
Message-ID: <38124bd892ac1f4683b7debe721fc69424a347be.1464957077.git.mhagger@alum.mit.edu>
References: <cover.1464957077.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 14:35:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8oJb-0005nU-On
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 14:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbcFCMei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 08:34:38 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:57650 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932530AbcFCMeY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 08:34:24 -0400
X-AuditID: 1207440c-c3fff70000000b85-41-5751794fa1e0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id F8.57.02949.F4971575; Fri,  3 Jun 2016 08:34:23 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53CXtiw005761
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 08:34:21 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464957077.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqOtfGRhuMGmXmMX8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/9
	S7exeSx+4OWx4Pl9do/Pm+QCOKK4bZISS8qCM9Pz9O0SuDP2z7rOWDDNveLN1RUsDYw/zboY
	OTkkBEwkXm36xNTFyMUhJLCVUeLF323MEM5xJolzK/4ygVSxCehKLOppBrNFBCIkGl61MIIU
	MQvMYZK4/bCTGSQhLBAs0TnrNlgRi4CqxNTOg2wgNq9AlMTxNZ1MEOvkJC5PfwAW5xSwkOi7
	94MdxBYSMJd4OGc3+wRGngWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdA31cjNL9FJTSjcx
	QsKOZwfjt3UyhxgFOBiVeHhXLAgIF2JNLCuuzD3EKMnBpCTKe/4sUIgvKT+lMiOxOCO+qDQn
	tfgQowQHs5II75+CwHAh3pTEyqrUonyYlDQHi5I4r+oSdT8hgfTEktTs1NSC1CKYrAwHh5IE
	749yoEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UBTEFwPjACTFA7T3M0g7b3FB
	Yi5QFKL1FKOilDgvA0hCACSRUZoHNxaWTF4xigN9KczrUwFUxQNMRHDdr4AGMwENLnjkDzK4
	JBEhJdXAqPXn9TWHuO8PdM+m3t/qsN1kwt/zK2SYf/vWSS6evmTFPumrh89cDlhzRvtY1sOG
	56+VZJMfREgIB2+ZmV71Rne7dLlimuORax+7vsW7GDNp7+PdtieZ94PypYUyZ7b9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296328>

The iterator interface is modeled on that for references, though no
vtable is necessary because there is (so far?) only one type of
dir_iterator.

There are obviously a lot of features that could easily be added to this
class:

* Skip/include directory paths in the iteration
* Shallow/deep iteration
* Letting the caller decide which subdirectories to recurse into (e.g.,
  via a dir_iterator_advance_into() function)
* Option to iterate in sorted order
* Option to iterate over directory paths before vs. after their contents

But these are not needed for the current patch series, so I refrain.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Makefile       |   1 +
 dir-iterator.c | 185 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 dir-iterator.h |  86 +++++++++++++++++++++++++++
 3 files changed, 272 insertions(+)
 create mode 100644 dir-iterator.c
 create mode 100644 dir-iterator.h

diff --git a/Makefile b/Makefile
index ac8f365..b4ffc11 100644
--- a/Makefile
+++ b/Makefile
@@ -722,6 +722,7 @@ LIB_OBJS += diff-lib.o
 LIB_OBJS += diff-no-index.o
 LIB_OBJS += diff.o
 LIB_OBJS += dir.o
+LIB_OBJS += dir-iterator.o
 LIB_OBJS += editor.o
 LIB_OBJS += entry.o
 LIB_OBJS += environment.o
diff --git a/dir-iterator.c b/dir-iterator.c
new file mode 100644
index 0000000..d53b235
--- /dev/null
+++ b/dir-iterator.c
@@ -0,0 +1,185 @@
+#include "cache.h"
+#include "dir.h"
+#include "iterator.h"
+#include "dir-iterator.h"
+
+struct dir_iterator_level {
+	int initialized;
+
+	DIR *dir;
+
+	/*
+	 * The length of the directory part of path at this level
+	 * (including a trailing '/'):
+	 */
+	size_t prefix_len;
+
+	/*
+	 * The last action that has been taken with the current entry
+	 * (needed for directories, which have to be included in the
+	 * iteration and also iterated into):
+	 */
+	enum {
+		DIR_STATE_ITER,
+		DIR_STATE_RECURSE
+	} dir_state;
+};
+
+/*
+ * The full data structure used to manage the internal directory
+ * iteration state. It includes members that are not part of the
+ * public interface.
+ */
+struct dir_iterator_int {
+	struct dir_iterator base;
+
+	/*
+	 * The number of levels currently on the stack. This is always
+	 * at least 1, because when it becomes zero the iteration is
+	 * ended and this struct is freed.
+	 */
+	size_t levels_nr;
+
+	/* The number of levels that have been allocated on the stack */
+	size_t levels_alloc;
+
+	/*
+	 * A stack of levels. levels[0] is the uppermost directory
+	 * that will be included in this iteration.
+	 */
+	struct dir_iterator_level *levels;
+};
+
+int dir_iterator_advance(struct dir_iterator *dir_iterator)
+{
+	struct dir_iterator_int *iter =
+		(struct dir_iterator_int *)dir_iterator;
+
+	while (1) {
+		struct dir_iterator_level *level =
+			&iter->levels[iter->levels_nr - 1];
+		struct dirent *de;
+
+		if (!level->initialized) {
+			if (!is_dir_sep(iter->base.path.buf[iter->base.path.len - 1]))
+				strbuf_addch(&iter->base.path, '/');
+			level->prefix_len = iter->base.path.len;
+
+			/* opendir() errors are handled below */
+			level->dir = opendir(iter->base.path.buf);
+
+			level->initialized = 1;
+		} else if (S_ISDIR(iter->base.st.st_mode)) {
+			if (level->dir_state == DIR_STATE_ITER) {
+				/*
+				 * The directory was just iterated
+				 * over; now prepare to iterate into
+				 * it.
+				 */
+				level->dir_state = DIR_STATE_RECURSE;
+				ALLOC_GROW(iter->levels, iter->levels_nr + 1,
+					   iter->levels_alloc);
+				level = &iter->levels[iter->levels_nr++];
+				level->initialized = 0;
+				continue;
+			} else {
+				/*
+				 * The directory has already been
+				 * iterated over and iterated into;
+				 * we're done with it.
+				 */
+			}
+		}
+
+		if (!level->dir) {
+			/*
+			 * This level is exhausted (or wasn't opened
+			 * successfully); pop up a level.
+			 */
+			if (--iter->levels_nr == 0) {
+				return dir_iterator_abort(dir_iterator);
+			}
+			continue;
+		}
+
+		/*
+		 * Loop until we find an entry that we can give back
+		 * to the caller:
+		 */
+		while (1) {
+			strbuf_setlen(&iter->base.path, level->prefix_len);
+			de = readdir(level->dir);
+
+			if (!de) {
+				/* This level is exhausted; pop up a level. */
+				closedir(level->dir);
+				level->dir = NULL;
+				if (--iter->levels_nr == 0)
+					return dir_iterator_abort(dir_iterator);
+				break;
+			}
+
+			if (is_dot_or_dotdot(de->d_name))
+				continue;
+
+			strbuf_addstr(&iter->base.path, de->d_name);
+			if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
+				if (errno != ENOENT)
+					warning("error reading path '%s': %s",
+						iter->base.path.buf,
+						strerror(errno));
+				continue;
+			}
+
+			/*
+			 * We have to set these each time because
+			 * the path strbuf might have been realloc()ed.
+			 */
+
+			iter->base.relative_path =
+				iter->base.path.buf + iter->levels[0].prefix_len;
+			iter->base.basename =
+				iter->base.path.buf + level->prefix_len;
+			level->dir_state = DIR_STATE_ITER;
+
+			return ITER_OK;
+		}
+	}
+}
+
+int dir_iterator_abort(struct dir_iterator *dir_iterator)
+{
+	struct dir_iterator_int *iter = (struct dir_iterator_int *)dir_iterator;
+
+	while (iter->levels_nr) {
+		struct dir_iterator_level *level =
+			&iter->levels[--iter->levels_nr];
+
+		if (level->dir)
+			closedir(level->dir);
+	}
+
+	free(iter->levels);
+	strbuf_release(&iter->base.path);
+	free(iter);
+	return ITER_DONE;
+}
+
+struct dir_iterator *dir_iterator_begin(const char *path)
+{
+	struct dir_iterator_int *iter = xcalloc(1, sizeof(*iter));
+	struct dir_iterator *dir_iterator = &iter->base;
+
+	if (!path || !*path)
+		die("BUG: empty path passed to dir_iterator_begin()");
+
+	strbuf_init(&iter->base.path, PATH_MAX);
+	strbuf_addstr(&iter->base.path, path);
+
+	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
+
+	iter->levels_nr = 1;
+	iter->levels[0].initialized = 0;
+
+	return dir_iterator;
+}
diff --git a/dir-iterator.h b/dir-iterator.h
new file mode 100644
index 0000000..f2f10e5
--- /dev/null
+++ b/dir-iterator.h
@@ -0,0 +1,86 @@
+#ifndef DIR_ITERATOR_H
+#define DIR_ITERATOR_H
+
+/*
+ * Iterate over a directory tree.
+ *
+ * Iterate over a directory tree, recursively, including paths of all
+ * types and hidden paths. Skip "." and ".." entries and don't follow
+ * symlinks except for the original path.
+ *
+ * Every time dir_iterator_advance() is called, update the members of
+ * the dir_iterator structure to reflect the next path in the
+ * iteration. The order that paths are iterated over within a
+ * directory is undefined, but directory paths are always iterated
+ * over before the subdirectory contents.
+ *
+ * A typical iteration looks like this:
+ *
+ *     int ok;
+ *     struct iterator *iter = dir_iterator_begin(path);
+ *
+ *     while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
+ *             if (want_to_stop_iteration()) {
+ *                     ok = dir_iterator_abort(iter);
+ *                     break;
+ *             }
+ *
+ *             // Access information about the current path:
+ *             if (S_ISDIR(iter->st.st_mode))
+ *                     printf("%s is a directory\n", iter->relative_path);
+ *     }
+ *
+ *     if (ok != ITER_DONE)
+ *             handle_error();
+ *
+ * Callers are allowed to modify iter->path while they are working,
+ * but they must restore it to its original contents before calling
+ * dir_iterator_advance() again.
+ */
+
+struct dir_iterator {
+	/* The current path: */
+	struct strbuf path;
+
+	/*
+	 * The current path relative to the starting path. This part
+	 * of the path always uses "/" characters to separate path
+	 * components:
+	 */
+	const char *relative_path;
+
+	/* The current basename: */
+	const char *basename;
+
+	/* The result of calling lstat() on path: */
+	struct stat st;
+};
+
+/*
+ * Start a directory iteration over path. Return a dir_iterator that
+ * holds the internal state of the iteration.
+ *
+ * The iteration includes all paths under path, not including path
+ * itself and not including "." or ".." entries.
+ *
+ * path is the starting directory. An internal copy will be made.
+ */
+struct dir_iterator *dir_iterator_begin(const char *path);
+
+/*
+ * Advance the iterator to the first or next item and return ITER_OK.
+ * If the iteration is exhausted, free the resources associated with
+ * the iterator and return ITER_DONE. On error, return ITER_ERROR. It
+ * is a bug to use iterator or call this function again after it has
+ * returned false.
+ */
+int dir_iterator_advance(struct dir_iterator *iterator);
+
+/*
+ * End the iteration before it has been exhausted. Free the directory
+ * iterator and any associated resources and return ITER_DONE. Return
+ * ITER_ERROR on error.
+ */
+int dir_iterator_abort(struct dir_iterator *iterator);
+
+#endif
-- 
2.8.1
