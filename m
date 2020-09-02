Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D441DC433E6
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 07:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A073E2087C
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 07:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIBHyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:54:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:47236 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgIBHyl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 03:54:41 -0400
Received: (qmail 32294 invoked by uid 109); 2 Sep 2020 07:54:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Sep 2020 07:54:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4389 invoked by uid 111); 2 Sep 2020 07:54:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Sep 2020 03:54:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Sep 2020 03:54:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] xrealloc: do not reuse pointer freed by zero-length
 realloc()
Message-ID: <20200902075439.GA855335@coredump.intra.peff.net>
References: <20200901111800.GA3115584@coredump.intra.peff.net>
 <c81b7225-a663-1598-62b3-bd80457d5648@gmail.com>
 <20200901135105.GA3284077@coredump.intra.peff.net>
 <xmqq3641ebep.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq3641ebep.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 01, 2020 at 08:58:54AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If we do handle it up-front, then I think we'd actually want:
> >
> >   if (!size) {
> >           free(ptr);
> > 	  return xmalloc(0);
> >   }
> >
> > (i.e., to never return NULL for consistency with xmalloc() and
> > xcalloc()).
> 
> Makes sense.  I suspect that this is optimizing for a wrong case,
> but in practice that should not matter.  Not having to worry about
> a request to resize to 0-byte in the remainder of the function is
> actually a plus for readability, I would say.

OK. Then here it is like that (and a slightly updated final paragraph in
the commit message).

There are other variants, too:

  - we could use malloc(1) versus xmalloc(0). Maybe more
    readable/obvious? But also potentially allocates an extra byte when
    the platform malloc(0) would not need to.

  - we could return a non-NULL "ptr" without shrinking it at all (nor
    allocating anything new). This is perfectly legal, and the
    underlying realloc() would still know the original size if anybody
    ever asked to grow it back again.

I have to admit I don't overly care between them. I suspect one of the
reasons we never ran into this 15-year-old bug is that it's quite hard
to convince Git to call realloc(0) in the first place. I only saw it
when investigating a bug in another series, and there the problem turned
out to be reading garbage bytes off the end of a buffer (which we
interpreted as a serialized ewah bitmap which happened to have a zero in
its length byte).

-- >8 --
Subject: [PATCH] xrealloc: do not reuse pointer freed by zero-length realloc()

This patch fixes a bug where xrealloc(ptr, 0) can double-free and
corrupt the heap on some platforms (including at least glibc).

The C99 standard says of malloc (section 7.20.3):

  If the size of the space requested is zero, the behavior is
  implementation-defined: either a null pointer is returned, or the
  behavior is as if the size were some nonzero value, except that the
  returned pointer shall not be used to access an object.

So we might get NULL back, or we might get an actual pointer (but we're
not allowed to look at its contents). To simplify our code, our
xmalloc() handles a NULL return by converting it into a single-byte
allocation. That way callers get consistent behavior. This was done way
back in 4e7a2eccc2 (?alloc: do not return NULL when asked for zero
bytes, 2005-12-29).

We also gave xcalloc() and xrealloc() the same treatment. And according
to C99, that is fine; the text above is in a paragraph that applies to
all three. But what happens to the memory we passed to realloc() in such
a case? I.e., if we do:

  ret = realloc(ptr, 0);

and "ptr" is non-NULL, but we get NULL back, is "ptr" still valid? C99
doesn't cover this case specifically, but says (section 7.20.3.4):

  The realloc function deallocates the old object pointed to by ptr and
  returns a pointer to a new object that has the size specified by size.

So "ptr" is now deallocated, and we must only look at "ret". And since
"ret" is NULL, that means we have no allocated object at all. But that's
not quite the whole story. It also says:

  If memory for the new object cannot be allocated, the old object is
  not deallocated and its value is unchanged.
  [...]
  The realloc function returns a pointer to the new object (which may
  have the same value as a pointer to the old object), or a null pointer
  if the new object could not be allocated.

So if we see a NULL return with a non-zero size, we can expect that the
original object _is_ still valid. But with a non-zero size, it's
ambiguous. The NULL return might mean a failure (in which case the
object is valid), or it might mean that we successfully allocated
nothing, and used NULL to represent that.

The glibc manpage for realloc() explicitly says:

  [...]if size is equal to zero, and ptr is not NULL, then the call is
  equivalent to free(ptr).

Likewise, this StackOverflow answer:

  https://stackoverflow.com/a/2135302

claims that C89 gave similar guidance (but I don't have a copy to verify
it). A comment on this answer:

  https://stackoverflow.com/a/2022410

claims that Microsoft's CRT behaves the same.

But our current "retry with 1 byte" code passes the original pointer
again. So on glibc, we effectively free() the pointer and then try to
realloc() it again, which is undefined behavior.

The simplest fix here is to just pass "ret" (which we know to be NULL)
to the follow-up realloc(). But that means that a system which _doesn't_
free the original pointer would leak it. It's not clear if any such
systems exist, and that interpretation of the standard seems unlikely
(I'd expect a system that doesn't deallocate to simply return the
original pointer in this case). But it's easy enough to err on the safe
side, and just never pass a zero size to realloc() at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 wrapper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 4ff4a9c3db..bcda41e374 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -117,10 +117,13 @@ void *xrealloc(void *ptr, size_t size)
 {
 	void *ret;
 
+	if (!size) {
+		free(ptr);
+		return xmalloc(0);
+	}
+
 	memory_limit_check(size, 0);
 	ret = realloc(ptr, size);
-	if (!ret && !size)
-		ret = realloc(ptr, 1);
 	if (!ret)
 		die("Out of memory, realloc failed");
 	return ret;
-- 
2.28.0.844.g468840f815

