Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CC3CD6137
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 20:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378103AbjJIU6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 16:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377082AbjJIU6l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 16:58:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F5F92
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 13:58:40 -0700 (PDT)
Received: (qmail 24305 invoked by uid 109); 9 Oct 2023 20:58:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 20:58:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18509 invoked by uid 111); 9 Oct 2023 20:58:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 16:58:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 16:58:38 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 02/20] t: add library for munging chunk-format files
Message-ID: <20231009205838.GB3282181@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When testing corruption of files using the chunk format (like
commit-graphs and midx files), it's helpful to be able to modify bytes
in specific chunks. This requires being able both to read the
table-of-contents (to find the chunk to modify) but also to adjust it
(to account for size changes in the offsets of subsequent chunks).

We have some tests already which corrupt chunk files, but they have some
downsides:

  1. They are very brittle, as they manually compute the expected size
     of a particular instance of the file (e.g., see the definitions
     starting with NUM_OBJECTS in t5319).

  2. Because they rely on manual offsets and don't read the
     table-of-contents, they're limited to overwriting bytes. But there
     are many interesting corruptions that involve changing the sizes of
     chunks (especially smaller-than-expected ones).

This patch adds a perl script which makes such corruptions easy. We'll
use it in subsequent patches.

Note that we could get by with just a big "perl -e" inside the helper
function. I chose to put it in a separate script for two reasons. One,
so we don't have to worry about the extra layer of shell quoting. And
two, the script is kind of big, and running the tests with "-x" would
repeatedly dump it into the log output.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-chunk.sh                    | 17 ++++++++
 t/lib-chunk/corrupt-chunk-file.pl | 66 +++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 t/lib-chunk.sh
 create mode 100644 t/lib-chunk/corrupt-chunk-file.pl

diff --git a/t/lib-chunk.sh b/t/lib-chunk.sh
new file mode 100644
index 0000000000..a7cd9c3c6d
--- /dev/null
+++ b/t/lib-chunk.sh
@@ -0,0 +1,17 @@
+# Shell library for working with "chunk" files (commit-graph, midx, etc).
+
+# corrupt_chunk_file <fn> <chunk> <offset> <bytes>
+#
+# Corrupt a chunk-based file (like a commit-graph) by overwriting the bytes
+# found in the chunk specified by the 4-byte <chunk> identifier. If <offset> is
+# "clear", replace the chunk entirely. Otherwise, overwrite data <offset> bytes
+# into the chunk.
+#
+# The <bytes> are interpreted as pairs of hex digits (so "000000FE" would be
+# big-endian 254).
+corrupt_chunk_file () {
+	fn=$1; shift
+	perl "$TEST_DIRECTORY"/lib-chunk/corrupt-chunk-file.pl \
+		"$@" <"$fn" >"$fn.tmp" &&
+	mv "$fn.tmp" "$fn"
+}
diff --git a/t/lib-chunk/corrupt-chunk-file.pl b/t/lib-chunk/corrupt-chunk-file.pl
new file mode 100644
index 0000000000..cd6d386fef
--- /dev/null
+++ b/t/lib-chunk/corrupt-chunk-file.pl
@@ -0,0 +1,66 @@
+#!/usr/bin/perl
+
+my ($chunk, $seek, $bytes) = @ARGV;
+$bytes =~ s/../chr(hex($&))/ge;
+
+binmode STDIN;
+binmode STDOUT;
+
+# A few helpers to read bytes, or read and copy them to the
+# output.
+sub get {
+	my $n = shift;
+	return unless $n;
+	read(STDIN, my $buf, $n)
+		or die "read error or eof: $!\n";
+	return $buf;
+}
+sub copy {
+	my $buf = get(@_);
+	print $buf;
+	return $buf;
+}
+
+# read until we find table-of-contents entry for chunk;
+# note that we cheat a bit by assuming 4-byte alignment and
+# that no ToC entry will accidentally look like a header.
+#
+# If we don't find the entry, copy() will hit EOF and exit
+# (which should cause the caller to fail the test).
+while (copy(4) ne $chunk) { }
+my $offset = unpack("Q>", copy(8));
+
+# In clear mode, our length will change. So figure out
+# the length by comparing to the offset of the next chunk, and
+# then adjust that offset (and all subsequent) ones.
+my $len;
+if ($seek eq "clear") {
+	my $id;
+	do {
+		$id = copy(4);
+		my $next = unpack("Q>", get(8));
+		if (!defined $len) {
+			$len = $next - $offset;
+		}
+		print pack("Q>", $next - $len + length($bytes));
+	} while (unpack("N", $id));
+}
+
+# and now copy up to our existing chunk data
+copy($offset - tell(STDIN));
+if ($seek eq "clear") {
+	# if clearing, skip past existing data
+	get($len);
+} else {
+	# otherwise, copy up to the requested offset,
+	# and skip past the overwritten bytes
+	copy($seek);
+	get(length($bytes));
+}
+
+# now write out the requested bytes, along
+# with any other remaining data
+print $bytes;
+while (read(STDIN, my $buf, 4096)) {
+	print $buf;
+}
-- 
2.42.0.884.g35e1fe1a6a

