From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] for_each_ref: load all loose refs before packed refs
Date: Mon, 6 May 2013 22:51:04 -0400
Message-ID: <20130507025103.GD22940@sigill.intra.peff.net>
References: <20130507023610.GA22053@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 04:51:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZXzl-0005FM-G7
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 04:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760276Ab3EGCvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 22:51:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:43739 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758590Ab3EGCvH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 22:51:07 -0400
Received: (qmail 14919 invoked by uid 102); 7 May 2013 02:51:26 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 May 2013 21:51:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2013 22:51:04 -0400
Content-Disposition: inline
In-Reply-To: <20130507023610.GA22053@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223528>

If we are iterating through the refs using for_each_ref (or
any of its sister functions), we can get into a race
condition with a simultaneous "pack-refs --prune" that looks
like this:

  0. We have a large number of loose refs, and a few packed
     refs. refs/heads/z/foo is loose, with no matching entry
     in the packed-refs file.

  1. Process A starts iterating through the refs. It loads
     the packed-refs file from disk, then starts lazily
     traversing through the loose ref directories.

  2. Process B, running "pack-refs --prune", writes out the
     new packed-refs file. It then deletes the newly packed
     refs, including refs/heads/z/foo.

  3. Meanwhile, process A has finally gotten to
     refs/heads/z (it traverses alphabetically). It
     descends, but finds nothing there.  It checks its
     cached view of the packed-refs file, but it does not
     mention anything in "refs/heads/z/" at all (it predates
     the new file written by B in step 2).

The traversal completes successfully without mentioning
refs/heads/z/foo at all (the name, of course, isn't
important; but the more refs you have and the farther down
the alphabetical list a ref is, the more likely it is to hit
the race). If refs/heads/z/foo did exist in the packed refs
file at state 0, we would see an entry for it, but it would
show whatever sha1 the ref had the last time it was packed
(which could be an arbitrarily long time ago).

This can be especially dangerous when process A is "git
prune", as it means our set of reachable tips will be
incomplete, and we may erroneously prune objects reachable
from that tip (the same thing can happen if "repack -ad" is
used, as it simply drops unreachable objects that are
packed).

This patch solves it by loading all of the loose refs for
our traversal into our in-memory cache, and then refreshing
the packed-refs cache. Because a pack-refs writer will
always put the new packed-refs file into place before
starting the prune, we know that any loose refs we fail to
see will either truly be missing, or will have already been
put in the packed-refs file by the time we refresh.

Signed-off-by: Jeff King <peff@peff.net>
---
So this cache-priming is ugly, but I don't think it will have a
performance impact, as it his hitting only directories and
files that we were about to see in a second anyway during
the real traversal. The only difference is that there is a
slight latency before we would start producing any output,
as we read the whole loose refs tree (well, the part we are
interested for this call) before processing any refs.

In theory we could do our lazy walk, and then at the end
double-check that packed-refs had not changed. But if it
does change, we couldn't output any newly found refs, then;
they would be out of sorted order. The only thing we could
do is die().  Which might be OK, and is certainly preferable
to silently dropping a ref and indicating that we processed
the whole list. But I think the latency is probably not that
big a deal.

 refs.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 6afe8cc..c127baf 100644
--- a/refs.c
+++ b/refs.c
@@ -641,6 +641,21 @@ static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
 }
 
 /*
+ * Load all of the refs from the dir into our in-memory cache. The hard work
+ * of loading loose refs is done by get_ref_dir(), so we just need to recurse
+ * through all of the sub-directories. We do not even need to care about
+ * sorting, as traversal order does not matter to us.
+ */
+static void prime_ref_dir(struct ref_dir *dir)
+{
+	int i;
+	for (i = 0; i < dir->nr; i++) {
+		struct ref_entry *entry = dir->entries[i];
+		if (entry->flag & REF_DIR)
+			prime_ref_dir(get_ref_dir(entry));
+	}
+}
+/*
  * Return true iff refname1 and refname2 conflict with each other.
  * Two reference names conflict if one of them exactly matches the
  * leading components of the other; e.g., "foo/bar" conflicts with
@@ -1351,14 +1366,27 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 			   int trim, int flags, void *cb_data)
 {
 	struct ref_cache *refs = get_ref_cache(submodule);
-	struct ref_dir *packed_dir = get_packed_refs(refs);
-	struct ref_dir *loose_dir = get_loose_refs(refs);
+	struct ref_dir *packed_dir;
+	struct ref_dir *loose_dir;
 	int retval = 0;
 
-	if (base && *base) {
-		packed_dir = find_containing_dir(packed_dir, base, 0);
+	/*
+	 * We must make sure that all loose refs are read before accessing the
+	 * packed-refs file; this avoids a race condition in which loose refs
+	 * are migrated to the packed-refs file by a simultaneous process, but
+	 * our in-memory view is from before the migration. get_packed_refs()
+	 * takes care of making sure our view is up to date with what is on
+	 * disk.
+	 */
+	loose_dir = get_loose_refs(refs);
+	if (base && *base)
 		loose_dir = find_containing_dir(loose_dir, base, 0);
-	}
+	if (loose_dir)
+		prime_ref_dir(loose_dir);
+
+	packed_dir = get_packed_refs(refs);
+	if (base && *base)
+		packed_dir = find_containing_dir(packed_dir, base, 0);
 
 	if (packed_dir && loose_dir) {
 		sort_ref_dir(packed_dir);
-- 
1.8.3.rc1.2.g12db477
