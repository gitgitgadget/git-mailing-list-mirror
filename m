From: Jeff King <peff@peff.net>
Subject: [DO NOT APPLY PATCH 4/4] index-pack: optionally skip duplicate
 packfile entries
Date: Wed, 21 Aug 2013 16:55:55 -0400
Message-ID: <20130821205555.GD28165@sigill.intra.peff.net>
References: <20130821204955.GA28025@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 21 22:56:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCFRm-0006QX-EP
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 22:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142Ab3HUU4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 16:56:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:49755 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753139Ab3HUUz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 16:55:58 -0400
Received: (qmail 11804 invoked by uid 102); 21 Aug 2013 20:55:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Aug 2013 15:55:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Aug 2013 16:55:55 -0400
Content-Disposition: inline
In-Reply-To: <20130821204955.GA28025@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232735>

When we are building the pack index, we can notice that
there are duplicate objects, pick one "winner" instance, and
mention the object only once in the index (mapped to the
winner's offset).

This has the effect that the duplicate packfile entries are
never found by lookup. The data still exists in the
packfile, though, and can be used as a delta base if delta
base offsets are used. If delta refs are used, then it is
possible that some deltas may be broken.

Unfortunately, this scheme does not quite work, as the pack
reader checks that the index and packfile claim the same
number of objects, and will refuse to open such a packfile.

We have a few options:

  1. Loosen the check in the reader. This drops a
     potentially useful sanity check on the data, and it
     won't work for any other implementations (including
     older versions of git).

  2. Loosen the check only if a special flag is found in the
     index indicating that we removed duplicates. This means
     that we only lose the safety check in the rare case
     that duplicates are found. But there is actually no
     place in the index to put such a flag, and in addition
     no other implementation would understand our flag.

  3. Instead of reducing the numnber of objects in the
     index, include "dummy" entries using the null sha1 or a
     similar sentinel value (and pointing to some invalid
     offset). This should work, but is awfully hacky (and
     will probably create havoc as we will now claim to have
     the null sha1, but will throw errors if you actually
     look at it).

Signed-off-by: Jeff King <peff@peff.net>
---
I think this line of "fixing" should probably be scrapped. Truly fixing
it and covering the REF_DELTA case would involve magic in the actual
object lookups (we would have to detect cycles and find the "other"
object that is the real base). And it's probably just not worth the
effort.

 builtin/index-pack.c              |  2 ++
 pack-write.c                      | 30 ++++++++++++++++++++++++++++++
 pack.h                            |  3 ++-
 t/t5308-pack-detect-duplicates.sh |  8 ++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 83fd3bb..1dadd56 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1375,6 +1375,8 @@ static int git_index_pack_config(const char *k, const char *v, void *cb)
 			opts->duplicates = WRITE_IDX_DUPLICATES_IGNORE;
 		else if (boolval == 0 || !strcmp(v, "reject"))
 			opts->duplicates = WRITE_IDX_DUPLICATES_REJECT;
+		else if (!strcmp(v, "skip"))
+			opts->duplicates = WRITE_IDX_DUPLICATES_SKIP;
 		else
 			die("unknown value for pack.indexduplicates: %s", v);
 		return 0;
diff --git a/pack-write.c b/pack-write.c
index 542b081..657da2a 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -50,6 +50,27 @@ static void *find_duplicate(void *vbase, size_t n, size_t size,
 	return NULL;
 }
 
+static size_t remove_duplicates(void *base, size_t n, size_t size,
+				int (*cmp)(const void *, const void *))
+{
+	unsigned char *from = base, *to = base;
+
+	from += size;
+	to += size;
+	n--;
+
+	while (n > 0) {
+		if (cmp(from, from - size)) {
+			if (to != from)
+				memcpy(to, from, size);
+			to += size;
+		}
+		from += size;
+		n--;
+	}
+	return (to - (unsigned char *)base) / size;
+}
+
 /*
  * On entry *sha1 contains the pack content SHA1 hash, on exit it is
  * the SHA1 hash of sorted object names. The objects array passed in
@@ -89,6 +110,15 @@ const char *write_idx_file(const char *index_name, struct pack_idx_entry **objec
 		if (dup)
 			die("pack has duplicate entries for %s",
 			    sha1_to_hex((*dup)->sha1));
+	} else if (opts->duplicates == WRITE_IDX_DUPLICATES_SKIP) {
+		int nr_unique = remove_duplicates(sorted_by_sha,
+						  nr_objects,
+						  sizeof(*sorted_by_sha),
+						  sha1_compare);
+		if (nr_unique != nr_objects) {
+			nr_objects = nr_unique;
+			last = sorted_by_sha + nr_objects;
+		}
 	}
 
 	if (opts->flags & WRITE_IDX_VERIFY) {
diff --git a/pack.h b/pack.h
index cd4b536..3017ea4 100644
--- a/pack.h
+++ b/pack.h
@@ -46,7 +46,8 @@ struct pack_idx_option {
 
 	enum {
 		WRITE_IDX_DUPLICATES_IGNORE = 0,
-		WRITE_IDX_DUPLICATES_REJECT
+		WRITE_IDX_DUPLICATES_REJECT,
+		WRITE_IDX_DUPLICATES_SKIP
 	} duplicates;
 
 	/*
diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index 0f2d928..963d7b9 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -102,4 +102,12 @@ test_expect_success 'index-pack can reject packs with duplicates' '
 	test_expect_code 1 git cat-file -e $LO_SHA1
 '
 
+test_expect_success 'index-pack can fix packs with duplicates' '
+	clear_packs &&
+	create_pack 2 >dups.pack &&
+	git -c pack.indexDuplicates=skip index-pack --stdin <dups.pack &&
+	git cat-file --batch-check <input >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.4.rc2.28.g6bb5f3f
