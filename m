From: Jeff King <peff@peff.net>
Subject: [PATCH] pack-objects: turn off bitmaps when skipping objects
Date: Fri, 14 Mar 2014 22:38:29 -0400
Message-ID: <20140315023828.GA6790@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 03:38:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOeUe-00077y-A2
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 03:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908AbaCOCic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 22:38:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:39848 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753781AbaCOCib (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 22:38:31 -0400
Received: (qmail 4865 invoked by uid 102); 15 Mar 2014 02:38:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Mar 2014 21:38:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2014 22:38:29 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244137>

The pack bitmap format requires that we have a single bit
for each object in the pack, and that each object's bitmap
represents its complete set of reachable objects. Therefore
we have no way to represent the bitmap of an object which
references objects outside the pack.

We notice this problem while generating the bitmaps, as we
try to find the offset of a particular object and realize
that we do not have it. In this case we die, and neither the
bitmap nor the pack is generated. This is correct, but
perhaps a little unfriendly. If you have bitmaps turned on
in the config, many repacks will fail which would otherwise
succeed. E.g., incremental repacks, repacks with "-l" when
you have alternates, ".keep" files.

Instead, this patch notices early that we are omitting some
objects from the pack and turns off bitmaps (with a
warning). Note that this is not strictly correct, as it's
possible that the object being omitted is not reachable from
any other object in the pack. In practice, this is almost
never the case, and there are two advantages to doing it
this way:

  1. The code is much simpler, as we do not have to cleanly
     abort the bitmap-generation process midway through.

  2. We do not waste time partially generating bitmaps only
     to find out that some object deep in the history is not
     being packed.

Signed-off-by: Jeff King <peff@peff.net>
---
I posted this earlier here:

  http://article.gmane.org/gmane.comp.version-control.git/240969

The discussion resulted in the jk/repack-pack-keep-objects topic.
However, I think this is still worth applying, as it means git behaves
sensibly when objects are omitted for other reasons (e.g., because you
tried to use "-b" with an incremental repack, or because you favor
".keep" files to bitmaps by explicitly setting repack.packKeptObjects
to "false"). In our previous discussions, I had assumed this patch had
already been picked up, but I don't see it anywhere. Without it, setting
"repack.packKeptObjects" to false is largely pointless (instead of
continuing without bitmaps, git will die).

 builtin/pack-objects.c  | 12 +++++++++++-
 t/t5310-pack-bitmaps.sh |  5 ++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 418801f..4ca3946 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1011,6 +1011,10 @@ static void create_object_entry(const unsigned char *sha1,
 	entry->no_try_delta = no_try_delta;
 }
 
+static const char no_closure_warning[] = N_(
+"disabling bitmap writing, as some objects are not being packed"
+);
+
 static int add_object_entry(const unsigned char *sha1, enum object_type type,
 			    const char *name, int exclude)
 {
@@ -1021,8 +1025,14 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	if (have_duplicate_entry(sha1, exclude, &index_pos))
 		return 0;
 
-	if (!want_object_in_pack(sha1, exclude, &found_pack, &found_offset))
+	if (!want_object_in_pack(sha1, exclude, &found_pack, &found_offset)) {
+		/* The pack is missing an object, so it will not have closure */
+		if (write_bitmap_index) {
+			warning(_(no_closure_warning));
+			write_bitmap_index = 0;
+		}
 		return 0;
+	}
 
 	create_object_entry(sha1, type, pack_name_hash(name),
 			    exclude, name && no_try_delta(name),
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index d3a3afa..f13525c 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -91,7 +91,10 @@ test_expect_success 'fetch (partial bitmap)' '
 
 test_expect_success 'incremental repack cannot create bitmaps' '
 	test_commit more-1 &&
-	test_must_fail git repack -d
+	find .git/objects/pack -name "*.bitmap" >expect &&
+	git repack -d &&
+	find .git/objects/pack -name "*.bitmap" >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'incremental repack can disable bitmaps' '
-- 
1.9.0.417.gc6bea4f
