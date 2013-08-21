From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] sha1-lookup: handle duplicate keys with GIT_USE_LOOKUP
Date: Wed, 21 Aug 2013 16:51:18 -0400
Message-ID: <20130821205118.GA28165@sigill.intra.peff.net>
References: <20130821204955.GA28025@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 21 22:51:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCFNF-0008CS-V1
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 22:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902Ab3HUUvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 16:51:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:49711 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864Ab3HUUvV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 16:51:21 -0400
Received: (qmail 11576 invoked by uid 102); 21 Aug 2013 20:51:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Aug 2013 15:51:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Aug 2013 16:51:18 -0400
Content-Disposition: inline
In-Reply-To: <20130821204955.GA28025@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232732>

The sha1_entry_pos function tries to be smart about
selecting the middle of a range for its binary search by
looking at the value differences between the "lo" and "hi"
constraints. However, it is unable to cope with entries with
duplicate keys in the sorted list.

We may hit a point in the search where both our "lo" and
"hi" point to the same key. In this case, the range of
values between our endpoints is 0, and trying to scale the
difference between our key and the endpoints over that range
is undefined (i.e., divide by zero). The current code
catches this with an "assert(lov < hiv)".

Moreover, after seeing that the first 20 byte of the key are
the same, we will try to establish a value from the 21st
byte. Which is nonsensical.

Instead, we can detect the case that we are in a run of
duplicates, and simply do a final comparison against any one
of them (since they are all the same, it does not matter
which). If the keys match, we have found our entry (or one
of them, anyway).  If not, then we know that we do not need
to look further, as we must be in a run of the duplicate
key.

Furthermore, we know that one of our endpoints must be
the edge of the run of duplicates. For example, given this
sequence:

 idx 0 1 2 3 4 5
 key A C C C C D

If we are searching for "B", we might hit the duplicate run
at lo=1, hi=3 (e.g., by first mi=3, then mi=0). But we can
never have lo > 1, because B < C. That is, if our key is
less than the run, we know that "lo" is the edge, but we can
say nothing of "hi". Similarly, if our key is greater than
the run, we know that "hi" is the edge, but we can say
nothing of "lo". But that is enough for us to return not
only "not found", but show the position at which we would
insert the new item.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1-lookup.c                     | 23 ++++++++++
 t/t5308-pack-detect-duplicates.sh | 97 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100755 t/t5308-pack-detect-duplicates.sh

diff --git a/sha1-lookup.c b/sha1-lookup.c
index c4dc55d..614cbb6 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -204,7 +204,30 @@ int sha1_entry_pos(const void *table,
 			 * byte 0 thru (ofs-1) are the same between
 			 * lo and hi; ofs is the first byte that is
 			 * different.
+			 *
+			 * If ofs==20, then no bytes are different,
+			 * meaning we have entries with duplicate
+			 * keys. We know that we are in a solid run
+			 * of this entry (because the entries are
+			 * sorted, and our lo and hi are the same,
+			 * there can be nothing but this single key
+			 * in between). So we can stop the search.
+			 * Either one of these entries is it (and
+			 * we do not care which), or we do not have
+			 * it.
 			 */
+			if (ofs == 20) {
+				mi = lo;
+				mi_key = base + elem_size * mi + key_offset;
+				cmp = memcmp(mi_key, key, 20);
+				if (!cmp)
+					return mi;
+				if (cmp < 0)
+					return -1 - hi;
+				else
+					return -1 - lo;
+			}
+
 			hiv = hi_key[ofs_0];
 			if (ofs_0 < 19)
 				hiv = (hiv << 8) | hi_key[ofs_0+1];
diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
new file mode 100755
index 0000000..4800379
--- /dev/null
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -0,0 +1,97 @@
+#!/bin/sh
+
+test_description='handling of duplicate objects in incoming packfiles'
+. ./test-lib.sh
+
+# git will never intentionally create packfiles with
+# duplicate objects, so we have to construct them by hand.
+#
+# $1 is the number of times to duplicate each object (must be
+# less than 127 for simplicify of implementation).
+create_pack() {
+	{
+		# header magic
+		printf 'PACK' &&
+		# version 2
+		printf '\0\0\0\2' &&
+		# num of objects
+		printf '\0\0\0\'"$(printf "%o" $(($1*2)))" &&
+
+		for i in $(test_seq 1 "$1"); do
+			# blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+			printf '\060\170\234\003\0\0\0\0\1' &&
+			# blob e68fe8129b546b101aee9510c5328e7f21ca1d18
+			printf '\062\170\234\143\267\3\0\0\116\0\106'
+		done
+	} >tmp.pack &&
+	# we store and cat the pack because we also have to output
+	# the sha1 pack trailer
+	cat tmp.pack &&
+	test-sha1 <tmp.pack | hex2bytes &&
+	rm -f tmp.pack
+}
+
+# convert an ascii hex representation of bytes into binary
+hex2bytes() {
+	"$PERL_PATH" -ne 's/[0-9a-f]{2}/print chr hex $&/ge'
+}
+
+# remove any existing packs, since we want to make
+# sure future operations use any new packs we are about
+# to install
+clear_packs() {
+	rm -f .git/objects/pack/*
+}
+
+# The sha1s we have in our pack. It's important that these have the same
+# starting byte, so that they end up in the same fanout section of the index.
+# That lets us make sure we are exercising the binary search with both sets.
+LO_SHA1=e68fe8129b546b101aee9510c5328e7f21ca1d18
+HI_SHA1=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+
+# And here's a "missing sha1" which will produce failed lookups. It must also
+# be in the same fanout section, and should be between the two (so that during
+# our binary search, we are sure to end up looking at one or the other of the
+# duplicate runs).
+MISSING_SHA1='e69d000000000000000000000000000000000000'
+
+# double-check that create_pack actually works
+test_expect_success 'pack with no duplicates' '
+	create_pack 1 >no-dups.pack &&
+	git index-pack --stdin <no-dups.pack
+'
+
+test_expect_success 'index-pack will allow duplicate objects by default' '
+	clear_packs &&
+	create_pack 100 >dups.pack &&
+	git index-pack --stdin <dups.pack
+'
+
+test_expect_success 'create test vectors' '
+	cat >input <<-EOF &&
+	$LO_SHA1
+	$HI_SHA1
+	$MISSING_SHA1
+	EOF
+	cat >expect <<-EOF
+	$LO_SHA1 blob 2
+	$HI_SHA1 blob 0
+	$MISSING_SHA1 missing
+	EOF
+'
+
+test_expect_success 'lookup in duplicated pack (binary search)' '
+	git cat-file --batch-check <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'lookup in duplicated pack (GIT_USE_LOOKUP)' '
+	(
+		GIT_USE_LOOKUP=1 &&
+		export GIT_USE_LOOKUP &&
+		git cat-file --batch-check <input >actual
+	) &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.4.rc2.28.g6bb5f3f
