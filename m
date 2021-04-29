Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9960C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 20:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A85BC6143A
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 20:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhD2U5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 16:57:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:40442 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232246AbhD2U5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 16:57:24 -0400
Received: (qmail 16436 invoked by uid 109); 29 Apr 2021 20:56:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Apr 2021 20:56:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23072 invoked by uid 111); 29 Apr 2021 20:56:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Apr 2021 16:56:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Apr 2021 16:56:37 -0400
From:   Jeff King <peff@peff.net>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     yguoaz@gmail.com, git@vger.kernel.org
Subject: Re: A possible divide by zero problem in read-cache.c
Message-ID: <YIsdhdQX03osraFD@coredump.intra.peff.net>
References: <CAM7=BFooqCo3vn+yy6uM26szZDAcbx8M=sZS1znucJvHRbtxHg@mail.gmail.com>
 <20210429145424.515208-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210429145424.515208-1-matheus.bernardino@usp.br>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 29, 2021 at 11:54:24AM -0300, Matheus Tavares wrote:

> > Step 1: (calling another function load_cache_entries_threaded with
> > nr_threads as an argument )  [ link:
> > https://github.com/git/git/blob/311531c9de557d25ac087c1637818bd2aad6eb3a/read-cache.c#L2247
> > ]
> >       src_offset += load_cache_entries_threaded(istate, mmap,
> > mmap_size, nr_threads, ieot);
> 
> Hmm, this function call is guarded by an `if (ieot)` block:
> 
> 	if (ieot) {
> 		src_offset += load_cache_entries_threaded(istate, mmap, mmap_size, nr_threads, ieot);
> 		free(ieot);
> 	} else {
> 		src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
> 	}
> 
> 
> And `ieot` will only get a non-NULL value if this previous assignment was
> executed:
> 
> 	if (extension_offset && nr_threads > 1)
> 		ieot = read_ieot_extension(mmap, mmap_size, extension_offset);
> 
> So it seems to me that we only call `load_cache_entries_threaded()` when
> `nr_threads > 1`.

Thanks for tracing this. I agree that this doesn't seem to be
triggerable along that patch for this reason.

There is another assignment to nr_threads inside the function with the
division:

          if (nr_threads > ieot->nr)
                  nr_threads = ieot->nr;
          CALLOC_ARRAY(data, nr_threads);
  
          offset = ieot_start = 0;
          ieot_blocks = DIV_ROUND_UP(ieot->nr, nr_threads);

Is it possible for ieot->nr to be 0? Almost certainly it would be a bug
for something to have written it, but I wonder if a malicious file could
trigger this.

Going back to read_ieot_extension(), I think the answer is "no". It
does:

         /* extension size - version bytes / bytes per entry */
          nr = (extsize - sizeof(uint32_t)) / (sizeof(uint32_t) + sizeof(uint32_t));
          if (!nr) {
                  error("invalid number of IEOT entries %d", nr);
                  return NULL;
          }
          ieot = xmalloc(sizeof(struct index_entry_offset_table)
                         + (nr * sizeof(struct index_entry_offset)));
          ieot->nr = nr;

so it will reject such an extension.

So I think all is well here.

-Peff
