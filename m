From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 10/12] get_packed_ref_cache: reload packed-refs file when it changes
Date: Wed, 19 Jun 2013 09:51:31 +0200
Message-ID: <1371628293-28824-11-git-send-email-mhagger@alum.mit.edu>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 09:52:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDC8-0003fT-5C
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 09:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933945Ab3FSHw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 03:52:26 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:52560 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756664Ab3FSHwE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jun 2013 03:52:04 -0400
X-AuditID: 1207440c-b7f016d000005997-e7-51c163234ede
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 7A.D0.22935.32361C15; Wed, 19 Jun 2013 03:52:03 -0400 (EDT)
Received: from michael.berlin.jpk.com (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5J7pZWc002453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Jun 2013 03:52:02 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqKucfDDQYMkkVYuuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MFrunLWBzYPP4+/4Dk8ell9/ZPJ717mH0uHhJ2ePxxBOsHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ2ye8ZK54LVixbKbzxkbGHukuxg5OSQETCQ+9J5kh7DFJC7cW8/W
	xcjFISRwmVHi9tWpLBDObSaJ7wuamECq2AR0JRb1NIPZIgJqEhPbDoEVMQvsZpRYfvoU2Chh
	gXCJB89OMIPYLAKqEr/XXQeKc3DwCrhK7L+fDLFNQWLKw/fMIGFOoPDZZZ4gYSEBF4l5pyaz
	TmDkXcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11AvN7NELzWldBMjJMx4djB+WydziFGA
	g1GJh/fG6gOBQqyJZcWVuYcYJTmYlER52ZMOBgrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4dVz
	AMrxpiRWVqUW5cOkpDlYlMR5VZeo+wkJpCeWpGanphakFsFkZTg4lCR4xUCGChalpqdWpGXm
	lCCkmTg4QYZzSYkUp+alpBYllpZkxIMiI74YGBsgKR6gvUcSQfYWFyTmAkUhWk8xGnNMPrvl
	PSPHwjdb3zMKseTl56VKifNGgmwSACnNKM2DWwRLMK8YxYH+Fua1A6niASYnuHmvgFYxAa0S
	+r4PZFVJIkJKqoGxjDm+KGne1ucevxt277Dep5tYxLdgZv4mNVfJqsSl6xZqHOsrvrM3PfXV
	pvxZDmej3XaeNjT0q7q2RvY5n2qjG/Pm5kcbbAsWzU0Uiejs9lw4v2ieya2a0zc6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228367>

From: Jeff King <peff@peff.net>

Once we read the packed-refs file into memory, we cache it
to save work on future ref lookups. However, our cache may
be out of date with respect to what is on disk if another
process is simultaneously packing the refs. Normally it
is acceptable for us to be a little out of date, since there
is no guarantee whether we read the file before or after the
simultaneous update. However, there is an important special
case: our packed-refs file must be up to date with respect
to any loose refs we read. Otherwise, we risk the following
race condition:

  0. There exists a loose ref refs/heads/master.

  1. Process A starts and looks up the ref "master". It
     first checks $GIT_DIR/master, which does not exist. It
     then loads (and caches) the packed-refs file to see if
     "master" exists in it, which it does not.

  2. Meanwhile, process B runs "pack-refs --all --prune". It
     creates a new packed-refs file which contains
     refs/heads/master, and removes the loose copy at
     $GIT_DIR/refs/heads/master.

  3. Process A continues its lookup, and eventually tries
     $GIT_DIR/refs/heads/master.  It sees that the loose ref
     is missing, and falls back to the packed-refs file. But
     it examines its cached version, which does not have
     refs/heads/master. After trying a few other prefixes,
     it reports master as a non-existent ref.

There are many variants (e.g., step 1 may involve process A
looking up another ref entirely, so even a fully qualified
refname can fail). One of the most interesting ones is if
"refs/heads/master" is already packed. In that case process
A will not see it as missing, but rather will report
whatever value happened to be in the packed-refs file before
process B repacked (which might be an arbitrarily old
value).

We can fix this by making sure we reload the packed-refs
file from disk after looking at any loose refs. That's
unacceptably slow, so we can check its stat()-validity as a
proxy, and read it only when it appears to have changed.

Reading the packed-refs file after performing any loose-ref
system calls is sufficient because we know the ordering of
the pack-refs process: it always makes sure the newly
written packed-refs file is installed into place before
pruning any loose refs. As long as those operations by B
appear in their executed order to process A, by the time A
sees the missing loose ref, the new packed-refs file must be
in place.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 6d48b42..d53a172 100644
--- a/refs.c
+++ b/refs.c
@@ -825,6 +825,9 @@ struct packed_ref_cache {
 	 * when it is unlocked.
 	 */
 	struct lock_file *lock;
+
+	/* The metadata from when this packed-refs cache was read */
+	struct stat_validity validity;
 };
 
 /*
@@ -859,6 +862,7 @@ static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
 {
 	if (!--packed_refs->referrers) {
 		free_ref_entry(packed_refs->root);
+		stat_validity_clear(&packed_refs->validity);
 		free(packed_refs);
 		return 1;
 	} else {
@@ -1050,19 +1054,26 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
  */
 static struct packed_ref_cache *get_packed_ref_cache(struct ref_cache *refs)
 {
+	const char *packed_refs_file;
+
+	if (*refs->name)
+		packed_refs_file = git_path_submodule(refs->name, "packed-refs");
+	else
+		packed_refs_file = git_path("packed-refs");
+
+	if (refs->packed &&
+	    !stat_validity_check(&refs->packed->validity, packed_refs_file))
+		clear_packed_ref_cache(refs);
+
 	if (!refs->packed) {
-		const char *packed_refs_file;
 		FILE *f;
 
 		refs->packed = xcalloc(1, sizeof(*refs->packed));
 		acquire_packed_ref_cache(refs->packed);
 		refs->packed->root = create_dir_entry(refs, "", 0, 0);
-		if (*refs->name)
-			packed_refs_file = git_path_submodule(refs->name, "packed-refs");
-		else
-			packed_refs_file = git_path("packed-refs");
 		f = fopen(packed_refs_file, "r");
 		if (f) {
+			stat_validity_update(&refs->packed->validity, fileno(f));
 			read_packed_refs(f, get_ref_dir(refs->packed->root));
 			fclose(f);
 		}
-- 
1.8.3.1
