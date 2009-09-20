From: Junio C Hamano <gitster@pobox.com>
Subject: [WIP PATCH 4/6] traverse_trees(): handle D/F conflict case sanely
Date: Sat, 19 Sep 2009 22:06:13 -0700
Message-ID: <1253423175-6339-5-git-send-email-gitster@pobox.com>
References: <1253423175-6339-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 07:06:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpEdI-00044A-CZ
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 07:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbZITFGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 01:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbZITFG2
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 01:06:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbZITFGY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 01:06:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ADCD25755D
	for <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=fMA5
	WDewlWGjHxmxFBmumHyrjAs=; b=wDZ9hAuTemEP4322l0cTULYgaqEStNeT2Hpz
	QlSVTJUt2jhahWpr1DOI9l3S+qu0qzuyaTnWEDHzEqbOK7aMbFcLRwx7POqZq0IO
	N6wHy2lA6A2jHyU3bL9qv56oF5eOAjzPBX++UxQZe2GcZB9muoU+kGONE68F0efW
	hwYsVdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=BCDvzn
	ouKLRQhjSveWzxLxhgt0bqToao98Ipz27iJ2+w1tywSOkuhc/ma9uq4nkKF9z0XW
	zLzA+fL3VutymO+KnmMWjOjjiKYZgaAz0rPGlc+oTl9ye2ZeZXpI7cpo0UJQcQdS
	Dm52AJwlh7pXOHJgAJ63huMpxL+rGki2IDtgg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ABB8E5755C
	for <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C1F5D5755B for
 <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:26 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.rc1.90.ga3b1b
In-Reply-To: <1253423175-6339-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5A0A91FE-A5A3-11DE-8953-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128841>

traverse_trees() is supposed to call its callback with all the matching
entries from the given trees.  The current algorithm keeps a pointer to
each of the tree being traversed, and feeds the entry with the earliest
name to the callback.

This breaks down if the trees being traversed looks like this:

    A    B
    t-1  t
    t-2  u
    t/a  v

When we are currently looking at an entry "t-1" in tree A, and tree B has
returned "t", feeding "t" from the B and not feeding anything from A, only
because "t-1" sorts later than "t", will miss an entry for a subtree "t"
behind the current entry in tree A.

This introduces extended_entry_extract() helper function that gives what
name is expected from the tree, and implements a mechanism to look-ahead
in the tree object using it, to make sure such a case is handled sanely.
Traversal in tree A in the above example will first return "t" to match
that of B, and then the next request for an entry to A then returns "t-1".

This roughly corresponds to what Linus's "prepare for one-entry lookahead"
wanted to do, but because this does implement look ahead, t6035 and t7003
reveal that the approach would not work without adjusting the side that
walks the index in unpack_trees() as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 tree-walk.c |  277 +++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 234 insertions(+), 43 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 02e2aed..08796c2 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -60,13 +60,6 @@ void *fill_tree_descriptor(struct tree_desc *desc, const unsigned char *sha1)
 	return buf;
 }
 
