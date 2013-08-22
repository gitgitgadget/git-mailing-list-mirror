From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] sha1-lookup: handle duplicate keys with GIT_USE_LOOKUP
Date: Thu, 22 Aug 2013 19:14:04 -0400
Message-ID: <20130822231404.GB17060@sigill.intra.peff.net>
References: <20130822231215.GA16978@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 23 01:14:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCe50-0008PI-7U
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 01:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754342Ab3HVXOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 19:14:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:60014 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753865Ab3HVXOI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 19:14:08 -0400
Received: (qmail 23871 invoked by uid 102); 22 Aug 2013 23:14:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Aug 2013 18:14:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Aug 2013 19:14:04 -0400
Content-Disposition: inline
In-Reply-To: <20130822231215.GA16978@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232788>

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
 sha1-lookup.c                     | 23 ++++++++++++
 t/lib-pack.sh                     | 78 +++++++++++++++++++++++++++++++++++++++
 t/t5308-pack-detect-duplicates.sh | 73 ++++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 t/lib-pack.sh
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
diff --git a/t/lib-pack.sh b/t/lib-pack.sh
new file mode 100644
index 0000000..61c5d19
--- /dev/null
+++ b/t/lib-pack.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+#
+# Support routines for hand-crafting weird or malicious packs.
+#
+# You can make a complete pack like:
+#
+#   pack_header 2 >foo.pack &&
+#   pack_obj e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 >>foo.pack &&
+#   pack_obj e68fe8129b546b101aee9510c5328e7f21ca1d18 >>foo.pack &&
+#   pack_trailer foo.pack
+
+# Print the big-endian 4-byte octal representation of $1
+uint32_octal() {
+	n=$1
+	printf '\%o' $(($n / 16777216)); n=$((n % 16777216))
+	printf '\%o' $(($n /    65536)); n=$((n %    65536))
+	printf '\%o' $(($n /      256)); n=$((n %      256))
+	printf '\%o' $(($n           ));
+}
+
+# Print the big-endian 4-byte binary representation of $1
+uint32_binary() {
+	printf "$(uint32_octal "$1")"
+}
+
+# Print a pack header, version 2, for a pack with $1 objects
+pack_header() {
+	printf 'PACK' &&
+	printf '\0\0\0\2' &&
+	uint32_binary "$1"
+}
+
+# Print the pack data for object $1, as a delta against object $2 (or as a full
+# object if $2 is missing or empty). The output is suitable for including
+# directly in the packfile, and represents the entirety of the object entry.
+# Doing this on the fly (especially picking your deltas) is quite tricky, so we
+# have hardcoded some well-known objects. See the case statements below for the
+# complete list.
+pack_obj() {
+	case "$1" in
+	# empty blob
+	e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
+		case "$2" in
+		'')
+			printf '\060\170\234\003\0\0\0\0\1'
+			return
+			;;
+		esac
+		;;
+
+	# blob containing "\7\76"
+	e68fe8129b546b101aee9510c5328e7f21ca1d18)
+		case "$2" in
+		'')
+			printf '\062\170\234\143\267\3\0\0\116\0\106'
+			return
+			;;
+		esac
+		;;
+	esac
+
+	echo >&2 "BUG: don't know how to print $1${2:+ (from $2)}"
+	return 1
+}
+
+# Compute and append pack trailer to "$1"
+pack_trailer() {
+	test-sha1 -b <"$1" >trailer.tmp &&
+	cat trailer.tmp >>"$1" &&
+	rm -f trailer.tmp
+}
+
+# Remove any existing packs to make sure that
+# whatever we index next will be the pack that we
+# actually use.
+clear_packs() {
+	rm -f .git/objects/pack/*
+}
diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
new file mode 100755
index 0000000..719d48f
--- /dev/null
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+
+test_description='handling of duplicate objects in incoming packfiles'
+. ./test-lib.sh
+. ../lib-pack.sh
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
+# git will never intentionally create packfiles with
+# duplicate objects, so we have to construct them by hand.
+#
+# $1 is the name of the packfile to create
+#
+# $2 is the number of times to duplicate each object
+create_pack() {
+	pack_header "$((2 * $2))" >"$1" &&
+	for i in $(test_seq 1 "$2"); do
+		pack_obj $LO_SHA1 &&
+		pack_obj $HI_SHA1
+	done >>"$1" &&
+	pack_trailer "$1"
+}
+
+# double-check that create_pack actually works
+test_expect_success 'pack with no duplicates' '
+	create_pack no-dups.pack 1 &&
+	git index-pack --stdin <no-dups.pack
+'
+
+test_expect_success 'index-pack will allow duplicate objects by default' '
+	clear_packs &&
+	create_pack dups.pack 100 &&
+	git index-pack --stdin <dups.pack
+'
+
+test_expect_success 'create batch-check test vectors' '
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
