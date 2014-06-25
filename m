From: Jeff King <peff@peff.net>
Subject: [PATCH 4/8] add functions for memory-efficient bitmaps
Date: Wed, 25 Jun 2014 19:40:01 -0400
Message-ID: <20140625234000.GD23146@sigill.intra.peff.net>
References: <20140625233429.GA20457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 01:40:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzwnR-0003E0-FT
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 01:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308AbaFYXkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 19:40:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:51221 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752641AbaFYXkC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 19:40:02 -0400
Received: (qmail 5036 invoked by uid 102); 25 Jun 2014 23:40:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Jun 2014 18:40:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jun 2014 19:40:01 -0400
Content-Disposition: inline
In-Reply-To: <20140625233429.GA20457@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252476>

We already have a nice-to-use bitmap implementation in
ewah/bitmap.c. It pretends to be infinitely long when asking
for a bit (and just returns 0 for bits that haven't been
allocated or set), and dynamically resizes as appropriate
when you set bits.

The cost to this is that each bitmap must store its own
pointer and length, using up to 16 bytes per bitmap on top
of the actual bit storage. This is a lot of storage (not to
mention an extra level of pointer indirection) if you are
going to store one bitmap per commit in a traversal.

These functions provide an alternative bitmap implementation
that can be used when you have a large number of fixed-size
bitmaps. See the documentation in the header file for
details and examples.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile |   1 +
 bitset.h | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 bitset.h

diff --git a/Makefile b/Makefile
index 07ea105..8158fd2 100644
--- a/Makefile
+++ b/Makefile
@@ -633,6 +633,7 @@ LIB_H += archive.h
 LIB_H += argv-array.h
 LIB_H += attr.h
 LIB_H += bisect.h
+LIB_H += bitset.h
 LIB_H += blob.h
 LIB_H += branch.h
 LIB_H += builtin.h
diff --git a/bitset.h b/bitset.h
new file mode 100644
index 0000000..5fbc956
--- /dev/null
+++ b/bitset.h
@@ -0,0 +1,113 @@
+#ifndef BITSET_H
+#define BITSET_H
+
+/*
+ * This header file provides functions for operating on an array of unsigned
+ * characters as a bitmap. There is zero per-bitset storage overhead beyond the
+ * actual number of stored bits (modulo some padding). This is efficient, but
+ * makes the API harder to use. In particular, each bitset does not know how
+ * long it is. It is the caller's responsibility to:
+ *
+ *   1. Never ask to get or set a bit outside of the allocated range.
+ *
+ *   2. Provide the allocated range to any functions which operate
+ *      on the whole bitset (e.g., bitset_or).
+ *
+ *   3. Always feed bitsets of the same size to functions which require it
+ *      (e.g., bitset_or).
+ *
+ * It is mostly intended to be used with commit-slabs to store N bits per
+ * commit. Here's an example:
+ *
+ *   define_commit_slab(bit_slab, unsigned char);
+ *
+ *   ... assume we want to store nr bits per commit ...
+ *   struct bit_slab bits;
+ *   init_bit_slab_with_stride(&bits, bitset_sizeof(nr));
+ *
+ *   ... set a bit (make sure 10 < nr!) ...
+ *   bitset_set(bit_slab_at(&bits, commit), 10);
+ *
+ *   ... or get a bit ...
+ *   if (bitset_get(bit_slab_at(&bits, commit), 5))
+ *
+ *   ... propagate bits to a parent commit ...
+ *   bitset_or(bit_slab_at(&bits, parent),
+ *	       bit_slab_at(&bits, commit),
+ *	       nr);
+ */
+
+/*
+ * Return the number of unsigned chars required to store num_bits bits.
+ *
+ * This is mostly used internally by the bitset functions, but you may need it
+ * when allocating the bitset. Example:
+ *
+ *   bits = xcalloc(1, bitset_sizeof(nr));
+ */
+static inline int bitset_sizeof(int num_bits)
+{
+	return (num_bits + CHAR_BIT - 1) / CHAR_BIT;
+}
+
+/*
+ * Set the bit at position "n". "n" is counted from zero, and must be
+ * smaller than the num_bits given to bitset_sizeof when allocating the bitset.
+ */
+static inline void bitset_set(unsigned char *bits, int n)
+{
+	bits[n / CHAR_BIT] |= 1 << (n % CHAR_BIT);
+}
+
+/*
+ * Return the bit at position "n" (see bitset_set for a description of "n").
+ */
+static inline int bitset_get(unsigned char *bits, int n)
+{
+	return !!(bits[n / CHAR_BIT] & (1 << (n % CHAR_BIT)));
+}
+
+/*
+ * Return true iff the bitsets contain the same bits. Each bitset should be the
+ * same size, and should have been allocated using bitset_sizeof(max).
+ *
+ * Note that it is not safe to check partial equality by providing a smaller
+ * "max" (we assume any bits beyond "max" up to the next CHAR_BIT boundary are
+ * zeroed padding).
+ */
+static inline int bitset_equal(unsigned char *a, unsigned char *b, int max)
+{
+	int i;
+	for (i = bitset_sizeof(max); i > 0; i--)
+		if (*a++ != *b++)
+			return 0;
+	return 1;
+}
+
+/*
+ * Bitwise-or the bitsets in "dst" and "src", and store the result in "dst".
+ *
+ * See bitset_equal for the definition of "max".
+ */
+static inline void bitset_or(unsigned char *dst, const unsigned char *src, int max)
+{
+	int i;
+	for (i = bitset_sizeof(max); i > 0; i--)
+		*dst++ |= *src++;
+}
+
+/*
+ * Returns true iff the bitset contains all zeroes.
+ *
+ * See bitset_equal for the definition of "max".
+ */
+static inline int bitset_empty(const unsigned char *bits, int max)
+{
+	int i;
+	for (i = bitset_sizeof(max); i > 0; i--, bits++)
+		if (*bits)
+			return 0;
+	return 1;
+}
+
+#endif /* BITSET_H */
-- 
2.0.0.566.gfe3e6b2
