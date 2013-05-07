From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] peel_ref: refactor for safety with simultaneous update
Date: Mon, 6 May 2013 23:06:41 -0400
Message-ID: <20130507030641.GB23219@sigill.intra.peff.net>
References: <20130507025458.GA22912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 05:06:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZYEq-0000HR-Sn
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 05:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757386Ab3EGDGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 23:06:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:43876 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756379Ab3EGDGn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 23:06:43 -0400
Received: (qmail 15685 invoked by uid 102); 7 May 2013 03:07:04 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 May 2013 22:07:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2013 23:06:41 -0400
Content-Disposition: inline
In-Reply-To: <20130507025458.GA22912@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223533>

The peel_ref function lets a caller peel an object, taking
advantage of the fact that we may have the peeled value
cached for a packed ref.  However, this function is not
necessarily safe in the face of simultaneous ref updates.

The caller has typically already loaded the ref from disk
(e.g., as part of a for_each_ref enumeration), and therefore
knows what the ref's base sha1 is. But if the asked-for ref
is not the current ref, we will load the ref from disk
ourselves. If another process is simultaneously updating the
ref, we may not get the same sha1 that the caller thinks is
in the ref, and as a result may return a peeled value that
does not match the sha1 that the caller has.

To make this safer, we can have the caller pass in its idea
of the sha1 of the ref, and use that as the base for peeling
(and we can also double-check that it matches the
current_ref pointer when we use that).

