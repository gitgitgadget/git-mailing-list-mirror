Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A510208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 22:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752815AbdHOWsT (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 18:48:19 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:37403 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbdHOWsS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 18:48:18 -0400
Received: by mail-ua0-f170.google.com with SMTP id f9so8039610uaf.4
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 15:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=f9/jlssgjRRUzq+uT/Rke411/UJtyO08CRaUvkZaxb0=;
        b=CEIOoMoPRPumeMVJJowxVllYge6rouGdh6hQwFrWlMQKeLlgxiR0DcNgE3471/AVfc
         aYtjQ5qLPt0B7I2kW43Aqhx6/XaNaotkgLZ/bNSI9eavcCPUjrOEtOU3GRbGzTF3kr2g
         +SpiPnuxjxPjtL0ZeWxwLSfiTw8RRd36fFY88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=f9/jlssgjRRUzq+uT/Rke411/UJtyO08CRaUvkZaxb0=;
        b=kYp1uKLWTs97syuSOvVkhAiKN1A6pQXpA+pfn1QdP5Unhap8NIoCzoGLYMvOTYcp/T
         7hnL3u7+AdSQVaIWI2mNDyRG/F5DtJEAVl2rq6ibgFsHAbWVO6my+Yqge+VMsaK01FTA
         JQCNo4qJK4MGCMqv3rvuicxWXL+ASnh28JInFAekEzpf6MliOBZ2ySoUfjW7y0bDUkZS
         JXxNQpKs8G/FoB3327g3iK/EpO5gk3ClzAKNL+VBijuVcsQMhnUD+VPGCn1H7WBOZiXW
         zNeBThpnGDViwqjw2P/2SrsQrxskqeHi6ryVqF+5eka9oUCle13reD60++5fzvvWgYvC
         b87Q==
X-Gm-Message-State: AHYfb5gDDJwDDDY++FWgzgPjaFnSvB9Bvnijwa3rWrho/2v8KzqSNqy2
        smOiAUmb47E5yk2m448rJGQOO5x2jOuq
X-Received: by 10.159.54.111 with SMTP id s44mr19855200uad.197.1502837297428;
 Tue, 15 Aug 2017 15:48:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Tue, 15 Aug 2017 15:47:56 -0700 (PDT)
From:   Shawn Pearce <spearce@spearce.org>
Date:   Tue, 15 Aug 2017 15:47:56 -0700
Message-ID: <CAJo=hJum2boTfcXOaZVhxmbGB9Dygoc5=TM8RD2nqxo-Ahjv9g@mail.gmail.com>
Subject: Re: reftable [v6]: new ref storage format
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 5:13 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 08/07/2017 03:47 AM, Shawn Pearce wrote:
>> 6th iteration of the reftable storage format.
>
> Thanks!
>
>> Changes from v5:
>> - extensions.refStorage = reftable is used to select this format.
>>
>> - Log records can be explicitly deleted (for refs/stash).
>> - Log records may use Michael Haggerty's chained idea to compress before zlib.
>>   This saved ~5.8% on one of my example repositories.
>
> Meh. Do you think that's worth the complexity? The percentage savings
> will presumably be even lower for repositories that store significant
> information in their reflog messages.

No, I don't. I'm quite happy to remove the chained compression. I'll
keep the explicit deletion support for refs/stash.


>> [...]
>> #### ref record
>> - `0x3`: symref and text: `varint( text_len ) text`
[...]
> I'm still relatively negative on storing "other" references (except
> `HEAD`) in reftable. Here are my thoughts:
>
> * "Other" references are not considered for reachability, so there
>   is no need for their modification to be done atomically.
>
> * "Other" references don't have or need reflogs.
>
> * The refs API would have to provide a way for other Git code to
>   read and write "other" references including their extra
>   information, and the users of that information would have to
>   be rewritten to use the new API.
>
> * Presumably there are other programs in the wild (e.g., scripts)
>   that want to read that information. They wouldn't be able to
>   extract it from reftable files themselves, so we would also have
>   to provide a command-line tool to read (and write?) such files.
>
> Regardless, I suggest allocating separate `value_type`s for generic
> symrefs (which then wouldn't need a `ref: ` prefix) vs. for "other"
> references.

Ack, I agree with you. Lets only store symrefs as 0x3, without the
"ref: " prefix nonsense, and don't support the "other" ref types. You
make good arguments above about why those would not be stored in a
reftable.


>> [...]
>> ### Ref index
>
> It wasn't clear to me whether (in the case of a multi-level index) ref
> index blocks have to be aligned in `block_size` blocks (both their
> maximum size and their alignment). I don't see a reason for that to be
> required, though of course a compactor implementation might choose to
> block-align these blocks based on the filesystem that is in use.
>
> For that matter, I don't see an intrinsic reason that object blocks or
> object index blocks need to be block aligned.

Yea, you are correct. There isn't an actual need for alignment.

> In fact, the only way I can see that the current reftable proposal makes
> use of `block_size` is so that `obj_record`s can record `block_delta` in
> units of `block_size` rather than in units of bytes. (And given that I'm
> skeptical about the value of the object index, that justification seems
> thin.)

This use of block_size in the obj_record also has been bothering me.
I'm changing it to use position, which removes any requirement on
alignment. It does cost a bit more space, but I'm willing to trade
that for simplification in the format definition.

> I totally accept that *you* want to align your blocks, and I'm totally
> supportive of a format that permits a reftable compactor to write
> reftables that are block-aligned. It just still seems to me that it
> imposes more complexity than necessary on *other* reftable compactor
> implementations that don't care about block alignment.
>
> Aside from the object index, I think it would be straightforward to
> write a reftable reader that is totally ignorant of `block_size`.

Yup, I think you are right. So I'll try to rework the document to make
it so alignment and padding are writer-local decisions. A writer can
choose to align, or choose to skip alignment. Readers should be
prepared for either.


>> [...]
>> #### index record
>>
>> An index record describes the last entry in another block.
>> Index records are written as:
>>
>>     varint( prefix_length )
>>     varint( (suffix_length << 3) | 0 )
>>     suffix
>>     varint( block_position )
>>
>> Index records use prefix compression exactly like `ref_record`.
>>
>> Index records store `block_position` after the suffix, specifying the
>> absolute position in bytes (from the start of the file) of the block
>> that ends with this reference.
>
> Is there a reason that the index lists the *last* refname that is
> contained in a block rather than the *first* refname? I can't think of a
> reason to choose one vs. the other, but your choice was initially
> surprising. I don't think it matters either way; I was just curious.

Yes, there is a reason. When a reader is searching the index block and
discovers a key that is greater than their search needle, they are now
sitting on a record with the block_position for that greater key. By
using the *last* refname the current block_position is the one to seek
to.

If instead we used *first* refname, the reader would now have to
backtrack to the prior index record to get the block_position out of
that record. Or it has to keep a running "prior_position" local
variable.

Using last simplifies the reader's code.


> Do I understand correctly that all `block_position`s are *byte*
> addresses, even in the `ref_index` where they should all be multiples of
> the block size (except the zeroth one)? I think that's OK, but note that
> it will waste more than a byte per `ref_index` and `obj_index` record,
> on average.

Yes, because it simplifies a lot of code, especially if we do away
with any sort of requirement for alignment.


>> Readers must examine the block header at `block_position` to determine
>> if the next block is another level index block, or the leaf-level ref
>> block.
>
> For scanning through a whole namespace, like `refs/tags/`, I guess you
> only need to use a binary search to find the beginning of the range.
> Then you would read serially forwards from there, continuing from one
> `ref_block` to the next, until you find a refname that doesn't start
> with `refs/tags/`. In other words, there is no reason to binary search
> to find the end of the namespace, correct?

Correct.


>> [...]
>> #### Importing logs
>>
>> When importing from `$GIT_DIR/logs` writers should globally order all
>> log records roughly by timestamp while preserving file order, and
>> assign unique, increasing `update_index` values for each log line.
>> Newer log records get higher `update_index` values.
>>
>> Although an import may write only a single reftable file, the reftable
>> file must span many unique `update_index`, as each log line requires
>> its own `update_index` to preserve semantics.
>
> Thinking out loud here: A really high-quality importer might want to
> group together, under the same `update_index`, ref updates that are
> thought originally to have been done in the same transaction.
[...]
> But I doubt that it is worth the effort. (The whole idea gives me nasty
> flashbacks from working on cvs2svn/cvs2git.)

Yup, that is why I didn't go down writing a description like that here. :)
