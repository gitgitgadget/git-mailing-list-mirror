From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/12] for_each_ref: load all loose refs before packed refs
Date: Tue, 11 Jun 2013 23:48:31 +0200
Message-ID: <1370987312-6761-12-git-send-email-mhagger@alum.mit.edu>
References: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 23:49:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWRW-00043f-5k
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 23:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756601Ab3FKVtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 17:49:20 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:51521 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755370Ab3FKVtK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 17:49:10 -0400
X-AuditID: 12074412-b7f656d00000102f-32-51b79b55f2c4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 66.83.04143.55B97B15; Tue, 11 Jun 2013 17:49:09 -0400 (EDT)
Received: from michael.fritz.box (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BLmbj1015717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 17:49:08 -0400
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqBs6e3ugwddGPYuuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MDqwef99/YPK49PI7m8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ3RvCe1YIVqxd9105gaGO/IdjFyckgImEg8XH6SHcIWk7hwbz1bFyMXh5DAZUaJP639
	LCAJIYELTBK7ZzGC2GwCuhKLepqZQGwRATWJiW2HWEAamAXaGSXeNe9jBkkIC3hLnGq4BDaV
	RUBV4traE2CDeAVcJC7fOcMCsU1O4v2dXWA2J1B84+bNzBDLnCW+9zQxTmDkXcDIsIpRLjGn
	NFc3NzEzpzg1Wbc4OTEvL7VI10wvN7NELzWldBMjJKSEdjCuPyl3iFGAg1GJh/eA2fZAIdbE
	suLK3EOMkhxMSqK8bNOAQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4dXOBcrwpiZVVqUX5MClp
	DhYlcd6fi9X9hATSE0tSs1NTC1KLYLIyHBxKErx3ZwI1ChalpqdWpGXmlCCkmTg4QQQXyAYe
	oA18s0A2FBck5hZnpkMUnWJUlBLnfQQyQQAkkVGaBzcAFv2vGMWB/hHmvQhSxQNMHHDdr4AG
	MwENLsoAG1ySiJCSamB0/mVYuGq2VOms9B+1HwqiEu9nK81y269xWqBr9a0VOVcOrstVPJnL
	enSmNovQbjnul/725qGWiZMOOX09XtY7u/fXllDtB6b3G9Kab4oXVb9KOWZ7nbvkaNwMLvuI
	e7JG5kvyctNlsqaXmWkYHgjI/bboYI+EZtuNayc9Dn5sWB+1rzWUW1yJpTgj0VCL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227528>

From: Jeff King <peff@peff.net>

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

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Ditto.

 refs.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 64f72ab..aa4641b 100644
--- a/refs.c
+++ b/refs.c
@@ -746,6 +746,21 @@ static int do_for_each_entry_in_dirs(struct ref_dir *dir1,
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
@@ -1600,15 +1615,31 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 static int do_for_each_entry(struct ref_cache *refs, const char *base,
 			     each_ref_entry_fn fn, void *cb_data)
 {
-	struct packed_ref_cache *packed_ref_cache = get_packed_ref_cache(refs);
-	struct ref_dir *packed_dir = get_packed_ref_dir(packed_ref_cache);
-	struct ref_dir *loose_dir = get_loose_refs(refs);
+	struct packed_ref_cache *packed_ref_cache;
+	struct ref_dir *loose_dir;
+	struct ref_dir *packed_dir;
 	int retval = 0;
 
+	/*
+	 * We must make sure that all loose refs are read before accessing the
+	 * packed-refs file; this avoids a race condition in which loose refs
+	 * are migrated to the packed-refs file by a simultaneous process, but
+	 * our in-memory view is from before the migration. get_packed_ref_cache()
+	 * takes care of making sure our view is up to date with what is on
+	 * disk.
+	 */
+	loose_dir = get_loose_refs(refs);
+	if (base && *base) {
+		loose_dir = find_containing_dir(loose_dir, base, 0);
+	}
+	if (loose_dir)
+		prime_ref_dir(loose_dir);
+
+	packed_ref_cache = get_packed_ref_cache(refs);
 	acquire_packed_ref_cache(packed_ref_cache);
+	packed_dir = get_packed_ref_dir(packed_ref_cache);
 	if (base && *base) {
 		packed_dir = find_containing_dir(packed_dir, base, 0);
-		loose_dir = find_containing_dir(loose_dir, base, 0);
 	}
 
 	if (packed_dir && loose_dir) {
-- 
1.8.3
