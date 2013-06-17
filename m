From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] unpack-trees: don't shift conflicts left and right
Date: Mon, 17 Jun 2013 22:30:12 +0200
Message-ID: <51BF71D4.402@lsrfire.ath.cx>
References: <1371339883-22775-1-git-send-email-rene.scharfe@lsrfire.ath.cx> <7va9mqlvpu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 22:30:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uog4L-0005Fz-Mb
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 22:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723Ab3FQUaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 16:30:25 -0400
Received: from india601.server4you.de ([85.25.151.105]:43841 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab3FQUaY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 16:30:24 -0400
Received: from [192.168.2.102] (p4FFDAFF1.dip0.t-ipconnect.de [79.253.175.241])
	by india601.server4you.de (Postfix) with ESMTPSA id 0C016108;
	Mon, 17 Jun 2013 22:30:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7va9mqlvpu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228112>

Am 16.06.2013 02:56, schrieb Junio C Hamano:
> One thing renaming df_conficts to conflicts really proves is that
> this field is not used by the traverse_trees machinery at all.
> 
> Before this patch, the bits in conflicts (now df_conflicts) mask had
> the semantics that is not consistent with the dirmask/mask the
> tree-walk machinery uses to communicate with its callers and
> callbacks.  Everything in tree-walk.[ch] is about "walk N trees",
> and bit 0 of dirmask and mask always means the first tree, not
> "first tree, or in index if the callback is doing a merge", which
> is used in the conflicts field before this patch.

Right.

> I think the true source of the confusion is that the "conflicts"
> field does not logically belong there.  It is not needed in the
> general "walk N trees" machinery.

NB: The only other caller of traverse_trees is git merge-tree.

> The information is only useful for the unpack_trees callback, and
> "info->data" is a more appropriate place to hang such a callback
> specific data.
> 
> Perhaps we should use info->data field to point at
> 
> 	struct {
>          	struct unpack_trees_options *o;
>          	unsigned long df_conflict;
> 	};
> 
> and get rid of info->conflicts field?

Here's a patch that does so, but it complicates matters quite a bit.
Did I miss anything (or rather: add too much)?

---
 tree-walk.h    |  1 -
 unpack-trees.c | 38 +++++++++++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/tree-walk.h b/tree-walk.h
index ae04b64..4876695 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -46,7 +46,6 @@ struct traverse_info {
 	int pathlen;
 	struct pathspec *pathspec;
 
-	unsigned long df_conflicts;
 	traverse_callback_t fn;
 	void *data;
 	int show_all_errors;
diff --git a/unpack-trees.c b/unpack-trees.c
index b27f2a6..1c1b4de 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -416,11 +416,17 @@ static int unpack_index_entry(struct cache_entry *ce,
 	return ret;
 }
 
+struct unpack_callback_info {
+	struct unpack_trees_options *options;
+	unsigned long df_conflicts;
+};
+
 static int find_cache_pos(struct traverse_info *, const struct name_entry *);
 
 static void restore_cache_bottom(struct traverse_info *info, int bottom)
 {
-	struct unpack_trees_options *o = info->data;
+	struct unpack_callback_info *uci = info->data;
+	struct unpack_trees_options *o = uci->options;
 
 	if (o->diff_index_cached)
 		return;
@@ -429,7 +435,8 @@ static void restore_cache_bottom(struct traverse_info *info, int bottom)
 
 static int switch_cache_bottom(struct traverse_info *info)
 {
-	struct unpack_trees_options *o = info->data;
+	struct unpack_callback_info *uci = info->data;
+	struct unpack_trees_options *o = uci->options;
 	int ret, pos;
 
 	if (o->diff_index_cached)
@@ -452,9 +459,14 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	int i, ret, bottom;
 	struct tree_desc t[MAX_UNPACK_TREES];
 	void *buf[MAX_UNPACK_TREES];
+	struct unpack_callback_info *uci = info->data;
+	struct unpack_callback_info newuci;
 	struct traverse_info newinfo;
 	struct name_entry *p;
 
+	newuci = *uci;
+	newuci.df_conflicts |= df_conflicts;
+
 	p = names;
 	while (!p->mode)
 		p++;
@@ -464,7 +476,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	newinfo.pathspec = info->pathspec;
 	newinfo.name = *p;
 	newinfo.pathlen += tree_entry_len(p) + 1;
-	newinfo.df_conflicts |= df_conflicts;
+	newinfo.data = &newuci;
 
 	for (i = 0; i < n; i++, dirmask >>= 1) {
 		const unsigned char *sha1 = NULL;
@@ -564,8 +576,9 @@ static int unpack_nondirectories(int n, unsigned long mask,
 				 const struct traverse_info *info)
 {
 	int i;
-	struct unpack_trees_options *o = info->data;
-	unsigned long conflicts = info->df_conflicts | dirmask;
+	struct unpack_callback_info *uci = info->data;
+	struct unpack_trees_options *o = uci->options;
+	unsigned long conflicts = uci->df_conflicts | dirmask;
 
 	/* Do we have *only* directories? Nothing to do */
 	if (mask == dirmask && !src[0])
@@ -644,7 +657,8 @@ static int find_cache_pos(struct traverse_info *info,
 			  const struct name_entry *p)
 {
 	int pos;
-	struct unpack_trees_options *o = info->data;
+	struct unpack_callback_info *uci = info->data;
+	struct unpack_trees_options *o = uci->options;
 	struct index_state *index = o->src_index;
 	int pfxlen = info->pathlen;
 	int p_len = tree_entry_len(p);
@@ -699,7 +713,8 @@ static struct cache_entry *find_cache_entry(struct traverse_info *info,
 					    const struct name_entry *p)
 {
 	int pos = find_cache_pos(info, p);
-	struct unpack_trees_options *o = info->data;
+	struct unpack_callback_info *uci = info->data;
+	struct unpack_trees_options *o = uci->options;
 
 	if (0 <= pos)
 		return o->src_index->cache[pos];
@@ -742,7 +757,8 @@ static void debug_unpack_callback(int n,
 static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
 {
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
-	struct unpack_trees_options *o = info->data;
+	struct unpack_callback_info *uci = info->data;
+	struct unpack_trees_options *o = uci->options;
 	const struct name_entry *p = names;
 
 	/* Find first entry with a real name (we could use "mask" too) */
@@ -1054,11 +1070,15 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	if (len) {
 		const char *prefix = o->prefix ? o->prefix : "";
+		struct unpack_callback_info uci;
 		struct traverse_info info;
 
+		memset(&uci, 0, sizeof(uci));
+		uci.options = o;
+
 		setup_traverse_info(&info, prefix);
 		info.fn = unpack_callback;
-		info.data = o;
+		info.data = &uci;
 		info.show_all_errors = o->show_all_errors;
 		info.pathspec = o->pathspec;
 
