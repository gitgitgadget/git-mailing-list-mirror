From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] commit-slab: introduce a macro to define a slab for new
 type
Date: Sat, 13 Apr 2013 23:04:49 -0700
Message-ID: <1365919489-17553-4-git-send-email-gitster@pobox.com>
References: <1365919489-17553-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 14 08:05:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URG3n-00016K-SL
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 08:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023Ab3DNGFC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 02:05:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64391 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766Ab3DNGE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 02:04:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83CB5E3DC;
	Sun, 14 Apr 2013 06:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=INhI
	E+H0Zqxq737HZ6gWvIZHeFo=; b=kgRSxSerEECLsUgjOpmnezPS2Dl8UpuaLbSm
	r6ZBThGDk9Y8fOFpQhb3e1siEXLeR3vpArFv1ZBoyg+5XdkJM12GpcaMDMlqMMSR
	qyVG4i/EoBFOQPg5clRGT/jQtKp6HDzg7boMBl2PFIYh4hQ/YQXZ/YTNS50wSsBg
	JWIuYic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	u02DwD9u82QX8TWUhcJv52y7ST1JlwNkCWgOrGyk3U/wowFACvBeV/BmR3/bxHLw
	CRHkqB7Wo/FYxnU4aR3NDOiBK0K1J+fjIw7XSESIKBHSp2/8fsOSxFSKpd7nYc7D
	XOFjzN136jgxCUKOfMDMVQU1SkH0tdcoSLAY41uHuMo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77DE2E3DA;
	Sun, 14 Apr 2013 06:04:58 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72CD7E3D7; Sun, 14 Apr 2013
 06:04:57 +0000 (UTC)
X-Mailer: git-send-email 1.8.2.1-514-gf369d36
In-Reply-To: <1365919489-17553-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3BE54C04-A4C9-11E2-9863-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221080>

Introduce a header file to define a macro that can define the struct
type, initializer, accessor and cleanup functions to manage a commit
slab.  Update the "indegree" topological sort facility using it.

To associate 32 flag bits with each commit,
you can write:

	define_commit_slab(flag32, uint32);

to declare "struct flag32" type, define an instance of it with

	struct flag32 flags;

and initialize it by calling

	init_flag32(&flags);

After that,

	uint32 *fp = flag32_at(&flags, commit);

will return a pointer pointing at a uint32 for that commit.  Once
you are done with these flags, clean them up with

	clear_flag32(&flags);

Callers that cannot hard-code how wide the data to be associated
with the commit be at compile time can use the "stride" variant.

Suppose you want to give one bit per existing ref and paint commits
down to find which refs are descendants of each commit. You find
that you have 320 refs only at runtime.

The code can declare a commit slab "struct flagbits"

	define_commit_slab(flagbits, unsigned char);
	struct flagbits flags;

and initialize it by:

	nrefs = ... count number of refs that returns say 320 ...
	init_flagbits_with_stride(&flags, (nrefs + 7) / 8);

so that

	unsigned char *fp = flagbits_at(&flags, commit);

will return a pointer pointing at an array of 40 "unsigned char"s
associated with the commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit-slab.h | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 commit.c      | 69 +++++++------------------------------------
 2 files changed, 105 insertions(+), 59 deletions(-)
 create mode 100644 commit-slab.h

diff --git a/commit-slab.h b/commit-slab.h
new file mode 100644
index 0000000..8030885
--- /dev/null
+++ b/commit-slab.h
@@ -0,0 +1,95 @@
+#ifndef COMMIT_SLAB_H
+#define COMMIT_SLAB_H
+
+/*
+ * define_commit_slab(slabname, elemtype) creates boilerplate code to define
+ * a new struct (struct slabname) that is used to associate a piece of data
+ * of elemtype to commits, and a few functions to use that struct.
+ *
+ * After including this header file, using:
+ *
+ * define_commit_slab(indegee, int);
+ *
+ * will let you call the following functions:
+ *
+ * - int *indegree_at(struct indegree *, struct commit *);
+ *
+ *   This function locates the data associated with the given commit in
+ *   the indegree slab, and returns the pointer to it.
+ *
+ * - void init_indegree(struct indegree *, int stride);
+ *
+ *   Initializes the indegree slab that associates an array of integers
+ *   to each commit. 'stride' specifies how big each array is.
+ */
+
+/* allocate ~512kB at once, allowing for malloc overhead */
+#ifndef COMMIT_SLAB_SIZE
+#define COMMIT_SLAB_SIZE (512*1024-32)
+#endif
+
+#define define_commit_slab(slabname, elemtype) 				\
+									\
+struct slabname {							\
+	unsigned slab_size;						\
+	unsigned stride;						\
+	unsigned slab_count;						\
+	elemtype **slab;						\
+};									\
+static int stat_ ##slabname## realloc;					\
+									\
+static void init_ ##slabname## _with_stride(struct slabname *s,		\
+					    unsigned stride)		\
+{									\
+	unsigned int elem_size;						\
+	if (!stride)							\
+		stride = 1;						\
+	s->stride = stride;						\
+	elem_size = sizeof(struct slabname) * stride;			\
+	s->slab_size = COMMIT_SLAB_SIZE / elem_size;			\
+	s->slab_count = 0;						\
+	s->slab = NULL;							\
+}									\
+									\
+static void init_ ##slabname(struct slabname *s)			\
+{									\
+	init_ ##slabname## _with_stride(s, 1);				\
+}									\
+									\
+static void clear_ ##slabname(struct slabname *s)			\
+{									\
+	int i;								\
+	for (i = 0; i < s->slab_count; i++)				\
+		free(s->slab[i]);					\
+	s->slab_count = 0;						\
+	free(s->slab);							\
+	s->slab = NULL;							\
+}									\
+									\
+static elemtype *slabname## _at(struct slabname *s,			\
+				const struct commit *c)			\
+{									\
+	int nth_slab, nth_slot, ix;					\
+									\
+	ix = c->index * s->stride;					\
+	nth_slab = ix / s->slab_size;					\
+	nth_slot = ix % s->slab_size;					\
+									\
+	if (s->slab_count <= nth_slab) {				\
+		int i;							\
+		s->slab = xrealloc(s->slab,				\
+				   (nth_slab + 1) * sizeof(s->slab));	\
+		stat_ ##slabname## realloc++;				\
+		for (i = s->slab_count; i <= nth_slab; i++)		\
+			s->slab[i] = NULL;				\
+		s->slab_count = nth_slab + 1;				\
+	}								\
+	if (!s->slab[nth_slab])						\
+		s->slab[nth_slab] = xcalloc(s->slab_size,		\
+					    sizeof(**s->slab));		\
+	return &s->slab[nth_slab][nth_slot];				\
+}									\
+									\
+static int stat_ ##slabname## realloc
+
+#endif /* COMMIT_SLAB_H */
diff --git a/commit.c b/commit.c
index 4c05b39..66a6c00 100644
--- a/commit.c
+++ b/commit.c
@@ -8,6 +8,7 @@
 #include "notes.h"
 #include "gpg-interface.h"
 #include "mergesort.h"
