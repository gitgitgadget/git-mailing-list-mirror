From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] xdiff: load full words in the inner loop of xdl_hash_record
Date: Mon, 12 Mar 2012 16:10:13 +0100
Message-ID: <1e11b1466ea3209cfe74e1dd8dff45f8666e942b.1331564754.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 16:10:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S76tG-0001iv-Ub
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 16:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755786Ab2CLPKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 11:10:22 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:39345 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755825Ab2CLPKS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 11:10:18 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 16:10:14 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 16:10:13 +0100
X-Mailer: git-send-email 1.7.10.rc0.230.g16d90
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192873>

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

So far we enable this only on x86; perhaps other platforms could also
benefit.  However it does NOT work on big-endian systems!

The resulting speedup is about 7% in 'log -p' workloads:

 Test                                  t/proper-xdl-speedup   origin/master             
 -------------------------------------------------------------------------------------
 4000.1: log -3000 (baseline)          0.08(0.06+0.01)        0.08(0.07+0.01) +3.0%     
 4000.2: log --raw -3000 (tree-only)   0.40(0.34+0.04)        0.40(0.34+0.05) -1.6%     
 4000.3: log -p -3000 (Myers)          1.63(1.51+0.10)        1.75(1.64+0.10) +7.4%***  
 4000.4: log -p -3000 --histogram      1.60(1.50+0.09)        1.73(1.63+0.08) +8.4%***  
 4000.5: log -p -3000 --patience       1.95(1.83+0.10)        2.07(1.96+0.10) +6.5%***  
 -------------------------------------------------------------------------------------
 Significance hints:  '.' 0.1  '*' 0.05  '**' 0.01  '***' 0.001

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Also definitely post-v1.7.10 material, but I figure many people will
be interested.  Since it's such a central part of much of git, it's
also quite important that it gets tested heavily.

For blame I get the following speedups:

 Test                                  t/proper-xdl-speedup   origin/master             
 ---------------------------------------------------------------------------------------
 8002.2: blame                         1.93(1.80+0.12)        1.92(1.79+0.12) -0.8%*    
 8002.3: blame -M                      2.05(1.91+0.12)        2.04(1.90+0.12) -0.4%     
 8002.4: blame -C                      2.26(2.11+0.13)        2.24(2.10+0.12) -1.0%*    
 8002.5: blame -C -C                   3.34(3.15+0.18)        3.47(3.28+0.18) +3.9%***  
 8002.6: blame -C -C -C                13.76(13.29+0.42)      14.72(14.27+0.41) +7.0%***
 ---------------------------------------------------------------------------------------
 Significance hints:  '.' 0.1  '*' 0.05  '**' 0.01  '***' 0.001

This is using p8002 and the t-test from the perf series I am sending
out in parallel.  It strikes me as odd that blame does not benefit
unless it uses at least -C -C; my understanding is that blame consists
largely of diffing.  Apparently there's more to it...


 Makefile       |   12 +++++++
 xdiff/xutils.c |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

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
index 0de084e..415e08a 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -20,6 +20,8 @@
  *
  */
 
+#include <limits.h>
+#include <assert.h>
 #include "xinclude.h"
 
 
@@ -276,6 +278,111 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
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
+		 */
+		char const *p;
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
@@ -293,6 +400,7 @@ unsigned long xdl_hash_record(char const **data, char const *top, long flags) {
 	return ha;
 }
 
+#endif /* XDL_FAST_HASH */
 
 unsigned int xdl_hashbits(unsigned int size) {
 	unsigned int val = 1, bits = 0;
-- 
1.7.10.rc0.230.g16d90
