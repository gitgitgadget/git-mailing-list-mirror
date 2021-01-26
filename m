Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD63C433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BB372068D
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbhAZWB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:01:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:39508 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731671AbhAZSY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 13:24:26 -0500
Received: (qmail 25079 invoked by uid 109); 26 Jan 2021 18:23:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Jan 2021 18:23:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1776 invoked by uid 111); 26 Jan 2021 18:23:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Jan 2021 13:23:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Jan 2021 13:23:40 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?6Zi/5b6354OI?= via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?6Zi/5b6354OI?= <adlternative@gmail.com>
Subject: Re: [PATCH] strbuf.c: optimize program logic
Message-ID: <YBBeLIhd+VHS25CE@coredump.intra.peff.net>
References: <pull.846.git.1611637582625.gitgitgadget@gmail.com>
 <xmqqy2gg2pdm.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy2gg2pdm.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 10:17:41PM -0800, Junio C Hamano wrote:

> "阿德烈 via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > the usage in strbuf.h tell us"Alloc is somehow a
> > "private" member that should not be messed with.
> > use `strbuf_avail()`instead."
> 
> When we use the word "private", it generally means it is private to
> the implementation of the API.  IOW, it is usually fine for the
> implementation of the API (i.e. for strbuf API, what you see in
> strbuf.c) to use private members.
> 
> In any case, these changes are _not_ optimizations.  

Yeah, I had both of those thoughts, too. :)

Though...

> Replacing (alloc - len - 1) with strbuf_avail() is at best an
> equivalent rewrite (which is a good thing from readability's point
> of view, but not an optimization).  We know sb->alloc during the
> loop is never 0, but the compiler may miss the fact, so the inlined
> implementation of _avail, i.e.
> 
> 	static inline size_t strbuf_avail(const struct strbuf *sb)
> 	{
> 	        return sb->alloc ? sb->alloc - sb->len - 1 : 0;
>         }
> 
> may not incur call overhead, but may be pessimizing the executed
> code.
> 
> If you compare the code in the loop in the second hunk below with
> what _setlen() does, I think you'll see the overhead of _setlen()
> relative to the original code is even higher, so it may also be
> pessimizing, not optimizing.
> 
> So, overall, I am not all that enthused to see this patch.

I would generally value readability/consistency here over trying to
micro-optimize an if-zero check.

However, if strbuf_avail() ever did return 0, I'm not sure the loop
would make forward progress:

          strbuf_grow(sb, hint ? hint : 8192);
          for (;;) {
                  ssize_t want = strbuf_avail(sb);
                  ssize_t got = read_in_full(fd, sb->buf + sb->len, want);
  
                  if (got < 0) {
                          if (oldalloc == 0)
                                  strbuf_release(sb);
                          else
                                  strbuf_setlen(sb, oldlen);
                          return -1;
                  }
                  strbuf_setlen(sb, sb->len + got);
                  if (got < want)
                          break;
                  strbuf_grow(sb, 8192);
          }

we'd just ask to read 0 bytes over and over. That almost makes me want
to add:

  if (!want)
	BUG("strbuf did not actually grow!?");

or possibly to teach the "if (got < want)" condition to check for a zero
return (though I guess that would probably just end up confusing us into
thinking we hit EOF).

> One thing I noticed is that, whether open coded like sb->len += got
> or made into parameter to strbuf_setlen(sb, sb->len + got), we are
> not careful about sb->len growing too large and overflowing with the
> addition.  That may potentially be an interesting thing to look
> into, but at the same time, unlike the usual "compute the number of
> bytes we need to allocate and then call xmalloc()" pattern, where we
> try to be careful in the "compute" step by using st_add() macros,
> this code actually keep growing the buffer, so by the time the size_t
> overflows and wraps around, we'd certainly have exhausted the memory
> already, so it won't be an issue.

I think "len" is OK here. An invariant of strbuf is that "len" is
smaller than "alloc" for obvious reasons. So as long as the actual
strbuf_grow() is safe, then extending "len".

I'm not sure that strbuf_grow() is safe, though. It relies on
ALLOC_GROW, which does not use st_add(), etc.

-Peff

PS The original patch does not seem to have made it to the list for some
   reason (I didn't get a copy, and neither did lore.kernel.org).
