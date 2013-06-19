From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/12] for_each_ref: load all loose refs before packed refs
Date: Wed, 19 Jun 2013 09:51:32 +0200
Message-ID: <1371628293-28824-12-git-send-email-mhagger@alum.mit.edu>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 09:52:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDC7-0003fT-LJ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 09:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933905Ab3FSHwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 03:52:19 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:42758 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756623Ab3FSHwF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jun 2013 03:52:05 -0400
X-AuditID: 1207440e-b7f0f6d0000043b7-4e-51c1632575d3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id E5.AF.17335.52361C15; Wed, 19 Jun 2013 03:52:05 -0400 (EDT)
Received: from michael.berlin.jpk.com (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5J7pZWd002453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Jun 2013 03:52:03 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqKuafDDQ4NwCVouuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MFrunLWBzYPP4+/4Dk8ell9/ZPJ717mH0uHhJ2ePxxBOsHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ9y/8pqtYIFqRdOzt+wNjDdkuxg5OSQETCQmb+plgrDFJC7cW8/W
	xcjFISRwmVHiytWZrBDObSaJk9unMoJUsQnoSizqaQbrEBFQk5jYdogFpIhZYDejxPLTp9hB
	EsICfhITVu4Fs1kEVCVWPpwF1MDBwSvgKtGznhFim4LElIfvmUHCnEDhs8s8QcJCAi4S805N
	Zp3AyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6xXm5miV5qSukmRkiY8e1gbF8vc4hR
	gINRiYe3YeWBQCHWxLLiytxDjJIcTEqivOxJBwOF+JLyUyozEosz4otKc1KLDzFKcDArifDq
	OQDleFMSK6tSi/JhUtIcLErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvGIgQwWLUtNTK9Iy
	c0oQ0kwcnCCCC2QDD9CGI4kgG4oLEnOLM9Mhik4xKkqJ84qCTBAASWSU5sENgCWEV4ziQP8I
	89qBVPEAkwlc9yugwUxAg4W+7wMZXJKIkJJqYHRitWiNM3lTmfE3xE3shc9SbbPtPAHVZ7yn
	1DK3ht68Epny/sUuecaJ/13sL/2NOPPLXyy1OVyPfWJZ19Rdn89FPVpxiPl9UujKb4fnWJxX
	CI/bz+0hyzvLqoJ90oNfLT9bdULncq0TEFpYv2Fq5QnrL7euXljVv67iz+dXJ3rc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228363>

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
 refs.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index d53a172..350054c 100644
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
1.8.3.1