-static int entry_compare(struct name_entry *a, struct name_entry *b)
-{
-	return df_name_compare(
-			a->path, tree_entry_len(a->path, a->sha1), a->mode,
-			b->path, tree_entry_len(b->path, b->sha1), b->mode);
-}
-
 static void entry_clear(struct name_entry *a)
 {
 	memset(a, 0, sizeof(*a));
@@ -138,66 +131,264 @@ char *make_traverse_path(char *path, const struct traverse_info *info, const str
 	return path;
 }
 
+struct tree_desc_skip {
+	struct tree_desc_skip *prev;
+	const void *ptr;
+};
+
+struct tree_desc_x {
+	struct tree_desc d;
+	struct tree_desc_skip *skip;
+};
+
+static int name_compare(const char *a, int a_len,
+			const char *b, int b_len)
+{
+	int len = (a_len < b_len) ? a_len : b_len;
+	int cmp = memcmp(a, b, len);
+	if (cmp)
+		return cmp;
+	return (a_len - b_len);
+}
+
+static int check_entry_match(const char *a, int a_len, const char *b, int b_len)
+{
+	/*
+	 * The caller wants to pick *a* from a tree or nothing.
+	 * We are looking at *b* in a tree.
+	 *
+	 * (0) If a and b are the same name, we are trivially happy.
+	 *
+	 * There are three possibilities where *a* could be hiding
+	 * behind *b*.
+	 *
+	 * (1) *a* == "t",   *b* == "ab"  i.e. *b* sorts earlier than *a* no
+	 *                                matter what.
+	 * (2) *a* == "t",   *b* == "t-2" and "t" is a subtree in the tree;
+	 * (3) *a* == "t-2", *b* == "t"   and "t-2" is a blob in the tree.
+	 *
+	 * Otherwise we know *a* won't appear in the tree without
+	 * scanning further.
+	 */
+
+	int cmp = name_compare(a, a_len, b, b_len);
+
+	/* Most common case first -- reading sync'd trees */
+	if (!cmp)
+		return cmp;
+
+	if (0 < cmp) {
+		/* a comes after b; it does not matter if it is case (3)
+		if (b_len < a_len && !memcmp(a, b, b_len) && a[b_len] < '/')
+			return 1;
+		*/
+		return 1; /* keep looking */
+	}
+
+	/* b comes after a; are we looking at case (2)? */
+	if (a_len < b_len && !memcmp(a, b, a_len) && b[a_len] < '/')
+		return 1; /* keep looking */
+
+	return -1; /* a cannot appear in the tree */
+}
+
+/*
+ * From the extended tree_desc, extract the first name entry, while
+ * paying attention to the candidate "first" name.  Most importantly,
+ * when looking for an entry, if there are entries that sorts earlier
+ * in the tree object representation than that name, skip them and
+ * process the named entry first.  We will remember that we haven't
+ * processed the first entry yet, and in the later call skip the
+ * entry we processed early when update_extended_entry() is called.
+ *
+ * E.g. if the underlying tree object has these entries:
+ *
+ *    blob    "t-1"
+ *    blob    "t-2"
+ *    tree    "t"
+ *    blob    "t=1"
+ *
+ * and the "first" asks for "t", remember that we still need to
+ * process "t-1" and "t-2" but extract "t".  After processing the
+ * entry "t" from this call, the caller will let us know by calling
+ * update_extended_entry() that we can remember "t" has been processed
+ * already.
+ */
+
+static void extended_entry_extract(struct tree_desc_x *t,
+				   struct name_entry *a,
+				   const char *first,
+				   int first_len)
+{
+	const char *path;
+	int len;
+	struct tree_desc probe;
+	struct tree_desc_skip *skip;
+
+	/*
+	 * Extract the first entry from the tree_desc, but skip the
+	 * ones that we already returned in earlier rounds.
+	 */
+	while (1) {
+		if (!t->d.size) {
+			entry_clear(a);
+			break; /* not found */
+		}
+		entry_extract(&t->d, a);
+		for (skip = t->skip; skip; skip = skip->prev)
+			if (a->path == skip->ptr)
+				break; /* found */
+		if (!skip)
+			break;
+		/* We have processed this entry already. */
+		update_tree_entry(&t->d);
+	}
+
+	if (!first || !a->path)
+		return;
+
+	/*
+	 * The caller wants "first" from this tree, or nothing.
+	 */
+	path = a->path;
+	len = tree_entry_len(a->path, a->sha1);
+	switch (check_entry_match(first, first_len, path, len)) {
+	case -1:
+		entry_clear(a);
+	case 0:
+		return;
+	default:
+		break;
+	}
+
+	/*
+	 * We need to look-ahead -- we suspect that a subtree whose
+	 * name is "first" may be hiding behind the current entry "path".
+	 */
+	probe = t->d;
+	while (probe.size) {
+		entry_extract(&probe, a);
+		path = a->path;
+		len = tree_entry_len(a->path, a->sha1);
+		switch (check_entry_match(first, first_len, path, len)) {
+		case -1:
+			entry_clear(a);
+		case 0:
+			return;
+		default:
+			update_tree_entry(&probe);
+			break;
+		}
+		/* keep looking */
+	}
+	entry_clear(a);
+}
+
+static void update_extended_entry(struct tree_desc_x *t, struct name_entry *a)
+{
+	if (t->d.entry.path == a->path) {
+		update_tree_entry(&t->d);
+	} else {
+		/* we have returned this entry early */
+		struct tree_desc_skip *skip = xmalloc(sizeof(*skip));
+		skip->ptr = a->path;
+		skip->prev = t->skip;
+		t->skip = skip;
+	}
+}
+
+static void free_extended_entry(struct tree_desc_x *t)
+{
+	struct tree_desc_skip *p, *s;
+
+	for (s = t->skip; s; s = p) {
+		p = s->prev;
+		free(s);
+	}
+}
+
 int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 {
 	int ret = 0;
 	struct name_entry *entry = xmalloc(n*sizeof(*entry));
+	int i;
+	struct tree_desc_x *tx = xcalloc(n, sizeof(*tx));
+
+	for (i = 0; i < n; i++)
+		tx[i].d = t[i];
 
 	for (;;) {
-		unsigned long mask = 0;
-		unsigned long dirmask = 0;
-		int i, last;
+		unsigned long mask, dirmask;
+		const char *first = NULL;
+		int first_len = 0;
+		struct name_entry *e;
+		int len;
 
-		last = -1;
 		for (i = 0; i < n; i++) {
-			if (!t[i].size)
+			e = entry + i;
+			extended_entry_extract(tx + i, e, NULL, 0);
+		}
+
+		/*
+		 * A tree may have "t-2" at the current location even
+		 * though it may have "t" that is a subtree behind it,
+		 * and another tree may return "t".  We want to grab
+		 * all "t" from all trees to match in such a case.
+		 */
+		for (i = 0; i < n; i++) {
+			e = entry + i;
+			if (!e->path)
 				continue;
-			entry_extract(t+i, entry+i);
-			if (last >= 0) {
-				int cmp = entry_compare(entry+i, entry+last);
-
-				/*
-				 * Is the new name bigger than the old one?
-				 * Ignore it
-				 */
-				if (cmp > 0)
+			len = tree_entry_len(e->path, e->sha1);
+			if (!first) {
+				first = e->path;
+				first_len = len;
+				continue;
+			}
+			if (name_compare(e->path, len, first, first_len) < 0) {
+				first = e->path;
+				first_len = len;
+			}
+		}
+
+		if (first) {
+			for (i = 0; i < n; i++) {
+				e = entry + i;
+				extended_entry_extract(tx + i, e, first, first_len);
+				/* Cull the ones that are not the earliest */
+				if (!e->path)
 					continue;
-				/*
-				 * Is the new name smaller than the old one?
-				 * Ignore all old ones
-				 */
-				if (cmp < 0)
-					mask = 0;
+				len = tree_entry_len(e->path, e->sha1);
+				if (name_compare(e->path, len, first, first_len))
+					entry_clear(e);
 			}
+		}
+
+		/* Now we have in entry[i] the earliest name from the trees */
+		mask = 0;
+		dirmask = 0;
+		for (i = 0; i < n; i++) {
+			if (!entry[i].path)
+				continue;
 			mask |= 1ul << i;
 			if (S_ISDIR(entry[i].mode))
 				dirmask |= 1ul << i;
-			last = i;
 		}
 		if (!mask)
 			break;
-		dirmask &= mask;
-
-		/*
-		 * Clear all the unused name-entries.
-		 */
-		for (i = 0; i < n; i++) {
-			if (mask & (1ul << i))
-				continue;
-			entry_clear(entry + i);
-		}
 		ret = info->fn(n, mask, dirmask, entry, info);
 		if (ret < 0)
 			break;
-		if (ret)
-			mask &= ret;
+		mask &= ret;
 		ret = 0;
-		for (i = 0; i < n; i++) {
+		for (i = 0; i < n; i++)
 			if (mask & (1ul << i))
-				update_tree_entry(t + i);
-		}
+				update_extended_entry(tx + i, entry + i);
 	}
 	free(entry);
+	for (i = 0; i < n; i++)
+		free_extended_entry(tx + i);
+	free(tx);
 	return ret;
 }
 
-- 
1.6.5.rc1.90.ga3b1b
