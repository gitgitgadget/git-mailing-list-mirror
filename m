From: Jeff King <peff@peff.net>
Subject: [PATCH] pack-objects: turn off bitmaps when skipping objects
Date: Thu, 23 Jan 2014 17:52:39 -0500
Message-ID: <20140123225238.GB2567@sigill.intra.peff.net>
References: <52E080C1.4030402@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Siddharth Agarwal <sid0@fb.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 23:52:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6T8f-0004zZ-Fn
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 23:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbaAWWwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 17:52:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:37848 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932203AbaAWWwk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 17:52:40 -0500
Received: (qmail 6249 invoked by uid 102); 23 Jan 2014 22:52:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 16:52:40 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 17:52:39 -0500
Content-Disposition: inline
In-Reply-To: <52E080C1.4030402@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240969>

On Wed, Jan 22, 2014 at 06:38:57PM -0800, Siddharth Agarwal wrote:

> Running git-next, writing bitmap indexes fails if a keep file is
> present from an earlier pack.

Right, that's expected.

The bitmap format cannot represent objects that are not present in the
pack. So we cannot write a bitmap index if any object reachable from a
packed commit is omitted from the pack.

We could be nicer and downgrade it to a warning, though. The patch below
does that.

> In our case we have .keep files lying around from ages ago (possibly
> due to kill -9s run on the server).

We ran into that problem at GitHub, too. We just turn off
`--honor-pack-keep` during our repacks, as we never want them on anyway
(and we would prefer to ignore the .keep than to abort the bitmap).

> It also means that running repack -a with bitmap writing enabled on a
> repo becomes problematic if a fetch is run concurrently.

For the most part, no. The .keep file should generally only be set
during the period between indexing the pack and updating the refs (so
while checking connectivity and running hooks). But pack-objects starts
from the ref tips and walks backwards. Until they are updated, it will
not try to pack the objects in the .keep files, as nobody references
them. There are two loopholes, though:

  1. In some instances, a remote may send an object we already have
     (e.g., because it is a blob referenced in an old commit, but newly
     referenced again due to a revert; we do not do a full object
     difference during the protocol negotiation, for reasons of
     efficiency). If that is the case, we may omit it if pack-objects
     starts during the period that the .pack and .keep files exist.

  2. Once the fetch updates the refs, it removes the .keep file. But
     this isn't atomic. A repack which starts between the two may pick
     up the new ref values, but also see the .keep file.

These are both unlikely, but possible on a very busy repository. The
patch below will downgrade each to a warning, rather than aborting the
repack.

So this should just work out of the box with this patch.  But if bitmaps
are important to you (say, you are running a very busy site and want
to make sure you always have bitmaps turned on) and you do not otherwise
care about .keep files, you may want to disable them, too.

-Peff

-- >8 --
Subject: pack-objects: turn off bitmaps when skipping objects

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
I tried to keep the warning to an 80-character line without making it
too confusing. Suggestions welcome if it doesn't make sense to people.

 builtin/pack-objects.c  | 12 +++++++++++-
 t/t5310-pack-bitmaps.sh |  5 ++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8364fbd..76831d9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1000,6 +1000,10 @@ static void create_object_entry(const unsigned char *sha1,
 	entry->no_try_delta = no_try_delta;
 }
 
+static const char no_closure_warning[] = N_(
+"disabling bitmap writing, as some objects are not being packed"
+);
+
 static int add_object_entry(const unsigned char *sha1, enum object_type type,
 			    const char *name, int exclude)
 {
@@ -1010,8 +1014,14 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
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
1.8.5.2.500.g8060133
