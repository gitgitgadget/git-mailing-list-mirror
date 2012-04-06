From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] xdiff: load full words in the inner loop of xdl_hash_record
Date: Fri, 6 Apr 2012 23:01:23 +0200
Message-ID: <e0f938e9b849108e958da2e45e177f6f33d1118d.1333745883.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 06 23:01:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGGHt-000117-V5
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 23:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758027Ab2DFVBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 17:01:37 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:10449 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755384Ab2DFVBg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 17:01:36 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Fri, 6 Apr
 2012 23:01:30 +0200
Received: from thomas.inf.ethz.net (80.219.158.96) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 6 Apr
 2012 23:01:33 +0200
X-Mailer: git-send-email 1.7.10.241.g545e6
X-Originating-IP: [80.219.158.96]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194906>

Redo the hashing loop in xdl_hash_record in a way that loads an entire
'long' at a time, using masking tricks to see when and where we found
the terminating '\n'.

I stole inspiration and code from the posts by Linus Torvalds around

  https://lkml.org/lkml/2012/3/2/452
  https://lkml.org/lkml/2012/3/5/6

His method reads the buffers in sizeof(long) increments, and may thus
overrun it by at most sizeof(long)-1 bytes before it sees the final
newline (or hits the buffer length check).  I considered padding out
all buffers by a suitable amount to "catch" the overrun, but

* this does not work for mmap()'d buffers: if you map 4096+8 bytes
  from a 4096 byte file, accessing the last 8 bytes results in a
  SIGBUS on my machine; and

* it would also be extremely ugly because it intrudes deep into the
  unpacking machinery.

So I adapted it to not read beyond the buffer at all.  Instead, it
reads the final partial word byte-by-byte and strings it together.
Then it can use the same logic as before to finish the hashing.

So far we enable this only on x86_64, where it provides nice speedup
for diff-related work:

  Test                                  origin/next      tr/xdiff-fast-hash
  -----------------------------------------------------------------------------
  4000.1: log -3000 (baseline)          0.07(0.05+0.02)  0.08(0.06+0.02) +14.3%
  4000.2: log --raw -3000 (tree-only)   0.37(0.33+0.04)  0.37(0.32+0.04) +0.0%
  4000.3: log -p -3000 (Myers)          1.75(1.65+0.09)  1.60(1.49+0.10) -8.6%
  4000.4: log -p -3000 --histogram      1.73(1.62+0.09)  1.58(1.49+0.08) -8.7%
  4000.5: log -p -3000 --patience       2.11(2.00+0.10)  1.94(1.80+0.11) -8.1%

Perhaps other platforms could also benefit.  However it does NOT work
on big-endian systems!

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Resending this now that 1.7.10 has been released.  There is one change
compared to the earlier version: the loading of the final partial word
used

  a = (a << 8) + *p

where p is 'char *'.  This broke if *p has a high bit, because 'char'
is signed here.  It now uses an unsigned char.

I have verified that in both the git and linux repositories, all
patch-ids are the same with the old and new hashing.


 Makefile       |   12 ++++++
 xdiff/xutils.c |  111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/Makefile b/Makefile
index be1957a..13ed1b1 100644
--- a/Makefile
+++ b/Makefile
@@ -288,6 +288,11 @@ all::
 # dependency rules.
 #
 # Define NATIVE_CRLF if your platform uses CRLF for line endings.
+#
+# Define XDL_FAST_HASH to use an alternative line-hashing method in
+# the diff algorithm.  It gives a nice speedup if your processor has
+# fast unaligned word loads.  Does NOT work on big-endian systems!
+# Enabled by default on x86_64.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -864,6 +869,9 @@ EXTLIBS =
 # because maintaining the nesting to match is a pain.  If
 # we had "elif" things would have been much nicer...
 
+ifeq ($(uname_M),x86_64)
+	XDL_FAST_HASH = YesPlease
+endif
 ifeq ($(uname_S),OSF1)
 	# Need this for u_short definitions et al
 	BASIC_CFLAGS += -D_OSF_SOURCE
@@ -1737,6 +1745,10 @@ ifndef NO_MSGFMT_EXTENDED_OPTIONS
 	MSGFMT += --check --statistics
 endif
 
