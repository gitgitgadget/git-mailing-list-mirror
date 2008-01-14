From: Junio C Hamano <gitster@pobox.com>
Subject: Re: performance problem: "git commit filename"
Date: Sun, 13 Jan 2008 17:00:10 -0800
Message-ID: <7vr6glnrvp.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org>
	<7vtzliqh3u.fsf@gitster.siamese.dyndns.org>
	<7vd4s6qal0.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801130922030.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Kristian H?gsberg <krh@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 14 02:00:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEDhA-0001Ck-F1
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 02:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbYANBA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 20:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753291AbYANBA2
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 20:00:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239AbYANBA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 20:00:26 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 187C14507;
	Sun, 13 Jan 2008 20:00:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CB0804504;
	Sun, 13 Jan 2008 20:00:20 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801130922030.2806@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 13 Jan 2008 09:24:02 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70430>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So at a minimum, you should also make ie_match_stat() set CE_UPTODATE if 
> it matches. Or something.

I've reworked the patch, and in the kernel repository, a
single-path commit after touching that path now calls 23k
lstat(2).  It used to call 46k lstat(2) after your fix.

This depends on the "index: be careful when handling long names"
patch I sent earlier.

-- >8 --
[PATCH] Avoid running lstat(2) on the same cache entry.

Aside from the lstat(2) done for work tree files, there are
quite many lstat(2) calls in refname dwimming codepath.  This
patch is not about reducing them.

 * It adds a new ce_flag, CE_UPTODATE, that is meant to mark the
   cache entries that record a regular file blob that is up to
   date in the work tree.  If somebody later walks the index and
   wants to see if the work tree has changes, they do not have
   to be checked with lstat(2) again.

 * This reduces the maximum length cached from 4k down to 2k to
   introduce the new flag.  People with an index that records
   paths longer than that needs to first commit their changes
   with the old git, discard the cache with "rm -f .git/index"
   and re-read with updated git by running "git-read-tree HEAD"
   followed by "git update-index --refresh".

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
 cache.h      |    4 +++-
 diff.c       |    4 ++++
 read-cache.c |   20 +++++++++++++++++++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 7f1457a..3e1cdf9 100644
--- a/cache.h
+++ b/cache.h
@@ -108,7 +108,8 @@ struct cache_entry {
 	char name[FLEX_ARRAY]; /* more */
 };
 
-#define CE_NAMEMASK  (0x0fff)
+#define CE_NAMEMASK  (0x07ff)
+#define CE_UPTODATE  (0x0800)
 #define CE_STAGEMASK (0x3000)
 #define CE_UPDATE    (0x4000)
 #define CE_VALID     (0x8000)
@@ -129,6 +130,7 @@ static inline size_t ce_namelen(const struct cache_entry *ce)
 	return strlen(ce->name + CE_NAMEMASK) + CE_NAMEMASK;
 }
 
+#define ce_uptodate(ce) (!!((ce)->ce_flags & htons(CE_UPTODATE)))
 #define ce_size(ce) cache_entry_size(ce_namelen(ce))
 #define ce_stage(ce) ((CE_STAGEMASK & ntohs((ce)->ce_flags)) >> CE_STAGESHIFT)
 
diff --git a/diff.c b/diff.c
index b18c140..62d0c06 100644
--- a/diff.c
+++ b/diff.c
@@ -1510,6 +1510,10 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	if (pos < 0)
 		return 0;
 	ce = active_cache[pos];
+
+	if (ce_uptodate(ce))
+		return 1;
+
 	if ((lstat(name, &st) < 0) ||
 	    !S_ISREG(st.st_mode) || /* careful! */
 	    ce_match_stat(ce, &st, 0) ||
diff --git a/read-cache.c b/read-cache.c
index 928f49b..6e40e37 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -44,6 +44,9 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 
 	if (assume_unchanged)
 		ce->ce_flags |= htons(CE_VALID);
+
+	if (S_ISREG(st->st_mode))
+		ce->ce_flags |= htons(CE_UPTODATE);
 }
 
 static int ce_compare_data(struct cache_entry *ce, struct stat *st)
@@ -428,6 +431,7 @@ int add_file_to_index_with_stat(struct index_state *istate,
 	    !ie_match_stat(istate, istate->cache[pos], st, ce_option)) {
 		/* Nothing changed, really */
 		free(ce);
+		istate->cache[pos]->ce_flags |= htons(CE_UPTODATE);
 		return 0;
 	}
 
@@ -804,6 +808,9 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	int changed, size;
 	int ignore_valid = options & CE_MATCH_IGNORE_VALID;
 
+	if (ce_uptodate(ce))
+		return ce;
+
 	if (lstat(ce->name, &st) < 0) {
 		if (err)
 			*err = errno;
@@ -822,8 +829,15 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 		if (ignore_valid && assume_unchanged &&
 		    !(ce->ce_flags & htons(CE_VALID)))
 			; /* mark this one VALID again */
-		else
+		else {
+			/*
+			 * We do not mark the index itself "modified"
+			 * because CE_UPTODATE flag is in-core only;
+			 * we are not going to write this change out.
+			 */
+			ce->ce_flags |= htons(CE_UPTODATE);
 			return ce;
+		}
 	}
 
 	if (ie_modified(istate, ce, &st, options)) {
@@ -1180,13 +1194,17 @@ int write_index(struct index_state *istate, int newfd)
 
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
+		unsigned short ce_flags;
 		if (!ce->ce_mode)
 			continue;
 		if (istate->timestamp &&
 		    istate->timestamp <= ntohl(ce->ce_mtime.sec))
 			ce_smudge_racily_clean_entry(ce);
+		ce_flags = ce->ce_flags;
+		ce->ce_flags &= htons(~(CE_UPDATE | CE_UPTODATE));
 		if (ce_write(&c, newfd, ce, ce_size(ce)) < 0)
 			return -1;
+		ce->ce_flags = ce_flags;
 	}
 
 	/* Write extension data here */
-- 
1.5.4.rc3.4.g16335
