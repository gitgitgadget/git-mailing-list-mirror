From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] commit-slab: avoid large realloc
Date: Sat, 13 Apr 2013 23:04:48 -0700
Message-ID: <1365919489-17553-3-git-send-email-gitster@pobox.com>
References: <1365919489-17553-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 14 08:05:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URG3n-00016K-DL
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 08:05:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843Ab3DNGE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 02:04:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56952 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766Ab3DNGE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 02:04:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3785EE3D1;
	Sun, 14 Apr 2013 06:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Tize
	A9HCkl1HzMrIp4//IA4Na/U=; b=CeIOy85RVUYt8YN3fabeESMsefiUX5ja+ZSo
	D3PlzKbyglIoR0JrNnV7g08UeWxcUVnKQObg2uUoH9CE81MEhuTbB/rZWiT1gl2Q
	8mfkjwiMx2nDHUZx+72RlWTvQdtHrqcf9qLvhW4K4MtGXwo35VkIxOCf3Eg7m+Pv
	FJuOCYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	lBGt/+iY2i3DFt2JzvMTlWuWz2RIR7QDH1DsHEicrQ4i3s5R46ZoaQY3tkmwjwz5
	tRgXHvQrCQZYz8dMgoqTMJOWMw7OFG0ztQOllG3wJhidNQ9hTj/9D8xnXM86d1Sj
	br8iXizCwOWnnTtr8dtKxx+5aMQ4Nxu02+GcIkovNCo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2ACBCE3D0;
	Sun, 14 Apr 2013 06:04:56 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CEF1E3CF; Sun, 14 Apr 2013
 06:04:55 +0000 (UTC)
X-Mailer: git-send-email 1.8.2.1-514-gf369d36
In-Reply-To: <1365919489-17553-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3AA66210-A4C9-11E2-AC32-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221078>

Instead of using a single "slab" and keep reallocating it as we find
that we need to deal with commits with larger values of commit->index,
make a "slab" an array of many "slab_piece"s. Each access may need
two levels of indirections, but we only need to reallocate the first
level array of pointers when we have to grow the table this way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 62 ++++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/commit.c b/commit.c
index 9365e3b..4c05b39 100644
--- a/commit.c
+++ b/commit.c
@@ -501,34 +501,56 @@ struct commit *pop_commit(struct commit_list **stack)
 	return item;
 }
 
+struct commit_slab_piece {
+	int buf;
+};
+
 struct commit_slab {
-	int *buf;
-	int alloc;
+	int piece_size;
+	int piece_count;
+	struct commit_slab_piece **piece;
 };
 
 static void slab_init(struct commit_slab *s)
 {
-	memset(s, 0, sizeof(*s));
+	/* allocate ~512kB at once, allowing for malloc overhead */
+	int size = (512*1024-32) / sizeof(struct commit_slab_piece);
+
+	s->piece_size = size;
+	s->piece_count = 0;
+	s->piece = NULL;
 }
 
 static void slab_clear(struct commit_slab *s)
 {
-	free(s->buf);
-	slab_init(s);
+	int i;
+
+	for (i = 0; i < s->piece_count; i++)
+		free(s->piece[i]);
+	s->piece_count = 0;
+	free(s->piece);
+	s->piece = NULL;
 }
 
-static inline int *slab_at(struct commit_slab *s, const struct commit *c)
+static inline struct commit_slab_piece *slab_at(struct commit_slab *s,
+						const struct commit *c)
 {
-	if (s->alloc <= c->index) {
-		int new_alloc = alloc_nr(s->alloc);
-		if (new_alloc <= c->index)
-			new_alloc = c->index + 1;
-
-		s->buf = xrealloc(s->buf, new_alloc * sizeof(*s->buf));
-		memset(s->buf + s->alloc, 0, new_alloc - s->alloc);
-		s->alloc = new_alloc;
+	int nth_piece, nth_slot;
+
+	nth_piece = c->index / s->piece_size;
+	nth_slot = c->index % s->piece_size;
+
+	if (s->piece_count <= nth_piece) {
+		int i;
+
+		s->piece = xrealloc(s->piece, (nth_piece + 1) * sizeof(s->piece));
+		for (i = s->piece_count; i <= nth_piece; i++)
+			s->piece[i] = NULL;
+		s->piece_count = nth_piece + 1;
 	}
-	return s->buf + c->index;
+	if (!s->piece[nth_piece])
+		s->piece[nth_piece] = xcalloc(s->piece_size, sizeof(**s->piece));
+	return &s->piece[nth_piece][nth_slot];
 }
 
 /*
@@ -550,7 +572,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 	/* Mark them and clear the indegree */
 	for (next = orig; next; next = next->next) {
 		struct commit *commit = next->item;
-		*slab_at(&indegree, commit) = 1;
+		slab_at(&indegree, commit)->buf = 1;
 	}
 
 	/* update the indegree */
@@ -558,7 +580,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		struct commit_list * parents = next->item->parents;
 		while (parents) {
 			struct commit *parent = parents->item;
-			int *pi = slab_at(&indegree, parent);
+			int *pi = &slab_at(&indegree, parent)->buf;
 
 			if (*pi)
 				(*pi)++;
@@ -578,7 +600,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 	for (next = orig; next; next = next->next) {
 		struct commit *commit = next->item;
 
-		if (*slab_at(&indegree, commit) == 1)
+		if (slab_at(&indegree, commit)->buf == 1)
 			insert = &commit_list_insert(commit, insert)->next;
 	}
 
@@ -599,7 +621,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		commit = work_item->item;
 		for (parents = commit->parents; parents ; parents = parents->next) {
 			struct commit *parent = parents->item;
-			int *pi = slab_at(&indegree, parent);
+			int *pi = &slab_at(&indegree, parent)->buf;
 
 			if (!*pi)
 				continue;
@@ -620,7 +642,7 @@ void sort_in_topological_order(struct commit_list ** list, int lifo)
 		 * work_item is a commit all of whose children
 		 * have already been emitted. we can emit it now.
 		 */
-		*slab_at(&indegree, commit) = 0;
+		slab_at(&indegree, commit)->buf = 0;
 		*pptr = work_item;
 		pptr = &work_item->next;
 	}
-- 
1.8.2.1-514-gf369d36
