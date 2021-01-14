Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C56C433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 07:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 145ED239CF
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 07:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbhANHXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 02:23:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65038 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbhANHXi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 02:23:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0CD398916;
        Thu, 14 Jan 2021 02:22:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SvjoQzidryZSwAgeBqVyJBpMaW4=; b=ZZKA+i
        GL39alNmRbS4LeYtRgM8HPHowcaPjgu5rKNldbVvb3TKNbIAgf+nnWM1kiYB4k53
        GFLRS9BHrUA/1uYJ7E4iesPQ1ZFsOV1YM60gDaO5fhbcsbDN+XD9Dp9TpRCmE0IY
        4lCOtlMHqs1LNQd4EMkuqv5x+lqXOcPSGbfiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RrZPxDwo6EaQRryY5JA5bIm58EQlAU9r
        nUI8/OBWOHXC8w9UgHPOJe5+NHF21RB5wUDgjBx4FXiplKUjY1YG/4wP+Z3ADXRh
        ahZBpL3+QWpEXW5g4qkxmROLzf5KsHylupsVa9EbQJP4q7Ek5F48Dbmr94qwBqVV
        bth8+xC7idA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1A2F98915;
        Thu, 14 Jan 2021 02:22:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 15DCF98914;
        Thu, 14 Jan 2021 02:22:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, jrnieder@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v2 1/8] packfile: prepare for the existence of '*.rev'
 files
References: <cover.1610129989.git.me@ttaylorr.com>
        <cover.1610576805.git.me@ttaylorr.com>
        <6742c15c84bafbcc1c06e2633de51dcda63e3314.1610576805.git.me@ttaylorr.com>
Date:   Wed, 13 Jan 2021 23:22:53 -0800
In-Reply-To: <6742c15c84bafbcc1c06e2633de51dcda63e3314.1610576805.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 13 Jan 2021 17:28:06 -0500")
Message-ID: <xmqqwnwgx9rm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 513DDBB4-5639-11EB-9F7E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> +== pack-*.rev files have the format:
> +
> +  - A 4-byte magic number '0x52494458' ('RIDX').
> +
> +  - A 4-byte version identifier (= 1)
> +
> +  - A 4-byte hash function identifier (= 1 for SHA-1, 2 for SHA-256)

These two are presumably 4-byte-wide network byte order integers.
We should spell it out.

> +  - A table of index positions, sorted by their corresponding offsets in the
> +    packfile.

Likewise, how wide is each entry and in what byte order, and how
many entries are there in the table?

	... oh, what about the "one beyond the last"?  We cannot
	go back to the forward index to learn the offset of such
	an non-existent object, can we?

Again, I expect it to be 4-byte-wide network byte order integer.

> -int load_pack_revindex(struct packed_git *p)
> +static int load_pack_revindex_from_memory(struct packed_git *p)

I said it when I saw the beginning of v1 API patches, but it is a
bit unreasonable to call the act of "computing from the forward
index" "to load from memory".  Loading from disk perfectly works as
a phrase, though.

