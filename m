From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] t5313: test bounds-checks of corrupted/malicious
 pack/idx files
Date: Thu, 25 Feb 2016 09:21:12 -0500
Message-ID: <20160225142112.GA17811@sigill.intra.peff.net>
References: <20160225142004.GA17678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacek Wielemborek <d33tah@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 15:21:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYwnM-0002rs-1j
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 15:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbcBYOVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 09:21:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:49124 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760725AbcBYOVP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 09:21:15 -0500
Received: (qmail 6557 invoked by uid 102); 25 Feb 2016 14:21:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 09:21:14 -0500
Received: (qmail 21386 invoked by uid 107); 25 Feb 2016 14:21:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 09:21:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Feb 2016 09:21:12 -0500
Content-Disposition: inline
In-Reply-To: <20160225142004.GA17678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287391>

Our on-disk .pack and .idx files may reference other data by
offset. We should make sure that we are not fooled by
corrupt data into accessing memory outside of our mmap'd
boundaries.

This patch adds a series of tests for offsets found in .pack
and .idx files. For the most part we get this right, but
there are two tests of .idx files marked as failures: we do
not bounds-check offsets in the v2 index's extended offset
table, nor do we handle .idx offsets that overflow a signed
off_t.

With these tests, we should have good coverage of all
offsets found in these files. Note that this doesn't cover
.bitmap files, which may have similar bugs.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5313-pack-bounds-checks.sh | 179 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)
 create mode 100755 t/t5313-pack-bounds-checks.sh

diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
new file mode 100755
index 0000000..efc5197
--- /dev/null
+++ b/t/t5313-pack-bounds-checks.sh
@@ -0,0 +1,179 @@
+#!/bin/sh
+
+test_description='bounds-checking of access to mmapped on-disk file formats'
+. ./test-lib.sh
+
+clear_base () {
+	test_when_finished 'restore_base' &&
+	rm -f $base
+}
+
+restore_base () {
+	cp base-backup/* .git/objects/pack/
+}
+
+do_pack () {
+	pack_objects=$1; shift
+	sha1=$(
+		for i in $pack_objects
+		do
+			echo $i
+		done | git pack-objects "$@" .git/objects/pack/pack
+	) &&
+	pack=.git/objects/pack/pack-$sha1.pack &&
+	idx=.git/objects/pack/pack-$sha1.idx &&
+	chmod +w $pack $idx &&
+	test_when_finished 'rm -f "$pack" "$idx"'
+}
+
+munge () {
+	printf "$3" | dd of="$1" bs=1 conv=notrunc seek=$2
+}
+
+# Offset in a v2 .idx to its initial and extended offset tables. For an index
+# with "nr" objects, this is:
+#
+#   magic(4) + version(4) + fan-out(4*256) + sha1s(20*nr) + crc(4*nr),
+#
+# for the initial, and another ofs(4*nr) past that for the extended.
+#
+ofs_table () {
+	echo $((4 + 4 + 4*256 + 20*$1 + 4*$1))
+}
+extended_table () {
+	echo $(($(ofs_table "$1") + 4*$1))
+}
+
+test_expect_success 'set up base packfile and variables' '
+	# the hash of this content starts with ff, which
+	# makes some later computations much simpler
+	echo 74 >file &&
+	git add file &&
+	git commit -m base &&
+	git repack -ad &&
+	base=$(echo .git/objects/pack/*) &&
+	chmod +w $base &&
+	mkdir base-backup &&
+	cp $base base-backup/ &&
+	object=$(git rev-parse HEAD:file)
+'
+
+test_expect_success 'pack/index object count mismatch' '
+	do_pack $object &&
+	munge $pack 8 "\377\0\0\0" &&
+	clear_base &&
+
+	# We enumerate the objects from the completely-fine
+	# .idx, but notice later that the .pack is bogus
+	# and fail to show any data.
+	echo "$object missing" >expect &&
+	git cat-file --batch-all-objects --batch-check >actual &&
+	test_cmp expect actual &&
+
+	# ...and here fail to load the object (without segfaulting),
+	# but fallback to a good copy if available.
+	test_must_fail git cat-file blob $object &&
+	restore_base &&
+	git cat-file blob $object >actual &&
+	test_cmp file actual &&
+
+	# ...and make sure that index-pack --verify, which has its
+	# own reading routines, does not segfault.
+	test_must_fail git index-pack --verify $pack
+'
+
+test_expect_success 'matched bogus object count' '
+	do_pack $object &&
+	munge $pack 8 "\377\0\0\0" &&
+	munge $idx $((255 * 4)) "\377\0\0\0" &&
+	clear_base &&
+
+	# Unlike above, we should notice early that the .idx is totally
+	# bogus, and not even enumerate its contents.
+	>expect &&
+	git cat-file --batch-all-objects --batch-check >actual &&
+	test_cmp expect actual &&
+
+	# But as before, we can do the same object-access checks.
+	test_must_fail git cat-file blob $object &&
+	restore_base &&
+	git cat-file blob $object >actual &&
+	test_cmp file actual &&
+
+	test_must_fail git index-pack --verify $pack
+'
+
+# Note that we cannot check the fallback case for these
+# further .idx tests, as we notice the problem in functions
+# whose interface doesn't allow an error return (like use_pack()),
+# and thus we just die().
+#
+# There's also no point in doing enumeration tests, as
+# we are munging offsets here, which are about looking up
+# specific objects.
+
+test_expect_success 'bogus object offset (v1)' '
+	do_pack $object --index-version=1 &&
+	munge $idx $((4 * 256)) "\377\0\0\0" &&
+	clear_base &&
+	test_must_fail git cat-file blob $object &&
+	test_must_fail git index-pack --verify $pack
+'
+
+test_expect_success 'bogus object offset (v2, no msb)' '
+	do_pack $object --index-version=2 &&
+	munge $idx $(ofs_table 1) "\0\377\0\0" &&
+	clear_base &&
+	test_must_fail git cat-file blob $object &&
+	test_must_fail git index-pack --verify $pack
+'
+
+test_expect_failure 'bogus offset into v2 extended table' '
+	do_pack $object --index-version=2 &&
+	munge $idx $(ofs_table 1) "\377\0\0\0" &&
+	clear_base &&
+	test_must_fail git cat-file blob $object &&
+	test_must_fail git index-pack --verify $pack
+'
+
+test_expect_failure 'bogus offset inside v2 extended table' '
+	# We need two objects here, so we can plausibly require
+	# an extended table (if the first object were larger than 2^31).
+	do_pack "$object $(git rev-parse HEAD)" --index-version=2 &&
+
+	# We have to make extra room for the table, so we cannot
+	# just munge in place as usual.
+	{
+		dd if=$idx bs=1 count=$(($(ofs_table 2) + 4)) &&
+		printf "\200\0\0\0" &&
+		printf "\377\0\0\0\0\0\0\0" &&
+		dd if=$idx bs=1 skip=$(extended_table 2)
+	} >tmp &&
+	mv tmp "$idx" &&
+	clear_base &&
+	test_must_fail git cat-file blob $object &&
+	test_must_fail git index-pack --verify $pack
+'
+
+test_expect_success 'bogus OFS_DELTA in packfile' '
+	# Generate a pack with a delta in it.
+	base=$(test-genrandom foo 3000 | git hash-object --stdin -w) &&
+	delta=$(test-genrandom foo 2000 | git hash-object --stdin -w) &&
+	do_pack "$base $delta" --delta-base-offset &&
+	rm -f .git/objects/??/* &&
+
+	# Double check that we have the delta we expect.
+	echo $base >expect &&
+	echo $delta | git cat-file --batch-check="%(deltabase)" >actual &&
+	test_cmp expect actual &&
+
+	# Now corrupt it. We assume the varint size for the delta is small
+	# enough to fit in the first byte (which it should be, since it
+	# is a pure deletion from the base), and that original ofs_delta
+	# takes 2 bytes (which it should, as it should be ~3000).
+	ofs=$(git show-index <$idx | grep $delta | cut -d" " -f1) &&
+	munge $pack $(($ofs + 1)) "\177\377" &&
+	test_must_fail git cat-file blob $delta >/dev/null
+'
+
+test_done
-- 
2.7.2.695.gf3fde8e