+ifneq (,$(XDL_FAST_HASH))
+	BASIC_CFLAGS += -DXDL_FAST_HASH
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK=NoThanks
 endif
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 0de084e..b198488 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -20,6 +20,8 @@
  *
  */
 
+#include <limits.h>
+#include <assert.h>
 #include "xinclude.h"
 
 
@@ -276,6 +278,114 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
 	return ha;
 }
 
+#ifdef XDL_FAST_HASH
+
+#define ONEBYTES	0x0101010101010101ul
+#define NEWLINEBYTES	0x0a0a0a0a0a0a0a0aul
+#define HIGHBITS	0x8080808080808080ul
+
+/* Return the high bit set in the first byte that is a zero */
+static inline unsigned long has_zero(unsigned long a)
+{
+	return ((a - ONEBYTES) & ~a) & HIGHBITS;
+}
+
+#if __WORDSIZE == 64
+
+/*
+ * Jan Achrenius on G+: microoptimized version of
+ * the simpler "(mask & ONEBYTES) * ONEBYTES >> 56"
+ * that works for the bytemasks without having to
+ * mask them first.
+ */
+static inline long count_masked_bytes(unsigned long mask)
+{
+	return mask*0x0001020304050608 >> 56;
+}
+
+#else	/* 32-bit case */
+
+/* Modified Carl Chatfield G+ version for 32-bit */
+static inline long count_masked_bytes(long mask)
+{
+	/*
+	 * (a) gives us
+	 *   -1 (0, ff), 0 (ffff) or 1 (ffffff)
+	 * (b) gives us
+	 *   0 for 0, 1 for (ff ffff ffffff)
+	 * (a+b+1) gives us
+	 *   correct 0-3 bytemask count result
+	 */
+	long a = (mask-256) >> 23;
+	long b = mask & 1;
+	return a + b + 1;
+}
+
+#endif
+
+unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
+	unsigned long hash = 5381;
+	unsigned long a = 0, mask = 0;
+	char const *ptr = *data;
+	char const *end = top-sizeof(unsigned long)+1;
+
+	if (flags & XDF_WHITESPACE_FLAGS)
+		return xdl_hash_record_with_whitespace(data, top, flags);
+
+	ptr -= sizeof(unsigned long);
+	do {
+		hash += hash << 5;
+		hash ^= a;
+		ptr += sizeof(unsigned long);
+		if (ptr >= end)
+			break;
+		a = *(unsigned long *)ptr;
+		/* Do we have any '\n' bytes in this word? */
+		mask = has_zero(a ^ NEWLINEBYTES);
+	} while (!mask);
+
+	if (ptr >= end) {
+		/*
+		 * There is only a partial word left at the end of the
+		 * buffer. Because we may work with a memory mapping,
+		 * we have to grab the rest byte by byte instead of
+		 * blindly reading it.
+		 *
+		 * To avoid problems with masking in a signed value,
+		 * we use an unsigned char here.
+		 */
+		unsigned char const *p;
+		for (p = top-1; p >= ptr; p--)
+			a = (a << 8) + *p;
+		mask = has_zero(a ^ NEWLINEBYTES);
+		if (!mask)
+			/*
+			 * No '\n' found in the partial word.  Make a
+			 * mask that matches what we read.
+			 */
+			mask = 1UL << (8*(top-ptr)+7);
+	}
+
+	/* The mask *below* the first high bit set */
+	mask = (mask - 1) & ~mask;
+	mask >>= 7;
+	hash += hash << 5;
+	hash ^= a & mask;
+
+	/* Advance past the last (possibly partial) word */
+	ptr += count_masked_bytes(mask);
+
+	if (ptr < top) {
+		assert (*ptr == '\n');
+		ptr++;
+	}
+
+	*data = ptr;
+
+	return hash;
+}
+
+#else /* XDL_FAST_HASH */
 
 unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
 	unsigned long ha = 5381;
@@ -293,6 +403,7 @@ unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
 	return ha;
 }
 
+#endif /* XDL_FAST_HASH */
 
 unsigned int xdl_hashbits(unsigned int size) {
 	unsigned int val = 1, bits = 0;
-- 
1.7.10.241.g545e6
