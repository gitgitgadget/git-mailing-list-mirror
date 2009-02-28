From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] import memmem() with linear complexity from Gnulib
Date: Sat, 28 Feb 2009 20:16:55 +0100
Message-ID: <1235848615.7043.30.camel@ubuntu.ubuntu-domain>
References: <cover.1235629933.git.gitster@pobox.com>
	 <cd73512d11e63554396983ed4e9556b2d18b3e4a.1235629933.git.gitster@pobox.com>
	 <49A88FA7.1020402@lsrfire.ath.cx>
	 <7vy6vrgxnn.fsf@gitster.siamese.dyndns.org>
	 <7v8wnrgkjw.fsf@gitster.siamese.dyndns.org>
	 <49A937B8.1030205@lsrfire.ath.cx>
	 <7vmyc6foj3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 20:20:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdUjw-000735-JY
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 20:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbZB1TRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 14:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753031AbZB1TRG
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 14:17:06 -0500
Received: from india601.server4you.de ([85.25.151.105]:53914 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbZB1TRE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 14:17:04 -0500
Received: from [10.0.1.101] (p57B7BF31.dip.t-dialin.net [87.183.191.49])
	by india601.server4you.de (Postfix) with ESMTPSA id CBA192F8075;
	Sat, 28 Feb 2009 20:16:59 +0100 (CET)
In-Reply-To: <7vmyc6foj3.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111786>

Gnulib and glibc have gained a memmem() implementation using the Two-Way
algorithm, which needs constant space and linear time.  Import it to
compat/ in order to replace the simple quadratic implementation there.

memmem.c and str-two-way.h are copied verbatim from the repository at
git://git.savannah.gnu.org/gnulib.git, with the following changes to
memmem.c to make it fit into git's build environment:

	21,23c21
	< #ifndef _LIBC
	< # include <config.h>
	< #endif
	---
	> #include "../git-compat-util.h"
	40c38
	< memmem (const void *haystack_start, size_t haystack_len,
	---
	> gitmemmem(const void *haystack_start, size_t haystack_len,

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Makefile             |    1 +
 compat/memmem.c      |  103 +++++++++----
 compat/str-two-way.h |  429 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 504 insertions(+), 29 deletions(-)
 rewrite compat/memmem.c (91%)
 create mode 100644 compat/str-two-way.h

diff --git a/Makefile b/Makefile
index 0675c43..b2b15d9 100644
--- a/Makefile
+++ b/Makefile
@@ -359,6 +359,7 @@ LIB_H += cache-tree.h
 LIB_H += commit.h
 LIB_H += compat/cygwin.h
 LIB_H += compat/mingw.h
+LIB_H += compat/str-two-way.h
 LIB_H += csum-file.h
 LIB_H += decorate.h
 LIB_H += delta.h
diff --git a/compat/memmem.c b/compat/memmem.c
dissimilarity index 91%
index cd0d877..b0b7821 100644
--- a/compat/memmem.c
+++ b/compat/memmem.c
@@ -1,29 +1,74 @@
-#include "../git-compat-util.h"
-
-void *gitmemmem(const void *haystack, size_t haystack_len,
-                const void *needle, size_t needle_len)
-{
-	const char *begin = haystack;
-	const char *last_possible = begin + haystack_len - needle_len;
-
-	/*
-	 * The first occurrence of the empty string is deemed to occur at
-	 * the beginning of the string.
-	 */
-	if (needle_len == 0)
-		return (void *)begin;
-
-	/*
-	 * Sanity check, otherwise the loop might search through the whole
-	 * memory.
-	 */
-	if (haystack_len < needle_len)
-		return NULL;
-
-	for (; begin <= last_possible; begin++) {
-		if (!memcmp(begin, needle, needle_len))
-			return (void *)begin;
-	}
-
-	return NULL;
-}
+/* Copyright (C) 1991,92,93,94,96,97,98,2000,2004,2007,2008 Free Software
+   Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2, or (at your option)
+   any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License along
+   with this program; if not, write to the Free Software Foundation,
+   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.  */
+
+/* This particular implementation was written by Eric Blake, 2008.  */
+
+#include "../git-compat-util.h"
+
+/* Specification of memmem.  */
+#include <string.h>
+
+#ifndef _LIBC
+# define __builtin_expect(expr, val)   (expr)
+#endif
+
+#define RETURN_TYPE void *
+#define AVAILABLE(h, h_l, j, n_l) ((j) <= (h_l) - (n_l))
+#include "str-two-way.h"
+
+/* Return the first occurrence of NEEDLE in HAYSTACK.  Return HAYSTACK
+   if NEEDLE_LEN is 0, otherwise NULL if NEEDLE is not found in
+   HAYSTACK.  */
+void *
+gitmemmem(const void *haystack_start, size_t haystack_len,
+	const void *needle_start, size_t needle_len)
+{
+  /* Abstract memory is considered to be an array of 'unsigned char' values,
+     not an array of 'char' values.  See ISO C 99 section 6.2.6.1.  */
+  const unsigned char *haystack = (const unsigned char *) haystack_start;
+  const unsigned char *needle = (const unsigned char *) needle_start;
+
+  if (needle_len == 0)
+    /* The first occurrence of the empty string is deemed to occur at
+       the beginning of the string.  */
+    return (void *) haystack;
+
+  /* Sanity check, otherwise the loop might search through the whole
+     memory.  */
+  if (__builtin_expect (haystack_len < needle_len, 0))
+    return NULL;
+
+  /* Use optimizations in memchr when possible, to reduce the search
+     size of haystack using a linear algorithm with a smaller
+     coefficient.  However, avoid memchr for long needles, since we
+     can often achieve sublinear performance.  */
+  if (needle_len < LONG_NEEDLE_THRESHOLD)
+    {
+      haystack = memchr (haystack, *needle, haystack_len);
+      if (!haystack || __builtin_expect (needle_len == 1, 0))
+	return (void *) haystack;
+      haystack_len -= haystack - (const unsigned char *) haystack_start;
+      if (haystack_len < needle_len)
+	return NULL;
+      return two_way_short_needle (haystack, haystack_len, needle, needle_len);
+    }
+  else
+    return two_way_long_needle (haystack, haystack_len, needle, needle_len);
+}
+
+#undef LONG_NEEDLE_THRESHOLD
diff --git a/compat/str-two-way.h b/compat/str-two-way.h
new file mode 100644
index 0000000..b0338a7
--- /dev/null
+++ b/compat/str-two-way.h
@@ -0,0 +1,429 @@
+/* Byte-wise substring search, using the Two-Way algorithm.
+   Copyright (C) 2008 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+   Written by Eric Blake <ebb9@byu.net>, 2008.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2, or (at your option)
+   any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License along
+   with this program; if not, write to the Free Software Foundation,
+   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.  */
+
+/* Before including this file, you need to include <config.h> and
+   <string.h>, and define:
+     RESULT_TYPE             A macro that expands to the return type.
+     AVAILABLE(h, h_l, j, n_l)
+			     A macro that returns nonzero if there are
+			     at least N_L bytes left starting at H[J].
+			     H is 'unsigned char *', H_L, J, and N_L
+			     are 'size_t'; H_L is an lvalue.  For
+			     NUL-terminated searches, H_L can be
+			     modified each iteration to avoid having
+			     to compute the end of H up front.
+
+  For case-insensitivity, you may optionally define:
+     CMP_FUNC(p1, p2, l)     A macro that returns 0 iff the first L
+			     characters of P1 and P2 are equal.
+     CANON_ELEMENT(c)        A macro that canonicalizes an element right after
+			     it has been fetched from one of the two strings.
+			     The argument is an 'unsigned char'; the result
+			     must be an 'unsigned char' as well.
+
+  This file undefines the macros documented above, and defines
+  LONG_NEEDLE_THRESHOLD.
+*/
+
+#include <limits.h>
+#include <stdint.h>
+
+/* We use the Two-Way string matching algorithm, which guarantees
+   linear complexity with constant space.  Additionally, for long
+   needles, we also use a bad character shift table similar to the
+   Boyer-Moore algorithm to achieve improved (potentially sub-linear)
+   performance.
+
+   See http://www-igm.univ-mlv.fr/~lecroq/string/node26.html#SECTION00260
+   and http://en.wikipedia.org/wiki/Boyer-Moore_string_search_algorithm
+*/
+
+/* Point at which computing a bad-byte shift table is likely to be
+   worthwhile.  Small needles should not compute a table, since it
+   adds (1 << CHAR_BIT) + NEEDLE_LEN computations of preparation for a
+   speedup no greater than a factor of NEEDLE_LEN.  The larger the
+   needle, the better the potential performance gain.  On the other
+   hand, on non-POSIX systems with CHAR_BIT larger than eight, the
+   memory required for the table is prohibitive.  */
+#if CHAR_BIT < 10
+# define LONG_NEEDLE_THRESHOLD 32U
+#else
+# define LONG_NEEDLE_THRESHOLD SIZE_MAX
+#endif
+
+#ifndef MAX
+# define MAX(a, b) ((a < b) ? (b) : (a))
+#endif
+
+#ifndef CANON_ELEMENT
+# define CANON_ELEMENT(c) c
+#endif
+#ifndef CMP_FUNC
+# define CMP_FUNC memcmp
+#endif
+
+/* Perform a critical factorization of NEEDLE, of length NEEDLE_LEN.
+   Return the index of the first byte in the right half, and set
+   *PERIOD to the global period of the right half.
+
+   The global period of a string is the smallest index (possibly its
+   length) at which all remaining bytes in the string are repetitions
+   of the prefix (the last repetition may be a subset of the prefix).
+
+   When NEEDLE is factored into two halves, a local period is the
+   length of the smallest word that shares a suffix with the left half
+   and shares a prefix with the right half.  All factorizations of a
+   non-empty NEEDLE have a local period of at least 1 and no greater
+   than NEEDLE_LEN.
+
+   A critical factorization has the property that the local period
+   equals the global period.  All strings have at least one critical
+   factorization with the left half smaller than the global period.
+
+   Given an ordered alphabet, a critical factorization can be computed
+   in linear time, with 2 * NEEDLE_LEN comparisons, by computing the
+   larger of two ordered maximal suffixes.  The ordered maximal
+   suffixes are determined by lexicographic comparison of
+   periodicity.  */
+static size_t
+critical_factorization (const unsigned char *needle, size_t needle_len,
+			size_t *period)
+{
+  /* Index of last byte of left half, or SIZE_MAX.  */
+  size_t max_suffix, max_suffix_rev;
+  size_t j; /* Index into NEEDLE for current candidate suffix.  */
+  size_t k; /* Offset into current period.  */
+  size_t p; /* Intermediate period.  */
+  unsigned char a, b; /* Current comparison bytes.  */
+
+  /* Invariants:
+     0 <= j < NEEDLE_LEN - 1
+     -1 <= max_suffix{,_rev} < j (treating SIZE_MAX as if it were signed)
+     min(max_suffix, max_suffix_rev) < global period of NEEDLE
+     1 <= p <= global period of NEEDLE
+     p == global period of the substring NEEDLE[max_suffix{,_rev}+1...j]
+     1 <= k <= p
+  */
+
+  /* Perform lexicographic search.  */
+  max_suffix = SIZE_MAX;
+  j = 0;
+  k = p = 1;
+  while (j + k < needle_len)
+    {
+      a = CANON_ELEMENT (needle[j + k]);
+      b = CANON_ELEMENT (needle[max_suffix + k]);
+      if (a < b)
+	{
+	  /* Suffix is smaller, period is entire prefix so far.  */
+	  j += k;
+	  k = 1;
+	  p = j - max_suffix;
+	}
+      else if (a == b)
+	{
+	  /* Advance through repetition of the current period.  */
+	  if (k != p)
+	    ++k;
+	  else
+	    {
+	      j += p;
+	      k = 1;
+	    }
+	}
+      else /* b < a */
+	{
+	  /* Suffix is larger, start over from current location.  */
+	  max_suffix = j++;
+	  k = p = 1;
+	}
+    }
+  *period = p;
+
+  /* Perform reverse lexicographic search.  */
+  max_suffix_rev = SIZE_MAX;
+  j = 0;
+  k = p = 1;
+  while (j + k < needle_len)
+    {
+      a = CANON_ELEMENT (needle[j + k]);
+      b = CANON_ELEMENT (needle[max_suffix_rev + k]);
+      if (b < a)
+	{
+	  /* Suffix is smaller, period is entire prefix so far.  */
+	  j += k;
+	  k = 1;
+	  p = j - max_suffix_rev;
+	}
+      else if (a == b)
+	{
+	  /* Advance through repetition of the current period.  */
+	  if (k != p)
+	    ++k;
+	  else
+	    {
+	      j += p;
+	      k = 1;
+	    }
+	}
+      else /* a < b */
+	{
+	  /* Suffix is larger, start over from current location.  */
+	  max_suffix_rev = j++;
+	  k = p = 1;
+	}
+    }
+
+  /* Choose the longer suffix.  Return the first byte of the right
+     half, rather than the last byte of the left half.  */
+  if (max_suffix_rev + 1 < max_suffix + 1)
+    return max_suffix + 1;
+  *period = p;
+  return max_suffix_rev + 1;
+}
+
+/* Return the first location of non-empty NEEDLE within HAYSTACK, or
+   NULL.  HAYSTACK_LEN is the minimum known length of HAYSTACK.  This
+   method is optimized for NEEDLE_LEN < LONG_NEEDLE_THRESHOLD.
+   Performance is guaranteed to be linear, with an initialization cost
+   of 2 * NEEDLE_LEN comparisons.
+
+   If AVAILABLE does not modify HAYSTACK_LEN (as in memmem), then at
+   most 2 * HAYSTACK_LEN - NEEDLE_LEN comparisons occur in searching.
+   If AVAILABLE modifies HAYSTACK_LEN (as in strstr), then at most 3 *
+   HAYSTACK_LEN - NEEDLE_LEN comparisons occur in searching.  */
+static RETURN_TYPE
+two_way_short_needle (const unsigned char *haystack, size_t haystack_len,
+		      const unsigned char *needle, size_t needle_len)
+{
+  size_t i; /* Index into current byte of NEEDLE.  */
+  size_t j; /* Index into current window of HAYSTACK.  */
+  size_t period; /* The period of the right half of needle.  */
+  size_t suffix; /* The index of the right half of needle.  */
+
+  /* Factor the needle into two halves, such that the left half is
+     smaller than the global period, and the right half is
+     periodic (with a period as large as NEEDLE_LEN - suffix).  */
+  suffix = critical_factorization (needle, needle_len, &period);
+
+  /* Perform the search.  Each iteration compares the right half
+     first.  */
+  if (CMP_FUNC (needle, needle + period, suffix) == 0)
+    {
+      /* Entire needle is periodic; a mismatch can only advance by the
+	 period, so use memory to avoid rescanning known occurrences
+	 of the period.  */
+      size_t memory = 0;
+      j = 0;
+      while (AVAILABLE (haystack, haystack_len, j, needle_len))
+	{
+	  /* Scan for matches in right half.  */
+	  i = MAX (suffix, memory);
+	  while (i < needle_len && (CANON_ELEMENT (needle[i])
+				    == CANON_ELEMENT (haystack[i + j])))
+	    ++i;
+	  if (needle_len <= i)
+	    {
+	      /* Scan for matches in left half.  */
+	      i = suffix - 1;
+	      while (memory < i + 1 && (CANON_ELEMENT (needle[i])
+					== CANON_ELEMENT (haystack[i + j])))
+		--i;
+	      if (i + 1 < memory + 1)
+		return (RETURN_TYPE) (haystack + j);
+	      /* No match, so remember how many repetitions of period
+		 on the right half were scanned.  */
+	      j += period;
+	      memory = needle_len - period;
+	    }
+	  else
+	    {
+	      j += i - suffix + 1;
+	      memory = 0;
+	    }
+	}
+    }
+  else
+    {
+      /* The two halves of needle are distinct; no extra memory is
+	 required, and any mismatch results in a maximal shift.  */
+      period = MAX (suffix, needle_len - suffix) + 1;
+      j = 0;
+      while (AVAILABLE (haystack, haystack_len, j, needle_len))
+	{
+	  /* Scan for matches in right half.  */
+	  i = suffix;
+	  while (i < needle_len && (CANON_ELEMENT (needle[i])
+				    == CANON_ELEMENT (haystack[i + j])))
+	    ++i;
+	  if (needle_len <= i)
+	    {
+	      /* Scan for matches in left half.  */
+	      i = suffix - 1;
+	      while (i != SIZE_MAX && (CANON_ELEMENT (needle[i])
+				       == CANON_ELEMENT (haystack[i + j])))
+		--i;
+	      if (i == SIZE_MAX)
+		return (RETURN_TYPE) (haystack + j);
+	      j += period;
+	    }
+	  else
+	    j += i - suffix + 1;
+	}
+    }
+  return NULL;
+}
+
+/* Return the first location of non-empty NEEDLE within HAYSTACK, or
+   NULL.  HAYSTACK_LEN is the minimum known length of HAYSTACK.  This
+   method is optimized for LONG_NEEDLE_THRESHOLD <= NEEDLE_LEN.
+   Performance is guaranteed to be linear, with an initialization cost
+   of 3 * NEEDLE_LEN + (1 << CHAR_BIT) operations.
+
+   If AVAILABLE does not modify HAYSTACK_LEN (as in memmem), then at
+   most 2 * HAYSTACK_LEN - NEEDLE_LEN comparisons occur in searching,
+   and sublinear performance O(HAYSTACK_LEN / NEEDLE_LEN) is possible.
+   If AVAILABLE modifies HAYSTACK_LEN (as in strstr), then at most 3 *
+   HAYSTACK_LEN - NEEDLE_LEN comparisons occur in searching, and
+   sublinear performance is not possible.  */
+static RETURN_TYPE
+two_way_long_needle (const unsigned char *haystack, size_t haystack_len,
+		     const unsigned char *needle, size_t needle_len)
+{
+  size_t i; /* Index into current byte of NEEDLE.  */
+  size_t j; /* Index into current window of HAYSTACK.  */
+  size_t period; /* The period of the right half of needle.  */
+  size_t suffix; /* The index of the right half of needle.  */
+  size_t shift_table[1U << CHAR_BIT]; /* See below.  */
+
+  /* Factor the needle into two halves, such that the left half is
+     smaller than the global period, and the right half is
+     periodic (with a period as large as NEEDLE_LEN - suffix).  */
+  suffix = critical_factorization (needle, needle_len, &period);
+
+  /* Populate shift_table.  For each possible byte value c,
+     shift_table[c] is the distance from the last occurrence of c to
+     the end of NEEDLE, or NEEDLE_LEN if c is absent from the NEEDLE.
+     shift_table[NEEDLE[NEEDLE_LEN - 1]] contains the only 0.  */
+  for (i = 0; i < 1U << CHAR_BIT; i++)
+    shift_table[i] = needle_len;
+  for (i = 0; i < needle_len; i++)
+    shift_table[CANON_ELEMENT (needle[i])] = needle_len - i - 1;
+
+  /* Perform the search.  Each iteration compares the right half
+     first.  */
+  if (CMP_FUNC (needle, needle + period, suffix) == 0)
+    {
+      /* Entire needle is periodic; a mismatch can only advance by the
+	 period, so use memory to avoid rescanning known occurrences
+	 of the period.  */
+      size_t memory = 0;
+      size_t shift;
+      j = 0;
+      while (AVAILABLE (haystack, haystack_len, j, needle_len))
+	{
+	  /* Check the last byte first; if it does not match, then
+	     shift to the next possible match location.  */
+	  shift = shift_table[CANON_ELEMENT (haystack[j + needle_len - 1])];
+	  if (0 < shift)
+	    {
+	      if (memory && shift < period)
+		{
+		  /* Since needle is periodic, but the last period has
+		     a byte out of place, there can be no match until
+		     after the mismatch.  */
+		  shift = needle_len - period;
+		  memory = 0;
+		}
+	      j += shift;
+	      continue;
+	    }
+	  /* Scan for matches in right half.  The last byte has
+	     already been matched, by virtue of the shift table.  */
+	  i = MAX (suffix, memory);
+	  while (i < needle_len - 1 && (CANON_ELEMENT (needle[i])
+					== CANON_ELEMENT (haystack[i + j])))
+	    ++i;
+	  if (needle_len - 1 <= i)
+	    {
+	      /* Scan for matches in left half.  */
+	      i = suffix - 1;
+	      while (memory < i + 1 && (CANON_ELEMENT (needle[i])
+					== CANON_ELEMENT (haystack[i + j])))
+		--i;
+	      if (i + 1 < memory + 1)
+		return (RETURN_TYPE) (haystack + j);
+	      /* No match, so remember how many repetitions of period
+		 on the right half were scanned.  */
+	      j += period;
+	      memory = needle_len - period;
+	    }
+	  else
+	    {
+	      j += i - suffix + 1;
+	      memory = 0;
+	    }
+	}
+    }
+  else
+    {
+      /* The two halves of needle are distinct; no extra memory is
+	 required, and any mismatch results in a maximal shift.  */
+      size_t shift;
+      period = MAX (suffix, needle_len - suffix) + 1;
+      j = 0;
+      while (AVAILABLE (haystack, haystack_len, j, needle_len))
+	{
+	  /* Check the last byte first; if it does not match, then
+	     shift to the next possible match location.  */
+	  shift = shift_table[CANON_ELEMENT (haystack[j + needle_len - 1])];
+	  if (0 < shift)
+	    {
+	      j += shift;
+	      continue;
+	    }
+	  /* Scan for matches in right half.  The last byte has
+	     already been matched, by virtue of the shift table.  */
+	  i = suffix;
+	  while (i < needle_len - 1 && (CANON_ELEMENT (needle[i])
+					== CANON_ELEMENT (haystack[i + j])))
+	    ++i;
+	  if (needle_len - 1 <= i)
+	    {
+	      /* Scan for matches in left half.  */
+	      i = suffix - 1;
+	      while (i != SIZE_MAX && (CANON_ELEMENT (needle[i])
+				       == CANON_ELEMENT (haystack[i + j])))
+		--i;
+	      if (i == SIZE_MAX)
+		return (RETURN_TYPE) (haystack + j);
+	      j += period;
+	    }
+	  else
+	    j += i - suffix + 1;
+	}
+    }
+  return NULL;
+}
+
+#undef AVAILABLE
+#undef CANON_ELEMENT
+#undef CMP_FUNC
+#undef MAX
+#undef RETURN_TYPE
-- 
1.6.2.rc2
