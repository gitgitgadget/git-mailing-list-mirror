Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4C0A20387
	for <e@80x24.org>; Tue, 18 Jul 2017 20:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbdGRUyl (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 16:54:41 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33373 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbdGRUyk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 16:54:40 -0400
Received: by mail-vk0-f54.google.com with SMTP id r126so276415vkg.0
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 13:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BnX/b5eQ4aQ5VNQgFWBX+D5Yu2bQcFzen3Ivk7n/VwI=;
        b=a5dOBBCU/NAcUKsqNjHbu0uHn/x+H3P647g38EQjMk5LOqhqPtN1TNcZ2qSrmmFJoJ
         5istXy4DrqB2hBz9a7ogNrSdRKliTnowcAbZ7gq2cDHtq98lHo6zYtpg7zRPP/RGCBt6
         i3uwc3b5XJAeBHHlx4erDE0PPmMDKVzmyAgs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BnX/b5eQ4aQ5VNQgFWBX+D5Yu2bQcFzen3Ivk7n/VwI=;
        b=IsmIVdqBofSu7fBl9217NuXNP9tmv/wCCnAYSeQoFf7/DxSF56qojKojVtSoxNKGtf
         4761ius7D4HcJDsnlZWefsOLr8IBHPv8kIc2jpv7Z2L/CS3hCVMePIK1yZAkVnALztxu
         M+zcM6nYYeGC6SImvYmKe5o5VYlKVw6HzY843GQr144hHSJSRaBKIeDgDNU1XsrfSm7j
         UGE5yJx11L7k5ZHlwp5qF4qR7h28zqGI4qqMzYyJJbK5nGnL/5IO+ToXxvWPfxSIFyJI
         tMe6p7CcbOdw0ReSIhAnDJZ6RsyHB93SxUljSV8GRN5RFrUt2PX2OymubZYlkF7RU4z+
         E+Ew==
X-Gm-Message-State: AIVw110m0nn3hQ3zF+ajBkITafYK5cii8MyfbQROsx3dem9jg6MrA2Rd
        Nnp4jxpT40BCZ017ccJSvKgvUS9Uv2QU4Ss=
X-Received: by 10.31.59.69 with SMTP id i66mr2106600vka.105.1500411279551;
 Tue, 18 Jul 2017 13:54:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.137.4 with HTTP; Tue, 18 Jul 2017 13:54:18 -0700 (PDT)
In-Reply-To: <xmqqlgnmhmep.fsf@gitster.mtv.corp.google.com>
References: <CAJo=hJtTp2eA3z9wW9cHo-nA7kK40vVThqh6inXpbCcqfdMP9g@mail.gmail.com>
 <xmqqlgnmhmep.fsf@gitster.mtv.corp.google.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Tue, 18 Jul 2017 13:54:18 -0700
Message-ID: <CAJo=hJuP9GdudFsA_ToFQwx-zESaDHRDXHLxmvAXSX5CKmh7JQ@mail.gmail.com>
Subject: Re: reftable [v2]: new ref storage format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 17, 2017 at 12:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>> You can read a rendered version of this here:
>> https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md
>
> Just a few comments.
>
>> A variable number of 4-byte `restart_offset` values follows the
>> records.  Offsets are relative to the start of the block (0 in first
>> block to include file header) and refer to the first byte of any
>> `ref_record` whose name has not been prefixed compressed.  Readers can
>> start linear scans from any of these records.
>
> It is unclear what "0 in first block to include file header" wants
> to say.  Do I write "8" if I want to express the offset of the first
> record in the first block, or do I write "0"?

"8". I've updated the text to try and clarify this better.


>> The 2-byte `number_of_restarts + 1` stores the number of entries in
>> the `restart_offset` list.
>
> It is unclear whose responsibility it is to add this "1".  Does this
> mean a reader thinks there is one entry in the restart table when it
> sees "0" in the number_of_restarts field (hence you can have max
> 65536 entries in total)?

Correct, I've reworded this section to clarify the reader must add +1
to reach the potential max of 65536 entries in total.

>> Readers can use the restart count to binary search between restarts
>> before starting a linear scan.  The `number_of_restarts` field must be
>> the last 2 bytes of the block as specified by `block_len` from the
>> block header.
>
> Does the new term "restart count" mean the same thing as
> number_of_restarts?

Not quite (because of the +1 issue), I've fixed the document to
introduce and define restart_count.


>> ### Log block format
>>
>> A log block is written as:
>>
>>     'g'
>>     uint24( block_len )
>>     zlib_deflate {
>>       log_record*
>>       int32( restart_offset )*
>>       int16( number_of_restarts )
>>     }
>>
>> Log blocks look similar to ref blocks, except `block_type = 'g'`.
>
> Is there a general recommended strategy for writers to choose how
> many entries to include in a single physical block?  I understand
> that the deflated whole must fit in the physical block whose length
> is defined in the footer of the whole file, and in general you would
> not know how small the data deflates down to before compressing,
> right?

No, this is an  incorrect understanding. The deflated log blocks do
not match the physical block length of the file. They are variable
length, matching whatever the deflater output, with no inter-block
padding.

Writers should allocate a "reasonable buffer" (my prototype has it
default to 2x the ref block length), pack log records into that, then
deflate that when its at capacity.


>> Log record keys are structured as:
>>
>>     ref_name '\0' reverse_int32( time_sec )
>>
>> where `time_sec` is the update time in seconds since the epoch.  The
>> `reverse_int32` function inverses the value so lexographical ordering
>> the network byte order time sorts more recent records first:
>>
>>     reverse_int(int32 t) {
>>       return 0xffffffff - t;
>>     }
>
> Is 2038 an issue, or by that time we'd all be retired together with
> this file format and it won't be our problem?

Based on discussion with Michael Haggerty, this is now an 8 byte field
storing microseconds since the epoch. We should be good through year
9999.


>> ### Log index
>>
>> The log index stores the log key (`refname \0 reverse_int32(time_sec)`)
>> for the last log record of every log block in the file, supporting
>> bounded-time lookup.
>
> This assumes that timestamps never wildly rewind in the reflog,
> doesn't it?  Is that a sensible assumption?

Oy. I forgot that local clock skew can cause this sort of behavior. :(

> Or does "the last log record" in the above mean "the log record with
> largest timestamp?  ... ah, not that is still not sufficient.  You'd
> still need to assume that timestamps on entries in one log block must
> be all older than the ones on entries in later log blocks.  Hmph...

Correct; I was assuming the times would be in order.

> Also it is not clear to me how reflogs for two refs would be
> intermixed in the log blocks, and what log keys for the entries must
> be recorded in the log index, to facilitate efficient lookup.  Is it
> assumed that a consecutive sequence of log blocks record reflogs for
> the same ref, before the sequence of log blocks switch to record
> reflogs for another ref, or something?

Multiple refs share the same log block.

>> A log index block must be written if 2 or more log blocks are written
>> to the file.  If present, the log index appears after the first log
>> block.  There is no padding used to align the log index to block
>> alignment.
>>
>> Log index format is identical to ref index, except the keys are 5
>> bytes longer to include `'\0'` and the 4-byte `reverse_int32(time)`.
>> Records use `block_offset` to refer to the start of a log block.
>
> I am assuming that we do not care about being able to quickly
> determine master@{24028}; I would imagine that it wouldn't be too
> hard to add an index to help such query, but I offhand would not
> know the details until I figure out how the format handles reflog
> entries for multiple refs first.

There is no assistance for master@{24028} quickly, its just a brute
force scan through 24,028 log records that pertain to master. Roughly
the same as the current reflog format.
