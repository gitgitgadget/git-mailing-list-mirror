Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731E7C433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 08:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2710D22D58
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 08:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbhAMIGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 03:06:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52168 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbhAMIGu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 03:06:50 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A65C3A1A9C;
        Wed, 13 Jan 2021 03:06:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nGQl77+ke/unhsavp7CF+jKQC6Q=; b=LJPAk/
        9yGfozUnh4qFGVQVl0g6sG5MaQK50UaiGhdHIV7iaavfIlPsyzsDCSs+3zlB57Fh
        AL5/akgFwPAM8zc3Esu2Qci45Fc9ACi1bO4BCjkT7KFL0vJVXQVera0xTccFs1q3
        qQAGJ2wmcwLSxF+PqDlECnCkg95s3YN4kbFTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z+j1fj/yoxpDXXTpgRUXVGFSZPqcyN5C
        ds574x3MaburTlaBW9rhthAo+xfiNrCCKq7U4lIs7G1bK/LtV8BgnfNIFhtgqyyH
        8smyufyd8ZKjEsBxyHS2BgXQvBu7hdK1MzzrAC6KuxMSYs9RLYMpIAxzcxJ9CDAe
        aQVI4Is8Ctg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D4D7A1A9A;
        Wed, 13 Jan 2021 03:06:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E298AA1A99;
        Wed, 13 Jan 2021 03:06:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com
Subject: Re: [PATCH 01/20] pack-revindex: introduce a new API
References: <cover.1610129796.git.me@ttaylorr.com>
        <fa6b8309088fd04410ca7276c5cf14db0fb82fb2.1610129796.git.me@ttaylorr.com>
