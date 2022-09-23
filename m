Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6D5C04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 21:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiIWVjj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 17:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiIWVjh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 17:39:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3CC306
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 14:39:29 -0700 (PDT)
Received: (qmail 14666 invoked by uid 109); 23 Sep 2022 21:39:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Sep 2022 21:39:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17204 invoked by uid 111); 23 Sep 2022 21:39:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Sep 2022 17:39:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Sep 2022 17:39:28 -0400
From:   Jeff King <peff@peff.net>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] read-cache: avoid misaligned reads in index v4
Message-ID: <Yy4nkEnhuzt2iH+R@coredump.intra.peff.net>
References: <pull.1366.git.1663962236069.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1366.git.1663962236069.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2022 at 07:43:55PM +0000, Victoria Dye via GitGitGadget wrote:

> Avoid this error by reading fields directly from the 'char *' buffer, using
> the 'offsetof' individual fields in 'struct ondisk_cache_entry'.

Thanks for moving this forward. I agree this should fix the alignment
problems, and I didn't see anything in the patch that would do the wrong
thing. I do have some style/technique suggestions, though.

> @@ -1883,7 +1883,7 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
>  	size_t len;
>  	const char *name;
>  	const unsigned hashsz = the_hash_algo->rawsz;
> -	const uint16_t *flagsp = (const uint16_t *)(ondisk->data + hashsz);
> +	const char *flagsp = ondisk + offsetof(struct ondisk_cache_entry, data) + hashsz;

Now we use the "const char *" pointer instead of the cast to the
ondisk_cache_entry struct, which is good, and is what fixes the
alignment question.

But we also convert flagsp from being a uint16_t into a byte pointer.
I'm not sure if that's strictly necessary from an alignment perspective,
as we'd dereference it only via get_be16(), which handles alignment and
type conversion itself.

I'd imagine the standard probably says that even forming such a pointer
is illegal, so in that sense, it probably is undefined behavior. But I
think it's one of those things that's OK in practice.

That might be splitting hairs, but if you kept it as a uint16_t pointer,
then code like this:

> @@ -1901,15 +1901,15 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
>  
>  	if (flags & CE_EXTENDED) {
>  		int extended_flags;
> -		extended_flags = get_be16(flagsp + 1) << 16;
> +		extended_flags = get_be16(flagsp + sizeof(uint16_t)) << 16;

doesn't need to be changed. I don't know if it's that big a deal either
way, though.

> @@ -1935,20 +1935,24 @@ static struct cache_entry *create_from_disk(struct mem_pool *ce_mem_pool,
>  
>  	ce = mem_pool__ce_alloc(ce_mem_pool, len);
>  
> -	ce->ce_stat_data.sd_ctime.sec = get_be32(&ondisk->ctime.sec);
> [...]
> +	ce->ce_stat_data.sd_ctime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, ctime)
> +							+ offsetof(struct cache_time, sec));

I had figured we'd be able to drop ondisk_cache_entry entirely. But here
you're using it essentially as a template for a set of constants
retrieved via offsetof().

That's OK from an alignment perspective. It does mean we'd be in trouble
if a compiler ever decided to introduce padding into the struct. That's
probably unlikely. We don't use __attribute__((packed)) because it's not
portable, and our existing uses have generally been OK, because our
data structures are organized around 8-byte alignment. We might have
problems on a theoretical 128-bit processor or something.

So I don't think this is a problem now, and unlikely to be in the near
future. But another way to do it would just be an actual set of offsets
(either #define or an enum). That maybe makes the intended use more
obvious, and also prevents people from accidentally misusing the struct.
I'm not sure if it's worth it for not.

It is a bit of a pain to write. Either you have magic numbers, or you
have to reference the offset and size of the previous entry:

  #define ONDISK_CACHE_CTIME 0
  #define ONDISK_CACHE_MTIME (ONDISK_CACHE_CTIME + sizeof(struct cache_time))
  #define ONDISK_CACHE_DEV (ONDISK_CACHE_MTIME + sizeof(struct cache_time))

Another strategy is to just parse left-to-right, advancing the byte
pointer. Like:

  ce->ce_state_data.sd_ctime.sec = get_be32(ondisk);
  ondisk += sizeof(uint32_t);
  ce->ce_state_data.sd_mtime.sec = get_be32(ondisk);
  ondisk += sizeof(uint32_t);
  ...etc...

You can even stick that in a helper function that does the get_b32() and
advances, so you know they're always done in sync. See pack-bitmap.c's
read_be32(), etc. IMHO this produces a nice result because the reading
code itself becomes the source of truth for the format.

But one tricky thing there is if you want to parse out of order. And it
does seem that we read the struct out of order in this case. But I don't
think there's any reason we need to do so. Of course reordering the
function would make the change much more invasive.

So all that said, I'm OK with this approach as the minimal fix, and then
we can think about further refactoring or cleanup on top.

One final note, though:

> +	ce->ce_stat_data.sd_mtime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mtime)
> +							+ offsetof(struct cache_time, sec));

Here (and elsewhere), you can assume that the offsetof() "sec" in
cache_time is 0, for two reasons:

  - I didn't look up chapter and verse, but I'm pretty sure the standard
    does guarantee that the first field of a struct is at the beginning.

  - If there's any padding, this whole scheme is hosed anyway, because
    it means sizeof(cache_time) is bigger than we expect, which messes
    up the offsetof() the entry after us (in this case sd_dev).

So this can just be:

  ce->ce_stat_data.sd_mtime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mtime));

which is mercifully shorter.

Assuming we dismiss the rest of what I said as not worth it for a
minimal fix, I do think that simplification is worth rolling a v2.

-Peff

PS BTW, I mentioned earlier "can we just get rid of ondisk_cache_entry".
   We also use it for the writing side, of course. That doesn't have
   alignment issues, but it does have the same "I hope there's never any
   padding" question. In an ideal world, it would be using the
   equivalent put_be32(), but again, that's getting out of the "minimal
   fix" territory.
