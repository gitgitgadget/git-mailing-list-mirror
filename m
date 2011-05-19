From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] bisect: refactor sha1_array into a generic sha1 list
Date: Thu, 19 May 2011 17:34:33 -0400
Message-ID: <20110519213433.GB29793@sigill.intra.peff.net>
References: <20110519213231.GA29702@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:34:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNArr-0006jM-NU
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934885Ab1ESVeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:34:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39451
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934861Ab1ESVef (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 17:34:35 -0400
Received: (qmail 21179 invoked by uid 107); 19 May 2011 21:36:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 May 2011 17:36:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 May 2011 17:34:33 -0400
Content-Disposition: inline
In-Reply-To: <20110519213231.GA29702@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174019>

This is a generally useful abstraction, so let's let others
make use of it.  The refactoring is more or less a straight
copy; however, functions and struct members have had their
names changed to match string_list, which is the most
similar data structure.

Signed-off-by: Jeff King <peff@peff.net>
---
I was tempted also to rename it to sha1_list to match string_list. But
after working with commit_list recently, where the linked list nature
was important, I began to think that string_list is perhaps mis-named.

 Makefile     |    2 +
 bisect.c     |   70 ++++++++++++---------------------------------------------
 sha1-array.c |   43 +++++++++++++++++++++++++++++++++++
 sha1-array.h |   18 +++++++++++++++
 4 files changed, 78 insertions(+), 55 deletions(-)
 create mode 100644 sha1-array.c
 create mode 100644 sha1-array.h

diff --git a/Makefile b/Makefile
index 5379aaa..a357d58 100644
--- a/Makefile
+++ b/Makefile
@@ -540,6 +540,7 @@ LIB_H += rerere.h
 LIB_H += resolve-undo.h
 LIB_H += revision.h
 LIB_H += run-command.h
+LIB_H += sha1-array.h
 LIB_H += sha1-lookup.h
 LIB_H += sideband.h
 LIB_H += sigchain.h
@@ -642,6 +643,7 @@ LIB_OBJS += revision.o
 LIB_OBJS += run-command.o
 LIB_OBJS += server-info.o
 LIB_OBJS += setup.o
+LIB_OBJS += sha1-array.o
 LIB_OBJS += sha1-lookup.o
 LIB_OBJS += sha1_file.o
 LIB_OBJS += sha1_name.o
diff --git a/bisect.c b/bisect.c
index 060c042..dd7e8ed 100644
--- a/bisect.c
+++ b/bisect.c
@@ -9,13 +9,7 @@
 #include "run-command.h"
 #include "log-tree.h"
 #include "bisect.h"
-
-struct sha1_array {
-	unsigned char (*sha1)[20];
-	int sha1_nr;
-	int sha1_alloc;
-	int sorted;
-};
+#include "sha1-array.h"
 
 static struct sha1_array good_revs;
 static struct sha1_array skipped_revs;
@@ -425,22 +419,15 @@ static void argv_array_push_sha1(struct argv_array *array,
 	argv_array_push(array, strbuf_detach(&buf, NULL));
 }
 
-static void sha1_array_push(struct sha1_array *array,
-			    const unsigned char *sha1)
-{
-	ALLOC_GROW(array->sha1, array->sha1_nr + 1, array->sha1_alloc);
-	hashcpy(array->sha1[array->sha1_nr++], sha1);
-}
-
 static int register_ref(const char *refname, const unsigned char *sha1,
 			int flags, void *cb_data)
 {
 	if (!strcmp(refname, "bad")) {
 		current_bad_sha1 = sha1;
 	} else if (!prefixcmp(refname, "good-")) {
-		sha1_array_push(&good_revs, sha1);
+		sha1_array_append(&good_revs, sha1);
 	} else if (!prefixcmp(refname, "skip-")) {
-		sha1_array_push(&skipped_revs, sha1);
+		sha1_array_append(&skipped_revs, sha1);
 	}
 
 	return 0;
@@ -477,41 +464,14 @@ static void read_bisect_paths(struct argv_array *array)
 	fclose(fp);
 }
 
-static int array_cmp(const void *a, const void *b)
-{
-	return hashcmp(a, b);
-}
-
-static void sort_sha1_array(struct sha1_array *array)
-{
-	qsort(array->sha1, array->sha1_nr, sizeof(*array->sha1), array_cmp);
-
-	array->sorted = 1;
-}
-
-static const unsigned char *sha1_access(size_t index, void *table)
-{
-	unsigned char (*array)[20] = table;
-	return array[index];
-}
-
-static int lookup_sha1_array(struct sha1_array *array,
-			     const unsigned char *sha1)
-{
-	if (!array->sorted)
-		sort_sha1_array(array);
-
-	return sha1_pos(sha1, array->sha1, array->sha1_nr, sha1_access);
-}
-
 static char *join_sha1_array_hex(struct sha1_array *array, char delim)
 {
 	struct strbuf joined_hexs = STRBUF_INIT;
 	int i;
 
-	for (i = 0; i < array->sha1_nr; i++) {
+	for (i = 0; i < array->nr; i++) {
 		strbuf_addstr(&joined_hexs, sha1_to_hex(array->sha1[i]));
-		if (i + 1 < array->sha1_nr)
+		if (i + 1 < array->nr)
 			strbuf_addch(&joined_hexs, delim);
 	}
 
@@ -546,13 +506,13 @@ struct commit_list *filter_skipped(struct commit_list *list,
 	if (count)
 		*count = 0;
 
-	if (!skipped_revs.sha1_nr)
+	if (!skipped_revs.nr)
 		return list;
 
 	while (list) {
 		struct commit_list *next = list->next;
 		list->next = NULL;
-		if (0 <= lookup_sha1_array(&skipped_revs,
+		if (0 <= sha1_array_lookup(&skipped_revs,
 					   list->item->object.sha1)) {
 			if (skipped_first && !*skipped_first)
 				*skipped_first = 1;
@@ -647,7 +607,7 @@ static struct commit_list *managed_skipped(struct commit_list *list,
 
 	*tried = NULL;
 
-	if (!skipped_revs.sha1_nr)
+	if (!skipped_revs.nr)
 		return list;
 
 	list = filter_skipped(list, tried, 0, &count, &skipped_first);
@@ -672,7 +632,7 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
 	/* rev_argv.argv[0] will be ignored by setup_revisions */
 	argv_array_push(&rev_argv, xstrdup("bisect_rev_setup"));
 	argv_array_push_sha1(&rev_argv, current_bad_sha1, bad_format);
-	for (i = 0; i < good_revs.sha1_nr; i++)
+	for (i = 0; i < good_revs.nr; i++)
 		argv_array_push_sha1(&rev_argv, good_revs.sha1[i],
 				     good_format);
 	argv_array_push(&rev_argv, xstrdup("--"));
@@ -772,12 +732,12 @@ static struct commit *get_commit_reference(const unsigned char *sha1)
 
 static struct commit **get_bad_and_good_commits(int *rev_nr)
 {
-	int len = 1 + good_revs.sha1_nr;
+	int len = 1 + good_revs.nr;
 	struct commit **rev = xmalloc(len * sizeof(*rev));
 	int i, n = 0;
 
 	rev[n++] = get_commit_reference(current_bad_sha1);
-	for (i = 0; i < good_revs.sha1_nr; i++)
+	for (i = 0; i < good_revs.nr; i++)
 		rev[n++] = get_commit_reference(good_revs.sha1[i]);
 	*rev_nr = n;
 
@@ -840,9 +800,9 @@ static void check_merge_bases(void)
 		const unsigned char *mb = result->item->object.sha1;
 		if (!hashcmp(mb, current_bad_sha1)) {
 			handle_bad_merge_base();
-		} else if (0 <= lookup_sha1_array(&good_revs, mb)) {
+		} else if (0 <= sha1_array_lookup(&good_revs, mb)) {
 			continue;
-		} else if (0 <= lookup_sha1_array(&skipped_revs, mb)) {
+		} else if (0 <= sha1_array_lookup(&skipped_revs, mb)) {
 			handle_skipped_merge_base(mb);
 		} else {
 			printf("Bisecting: a merge base must be tested\n");
@@ -903,7 +863,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix)
 		return;
 
 	/* Bisecting with no good rev is ok. */
-	if (good_revs.sha1_nr == 0)
+	if (good_revs.nr == 0)
 		return;
 
 	/* Check if all good revs are ancestor of the bad rev. */
@@ -968,7 +928,7 @@ int bisect_next_all(const char *prefix)
 	bisect_common(&revs);
 
 	revs.commits = find_bisection(revs.commits, &reaches, &all,
-				       !!skipped_revs.sha1_nr);
+				       !!skipped_revs.nr);
 	revs.commits = managed_skipped(revs.commits, &tried);
 
 	if (!revs.commits) {
diff --git a/sha1-array.c b/sha1-array.c
new file mode 100644
index 0000000..5b75a5a
--- /dev/null
+++ b/sha1-array.c
@@ -0,0 +1,43 @@
+#include "cache.h"
+#include "sha1-array.h"
+#include "sha1-lookup.h"
+
+void sha1_array_append(struct sha1_array *array, const unsigned char *sha1)
+{
+	ALLOC_GROW(array->sha1, array->nr + 1, array->alloc);
+	hashcpy(array->sha1[array->nr++], sha1);
+	array->sorted = 0;
+}
+
+static int void_hashcmp(const void *a, const void *b)
+{
+	return hashcmp(a, b);
+}
+
+void sha1_array_sort(struct sha1_array *array)
+{
+	qsort(array->sha1, array->nr, sizeof(*array->sha1), void_hashcmp);
+	array->sorted = 1;
+}
+
+static const unsigned char *sha1_access(size_t index, void *table)
+{
+	unsigned char (*array)[20] = table;
+	return array[index];
+}
+
+int sha1_array_lookup(struct sha1_array *array, const unsigned char *sha1)
+{
+	if (!array->sorted)
+		sha1_array_sort(array);
+	return sha1_pos(sha1, array->sha1, array->nr, sha1_access);
+}
+
+void sha1_array_clear(struct sha1_array *array)
+{
+	free(array->sha1);
+	array->sha1 = NULL;
+	array->nr = 0;
+	array->alloc = 0;
+	array->sorted = 0;
+}
diff --git a/sha1-array.h b/sha1-array.h
new file mode 100644
index 0000000..15d3b6b
--- /dev/null
+++ b/sha1-array.h
@@ -0,0 +1,18 @@
+#ifndef SHA1_ARRAY_H
+#define SHA1_ARRAY_H
+
+struct sha1_array {
+	unsigned char (*sha1)[20];
+	int nr;
+	int alloc;
+	int sorted;
+};
+
+#define SHA1_ARRAY_INIT { NULL, 0, 0, 0 }
+
+void sha1_array_append(struct sha1_array *array, const unsigned char *sha1);
+void sha1_array_sort(struct sha1_array *array);
+int sha1_array_lookup(struct sha1_array *array, const unsigned char *sha1);
+void sha1_array_clear(struct sha1_array *array);
+
+#endif /* SHA1_ARRAY_H */
-- 
1.7.5.8.ga95ab
