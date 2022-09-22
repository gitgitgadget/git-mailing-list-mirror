Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A48C54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 22:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiIVW1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 18:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIVW1V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 18:27:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34D4DF68A
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 15:27:20 -0700 (PDT)
Received: (qmail 9389 invoked by uid 109); 22 Sep 2022 22:27:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Sep 2022 22:27:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8569 invoked by uid 111); 22 Sep 2022 22:27:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Sep 2022 18:27:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Sep 2022 18:27:19 -0400
From:   Jeff King <peff@peff.net>
To:     Victoria Dye <vdye@github.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: t9210-scalar.sh fails with SANITIZE=undefined
Message-ID: <YyzhR8CGu2CNQMfJ@coredump.intra.peff.net>
References: <YywzNTzd72tox8Z+@coredump.intra.peff.net>
 <ff921c34-139a-9e2b-ca1f-d6f9f7213d1b@github.com>
 <Yyyzk3FVjmms7dkO@coredump.intra.peff.net>
 <50c57a60-8346-6952-93d9-432a70ef74c5@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50c57a60-8346-6952-93d9-432a70ef74c5@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2022 at 03:09:52PM -0700, Victoria Dye wrote:

> Other than allowing us to use a (non-packed) 'struct ondisk_cache_entry' to
> parse the index entries, is there any reason why the on-disk index entries
> should (or need to be) 4-byte aligned? If not, we could update how we read
> the 'ondisk' index entry in 'create_from_disk()' to avoid the misalignment.

I don't think so. And indeed, we already use get_be16(), etc, for most
of the access (which is mostly there for endian-fixing, but also
resolves alignment problems).

> ------------------8<------------------8<------------------8<------------------
> diff --git a/read-cache.c b/read-cache.c
> index b09128b188..f132a3f256 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1875,7 +1875,7 @@ static int read_index_extension(struct index_state *istate,
>  
>  static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
>  					    unsigned int version,
> -					    struct ondisk_cache_entry *ondisk,
> +					    const char *ondisk,
>  					    unsigned long *ent_size,
>  					    const struct cache_entry *previous_ce)
>  {
> @@ -1883,7 +1883,7 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
>  	size_t len;
>  	const char *name;
>  	const unsigned hashsz = the_hash_algo->rawsz;
> -	const uint16_t *flagsp = (const uint16_t *)(ondisk->data + hashsz);
> +	const char *flagsp = ondisk + offsetof(struct ondisk_cache_entry, data) + hashsz;
>  	unsigned int flags;
>  	size_t copy_len = 0;
>  	/*
> ------------------>8------------------>8------------------>8------------------
> 
> the do the same sort of conversion with the rest of the function. It's
> certainly uglier than just using the 'struct ondisk_index_entry *' pointer,
> but it should avoid the misaligned addressing error.

Yeah, I think that's probably the only reasonable solution. I thought
ditching ondisk_cache_entry entirely (which is basically what this is
doing) would be a tough sell, but a quick "grep" shows it really isn't
used in all that many spots.

I also wondered why other versions do not have a similar problem. After
all, cache entries contain pathnames which are going to be of varying
lengths. But this seems telling:

  $ git grep -m1 -B1 -A2 align_padding_size
  read-cache.c-/* These are only used for v3 or lower */
  read-cache.c:#define align_padding_size(size, len) ((size + (len) + 8) & ~7) - (size + len)
  read-cache.c-#define align_flex_name(STRUCT,len) ((offsetof(struct STRUCT,data) + (len) + 8) & ~7)
  read-cache.c-#define ondisk_cache_entry_size(len) align_flex_name(ondisk_cache_entry,len)

So we actually pad the entries in earlier versions to align them, but
don't in v4. I'm not sure if that was a conscious choice to save space,
or an unintended consequence (though it is mentioned in the docs, I
think that came after the code).

That's probably all obvious to people who work with the index a lot.
It's the one part of Git I've mostly managed to remain oblivious to. :)

-Peff
