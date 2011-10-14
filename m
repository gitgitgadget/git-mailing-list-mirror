From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] pack-objects: protect against disappearing packs
Date: Fri, 14 Oct 2011 14:03:48 -0400
Message-ID: <20111014180348.GA17412@sigill.intra.peff.net>
References: <20111014012320.GA4395@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 20:03:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REm6v-00056O-9T
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 20:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267Ab1JNSDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 14:03:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60706
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945Ab1JNSDw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 14:03:52 -0400
Received: (qmail 12713 invoked by uid 107); 14 Oct 2011 18:03:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Oct 2011 14:03:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Oct 2011 14:03:48 -0400
Content-Disposition: inline
In-Reply-To: <20111014012320.GA4395@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183589>

It's possible that while pack-objects is running, a
simultaneously running prune process might delete a pack
that we are interested in. Because we load the pack indices
early on, we know that the pack contains our item, but by
the time we try to open and map it, it is gone.

Since c715f78, we already protect against this in the normal
object access code path, but pack-objects accesses the packs
at a lower level.  In the normal access path, we call
find_pack_entry, which will call find_pack_entry_one on each
pack index, which does the actual lookup. If it gets a hit,
we will actually open and verify the validity of the
matching packfile (using c715f78's is_pack_valid). If we
can't open it, we'll issue a warning and pretend that we
didn't find it, causing us to go on to the next pack (or on
to loose objects).

Furthermore, we will cache the descriptor to the opened
packfile. Which means that later, when we actually try to
access the object, we are likely to still have that packfile
opened, and won't care if it has been unlinked from the
filesystem.

Notice the "likely" above. If there is another pack access
in the interim, and we run out of descriptors, we could
close the pack. And then a later attempt to access the
closed pack could fail (we'll try to re-open it, of course,
but it may have been deleted). In practice, this doesn't
happen because we tend to look up items and then access them
immediately.

Pack-objects does not follow this code path. Instead, it
accesses the packs at a much lower level, using
find_pack_entry_one directly. This means we skip the
is_pack_valid check, and may end up with the name of a
packfile, but no open descriptor.

We can add the same is_pack_valid check here. Unfortunately,
the access patterns of pack-objects are not quite as nice
for keeping lookup and object access together. We look up
each object as we find out about it, and the only later when
writing the packfile do we necessarily access it. Which
means that the opened packfile may be closed in the interim.

In practice, however, adding this check still has value, for
three reasons.

  1. If you have a reasonable number of packs and/or a
     reasonable file descriptor limit, you can keep all of
     your packs open simultaneously. If this is the case,
     then the race is impossible to trigger.

  2. Even if you can't keep all packs open at once, you
     may end up keeping the deleted one open (i.e., you may
     get lucky).

  3. The race window is shortened. You may notice early that
     the pack is gone, and not try to access it. Triggering
     the problem without this check means deleting the pack
     any time after we read the list of index files, but
     before we access the looked-up objects.  Triggering it
     with this check means deleting the pack means deleting
     the pack after we do a lookup (and successfully access
     the packfile), but before we access the object. Which
     is a smaller window.

Acked-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Jeff King <peff@peff.net>
---
Re-post with ack from Nicolas and my SOB fixed. No changes from earlier
version in this thread.

 builtin/pack-objects.c |    4 ++++
 cache.h                |    1 +
 sha1_file.c            |    2 +-
 3 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2b18de5..8681ccd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -804,6 +804,10 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 		off_t offset = find_pack_entry_one(sha1, p);
 		if (offset) {
 			if (!found_pack) {
+				if (!is_pack_valid(p)) {
+					error("packfile %s cannot be accessed", p->pack_name);
+					continue;
+				}
 				found_offset = offset;
 				found_pack = p;
 			}
diff --git a/cache.h b/cache.h
index e39e160..495b468 100644
--- a/cache.h
+++ b/cache.h
@@ -1055,6 +1055,7 @@ struct extra_have_objects {
 extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t);
 extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t);
 extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
+extern int is_pack_valid(struct packed_git *);
 extern void *unpack_entry(struct packed_git *, off_t, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
 extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
diff --git a/sha1_file.c b/sha1_file.c
index 3401301..a22c5b4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1987,7 +1987,7 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 	return 0;
 }
 
-static int is_pack_valid(struct packed_git *p)
+int is_pack_valid(struct packed_git *p)
 {
 	/* An already open pack is known to be valid. */
 	if (p->pack_fd != -1)
-- 
1.7.6.4.37.g43b58b
