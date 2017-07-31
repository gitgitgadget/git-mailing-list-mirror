Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6721F991
	for <e@80x24.org>; Mon, 31 Jul 2017 19:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbdGaTm1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 15:42:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59975 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750999AbdGaTmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 15:42:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B6727A3F44;
        Mon, 31 Jul 2017 15:42:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aeE/AChgWGC9bVIbr8ksvW7blcM=; b=NoY+y7
        yvUPOIi3f2E1McEkojOgxSCD5RV4Ugt4rUbtbd2DYTRyZ0sYQX//VXzu4Ask+dZT
        Nea1x6nMGC/6Cih1eatTNgPot2Z0jDahOTW4iKZ75iPQGnyy3X5LGrUJm8DvzEbN
        cZNGniaNGen/968ibnU5xrM7qrWfv3MKhwEho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z0X3ISvHOlbVMQ1SfWLr76NteYqxWZB6
        ks/mrPlRR6jzjPzrBdWywxbydlmyunCzjUJLD0aX8eN54YfSMjqLipOeuSysp0bu
        6ZJzLHVAL7fB4E5IldBrbXCNvUxSdzqMfkZ8TMFvT/EgIoKXP9bZ+RcvDcwa36k9
        Oh9vUvZDL2w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADFDCA3F43;
        Mon, 31 Jul 2017 15:42:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0A1B4A3F40;
        Mon, 31 Jul 2017 15:42:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Borowitz <dborowitz@google.com>
