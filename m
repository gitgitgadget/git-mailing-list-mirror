Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F17C35241
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 05:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04482075E
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 05:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgAYFoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 00:44:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:44416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725601AbgAYFoa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 00:44:30 -0500
Received: (qmail 10980 invoked by uid 109); 25 Jan 2020 05:44:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Jan 2020 05:44:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13905 invoked by uid 111); 25 Jan 2020 05:51:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Jan 2020 00:51:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 25 Jan 2020 00:44:29 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH v2 4/4] obstack: avoid computing offsets from NULL pointer
Message-ID: <20200125054429.GA745003@coredump.intra.peff.net>
References: <20200125053542.GA744596@coredump.intra.peff.net>
 <20200125054117.GD744673@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200125054117.GD744673@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 25, 2020 at 12:41:18AM -0500, Jeff King wrote:

> diff --git a/compat/obstack.h b/compat/obstack.h
> index 01e7c81840..fbcf68c67c 100644
> --- a/compat/obstack.h
> +++ b/compat/obstack.h
> @@ -135,8 +135,10 @@ extern "C" {
>     alignment relative to 0.  */
>  
>  #define __PTR_ALIGN(B, P, A)						    \
> -  __BPTR_ALIGN (sizeof (PTR_INT_TYPE) < sizeof (void *) ? (B) : (char *) 0, \
> -		P, A)
> +  (sizeof (PTR_INT_TYPE) < sizeof(void *) ?                                 \
> +   __BPTR_ALIGN((B), (P), (A)) :                                            \
> +   (void *)__BPTR_ALIGN((PTR_INT_TYPE)0, (PTR_INT_TYPE)(P), (A))            \
> +  )

Oops, I added in one change at the last minute but failed to commit it.
The first argument to __BPTR_ALIGN() should be:

  (PTR_INT_TYPE)(void *)0

to ensure that it's a NULL pointer, even if the platform doesn't have
an all-bits-zero NULL. Again, this is probably academic for Git's
codebase, but I was trying to keep as close to the original as possible.

Here's a fixed patch.

-- >8 --
Subject: obstack: avoid computing offsets from NULL pointer

As with the previous two commits, UBSan with clang-11 complains about
computing offsets from a NULL pointer. The failures in t4013 (and
elsewhere) look like this:

  kwset.c:102:23: runtime error: applying non-zero offset 107820859019600 to null pointer
  ...
  not ok 79 - git log -SF master # magic is (not used)

That line is not enlightening:

  ... = obstack_alloc(&kwset->obstack, sizeof (struct trie));

because obstack is implemented almost entirely in macros, and the actual
problem is five macros deep (I temporarily converted them to inline
functions to get better compiler errors, which was tedious but worked
reasonably well).

The actual problem is in these pointer-alignment macros:

  /* If B is the base of an object addressed by P, return the result of
     aligning P to the next multiple of A + 1.  B and P must be of type
     char *.  A + 1 must be a power of 2.  */

  #define __BPTR_ALIGN(B, P, A) ((B) + (((P) - (B) + (A)) & ~(A)))

  /* Similar to _BPTR_ALIGN (B, P, A), except optimize the common case
     where pointers can be converted to integers, aligned as integers,
     and converted back again.  If PTR_INT_TYPE is narrower than a
     pointer (e.g., the AS/400), play it safe and compute the alignment
     relative to B.  Otherwise, use the faster strategy of computing the
     alignment relative to 0.  */

  #define __PTR_ALIGN(B, P, A)                                                \
    __BPTR_ALIGN (sizeof (PTR_INT_TYPE) < sizeof (void *) ? (B) : (char *) 0, \
                  P, A)

If we have a sufficiently-large integer pointer type, then we do the
computation using a NULL pointer constant. That turns __BPTR_ALIGN()
into something like:

  NULL + (P - NULL + A) & ~A

and UBSan is complaining about adding the full value of P to that
initial NULL. We can fix this by doing our math as an integer type, and
then casting the result back to a pointer. The problem case only happens
when we know that the integer type is large enough, so there should be
no issue with truncation.

Another option would be just simplify out all the 0's from
__BPTR_ALIGN() for the NULL-pointer case. That probably wouldn't work
for a platform where the NULL pointer isn't all-zeroes, but Git already
wouldn't work on such a platform (due to our use of memset to set
pointers in structs to NULL). But I tried here to keep as close to the
original as possible.

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/obstack.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/compat/obstack.h b/compat/obstack.h
index 01e7c81840..f90a46d9b9 100644
--- a/compat/obstack.h
+++ b/compat/obstack.h
@@ -135,8 +135,10 @@ extern "C" {
    alignment relative to 0.  */
 
 #define __PTR_ALIGN(B, P, A)						    \
-  __BPTR_ALIGN (sizeof (PTR_INT_TYPE) < sizeof (void *) ? (B) : (char *) 0, \
-		P, A)
+  (sizeof (PTR_INT_TYPE) < sizeof(void *) ?                                 \
+   __BPTR_ALIGN((B), (P), (A)) :                                            \
+   (void *)__BPTR_ALIGN((PTR_INT_TYPE)(void *)0, (PTR_INT_TYPE)(P), (A))            \
+  )
 
 #include <string.h>
 
-- 
2.25.0.421.gb74d19af79

