From: Jeff King <peff@peff.net>
Subject: [PATCH v3 09/21] documentation: add documentation for the bitmap
 format
Date: Thu, 14 Nov 2013 07:44:02 -0500
Message-ID: <20131114124402.GI10757@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 13:44:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgwHJ-0007t1-Ph
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 13:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab3KNMoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 07:44:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:39125 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753708Ab3KNMoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 07:44:04 -0500
Received: (qmail 11457 invoked by uid 102); 14 Nov 2013 12:44:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Nov 2013 06:44:03 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Nov 2013 07:44:02 -0500
Content-Disposition: inline
In-Reply-To: <20131114124157.GA23784@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237833>

From: Vicent Marti <tanoku@gmail.com>

This is the technical documentation for the JGit-compatible Bitmap v1
on-disk format.

Signed-off-by: Vicent Marti <tanoku@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/bitmap-format.txt | 131 ++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 Documentation/technical/bitmap-format.txt

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
new file mode 100644
index 0000000..7a86bd7
--- /dev/null
+++ b/Documentation/technical/bitmap-format.txt
@@ -0,0 +1,131 @@
+GIT bitmap v1 format
+====================
+
+	- A header appears at the beginning:
+
+		4-byte signature: {'B', 'I', 'T', 'M'}
+
+		2-byte version number (network byte order)
+			The current implementation only supports version 1
+			of the bitmap index (the same one as JGit).
+
+		2-byte flags (network byte order)
+
+			The following flags are supported:
+
+			- BITMAP_OPT_FULL_DAG (0x1) REQUIRED
+			This flag must always be present. It implies that the bitmap
+			index has been generated for a packfile with full closure
+			(i.e. where every single object in the packfile can find
+			 its parent links inside the same packfile). This is a
+			requirement for the bitmap index format, also present in JGit,
+			that greatly reduces the complexity of the implementation.
+
+		4-byte entry count (network byte order)
+
+			The total count of entries (bitmapped commits) in this bitmap index.
+
+		20-byte checksum
+
+			The SHA1 checksum of the pack this bitmap index belongs to.
+
+	- 4 EWAH bitmaps that act as type indexes
+
+		Type indexes are serialized after the hash cache in the shape
+		of four EWAH bitmaps stored consecutively (see Appendix A for
+		the serialization format of an EWAH bitmap).
+
+		There is a bitmap for each Git object type, stored in the following
+		order:
+
+			- Commits
+			- Trees
+			- Blobs
+			- Tags
+
+		In each bitmap, the `n`th bit is set to true if the `n`th object
+		in the packfile is of that type.
+
+		The obvious consequence is that the OR of all 4 bitmaps will result
+		in a full set (all bits set), and the AND of all 4 bitmaps will
+		result in an empty bitmap (no bits set).
+
+	- N entries with compressed bitmaps, one for each indexed commit
+
+		Where `N` is the total amount of entries in this bitmap index.
+		Each entry contains the following:
+
+		- 4-byte object position (network byte order)
+			The position **in the index for the packfile** where the
+			bitmap for this commit is found.
+
+		- 1-byte XOR-offset
+			The xor offset used to compress this bitmap. For an entry
+			in position `x`, a XOR offset of `y` means that the actual
+			bitmap representing this commit is composed by XORing the
+			bitmap for this entry with the bitmap in entry `x-y` (i.e.
+			the bitmap `y` entries before this one).
+
+			Note that this compression can be recursive. In order to
+			XOR this entry with a previous one, the previous entry needs
+			to be decompressed first, and so on.
+
+			The hard-limit for this offset is 160 (an entry can only be
+			xor'ed against one of the 160 entries preceding it). This
+			number is always positive, and hence entries are always xor'ed
+			with **previous** bitmaps, not bitmaps that will come afterwards
+			in the index.
+
+		- 1-byte flags for this bitmap
+			At the moment the only available flag is `0x1`, which hints
+			that this bitmap can be re-used when rebuilding bitmap indexes
+			for the repository.
+
+		- The compressed bitmap itself, see Appendix A.
+
+== Appendix A: Serialization format for an EWAH bitmap
+
+Ewah bitmaps are serialized in the same protocol as the JAVAEWAH
+library, making them backwards compatible with the JGit
+implementation:
+
+	- 4-byte number of bits of the resulting UNCOMPRESSED bitmap
+
+	- 4-byte number of words of the COMPRESSED bitmap, when stored
+
+	- N x 8-byte words, as specified by the previous field
+
+		This is the actual content of the compressed bitmap.
+
+	- 4-byte position of the current RLW for the compressed
+		bitmap
+
+All words are stored in network byte order for their corresponding
+sizes.
+
+The compressed bitmap is stored in a form of run-length encoding, as
+follows.  It consists of a concatenation of an arbitrary number of
+chunks.  Each chunk consists of one or more 64-bit words
+
+     H  L_1  L_2  L_3 .... L_M
+
+H is called RLW (run length word).  It consists of (from lower to higher
+order bits):
+
+     - 1 bit: the repeated bit B
+
+     - 32 bits: repetition count K (unsigned)
+
+     - 31 bits: literal word count M (unsigned)
+
+The bitstream represented by the above chunk is then:
+
+     - K repetitions of B
+
+     - The bits stored in `L_1` through `L_M`.  Within a word, bits at
+       lower order come earlier in the stream than those at higher
+       order.
+
+The next word after `L_M` (if any) must again be a RLW, for the next
+chunk.  For efficient appending to the bitstream, the EWAH stores a
+pointer to the last RLW in the stream.
-- 
1.8.5.rc0.443.g2df7f3f
