From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/12] get_packed_ref_cache: reload packed-refs file when it changes
Date: Tue, 11 Jun 2013 23:48:30 +0200
Message-ID: <1370987312-6761-11-git-send-email-mhagger@alum.mit.edu>
References: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 23:49:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWRW-00043f-Mc
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 23:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756613Ab3FKVt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 17:49:27 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:49384 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754796Ab3FKVtI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 17:49:08 -0400
X-AuditID: 1207440d-b7f006d000000adf-48-51b79b544e11
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id AA.4B.02783.45B97B15; Tue, 11 Jun 2013 17:49:08 -0400 (EDT)
Received: from michael.fritz.box (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BLmbj0015717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 17:49:06 -0400
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqBsye3ugQft7DouuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MDqwef99/YPK49PI7m8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ0xvWEtY0GbcsWxtqesDYztMl2MnBwSAiYS7/5cZIawxSQu3FvP1sXIxSEkcJlRYmrb
	MhYI5wKTxIXdZ8Cq2AR0JRb1NDOB2CICahIT2w6BFTELtDNKvGveB1YkLBAicXnFMzCbRUBV
	4nHvZlYQm1fARaJh02l2iHVyEu/v7GIBsTmB4hs3bwarFxJwlvje08Q4gZF3ASPDKka5xJzS
	XN3cxMyc4tRk3eLkxLy81CJdI73czBK91JTSTYyQsOLdwfh/ncwhRgEORiUe3gNm2wOFWBPL
	iitzDzFKcjApifKyTQMK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuHVzQXK8aYkVlalFuXDpKQ5
	WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeENmATUKFqWmp1akZeaUIKSZODhBhnNJiRSn
	5qWkFiWWlmTEg6IjvhgYHyApHqC9fCDtvMUFiblAUYjWU4zGHJvPT37HyDHj1ZR3jEIsefl5
	qVLivCkgpQIgpRmleXCLYAnlFaM40N/CvN4gVTzAZAQ37xXQKiagVUUZYKtKEhFSUg2M/rWx
	fxX99GySj7K5clp46LepyupoXK58lRy9VeRzt3SZRuJvNi3GaR/sJUNFWA86Hf+x56/QFa15
	4g9NxeK4W1SXlYmccZN498E3nX97F6/Q9o72eN5/c9SCd/g/W7nz5N/Of7tXPqhP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227530>

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
This is Peff's work, rebased and with some smallish changes to fit it
in with the packed_ref_cache data structure.

 refs.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 92c8e97..64f72ab 100644
--- a/refs.c
+++ b/refs.c
@@ -824,6 +824,9 @@ struct packed_ref_cache {
 
 	/* If locked, the file descriptor of the lock file. */
 	int fd;
+
+	/* The metadata from when this packed-refs cache was read */
+	struct stat_validity validity;
 };
 
 /*
@@ -858,6 +861,7 @@ static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
 {
 	if (!--packed_refs->referrers) {
 		free_ref_entry(packed_refs->root);
+		stat_validity_clear(&packed_refs->validity);
 		free(packed_refs);
 		return 1;
 	} else {
@@ -1049,20 +1053,27 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
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
 		refs->packed->fd = -1;
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
1.8.3