Date:   Wed, 13 Jan 2021 00:06:03 -0800
In-Reply-To: <fa6b8309088fd04410ca7276c5cf14db0fb82fb2.1610129796.git.me@ttaylorr.com>
        (Taylor Blau's message of "Fri, 8 Jan 2021 13:16:43 -0500")
Message-ID: <xmqqa6tdz2fo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E7F7100-5576-11EB-A24F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> In the next several patches, we will prepare for loading a reverse index
> either in memory, or from a yet-to-be-introduced on-disk format. To do

Does "load revindex in memory" (as opposed to "from on-disk file")
mean the good old "read the forward index and make inverse map
in-core", or something else?  

IOW, is "We will prepare a reverse index either by computing in
memory from forward index, or loading from on-disk file" what we
want to say here?

> There are four ways to interact with the reverse index. Accordingly,
> four functions will be exported from 'pack-revindex.h' by the time that
> the existing API is removed. A caller may:
>
>  1. Load the pack's reverse index. This involves opening up the index,
>     generating an array, and then sorting it. Since opening the index
>     can fail, this function ('load_pack_revindex()') returns an int.
>     Accordingly, it takes only a single argument: the 'struct
>     packed_git' the caller wants to build a reverse index for.
>
>     This function is well-suited for both the current and new API.
>     Callers will have to continue to open the reverse index explicitly,
>     but this function will eventually learn how to detect and load a
>     reverse index from the on-disk format, if one exists. Otherwise, it
>     will fallback to generating one in memory from scratch.

OK.

>  2. Convert a pack position into an offset. This operation is now
>     called `pack_pos_to_offset()`. It takes a pack and a position, and
>     returns the corresponding off_t.
>
>  3. Convert a pack position into an index position. Same as above; this
>     takes a pack and a position, and returns a uint32_t. This operation
>     is known as `pack_pos_to_index()`.
>
>  4. Find the pack position for a given offset. This operation is now
>     known as `offset_to_pack_pos()`. It takes a pack, an offset, and a
>     pointer to a uint32_t where the position is written, if an object
>     exists at that offset. Otherwise, -1 is returned to indicate
>     failure.

Without knowing what exactly "pack position", "offset" and "index
position" refer to, the above three are almost impossible to grok.
Can we have one paragraph description for each?  Something along the
lines of...

 - Pack position: a packstream consists of series of byte ranges,
   each of which represents an object, so the objects can be
   numbered from 0 (the object whose data is stored at the earliest
   part in the packfile) to N (the object whose data is stored at
   the tail end of the packfile).  The number corresponding to an
   object in this order in the packfile is called the "pack
   position" of the object.

 - Offset: The ofs_t distance between the beginning of a pack stream
   and the beginning of data that represents an object is called the
   "offset" of the object in the packfile.

 - Index position: for a single pack stream, there is a table that
   maps object name to its offset and the entries in this table are
   sorted by the object name (this is what pack ".idx" file is).
   The location (counting from 0) of an object in this table is
   called the "index position" of the object in the packfile.

I am not sure if the above correctly reflects what you meant by
"position", though.

>     Unlike some of the callers that used to access '->offset' and '->nr'
>     directly, the error checking around this call is somewhat more
>     robust. This is important since callers can pass an offset which
>     does not contain an object.

Meaning "offset ought to point at the boundary between objects in
the pack stream, and the API, unlike the direct access, makes sure
that is the case"?  That is a good thing.

>     This will become important in a subsequent patch where a caller
>     which does not but could check the return value treats the signed
>     `-1` from `find_revindex_position()` as an index into the 'revindex'
>     array.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  pack-revindex.c | 32 ++++++++++++++++++++++++++++++++
>  pack-revindex.h |  4 ++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/pack-revindex.c b/pack-revindex.c
> index ecdde39cf4..6d86a85208 100644
> --- a/pack-revindex.c
> +++ b/pack-revindex.c
> @@ -203,3 +203,35 @@ struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
>  
>  	return p->revindex + pos;
>  }
> +
> +int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
> +{
> +	int ret;
> +
> +	if (load_pack_revindex(p) < 0)
> +		return -1;
> +
> +	ret = find_revindex_position(p, ofs);
> +	if (ret < 0)
> +		return -1;

Why not "return ret"?  We know that find_revindex_position() would
signal an error by returning -1, but is there a reason why we want
to prevent it from returning richer errors in the future?

> +	*pos = ret;

The untold assumption is that uint32_t can fit the maximum returned
value from find_revindex_position() and "signed int" can also big
enough.  I guess it is OK to be limited to up-to 2 billion objects
on 32-bit systems.

> +	return 0;
> +}
> +
> +uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos)
> +{
> +	if (!p->revindex)
> +		BUG("pack_pos_to_index: reverse index not yet loaded");

The previous function lazy loaded the revindex, but this one and the
next one refuses to work without revindex.  Intended?

> +	if (pos >= p->num_objects)
> +		BUG("pack_pos_to_index: out-of-bounds object at %"PRIu32, pos);

Personally I find it easier to place items on a single line in an
ascending order of magnitude, i.e.

	if (p->num_objects <= pos)
		BUG("...");

The assertion requires pos to be strictly lower than p->num_objects,
which is in line with how we usually count elements of an array of
size p->num_objects, but the next one allows pos == p->num_objects;
intended?

p->revindex[] is an array of two-member struct, so if an element of
the array is invalid for its .nr member here because pos is exactly
at p->num_objects, I would imagine it is also invalid for its .offset
member, too, no?

Ah, perhaps the "offset beyond the end of the pack positions" is a
sentinel element to give the in-pack-stream size of the object at
the last pack position?  If that is the case, it deserves a comment,
I would think.

> +	return p->revindex[pos].nr;
> +}
> +
> +off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos)
> +{
> +	if (!p->revindex)
> +		BUG("pack_pos_to_index: reverse index not yet loaded");
> +	if (pos > p->num_objects)
> +		BUG("pack_pos_to_offset: out-of-bounds object at %"PRIu32, pos);
> +	return p->revindex[pos].offset;
> +}
> diff --git a/pack-revindex.h b/pack-revindex.h
> index 848331d5d6..256c0a9106 100644
> --- a/pack-revindex.h
> +++ b/pack-revindex.h
> @@ -13,4 +13,8 @@ int find_revindex_position(struct packed_git *p, off_t ofs);
>  
>  struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs);
>  
> +int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos);
> +uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos);
> +off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos);
> +
>  #endif