+#include "commit-slab.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -501,57 +502,7 @@ struct commit *pop_commit(struct commit_list **stack)
 	return item;
 }
 
-struct commit_slab_piece {
-	int buf;
-};
-
-struct commit_slab {
-	int piece_size;
-	int piece_count;
-	struct commit_slab_piece **piece;
-};
-
-static void slab_init(struct commit_slab *s)
-{
-	/* allocate ~512kB at once, allowing for malloc overhead */
-	int size = (512*1024-32) / sizeof(struct commit_slab_piece);
-
-	s->piece_size = size;
-	s->piece_count = 0;
-	s->piece = NULL;
-}
-
-static void slab_clear(struct commit_slab *s)
-{
-	int i;
-
-	for (i = 0; i < s->piece_count; i++)
-		free(s->piece[i]);
-	s->piece_count = 0;
-	free(s->piece);
-	s->piece = NULL;
-}
-
-static inline struct commit_slab_piece *slab_at(struct commit_slab *s,
-						const struct commit *c)
-{
-	int nth_piece, nth_slot;
-
-	nth_piece = c->index / s->piece_size;
-	nth_slot = c->index % s->piece_size;
-
-	if (s->piece_count <= nth_piece) {
-		int i;
-
-		s->piece = xrealloc(s->piece, (nth_piece + 1) * sizeof(s->piece));
-		for (i = s->piece_count; i <= nth_piece; i++)
-			s->piece[i] = NULL;
-		s->piece_count = nth_piece + 1;
-	}
-	if (!s->piece[nth_piece])
-		s->piece[nth_piece] = xcalloc(s->piece_size, sizeof(**s->piece));
-	return &s->piece[nth_piece][nth_slot];
-}
+define_commit_slab(indegree_slab, int);
 
 /*
  * Performs an in-place topological sort on the list supplied.
@@ -561,18 +512,18 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 	struct commit_list *next, *orig = *list;
 	struct commit_list *work, **insert;
 	struct commit_list **pptr;
-	struct commit_slab indegree;
+	struct indegree_slab indegree;
 
 	if (!orig)
 		return;
 	*list = NULL;
 
-	slab_init(&indegree);
+	init_indegree_slab(&indegree);
 
 	/* Mark them and clear the indegree */
 	for (next = orig; next; next = next->next) {
 		struct commit *commit = next->item;
-		slab_at(&indegree, commit)->buf = 1;
+		*(indegree_slab_at(&indegree, commit)) = 1;
 	}
 
 	/* update the indegree */
@@ -580,7 +531,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		struct commit_list * parents = next->item->parents;
 		while (parents) {
 			struct commit *parent = parents->item;
-			int *pi = &slab_at(&indegree, parent)->buf;
+			int *pi = indegree_slab_at(&indegree, parent);
 
 			if (*pi)
 				(*pi)++;
@@ -600,7 +551,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 	for (next = orig; next; next = next->next) {
 		struct commit *commit = next->item;
 
-		if (slab_at(&indegree, commit)->buf == 1)
+		if (*(indegree_slab_at(&indegree, commit)) == 1)
 			insert = &commit_list_insert(commit, insert)->next;
 	}
 
@@ -621,7 +572,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		commit = work_item->item;
 		for (parents = commit->parents; parents ; parents = parents->next) {
 			struct commit *parent = parents->item;
-			int *pi = &slab_at(&indegree, parent)->buf;
+			int *pi = indegree_slab_at(&indegree, parent);
 
 			if (!*pi)
 				continue;
@@ -642,12 +593,12 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		 * work_item is a commit all of whose children
 		 * have already been emitted. we can emit it now.
 		 */
-		slab_at(&indegree, commit)->buf = 0;
+		*(indegree_slab_at(&indegree, commit)) = 0;
 		*pptr = work_item;
 		pptr = &work_item->next;
 	}
 
-	slab_clear(&indegree);
+	clear_indegree_slab(&indegree);
 }
 
 /* merge-base stuff */
-- 
1.8.2.1-514-gf369d36
