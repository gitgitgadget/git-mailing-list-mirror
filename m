From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] peel_ref: do not return a null sha1
Date: Thu, 4 Oct 2012 04:00:19 -0400
Message-ID: <20121004080019.GB31325@sigill.intra.peff.net>
References: <20121004075609.GA1355@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:21:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtUb-0001w8-Ja
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373Ab2JDIAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 04:00:23 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40482 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932089Ab2JDIAW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 04:00:22 -0400
Received: (qmail 17750 invoked by uid 107); 4 Oct 2012 08:00:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Oct 2012 04:00:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2012 04:00:19 -0400
Content-Disposition: inline
In-Reply-To: <20121004075609.GA1355@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206989>

The idea of the peel_ref function is to dereference tag
objects recursively until we hit a non-tag, and return the
sha1. Conceptually, it should return 0 if it is successful
(and fill in the sha1), or -1 if there was nothing to peel.

However, the current behavior is much more confusing. For a
regular loose ref, the behavior is as described above. But
there is an optimization to reuse the peeled-ref value for a
ref that came from a packed-refs file. If we have such a
ref, we return its peeled value, even if that peeled value
is null (indicating that we know the ref definitely does
_not_ peel).

It might seem like such information is useful to the caller,
who would then know not to bother loading and trying to peel
the object. Except that they should not bother loading and
trying to peel the object _anyway_, because that fallback is
already handled by peel_ref. In other words, the whole point
of calling this function is that it handles those details
internally, and you either get a sha1, or you know that it
is not peel-able.

This patch catches the null sha1 case internally and
converts it into a -1 return value (i.e., there is nothing
to peel). This simplifies callers, which do not need to
bother checking themselves.

Two callers are worth noting:

  - in pack-objects, a comment indicates that there is a
    difference between non-peelable tags and unannotated
    tags. But that is not the case (before or after this
    patch). Whether you get a null sha1 has to do with
    internal details of how peel_ref operated.

  - in show-ref, if peel_ref returns a failure, the caller
    tries to decide whether to try peeling manually based on
    whether the REF_ISPACKED flag is set. But this doesn't
    make any sense. If the flag is set, that does not
    necessarily mean the ref came from a packed-refs file
    with the "peeled" extension. But it doesn't matter,
    because even if it didn't, there's no point in trying to
    peel it ourselves, as peel_ref would already have done
    so. In other words, the fallback peeling is guaranteed
    to fail.

Signed-off-by: Jeff King <peff@peff.net>
---
Sorry for the long-winded explanation. I'd love it if somebody could
eyeball the code and make sure what I wrote above is correct. I was
mightily confused at first by the way that some of the callers treated
the return value. I think it is simply a case of code growing crufty as
features were added (originally the packed-refs optimization did not
exist, and was bolted on later), but I may have mis-read something.

 builtin/describe.c     |  2 +-
 builtin/pack-objects.c |  1 -
 builtin/show-ref.c     | 23 +++--------------------
 refs.c                 |  2 ++
 4 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 9fe11ed..04c185b 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -144,7 +144,7 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
 	if (!all && !might_be_tag)
 		return 0;
 
-	if (!peel_ref(path, peeled) && !is_null_sha1(peeled)) {
+	if (!peel_ref(path, peeled)) {
 		is_tag = !!hashcmp(sha1, peeled);
 	} else {
 		hashcpy(peeled, sha1);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5e14064..f069462 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2033,7 +2033,6 @@ static int add_ref_tag(const char *path, const unsigned char *sha1, int flag, vo
 
 	if (!prefixcmp(path, "refs/tags/") && /* is a tag? */
 	    !peel_ref(path, peeled)        && /* peelable? */
-	    !is_null_sha1(peeled)          && /* annotated tag? */
 	    locate_object_entry(peeled))      /* object packed? */
 		add_object_entry(sha1, OBJ_TAG, NULL, 0);
 	return 0;
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 4eb016d..8d9b76a 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -28,7 +28,6 @@ static int show_ref(const char *refname, const unsigned char *sha1, int flag, vo
 
 static int show_ref(const char *refname, const unsigned char *sha1, int flag, void *cbdata)
 {
-	struct object *obj;
 	const char *hex;
 	unsigned char peeled[20];
 
@@ -79,25 +78,9 @@ match:
 	if (!deref_tags)
 		return 0;
 
-	if ((flag & REF_ISPACKED) && !peel_ref(refname, peeled)) {
-		if (!is_null_sha1(peeled)) {
-			hex = find_unique_abbrev(peeled, abbrev);
-			printf("%s %s^{}\n", hex, refname);
-		}
-	}
-	else {
-		obj = parse_object(sha1);
-		if (!obj)
-			die("git show-ref: bad ref %s (%s)", refname,
-			    sha1_to_hex(sha1));
-		if (obj->type == OBJ_TAG) {
-			obj = deref_tag(obj, refname, 0);
-			if (!obj)
-				die("git show-ref: bad tag at ref %s (%s)", refname,
-				    sha1_to_hex(sha1));
-			hex = find_unique_abbrev(obj->sha1, abbrev);
-			printf("%s %s^{}\n", hex, refname);
-		}
+	if (!peel_ref(refname, peeled)) {
+		hex = find_unique_abbrev(peeled, abbrev);
+		printf("%s %s^{}\n", hex, refname);
 	}
 	return 0;
 }
diff --git a/refs.c b/refs.c
index 0a916a0..f672ad9 100644
--- a/refs.c
+++ b/refs.c
@@ -1202,6 +1202,8 @@ int peel_ref(const char *refname, unsigned char *sha1)
 	if (current_ref && (current_ref->name == refname
 		|| !strcmp(current_ref->name, refname))) {
 		if (current_ref->flag & REF_KNOWS_PEELED) {
+			if (is_null_sha1(current_ref->u.value.peeled))
+			    return -1;
 			hashcpy(sha1, current_ref->u.value.peeled);
 			return 0;
 		}
-- 
1.8.0.rc0.10.g8dd2a92
