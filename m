From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] traverse_trees(): allow pruning with pathspec
Date: Mon, 29 Aug 2011 14:33:21 -0700
Message-ID: <1314653603-7533-2-git-send-email-gitster@pobox.com>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org>
 <1314653603-7533-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 23:33:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy9Sa-00085Q-Ji
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 23:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015Ab1H2Vd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 17:33:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39628 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754524Ab1H2Vd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 17:33:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2A8747C9;
	Mon, 29 Aug 2011 17:33:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6dH9
	8iGVq318kfmwlkQL3r1KWvw=; b=CqsHyZNF9vc0fiWdyw6S2QekiuW4kbh6JpJM
	brQR0hWsGBwR/p6PWGMrZsATbfz4wY7BJ/GY7vRy0aOrGd2wjO/QbxWV4PJKSxY2
	yalXcrDrH2aDMulQXvrlE9gX9/qPcGQ7WASYkDmbd/d0X+00J+raIsBBBgZpnIxz
	bY5lRrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	R+0JLGeSmuNUTxsZ9pTC0AueZdvfptvquDkic15e2LZIRC2r0DFFchRLE5g+TiuQ
	v1djGjAAHoqtuYFEYu9GjIvZd/UenrYSnkq/elhY9c5w48CNpXtOWBjMevCSr/qu
	EvXqAxD8/4IV9Gs5lTDELPuPA9b2zyxVvDjRUYzI1+Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA67047C8;
	Mon, 29 Aug 2011 17:33:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E6A347C5; Mon, 29 Aug 2011
 17:33:26 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.70.g82660
In-Reply-To: <1314653603-7533-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 88069384-D286-11E0-A897-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180359>

The traverse_trees() machinery is primarily meant for merging two (or
more) trees, and because a merge is a full tree operation, it doesn't
support any pruning with pathspec.

Since d1f2d7e (Make run_diff_index() use unpack_trees(), not read_tree(),
2008-01-19), however, we use unpack_trees() to traverse_trees() callchain
to perform "diff-index", which could waste a lot of work traversing trees
outside the user-supplied pathspec, only to discard at the blob comparison
level in diff-lib.c::oneway_diff() which is way too late.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 tree-walk.c |   39 +++++++++++++++++++++++++++++++++------
 tree-walk.h |    1 +
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 33f749e..808bb55 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -309,6 +309,18 @@ static void free_extended_entry(struct tree_desc_x *t)
 	}
 }
 
+static inline int prune_traversal(struct name_entry *e,
+				  struct traverse_info *info,
+				  struct strbuf *base,
+				  int still_interesting)
+{
+	if (!info->pathspec || still_interesting == 2)
+		return 2;
+	if (still_interesting < 0)
+		return still_interesting;
+	return tree_entry_interesting(e, base, 0, info->pathspec);
+}
+
 int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 {
 	int ret = 0;
@@ -316,10 +328,18 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 	struct name_entry *entry = xmalloc(n*sizeof(*entry));
 	int i;
 	struct tree_desc_x *tx = xcalloc(n, sizeof(*tx));
+	struct strbuf base = STRBUF_INIT;
+	int interesting = 1;
 
 	for (i = 0; i < n; i++)
 		tx[i].d = t[i];
 
+	if (info->prev) {
+		strbuf_grow(&base, info->pathlen);
+		make_traverse_path(base.buf, info->prev, &info->name);
+		base.buf[info->pathlen-1] = '/';
+		strbuf_setlen(&base, info->pathlen);
+	}
 	for (;;) {
 		unsigned long mask, dirmask;
 		const char *first = NULL;
@@ -376,16 +396,22 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 			mask |= 1ul << i;
 			if (S_ISDIR(entry[i].mode))
 				dirmask |= 1ul << i;
+			e = &entry[i];
 		}
 		if (!mask)
 			break;
-		ret = info->fn(n, mask, dirmask, entry, info);
-		if (ret < 0) {
-			error = ret;
-			if (!info->show_all_errors)
-				break;
+		interesting = prune_traversal(e, info, &base, interesting);
+		if (interesting < 0)
+			break;
+		if (interesting) {
+			ret = info->fn(n, mask, dirmask, entry, info);
+			if (ret < 0) {
+				error = ret;
+				if (!info->show_all_errors)
+					break;
+			}
+			mask &= ret;
 		}
-		mask &= ret;
 		ret = 0;
 		for (i = 0; i < n; i++)
 			if (mask & (1ul << i))
@@ -395,6 +421,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 	for (i = 0; i < n; i++)
 		free_extended_entry(tx + i);
 	free(tx);
+	strbuf_release(&base);
 	return error;
 }
 
diff --git a/tree-walk.h b/tree-walk.h
index 39524b7..0089581 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -44,6 +44,7 @@ struct traverse_info {
 	struct traverse_info *prev;
 	struct name_entry name;
 	int pathlen;
+	struct pathspec *pathspec;
 
 	unsigned long conflicts;
 	traverse_callback_t fn;
-- 
1.7.7.rc0.70.g82660