Subject: Re: reftable [v4]: new ref storage format
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
Date:   Mon, 31 Jul 2017 12:42:15 -0700
In-Reply-To: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
        (Shawn Pearce's message of "Sun, 30 Jul 2017 20:51:24 -0700")
Message-ID: <xmqqlgn4ieaw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BE467B2-7628-11E7-87BB-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> ### Peeling
>
> References in a reftable are always peeled.

This hopefully means "a record for an annotated (or signed) tag
records both the tag object and the object it refers to", and does
not include peeling a commit down to its tree.

> ### Reference name encoding
>
> Reference names should be encoded with UTF-8.

If we limited ourselves to say that a refname is an uninterpreted
sequence of bytes that must pass check_refname_format() test, then
we won't open us to confusion such as "are two refs with the same
Unicode name encoded with different normalization form considered
the same?"

In what way does this "should be in UTF-8" help describing the file
format, I wonder.

> ### Directory/file conflicts
>
> The reftable format accepts both `refs/heads/foo` and
> `refs/heads/foo/bar` as distinct references.
>
> This property is useful for retaining log records in reftable, but may
> confuse versions of Git using `$GIT_DIR/refs` directory tree to
> maintain references.  Users of reftable may choose to continue to
> reject `foo` and `foo/bar` type conflicts to prevent problems for
> peers.

This is an interesting one.  I do agree that preserving reflog for
removed refs is a nice propertly to have.

> ### First ref block
>
> The first ref block shares the same block as the file header, and is
> 24 bytes smaller than all other blocks in the file.  The first block
> immediately begins after the file header, at offset 24.
>
> If the first block is a log block (a log only table), its block header
> begins immediately at offset 24.

A minor nit: You called such a file "a log-only file"; let's be consistent.

>
> ### Ref block format
>
> A ref block is written as:
>
>     'r'
>     uint24( block_len )
>     ref_record+
>     uint32( restart_offset )+
>     uint16( restart_count )
>     padding?
>
> Blocks begin with `block_type = 'r'` and a 3-byte `block_len` which
> encodes the number of bytes in the block up to, but not including the
> optional `padding`.  This is almost always shorter than the file's
> `block_size`.  In the first ref block, `block_len` includes 24 bytes
> for the file header.

As a block cannot be longer than 16MB, allocating uint32 to a
restart offset may be a bit overkill.  I do not know if it is worth
attempting to pack 1/3 more restart entries in a block by using
uint24, though.

> The end of the block may be filled with `padding` NUL bytes to fill
> out the block to the common `block_size` as specified in the file
> header.  Padding may be necessary to ensure the following block starts
> at a block alignment, and does not spill into the tail of this block.
> Padding may be omitted if the block is the last block of the file, and
> there is no index block.  This allows reftable to efficiently scale
> down to a small number of refs.

We may want to phrase it in a way that it is more clear that
padding, if exists, must be filled with NUL bytes, not arbitrary
garbage.  Your version may be clear enough already.  I dunno.

> #### ref record
>
> A `ref_record` describes a single reference, storing both the name and
> its value(s). Records are formatted as:
>
>     varint( prefix_length )

Just like we saw that "uintX are network byte order" upfront, it may
be easier to give the definition, or at least an outline, of varint()
near there.

>     varint( (suffix_length << 3) | value_type )
>     suffix
>     value?
>
> The `prefix_length` field specifies how many leading bytes of the
> prior reference record's name should be copied to obtain this
> reference's name.  This must be 0 for the first reference in any
> block, and also must be 0 for any `ref_record` whose offset is listed
> in the `restart_offset` table at the end of the block.
>
> Recovering a reference name from any `ref_record` is a simple concat:
>
>     this_name = prior_name[0..prefix_length] + suffix
>
> The `suffix_length` value provides the number of bytes to copy from
> `suffix` to complete the reference name.
>
> The `value` follows.  Its format is determined by `value_type`, one of
> the following:
>
> - `0x0`: deletion; no value data (see transactions, below)
> - `0x1`: one 20-byte object id; value of the ref
> - `0x2`: two 20-byte object ids; value of the ref, peeled target
> - `0x3`: symref and text: `varint( text_len ) text`
> - `0x4`: index record (see below)
> - `0x5`: log record (see below)
>
> Symbolic references use `0x3` with a `text` string starting with `"ref: "`,
> followed by the complete name of the reference target.  No
> compression is applied to the target name.  Other types of contents
> that are also reference like, such as `FETCH_HEAD` and `MERGE_HEAD`,
> may also be stored using type `0x3`.
>
> Types `0x6..0x7` are reserved for future use.

I wondered if we regret the apparent limited extensibility later,
but giving 4 bits to value-type would limit suffix length that can
be represented by a single varint() only to 7, while the format
described would give us up to 15 bytes.  We can say type 0x7 would
be followed by another varint() to record the extended type, or
something, to extend it, so probably what you did here strikes a
good balance.

> ### Ref index
> ...
> An index block should only be written if there are at least 4 blocks
> in the file, as cold reads using the index requires 2 disk reads (read
> index, read block), and binary searching <= 4 blocks also requires <=
> 2 reads.  Omitting the index block from smaller files saves space.

I think the last "<= 4" should be "< 4" here.  That is consistent
with an earlier part of the paragraph that requires at least 4
ref-blocks in the file, because a reftable with only 3 ref-blocks
still can be accessed with 2 reads (a reftable with 4 ref-blocks
without index may need 3 reads as there is no "middle" for binary
search).

The first sentence should be "if there are at least 4 ref-blocks", I
guess.

> ### Obj block format
>
> Object blocks use unique, abbreviated 2-20 byte SHA-1 keys, mapping
> to ref blocks containing references pointing to that object directly,
> or as the peeled value of an annotated tag.  Like ref blocks, object
> blocks use the file's standard `block_size`.
>
> To save space in small files, object blocks may be omitted if the ref
> index is not present.  When missing readers should brute force a
> linear search of all references to lookup by SHA-1.

I want a comma after "When missing".

It is a bit unclear why the presense of ref-index is linked to the
presense and/or need of this block. I first thought that the reason
is because the data in this table is to index into ref-index table,
in which case of course it would not make sense to have this table
if ref-index table is not present, but that is not the case. Am I
correct to read the above advice/suggestion to mean "if the reftable
has so few blocks not to require ref-index blocks, we hypothesize
that it is not worth having obj-block table either"?

> #### obj record
>
> An `obj_record` describes a single object abbreviation, and the blocks
> containing references using that unique abbreviation:
>
>     varint( prefix_length )
>     varint( (suffix_length << 3) | cnt_3 )
>     suffix
>     varint( cnt_large )?
>     varint( block_delta )+
>
> Like in reference blocks, abbreviations are prefix compressed within
> an obj block.  On large reftables with many unique objects, higher
> block sizes (64k), and higher restart interval (128), a
> `prefix_length` of 2 or 3 and `suffix_length` of 3 may be common in
> obj records (unique abbreviation of 5-6 raw bytes, 10-12 hex digits).

OK.

> Each record contains `block_count` number of block identifiers for ref
> blocks.  For 1-7 blocks the block count is stored in `cnt_3`.  When
> `cnt_3 = 0` the actual block count follows in a varint, `cnt_large`.

I feel a bit lost here.  Is this about a single object pointed by
multiple refs, and that we expect to have not too many refs pointing
at a single object?

> The first `block_delta` is the absolute block identifier counting from
> the start of the file. The offset of that block can be obtained by
> `block_delta[0] * block_size`.  Additional `block_delta` entries are
> relative to the prior entry, e.g. a reader would perform:
>
>     block_id = block_delta[0]
>     prior = block_id
>     for (j = 1; j < block_count; j++) {
>       block_id = prior + block_delta[j]
>       prior = block_id
>     }
>
> With a `block_id` in hand, a reader must linearly scan the ref block
> at `block_id * block_size` offset in the file, starting from the first
> `ref_record`, testing each reference's SHA-1s (for `value_type = 0x1`
> or `0x2`) for full equality.  Faster searching by SHA-1 within a
> single ref block is not supported by the reftable format.  Smaller
> block sizes reduces the number of candidates this step must consider.

