From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Avoid running lstat(2) on the same cache entry.
Date: Fri, 18 Jan 2008 23:45:24 -0800
Message-ID: <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 19 08:46:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JG8Ou-0000mf-6d
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 08:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbYASHpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 02:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbYASHpb
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 02:45:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbYASHpa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 02:45:30 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E7835526B;
	Sat, 19 Jan 2008 02:45:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F2B5A526A;
	Sat, 19 Jan 2008 02:45:25 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 18 Jan 2008 19:25:58 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71084>

Aside from the lstat(2) done for work tree files, there are
quite many lstat(2) calls in refname dwimming codepath.  This
patch is not about reducing them.

 * It adds a new ce_flag, CE_UPTODATE, that is meant to mark the
   cache entries that record a regular file blob that is up to
   date in the work tree.  If somebody later walks the index and
   wants to see if the work tree has changes, they do not have
   to be checked with lstat(2) again.

 * fill_stat_cache_info() marks the cache entry it just added
   with CE_UPTODATE.  This has the effect of marking the paths
   we write out of the index and lstat(2) immediately as "no
   need to lstat -- we know it is up-to-date", from quite a lot
   fo callers:

    - git-apply --index
    - git-update-index
    - git-checkout-index
    - git-add (uses add_file_to_index())
    - git-commit (ditto)
    - git-mv (ditto)

 * refresh_cache_ent() also marks the cache entry that are clean
   with CE_UPTODATE.

 * write_index is changed not to write CE_UPTODATE out to the
   index file, because CE_UPTODATE is meant to be transient only
   in core.  For the same reason, CE_UPDATE is not written to
   prevent an accident from happening.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Again, this is a rebase on top of your "Updated in-memory
   index".  "echo >>Makefile && git commit -m test Makefile" in
   the kernel repository does 23k lstat(2) with this patch, 46k
   without.

 cache.h      |    3 +++
 diff.c       |   23 ++++++++++++++---------
 read-cache.c |   16 +++++++++++++++-
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index 9eaffde..3a47cdc 100644
--- a/cache.h
+++ b/cache.h
@@ -130,6 +130,7 @@ struct cache_entry {
 /* In-memory only */
 #define CE_UPDATE    (0x10000)
 #define CE_REMOVE    (0x20000)
+#define CE_UPTODATE  (0x40000)
 
 static inline unsigned create_ce_flags(size_t len, unsigned stage)
 {
@@ -149,6 +150,8 @@ static inline size_t ce_namelen(const struct cache_entry *ce)
 #define ce_size(ce) cache_entry_size(ce_namelen(ce))
 #define ondisk_ce_size(ce) ondisk_cache_entry_size(ce_namelen(ce))
 #define ce_stage(ce) ((CE_STAGEMASK & (ce)->ce_flags) >> CE_STAGESHIFT)
+#define ce_uptodate(ce) ((ce)->ce_flags & CE_UPTODATE)
+#define ce_mark_uptodate(ce) ((ce)->ce_flags |= CE_UPTODATE)
 
 #define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
 static inline unsigned int create_ce_mode(unsigned int mode)
diff --git a/diff.c b/diff.c
index 5b8afdc..d464fe3 100644
--- a/diff.c
+++ b/diff.c
@@ -1510,17 +1510,22 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	if (pos < 0)
 		return 0;
 	ce = active_cache[pos];
-	if ((lstat(name, &st) < 0) ||
-	    !S_ISREG(st.st_mode) || /* careful! */
-	    ce_match_stat(ce, &st, 0) ||
-	    hashcmp(sha1, ce->sha1))
+
+	/*
+	 * This is not the sha1 we are looking for, or
+	 * unreusable because it is not a regular file.
+	 */
+	if (hashcmp(sha1, ce->sha1) || !S_ISREG(ce->ce_mode))
 		return 0;
-	/* we return 1 only when we can stat, it is a regular file,
-	 * stat information matches, and sha1 recorded in the cache
-	 * matches.  I.e. we know the file in the work tree really is
-	 * the same as the <name, sha1> pair.
+
+	/*
+	 * If ce matches the file in the work tree, we can reuse it.
 	 */
-	return 1;
+	if (ce_uptodate(ce) ||
+	    (!lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
+		return 1;
+
+	return 0;
 }
 
 static int populate_from_stdin(struct diff_filespec *s)
diff --git a/read-cache.c b/read-cache.c
index f98f57c..6165885 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -40,6 +40,9 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 
 	if (assume_unchanged)
 		ce->ce_flags |= CE_VALID;
+
+	if (S_ISREG(st->st_mode))
+		ce_mark_uptodate(ce);
 }
 
 static int ce_compare_data(struct cache_entry *ce, struct stat *st)
@@ -411,6 +414,7 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 	    !ie_match_stat(istate, istate->cache[pos], &st, ce_option)) {
 		/* Nothing changed, really */
 		free(ce);
+		ce_mark_uptodate(istate->cache[pos]);
 		return 0;
 	}
 
@@ -778,6 +782,9 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	int changed, size;
 	int ignore_valid = options & CE_MATCH_IGNORE_VALID;
 
+	if (ce_uptodate(ce))
+		return ce;
+
 	if (lstat(ce->name, &st) < 0) {
 		if (err)
 			*err = errno;
@@ -796,8 +803,15 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 		if (ignore_valid && assume_unchanged &&
 		    !(ce->ce_flags & CE_VALID))
 			; /* mark this one VALID again */
-		else
+		else {
+			/*
+			 * We do not mark the index itself "modified"
+			 * because CE_UPTODATE flag is in-core only;
+			 * we are not going to write this change out.
+			 */
+			ce_mark_uptodate(ce);
 			return ce;
+		}
 	}
 
 	if (ie_modified(istate, ce, &st, options)) {
-- 
1.5.4.rc3.37.gfdcf3
