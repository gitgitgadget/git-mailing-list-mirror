From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 10/12] get_packed_ref_cache: reload packed-refs file when it changes
Date: Thu, 20 Jun 2013 10:37:52 +0200
Message-ID: <1371717474-28942-11-git-send-email-mhagger@alum.mit.edu>
References: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 10:38:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpaOB-00075w-Fi
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 10:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091Ab3FTIie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 04:38:34 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53787 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965057Ab3FTIiZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 04:38:25 -0400
X-AuditID: 12074411-b7f296d000001209-f8-51c2bf808436
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 6A.BF.04617.08FB2C15; Thu, 20 Jun 2013 04:38:24 -0400 (EDT)
Received: from michael.fritz.box (p57A25408.dip0.t-ipconnect.de [87.162.84.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5K8c0sI001560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Jun 2013 04:38:22 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqNuw/1CgwYUzHBZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLXZPW8DmwObx9/0HJo9LL7+zeTzr3cPocfGSssfjiSdYPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzjh/ZglzwVSlinl/prM2MG6U7mLk5JAQMJH4umUFM4QtJnHh3no2
	EFtI4DKjxNP2yC5GLiD7HJPEtNtfwBJsAroSi3qamUBsEQE1iYlth1hAipgFdjNKLD99ih0k
	ISwQLrGvoxFsKouAqsT0nY+Bmjk4eAVcJd49loRYpiAx5eF7sBJOoPCbw3NYIRa7SGzdtYN1
	AiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6pnq5mSV6qSmlmxghYSa4g3HGSblDjAIc
	jEo8vBqXDwYKsSaWFVfmHmKU5GBSEuWdu+9QoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3tQ5
	QDnelMTKqtSifJiUNAeLkjgv3xJ1PyGB9MSS1OzU1ILUIpisDAeHkgRvGshQwaLU9NSKtMyc
	EoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFBkxBcDYwMkxQO0dxlIO29xQWIuUBSi9RSjMcfks1ve
	M3IsfLP1PaMQS15+XqqUOO8qkFIBkNKM0jy4RbAE84pRHOhvYd5okCoeYHKCm/cKaBUT0Ko9
	q8FWlSQipKQaGKMciwtPmJWGftiTrz1Z5L/GjPlMX1/Omb/R83rwrD0CEXFruBKqr5yUvVom
	uG2BzclV/uv7z8o1WaTUp+3zjXu+cCFj94WsG8f2cyv3/G3at3hVqd+sDPt63YvV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228455>

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
Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index a5a5b5d..60f2507 100644
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
@@ -862,6 +865,7 @@ static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
 {
 	if (!--packed_refs->referrers) {
 		free_ref_entry(packed_refs->root);
+		stat_validity_clear(&packed_refs->validity);
 		free(packed_refs);
 		return 1;
 	} else {
@@ -1053,19 +1057,26 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
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
