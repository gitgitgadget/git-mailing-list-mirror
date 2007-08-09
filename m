From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 09 Aug 2007 13:42:50 -0700
Message-ID: <7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
References: <20070809163026.GD568@mbox.bz>
	<alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
	<7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: moe <moe-git@mbox.bz>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 22:43:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJEqR-0002AP-Gc
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 22:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756974AbXHIUmx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 16:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756582AbXHIUmx
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 16:42:53 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:33359 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173AbXHIUmw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 16:42:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070809204251.TSXI23215.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 9 Aug 2007 16:42:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Zwiq1X0021kojtg0000000; Thu, 09 Aug 2007 16:42:51 -0400
In-Reply-To: <7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 09 Aug 2007 11:11:38 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55472>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> In fact, I'm almost sure I will *not* have time today.
>>
>> Anyway, the really trivial (and ugly) fix is to handle the cases of adding 
>> _independent_ stages to the index (which is the case for both "git 
>> diff-index" and "git read-tree -m") differently...
>> ...
>> Sadly, this is an area that is almost exclusively mine and Junio's. I'd 
>> love for somebody else to get their feet wet,...
>
> I hopefully have some time this evening to look into this, if
> not earlier.

So here is what I did during the lunch break.

wt-status has two calls to run_diff_index() to do the equivalent
of "git diff --cached".  This codepath is the sole caller of
read_tree(), and before calling read_tree(), vacates stage #1
entries, and reads tree contents to the index at stage #1,
without any funky "merge" magic.

This changes read_tree() to first make sure that there is not
any existing cache entries at specified stage (from the above
description, you can see this is not strictly needed if we are
only interested in supporting existing callers), and if that is
the case, it runs add_cache_entry() with ADD_CACHE_JUST_APPEND
flag (new), and then sort the resulting cache using qsort().

add_cache_entry() has been taught to omit all the checks such as
"Does this path already exist?  Does adding this path remove
other existing entries because it turns a directory to a file?"
and appends the given cache entry straight at the end of the
active cache.

The appending and sorting at the end destroys cache-tree
optimization, but we are not writing the resulting index out
anyway, so that is not a problem.

I do not know if this "fixes" the performance problem or not (I
do not have that much time during the day), so I would not call
this a "fix" yet, but at least the _change_ looks trivially
correct, and passes all the existing tests.

Interested parties may want to try it and see if it shifts the
bottleneck.

---

 cache.h      |    1 +
 read-cache.c |   20 +++++++++++++++-
 tree.c       |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index e97af18..e5276e6 100644
--- a/cache.h
+++ b/cache.h
@@ -258,6 +258,7 @@ extern int index_name_pos(struct index_state *, const char *name, int namelen);
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
+#define ADD_CACHE_JUST_APPEND 8		/* Append only; tree.c::read_tree() */
 extern int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
 extern struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
 extern int remove_index_entry_at(struct index_state *, int pos);
diff --git a/read-cache.c b/read-cache.c
index e060392..865369d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -665,7 +665,7 @@ static int check_file_directory_conflict(struct index_state *istate,
 	return retval + has_dir_name(istate, ce, pos, ok_to_replace);
 }
 
-int add_index_entry(struct index_state *istate, struct cache_entry *ce, int option)
+static int add_index_entry_with_check(struct index_state *istate, struct cache_entry *ce, int option)
 {
 	int pos;
 	int ok_to_add = option & ADD_CACHE_OK_TO_ADD;
@@ -707,6 +707,22 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
 		pos = index_name_pos(istate, ce->name, ntohs(ce->ce_flags));
 		pos = -pos-1;
 	}
+	return pos + 1;
+}
+
+int add_index_entry(struct index_state *istate, struct cache_entry *ce, int option)
+{
+	int pos;
+
+	if (option & ADD_CACHE_JUST_APPEND)
+		pos = istate->cache_nr;
+	else {
+		int ret;
+		ret = add_index_entry_with_check(istate, ce, option);
+		if (ret <= 0)
+			return ret;
+		pos = ret - 1;
+	}
 
 	/* Make sure the array is big enough .. */
 	if (istate->cache_nr == istate->cache_alloc) {
@@ -717,7 +733,7 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
 
 	/* Add it in.. */
 	istate->cache_nr++;
-	if (istate->cache_nr > pos)
+	if (istate->cache_nr > pos + 1)
 		memmove(istate->cache + pos + 1,
 			istate->cache + pos,
 			(istate->cache_nr - pos - 1) * sizeof(ce));
diff --git a/tree.c b/tree.c
index 04fe653..8c0819f 100644
--- a/tree.c
+++ b/tree.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "cache-tree.h"
 #include "tree.h"
 #include "blob.h"
 #include "commit.h"
@@ -7,7 +8,7 @@
 
 const char *tree_type = "tree";
 
-static int read_one_entry(const unsigned char *sha1, const char *base, int baselen, const char *pathname, unsigned mode, int stage)
+static int read_one_entry_opt(const unsigned char *sha1, const char *base, int baselen, const char *pathname, unsigned mode, int stage, int opt)
 {
 	int len;
 	unsigned int size;
@@ -25,7 +26,23 @@ static int read_one_entry(const unsigned char *sha1, const char *base, int basel
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len+1);
 	hashcpy(ce->sha1, sha1);
-	return add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
+	return add_cache_entry(ce, opt);
+}
+
+static int read_one_entry(const unsigned char *sha1, const char *base, int baselen, const char *pathname, unsigned mode, int stage)
+{
+	return read_one_entry_opt(sha1, base, baselen, pathname, mode, stage,
+				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
+}
+
+/*
+ * This is used when the caller knows there is no existing entries at
+ * the stage that will conflict with the entry being added.
+ */
+static int read_one_entry_quick(const unsigned char *sha1, const char *base, int baselen, const char *pathname, unsigned mode, int stage)
+{
+	return read_one_entry_opt(sha1, base, baselen, pathname, mode, stage,
+				  ADD_CACHE_JUST_APPEND);
 }
 
 static int match_tree_entry(const char *base, int baselen, const char *path, unsigned int mode, const char **paths)
@@ -119,9 +136,55 @@ int read_tree_recursive(struct tree *tree,
 	return 0;
 }
 
+static int cmp_cache_name_compare(const void *a_, const void *b_)
+{
+	const struct cache_entry *ce1, *ce2;
+
+	ce1 = *((const struct cache_entry **)a_);
+	ce2 = *((const struct cache_entry **)b_);
+	return cache_name_compare(ce1->name, ntohs(ce1->ce_flags),
+				  ce2->name, ntohs(ce2->ce_flags));
+}
+
 int read_tree(struct tree *tree, int stage, const char **match)
 {
-	return read_tree_recursive(tree, "", 0, stage, match, read_one_entry);
+	read_tree_fn_t fn = NULL;
+	int i, err;
+
+	/*
+	 * Currently the only existing callers of this function all
+	 * call it with stage=1 and after making sure there is nothing
+	 * at that stage; we could always use read_one_entry_quick().
+	 *
+	 * But when we decide to straighten out git-read-tree not to
+	 * use unpack_trees() in some cases, this will probably start
+	 * to matter.
+	 */
+
+	/*
+	 * See if we have cache entry at the stage.  If so,
+	 * do it the original slow way, otherwise, append and then
+	 * sort at the end.
+	 */
+	for (i = 0; !fn && i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		if (ce_stage(ce) == stage)
+			fn = read_one_entry;
+	}
+
+	if (!fn)
+		fn = read_one_entry_quick;
+	err = read_tree_recursive(tree, "", 0, stage, match, fn);
+	if (fn == read_one_entry || err)
+		return err;
+
+	/*
+	 * Sort the cache entry -- we need to nuke the cache tree, though.
+	 */
+	cache_tree_free(&active_cache_tree);
+	qsort(active_cache, active_nr, sizeof(active_cache[0]),
+	      cmp_cache_name_compare);
+	return 0;
 }
 
 struct tree *lookup_tree(const unsigned char *sha1)
