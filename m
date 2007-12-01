From: Christian Thaeter <ct@pipapo.org>
Subject: memmem.c improvement
Date: Sat, 01 Dec 2007 01:48:15 +0100
Message-ID: <4750AF4F.6090207@pipapo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;  boundary="------------010100010109010607050003"
To: libc-alpha@sourceware.org,  git@vger.kernel.org
X-From: libc-alpha-return-20626-glibc-alpha=m.gmane.org@sourceware.org Sat Dec 01 01:50:04 2007
Return-path: <libc-alpha-return-20626-glibc-alpha=m.gmane.org@sourceware.org>
Envelope-to: glibc-alpha@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IyGYV-0005ZO-7E
	for glibc-alpha@gmane.org; Sat, 01 Dec 2007 01:50:03 +0100
Received: (qmail 22686 invoked by alias); 1 Dec 2007 00:49:45 -0000
Received: (qmail 22675 invoked by uid 22791); 1 Dec 2007 00:49:44 -0000
X-Spam-Check-By: sourceware.org
Received: from pipapo.org (HELO mail.pipapo.org) (217.140.77.75)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 01 Dec 2007 00:49:38 +0000
Received: from [10.20.70.10] (mercur.pipapo.org [10.20.70.10]) 	by mail.pipapo.org (Postfix) with ESMTP id 572CD34F49D62; 	Sat,  1 Dec 2007 01:47:45 +0100 (CET)
User-Agent: Icedove 1.5.0.14pre (X11/20071018)
Mailing-List: contact libc-alpha-help@sourceware.org; run by ezmlm
Precedence: bulk
List-Id: <libc-alpha.sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
Delivered-To: mailing list libc-alpha@sourceware.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66670>

This is a multi-part message in MIME format.
--------------010100010109010607050003
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Short story, 'memmem()' is a gnuish, nonstandard function. I wanted to
provide a generic fallback in some code. So, lets borrow it somewhere else:

First looking at git's compat/memmem.c which I found was suboptimal with
roughly O(M*N) performance (albeit ok for that case since it was just a
generic fallback).

Well, second taking a look at glibc's source surprised me, there is the
same code as in git. I somewhat expected a faster implementation from a
generic C library.

That thought and done, the code is attached to this mail. The algorithm
is similar to the Rabin/Karp method for string searches but uses a
weaker and simpler additive rolling hash. The result is still somewhat
like O(M+N) for most cases (There may be corner cases where it not that
good, but its really hard to imagine those). Anyways, it is always
faster than the current implementation, in my tests with common data
(parsing multipart/form-data cgi responses) it yields approx 20%-100%
improvements and with little artificial cheating (having strings in
haystack which only differ at the last char of needle) the improvements
are much better (500%, since is another complexity class). The fact is
that the old implementation does a brute force search which has corner
cases which are quite easy to hit (repeating symbol sequences, small set
of possible symbols) while for my implementation the corner cases are
much more rare and even then, it will still perform better than the old
implementation.

The code is not much more complex as the old one, not the original
'Rabin/Karp' algorithm because that would require a efficient modulo
operation with a prime number which might be slower on some platforms
(just a guess, I didn't even tried, the performance satisfies me
perfectly). Other search algorithms like 'Knuth/Morris/Pratt' or
'Boyer/More' are more complex to implement and require O(Needle) extra
memory for common implementations, which reserve them for special
purposes imo. I just wanted to keep it simple but still considerably
better than the current one.

Feel free to use the code in glibc and/or git.

	Christian

--------------010100010109010607050003
Content-Type: text/x-csrc;
 name="memmem.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="memmem.c"

/* Copyright (C) 1991,92,93,94,96,97,98,2000,2004 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
   02111-1307 USA.  */

#include <stddef.h>
#include <string.h>

#ifndef _LIBC
# define __builtin_expect(expr, val)   (expr)
#endif

#undef memmem

/* Return the first occurrence of NEEDLE in HAYSTACK. */
void *
memmem (haystack, haystack_len, needle, needle_len)
     const void *haystack;
     size_t haystack_len;
     const void *needle;
     size_t needle_len;
{
  /* not really Rabin-Karp, just using additive hashing */
  char* haystack_ = (char*)haystack;
  char* needle_ = (char*)needle;
  int hash = 0;		/* this is the static hash value of the needle */
  int hay_hash = 0;	/* rolling hash over the haystack */
  char* last;
  size_t i;

  if (haystack_len < needle_len)
    return NULL;

  if (!needle_len)
    return haystack_;

  /* initialize hashes */
  for (i = needle_len; i; --i)
    {
      hash += *needle_++;
      hay_hash += *haystack_++;
    }

  /* iterate over the haystack */
  haystack_ = (char*)haystack;
  needle_ = (char*)needle;
  last = haystack_+(haystack_len - needle_len + 1);
  for (; haystack_ < last; ++haystack_)
    {
      if (__builtin_expect(hash == hay_hash, 0) &&
	  *haystack_ == *needle_ &&	/* prevent calling memcmp, was a optimization from existing glibc */
	  !memcmp (haystack_, needle_, needle_len))
	return haystack_;

      /* roll the hash */
      hay_hash -= *haystack_;
      hay_hash += *(haystack_+needle_len);
    }

  return NULL;
}

--------------010100010109010607050003--