> +#define RIDX_MIN_SIZE (12 + (2 * the_hash_algo->rawsz))
> +
> +static int load_revindex_from_disk(char *revindex_name,
> +				   uint32_t num_objects,
> +				   const void **data, size_t *len)
> +{
> +	int fd, ret = 0;
> +	struct stat st;
> +	size_t revindex_size;
> +
> +	fd = git_open(revindex_name);
> +
> +	if (fd < 0) {
> +		ret = -1;
> +		goto cleanup;
> +	}
> +	if (fstat(fd, &st)) {
> +		ret = error_errno(_("failed to read %s"), revindex_name);
> +		goto cleanup;
> +	}
> +
> +	revindex_size = xsize_t(st.st_size);
> +
> +	if (revindex_size < RIDX_MIN_SIZE) {
> +		ret = error(_("reverse-index file %s is too small"), revindex_name);
> +		goto cleanup;
> +	}
> +
> +	if (revindex_size - RIDX_MIN_SIZE != st_mult(sizeof(uint32_t), num_objects)) {
> +		ret = error(_("reverse-index file %s is corrupt"), revindex_name);
> +		goto cleanup;
> +	}
> +
> +	*len = revindex_size;
> +	*data = xmmap(NULL, revindex_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +
> +cleanup:
> +	close(fd);
> +	return ret;
> +}
> +
> +static int load_pack_revindex_from_disk(struct packed_git *p)
> +{
> +	char *revindex_name;
> +	int ret;
> +	if (open_pack_index(p))
> +		return -1;
> +
> +	revindex_name = pack_revindex_filename(p);
> +
> +	ret = load_revindex_from_disk(revindex_name,
> +				      p->num_objects,
> +				      &p->revindex_map,
> +				      &p->revindex_size);
> +	if (ret)
> +		goto cleanup;
> +
> +	p->revindex_data = (char *)p->revindex_map + 12;

We've seen hardcoded constant "12" twice so far in this patch.

We need a C proprocessor macro "#define RIDX_FILE_HEADER_SIZE 12" or
something, perhaps?

> +cleanup:
> +	free(revindex_name);
> +	return ret;
> +}
> +
> +int load_pack_revindex(struct packed_git *p)
> +{
> +	if (p->revindex || p->revindex_data)
> +		return 0;
> +
> +	if (!load_pack_revindex_from_disk(p))
> +		return 0;
> +	else if (!load_pack_revindex_from_memory(p))
> +		return 0;
> +	return -1;
> +}
> +
>  int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
>  {
>  	unsigned lo, hi;
> @@ -203,18 +285,28 @@ int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
>  
>  uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos)
>  {
> -	if (!p->revindex)
> +	if (!(p->revindex || p->revindex_data))
>  		BUG("pack_pos_to_index: reverse index not yet loaded");
>  	if (p->num_objects <= pos)
>  		BUG("pack_pos_to_index: out-of-bounds object at %"PRIu32, pos);
> -	return p->revindex[pos].nr;
> +
> +	if (p->revindex)
> +		return p->revindex[pos].nr;
> +	else
> +		return get_be32((char *)p->revindex_data + (pos * sizeof(uint32_t)));

Good.  We are using 32-bit uint in network byte order.  We should
document it as such.

Let's not strip const away while casting, though.  get_be32()
ensures that it only reads and never writes thru the pointer, and
p->revindex_data is a "const void *".

>  }
>  
>  off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos)
>  {
> -	if (!p->revindex)
> +	if (!(p->revindex || p->revindex_data))
>  		BUG("pack_pos_to_index: reverse index not yet loaded");
>  	if (p->num_objects < pos)
>  		BUG("pack_pos_to_offset: out-of-bounds object at %"PRIu32, pos);
> -	return p->revindex[pos].offset;
> +
> +	if (p->revindex)
> +		return p->revindex[pos].offset;
> +	else if (pos == p->num_objects)
> +		return p->pack_size - the_hash_algo->rawsz;

OK, here is the answer to my previous question.  We should document
that the table has num_objects entries in the on-disk file (we do
not need to say that there is no sentinel entry in the table at the
end).

> +	else
> +		return nth_packed_object_offset(p, pack_pos_to_index(p, pos));
>  }
> diff --git a/pack-revindex.h b/pack-revindex.h
> index 6e0320b08b..01622cf21a 100644
> --- a/pack-revindex.h
> +++ b/pack-revindex.h
> @@ -21,6 +21,9 @@ struct packed_git;
>  /*
>   * load_pack_revindex populates the revindex's internal data-structures for the
>   * given pack, returning zero on success and a negative value otherwise.
> + *
> + * If a '.rev' file is present, it is checked for consistency, mmap'd, and
> + * pointers are assigned into it (instead of using the in-memory variant).

Hmph, I missed where it got checked for consistency, though.  If the
file is corrupt and has say duplicated entries, we'd happily grab
the data via get_be32(), for example.

> @@ -55,7 +58,9 @@ uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos);
>   * If the reverse index has not yet been loaded, or the position is out of
>   * bounds, this function aborts.
>   *
> - * This function runs in constant time.
> + * This function runs in constant time under both in-memory and on-disk reverse
> + * indexes, but an additional step is taken to consult the corresponding .idx
> + * file when using the on-disk format.

Again, I know this is a kind of detail that is interesting to those
who implemented the function, but I wonder how it would help those
who wonder if they should call it or use some other method to
achieve what they want.

