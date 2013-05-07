From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] get_packed_refs: reload packed-refs file when it changes
Date: Mon, 6 May 2013 22:43:13 -0400
Message-ID: <20130507024313.GC22940@sigill.intra.peff.net>
References: <20130507023610.GA22053@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 04:43:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZXs8-0007ks-0z
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 04:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934531Ab3EGCnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 22:43:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:43683 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934528Ab3EGCnP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 22:43:15 -0400
Received: (qmail 14572 invoked by uid 102); 7 May 2013 02:43:35 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 May 2013 21:43:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2013 22:43:13 -0400
Content-Disposition: inline
In-Reply-To: <20130507023610.GA22053@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223527>

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
unacceptably slow, so we can check it's stat()-validity as a
proxy, and read it only when it appears to have changed.

Reading the packed-refs file after performing any loose-ref
system calls is sufficient because we know the ordering of
the pack-refs process: it always makes sure the newly
written packed-refs file is installed into place before
pruning any loose refs. As long as those operations by B
appear in their executed order to process A, by the time A
sees the missing loose ref, the new packed-refs file must be
in place.

Signed-off-by: Jeff King <peff@peff.net>
---
I hooked the refreshing into get_packed_refs, since then all callers get
it for free. It makes me a little nervous, though, just in case some
caller really cares about calling get_packed_refs but not having the
list of packed-refs change during the call. peel_ref looks like such a
function, but isn't, for reasons I'll explain in a followup patch.

Clone also looks like such a caller, as it calls get_packed_refs once
for each upstream ref it adds (it puts them in the packed-refs list, and
then writes them all out at the end). But it's OK because there is no
packed-refs file for it to refresh from.

An alternative would be to move the refreshing to an explicit
refresh_packed_refs() function, and call it from a few places
(resolve_ref, and later from do_for_each_ref).

 refs.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 5a14703..6afe8cc 100644
--- a/refs.c
+++ b/refs.c
@@ -708,6 +708,7 @@ static struct ref_cache {
 	struct ref_cache *next;
 	struct ref_entry *loose;
 	struct ref_entry *packed;
+	struct stat_validity packed_validity;
 	/* The submodule name, or "" for the main repo. */
 	char name[FLEX_ARRAY];
 } *ref_cache;
@@ -717,6 +718,7 @@ static void clear_packed_ref_cache(struct ref_cache *refs)
 	if (refs->packed) {
 		free_ref_entry(refs->packed);
 		refs->packed = NULL;
+		stat_validity_clear(&refs->packed_validity);
 	}
 }
 
@@ -878,17 +880,25 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 
 static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 {
+	const char *packed_refs_file;
+
+	if (*refs->name)
+		packed_refs_file = git_path_submodule(refs->name, "packed-refs");
+	else
+		packed_refs_file = git_path("packed-refs");
+
+	if (refs->packed &&
+	    !stat_validity_check(&refs->packed_validity, packed_refs_file))
+		clear_packed_ref_cache(refs);
+
 	if (!refs->packed) {
-		const char *packed_refs_file;
 		FILE *f;
 
 		refs->packed = create_dir_entry(refs, "", 0, 0);
-		if (*refs->name)
-			packed_refs_file = git_path_submodule(refs->name, "packed-refs");
-		else
-			packed_refs_file = git_path("packed-refs");
+
 		f = fopen(packed_refs_file, "r");
 		if (f) {
+			stat_validity_update(&refs->packed_validity, fileno(f));
 			read_packed_refs(f, get_ref_dir(refs->packed));
 			fclose(f);
 		}
-- 
1.8.3.rc1.2.g12db477
