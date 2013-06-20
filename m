From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 11/12] for_each_ref: load all loose refs before packed refs
Date: Thu, 20 Jun 2013 10:37:53 +0200
Message-ID: <1371717474-28942-12-git-send-email-mhagger@alum.mit.edu>
References: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 10:38:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpaOA-00075w-S7
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 10:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085Ab3FTIid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 04:38:33 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57466 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965069Ab3FTIi0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 04:38:26 -0400
X-AuditID: 12074413-b7f136d000006de1-9c-51c2bf810068
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 8A.03.28129.18FB2C15; Thu, 20 Jun 2013 04:38:25 -0400 (EDT)
Received: from michael.fritz.box (p57A25408.dip0.t-ipconnect.de [87.162.84.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5K8c0sJ001560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Jun 2013 04:38:24 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqNu4/1CgQVuXkUXXlW4mi4beK8wW
	8+7uYrK4vWI+s8WPlh5mi93TFrA5sHn8ff+ByePSy+9sHs969zB6XLyk7PF44glWj8+b5ALY
	orhtkhJLyoIz0/P07RK4My7e/sFecEq14tVb0wbGv7JdjJwcEgImEl9bvrJC2GISF+6tZ+ti
	5OIQErjMKHH+dCsTSEJI4ByTxLf1pSA2m4CuxKKeZrC4iICaxMS2QywgDcwCuxkllp8+xQ6S
	EBbwk5iw8AobiM0ioCqx6NhysDivgKtE29v7zBDbFCSmPHwPZnMCxd8cnsMKscxFYuuuHawT
	GHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vNLNFLTSndxAgJM+EdjLtOyh1iFOBg
	VOLh1bx8MFCINbGsuDL3EKMkB5OSKO/cfYcChfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwps4B
	yvGmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHgfggwVLEpNT61Iy8wp
	QUgzcXCCCC6QDTxAG5aBFPIWFyTmFmemQxSdYlSUEud9DJIQAElklObBDYAlhFeM4kD/CPNO
	BaniASYTuO5XQIOZgAbvWQ02uCQRISXVwOiYHRlWY5a0xTvWeVee483LXcZ3+KYoqiSc5Ni/
	WqhQY9Ye/5urb3Uvsjp/zneTyUtvcYWzvL7/K/9dZL5qN0n1mHV4D392bfc8e4nWzmZ/7yzx
	o3uXLQm43X9415R+o+zH/WrrXf+4f3KVsREXc7Cdt7x7t1GBw+Yjh6ffyXq28bDv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228452>

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
Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 60f2507..787cc1c 100644
--- a/refs.c
+++ b/refs.c
@@ -750,6 +750,21 @@ static int do_for_each_entry_in_dirs(struct ref_dir *dir1,
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
@@ -1603,15 +1618,31 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
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
1.8.3.1
