Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B9C01F453
	for <e@80x24.org>; Mon, 22 Oct 2018 20:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbeJWEhV (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 00:37:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:49530 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725788AbeJWEhV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 00:37:21 -0400
Received: (qmail 11753 invoked by uid 109); 22 Oct 2018 20:17:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Oct 2018 20:17:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9172 invoked by uid 111); 22 Oct 2018 20:16:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Oct 2018 16:16:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Oct 2018 16:17:21 -0400
Date:   Mon, 22 Oct 2018 16:17:21 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v1] load_cache_entries_threaded: remove unused src_offset
 parameter
Message-ID: <20181022201721.GD9917@sigill.intra.peff.net>
References: <20181022150513.18028-1-peartben@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181022150513.18028-1-peartben@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 11:05:13AM -0400, Ben Peart wrote:

> From: Ben Peart <benpeart@microsoft.com>
> 
> Remove the src_offset parameter which is unused as a result of switching
> to the IEOT table of offsets.  Also stop incrementing src_offset in the
> multi-threaded codepath as it is no longer used and could cause confusion.

Hmm, OK. We only do threads if we have ieot:

>  	if (ieot) {
> -		src_offset += load_cache_entries_threaded(istate, mmap, mmap_size, src_offset, nr_threads, ieot);
> +		load_cache_entries_threaded(istate, mmap, mmap_size, nr_threads, ieot);
>  		free(ieot);
>  	} else {
>  		src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);

And we only have ieot if we had an extension_offset:

          if (extension_offset && nr_threads > 1)
                  ieot = read_ieot_extension(mmap, mmap_size, extension_offset);

So later, when we _do_ use src_offset, we know that this code should
never trigger in the threaded case:

          if (!extension_offset) {
                  p.src_offset = src_offset;
                  load_index_extensions(&p);
          }

So I think it's right, but it's rather subtle. I wonder if we could do
it like this:

	unsigned long entry_offset;
  [...]
  #ifndef NO_PTHREADS
	if (ieot)
		load_cache_entries_threaded(...);
	else
		entry_offset = load_all_cache_entries(...);
  #else
	entry_offset = load_all_cache_entries(...);
  [...]

  p.src_offset = src_offset + entry_offset;

and then the compiler could warn us that entry_offset is used
uninitialized (though I would not be surprised if the compiler gets
confused in this case).

Not sure if it is worth the trouble or not.


>  static unsigned long load_cache_entries_threaded(struct index_state *istate, const char *mmap, size_t mmap_size,
> -			unsigned long src_offset, int nr_threads, struct index_entry_offset_table *ieot)
> +			int nr_threads, struct index_entry_offset_table *ieot)

If nobody uses it, should we drop the return value, too? Like:

diff --git a/read-cache.c b/read-cache.c
index 78c9516eb7..4b44a2eae5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2052,12 +2052,11 @@ static void *load_cache_entries_thread(void *_data)
 	return NULL;
 }
 
-static unsigned long load_cache_entries_threaded(struct index_state *istate, const char *mmap, size_t mmap_size,
-						 int nr_threads, struct index_entry_offset_table *ieot)
+static void load_cache_entries_threaded(struct index_state *istate, const char *mmap, size_t mmap_size,
+					int nr_threads, struct index_entry_offset_table *ieot)
 {
 	int i, offset, ieot_blocks, ieot_start, err;
 	struct load_cache_entries_thread_data *data;
-	unsigned long consumed = 0;
 
 	/* a little sanity checking */
 	if (istate->name_hash_initialized)
@@ -2115,12 +2114,9 @@ static unsigned long load_cache_entries_threaded(struct index_state *istate, con
 		if (err)
 			die(_("unable to join load_cache_entries thread: %s"), strerror(err));
 		mem_pool_combine(istate->ce_mem_pool, p->ce_mem_pool);
-		consumed += p->consumed;
 	}
 
 	free(data);
-
-	return consumed;
 }
 #endif
 

-Peff
