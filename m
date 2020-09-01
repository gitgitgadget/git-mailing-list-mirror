Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1023BC2BC0E
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 14:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9E02078B
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 14:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgIALZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:25:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:46172 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgIALZK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 07:25:10 -0400
Received: (qmail 26323 invoked by uid 109); 1 Sep 2020 11:18:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Sep 2020 11:18:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26311 invoked by uid 111); 1 Sep 2020 11:18:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Sep 2020 07:18:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Sep 2020 07:18:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] xrealloc: do not reuse pointer freed by zero-length realloc()
Message-ID: <20200901111800.GA3115584@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
original object _is_ still valid. But with a zero size, it's ambiguous.
The NULL return might mean a failure (in which case the object is
valid), or it might mean that we successfully allocated nothing, and
used NULL to represent that.

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
to the follow-up realloc(). That does mean that a system which _doesn't_
free the original pointer would leak it. But that interpretation of the
standard seems unlikely (if a system didn't deallocate in this case, I'd
expect it to simply return the original pointer). If it turns out to be
an issue, we can handle the "!size" case up front instead, before we
call realloc() at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 wrapper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wrapper.c b/wrapper.c
index 4ff4a9c3db..b0d375beee 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -120,7 +120,7 @@ void *xrealloc(void *ptr, size_t size)
 	memory_limit_check(size, 0);
 	ret = realloc(ptr, size);
 	if (!ret && !size)
-		ret = realloc(ptr, 1);
+		ret = realloc(ret, 1);
 	if (!ret)
 		die("Out of memory, realloc failed");
 	return ret;
-- 
2.28.0.844.g468840f815
