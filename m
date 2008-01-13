From: Junio C Hamano <gitster@pobox.com>
Subject: Re: performance problem: "git commit filename"
Date: Sun, 13 Jan 2008 02:33:15 -0800
Message-ID: <7vd4s6qal0.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org>
	<7vtzliqh3u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Kristian H?gsberg <krh@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 13 11:33:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE0A7-000309-FC
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 11:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbYAMKd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 05:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbYAMKd1
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 05:33:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63362 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbYAMKdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 05:33:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FD063BCE;
	Sun, 13 Jan 2008 05:33:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 720B13BCD;
	Sun, 13 Jan 2008 05:33:19 -0500 (EST)
In-Reply-To: <7vtzliqh3u.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 13 Jan 2008 00:12:21 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70376>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> HOWEVER. This was just a quick hack, and while it all looks sane, this is 
>> some damn core code. Somebody else should double- and triple-check this.
>
> Double-checked.  The patch looks sane.
>
>> [ That 4x lstat thing bothers me. I think we should add a flag to the 
>>   index saying "we checked this once already, it's clean", so that if we 
>>   do multiple passes over the index, we can still do just a single lstat() 
>>   on just the first pass. But that's a separate issue.
>
> I've thought about this in a different context before, but it
> seemed quite tricky, as some codepaths in more complex commands
> (commit being one of them) tend to use the cache and discard to
> use it for different purpose (like creating temporary index and
> then reading the real index).  Besides, I had an impression that
> we ran out of the bits of ce_flags in the cache entry, although
> we could shorten the maximum path we support from 4k down to 2k
> bytes.  I'll have to think about this a bit more.

Aside from the lstat(2) done for work tree files, there are
quite many lstat(2) calls in refname dwimming codepath.  I am
not currently looking into reducing them.

Some observations.

 * In the partial commit codepath, we run one file_exists() and
   then one add_file_to_index(), each of which has lstat(2) on
   the same pathname, for the paths to be committed.  This can
   be reduced to one trivially by changing the calling
   convention of add_file_to_index().  This is done in order to
   build the temporary index file to be written out as a tree
   for committing (and the index file needs to be written to be
   shown to the pre-commit hook).

 * Then refresh_cache_ent(), which has one lstat(2), is called
   for everybody in the temporary index, in order to refresh the
   temporary index.  Again this cannot be avoided because we
   promise to show the pre-commit hook a refreshed index.

 * Then we run file_exists() and add_file_to_index() to update
   the real index.

 * And refresh_cache_ent() is run for everybody in the real
   index.

 * The final diffstat phase runs lstat(2) from
   reuse_worktree_file() codepath to see if the work tree is up
   to date, and read from the work tree files instead of having
   to explode them from the object store.

The attached is a quick and dirty hack which may or may not
help.  It all looks sane, this also is some core code, and meant
only for discussion and not application.

 * It adds a new ce_flag, CE_UPTODATE, that is meant to mark the
   cache entries that record a regular file blob that is up to
   date in the work tree.

 * I had to reduce the maximum length of allowed pathname from
   4k down to 2k for the above.  Incidentally I noticed that we
   do not check the length of pathname does not exceed what we
   can express with CE_NAMEMASK, which we may want to fix (and
   make it barf if somebody tries to add too long a path)
   independently from this issue.  A low hanging fruit for
   janitors -- hint, hint.

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

 * write_index is changed not to write CE_UPTODATE out to the
   index file, because CE_UPTODATE is meant to be transient only
   in core.  For the same reason, CE_UPDATE is not written to
   prevent an accident from happening.

The fact that we write out a temporary index and then rebuild
the real index means CE_UPTODATE flag we populate in the
temporary index is lost and we still need to lstat(2) while
building the real index, which is a bit unfortunate.  I suspect
that we can use the one-way merge to reset the index when
building the real index after we are done building the temporary
index, instead of discarding the in-core temporary index and
re-reading the real index.

---
 cache.h      |    3 ++-
 diff.c       |    4 ++++
 read-cache.c |   10 ++++++++++
 3 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 39331c2..9b950fc 100644
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
diff --git a/diff.c b/diff.c
index b18c140..41847ae 100644
--- a/diff.c
+++ b/diff.c
@@ -1510,6 +1510,10 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	if (pos < 0)
 		return 0;
 	ce = active_cache[pos];
+
+	if (ce->ce_flags & htons(CE_UPTODATE))
+		return 1;
+
 	if ((lstat(name, &st) < 0) ||
 	    !S_ISREG(st.st_mode) || /* careful! */
 	    ce_match_stat(ce, &st, 0) ||
diff --git a/read-cache.c b/read-cache.c
index 7db5588..3a90db1 100644
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
@@ -794,6 +797,9 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	int changed, size;
 	int ignore_valid = options & CE_MATCH_IGNORE_VALID;
 
+	if (ce->ce_flags & htons(CE_UPTODATE))
+		return ce;
+
 	if (lstat(ce->name, &st) < 0) {
 		if (err)
 			*err = errno;
@@ -1170,13 +1176,17 @@ int write_index(struct index_state *istate, int newfd)
 
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