This makes the function harder to call (it is not really
"peel this ref", but "peel this object, and by the way, it
is called by this refname"). However, none of the current
callers care, because they always call it from a
for_each_ref enumeration, meaning it is no extra work to
pass in the sha1.

Furthermore, that means that none of the current callers hit
the "read_ref_full" codepath at all (so this bug is not
currently triggerable). They either follow the current_ref
optimization, or if the ref is not packed, they go straight
to the deref_tag fallback.

Let's just rip out the unused code path entirely. Not only
is it not used now, but it would not even make sense to use:
you would get the peeled value of the ref, but you would
have no clue which base object led to that peel.

Signed-off-by: Jeff King <peff@peff.net>
---
So I think peel_ref is buggy as-is (in both master and in
mh/packed-refs-various), it's just not triggerable because of the
dead code path. And it would get buggier again with my other patch
series, as then get_packed_ref could actually re-read the packed-refs
file. But I really think peel_ref is a badly designed function.

You do not peel a ref; you peel an object. You might think it is
convenient to have a function do the ref lookup and the peeling
together, but in practice nobody wants that, because you would not know
what you had just peeled. The real point is to hit the current_ref
optimization. Michael's series already has factored out a peel_object
function with the relevant bits. I think we can simply do away with
peel_ref entirely, and move the current_ref optimization there. I think
it should be perfectly cromulent to do:

  int peel_object(const unsigned char *base, const unsigned char *peeled)
  {
          if (current_ref && current_ref->flag & REF_KNOWS_PEELED &&
              !hashcmp(base, current_ref->u.value.sha1)) {
                  hashcpy(peeled, current_ref->u.value.peeled);
                  return 0;
          }

          /* peel as usual */
  }

That is, we do not need to care that it is _our_ ref that peels to that.
We happen to have a ref whose peeled value we know, and its object
matches the one we want to peel. Whether it is the same ref or not, the
same object sha1 should peel to the same peeled sha1. Of course, in
practice it will be our ref, because that is how the current callers
work. But it is also a safe function for callers who do not know or care
about the optimization.

My original patch on "master" is below for illustration, but do not look
too closely. I think the path I outlined above makes more sense, but I
am not going to work on it tonight.

 builtin/describe.c     |  2 +-
 builtin/pack-objects.c |  4 ++--
 builtin/show-ref.c     |  2 +-
 refs.c                 | 24 ++++--------------------
 refs.h                 |  3 ++-
 upload-pack.c          |  2 +-
 6 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 6636a68..23d7f1a 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -150,7 +150,7 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
 		return 0;
 
 	/* Is it annotated? */
-	if (!peel_ref(path, peeled)) {
+	if (!peel_ref(path, sha1, peeled)) {
 		is_annotated = !!hashcmp(sha1, peeled);
 	} else {
 		hashcpy(peeled, sha1);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f069462..76352df 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -556,7 +556,7 @@ static int mark_tagged(const char *path, const unsigned char *sha1, int flag,
 
 	if (entry)
 		entry->tagged = 1;
-	if (!peel_ref(path, peeled)) {
+	if (!peel_ref(path, sha1, peeled)) {
 		entry = locate_object_entry(peeled);
 		if (entry)
 			entry->tagged = 1;
@@ -2032,7 +2032,7 @@ static int add_ref_tag(const char *path, const unsigned char *sha1, int flag, vo
 	unsigned char peeled[20];
 
 	if (!prefixcmp(path, "refs/tags/") && /* is a tag? */
-	    !peel_ref(path, peeled)        && /* peelable? */
+	    !peel_ref(path, sha1, peeled)  && /* peelable? */
 	    locate_object_entry(peeled))      /* object packed? */
 		add_object_entry(sha1, OBJ_TAG, NULL, 0);
 	return 0;
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 8d9b76a..64f339d 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -78,7 +78,7 @@ match:
 	if (!deref_tags)
 		return 0;
 
-	if (!peel_ref(refname, peeled)) {
+	if (!peel_ref(refname, sha1, peeled)) {
 		hex = find_unique_abbrev(peeled, abbrev);
 		printf("%s %s^{}\n", hex, refname);
 	}
diff --git a/refs.c b/refs.c
index 89f8141..c16bd75 100644
--- a/refs.c
+++ b/refs.c
@@ -1231,38 +1231,22 @@ int peel_ref(const char *refname, unsigned char *peeled)
 	return filter->fn(refname, sha1, flags, filter->cb_data);
 }
 
-int peel_ref(const char *refname, unsigned char *peeled)
+int peel_ref(const char *refname, const unsigned char *base,
+	     unsigned char *peeled)
 {
-	int flag;
-	unsigned char base[20];
 	struct object *o;
 
 	if (current_ref && (current_ref->name == refname
-		|| !strcmp(current_ref->name, refname))) {
+		|| !strcmp(current_ref->name, refname))
+	    && !hashcmp(current_ref->u.value.sha1, base)) {
 		if (current_ref->flag & REF_KNOWS_PEELED) {
 			if (is_null_sha1(current_ref->u.value.peeled))
 			    return -1;
 			hashcpy(peeled, current_ref->u.value.peeled);
 			return 0;
 		}
-		hashcpy(base, current_ref->u.value.sha1);
-		goto fallback;
-	}
-
-	if (read_ref_full(refname, base, 1, &flag))
-		return -1;
-
-	if ((flag & REF_ISPACKED)) {
-		struct ref_dir *dir = get_packed_refs(get_ref_cache(NULL));
-		struct ref_entry *r = find_ref(dir, refname);
-
-		if (r != NULL && r->flag & REF_KNOWS_PEELED) {
-			hashcpy(peeled, r->u.value.peeled);
-			return 0;
-		}
 	}
 
-fallback:
 	o = lookup_unknown_object(base);
 	if (o->type == OBJ_NONE) {
 		int type = sha1_object_info(base, NULL);
diff --git a/refs.h b/refs.h
index 1e8b4e1..39817a4 100644
--- a/refs.h
+++ b/refs.h
@@ -61,7 +61,8 @@ extern int ref_exists(const char *);
 
 extern int ref_exists(const char *);
 
-extern int peel_ref(const char *refname, unsigned char *peeled);
+extern int peel_ref(const char *refname, const unsigned char *base,
+		    unsigned char *peeled);
 
 /** Locks a "refs/" ref returning the lock on success and NULL on failure. **/
 extern struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1);
diff --git a/upload-pack.c b/upload-pack.c
index bfa6279..6acff92 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -755,7 +755,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	else
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname_nons);
 	capabilities = NULL;
-	if (!peel_ref(refname, peeled))
+	if (!peel_ref(refname, sha1, peeled))
 		packet_write(1, "%s %s^{}\n", sha1_to_hex(peeled), refname_nons);
 	return 0;
 }
-- 
1.8.3.rc1.2.g12db477