Assuming varint() yields an unsigned quantity, the writer needs to
sort the refs that point at the same object by their block numbers
first and record from the smallest one to the larger ones?  Not a
complaint, but just seeking help to make sure I understood it.

> ### Log block format
>
> Unlike ref and obj blocks, log block sizes are variable in size, and
> do not match the `block_size` specified in the file header or footer.
> Writers should choose an appropriate buffer size to prepare a log block
> for deflation, such as `2 * block_size`.
>
> A log block is written as:
>
>     'g'
>     uint24( block_len )
>     zlib_deflate {
>       log_record+
>       int32( restart_offset )+
>       int16( restart_count )
>     }
>
> Log blocks look similar to ref blocks, except `block_type = 'g'`.
>
> The 4-byte block header is followed by the deflated block contents
> using zlib deflate.  The `block_len` in the header is the inflated
> size (including 4-byte block header), and should be used by readers to
> preallocate the inflation output buffer.  Offsets within the block
> (e.g.  `restart_offset`) still include the 4-byte header.  Readers may
> prefer prefixing the inflation output buffer with the 4-byte header.

Is block_len allowed to exceed the file-global block_size?

> #### log record
>
> Log record keys are structured as:
>
>     ref_name '\0' reverse_int64( update_index )
>
> where `update_index` is the unique transaction identifier.  The
> `update_index` field must be unique within the scope of a `ref_name`.
> See the update index section below for further details.
>
> The `reverse_int64` function inverses the value so lexographical
> ordering the network byte order encoding sorts the more recent records
> with higher `update_index` values first:
>
>     reverse_int64(int64 t) {
>       return 0xffffffffffffffff - t;
>     }

OK, so this no longer is linked to timestamp, which makes things
simpler.

All log records in a single reftable is sorted with the log record
key, so the reflog entries for a specific ref are adjacent to each
other and are ordered in reverse "chronological" order, assuming
that the update_index transaction numbers monotonically increase?

> The value data following the key suffix is complex:
>
> - two 20-byte SHA-1s (old id, new id)
> - varint time in seconds since epoch (Jan 1, 1970)
> - 2-byte timezone offset (signed)

"offset in minutes"

> - varint string of committer's name
> - varint string of committer's email

We might want to clarify that this is without surrounding <>.

> #### Reading the log
>
> Readers accessing the log must first read the footer (below) to
> determine the `log_offset`.  The first block of the log begins at
> `log_offset` bytes since the start of the file.  The `log_offset` is
> not block aligned.
>
> #### Importing logs
>
> When importing from `$GIT_DIR/logs` writers should globally order all
> log records roughly by timestamp while preserving file order, and
> assign unique, increasing `update_index` values for each log line.

I am not quite sure why you need global order (I am assuming that
you mean "consistency across multiple logs, e.g. $GIT_DIR/logs/HEAD
and $GIT_DIR/logs/refs/heads/master"), as the resulting log table
sorts the entries essentially with refname as the first key and then
recentness of the entry as the second key.  Wouldn't the resulting
log table in a reftable be sorted in the same way as

    cd $GIT_DIR/logs &&
    find -type f -print |
    sort |
    xargs -n 1 tac

anyway?

... Ah, you want to give the same (or at least close-enough)
transaction ID to two reflog entries that result from a commit while
'master' branch is checked out, one for 'refs/heads/master' and the
other for HEAD.  Then the suggestion makes sense.  I wonder if the
existing log records that are migrated are known to have timestamps
that fit in int64_t, using the timestamp from the original is
sufficient?

... The answer is no; if the original records clock rewind, you'd
still want to assign the update_index number that is in line with
the order of the entries, not with the skewed clock value.

OK.

> ## Repository format
>
> ### Version 1
>
> A repository must set its `$GIT_DIR/config` to configure reftable:
>
>     [core]
>         repositoryformatversion = 1
>     [extensions]
>         reftable = 1

The expectation is that this number matches the version number
recorded in the reftable itself?

That's it for now.  I'll comment on the part after Update
transactions in a separate message.

Thanks.
