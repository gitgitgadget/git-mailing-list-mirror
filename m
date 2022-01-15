Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676DEC433F5
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 06:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiAOG1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jan 2022 01:27:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62609 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiAOG1x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jan 2022 01:27:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8975110F438;
        Sat, 15 Jan 2022 01:27:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w8ZrEzVkAWE/FoXJR9Bqu4C2UyvMPUrRZYOg2R
        3BqoM=; b=rZHNF9dz3qgCcnUDFKdaqzRB1UsQbhW2tMFCtkZOJTtX3R/uTWz9/b
        REW8Xc1XMg+JMVccrXM27Khn882qS8ujkinsCeFBiR8rrw9w1rLp3B32/Zjl10tI
        eFTohoOzqVB9JLbYKI5eF1ksocH0w+OD/Ja33hQI+jMY8R0TFN8nE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8235110F437;
        Sat, 15 Jan 2022 01:27:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DDBD510F435;
        Sat, 15 Jan 2022 01:27:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH v3 2/9] midx.c: make changing the preferred pack safe
References: <cover.1638991570.git.me@ttaylorr.com>
        <cover.1641320129.git.me@ttaylorr.com>
        <7d20c13f8b48d2aef45c2c8c40efb6ecdb865aa8.1641320129.git.me@ttaylorr.com>
        <xmqqwnj29f1v.fsf@gitster.g> <xmqqsftq9en8.fsf@gitster.g>
        <YeIcem4bDgmQhs7+@nand.local>
Date:   Fri, 14 Jan 2022 22:27:50 -0800
In-Reply-To: <YeIcem4bDgmQhs7+@nand.local> (Taylor Blau's message of "Fri, 14
        Jan 2022 19:59:38 -0500")
Message-ID: <xmqqtue54iop.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 442D8484-75CC-11EC-8A9A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Jan 14, 2022 at 01:43:55PM -0800, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > Taylor Blau <me@ttaylorr.com> writes:
>> >
>> >> ... It's likely we were using
>> >> finalize_object_file() instead of a pure rename() because the former
>> >> also adjusts shared permissions.
>> >
>> > I thought the primary reason why we use finalize was because we
>> > ignore EEXIST (and the assumption is that the files with the same
>> > contents get the same name computed from their contents).
>> >
>> >>  	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
>> >>  					midx_hash, WRITE_REV);
>> >>
>> >> -	if (finalize_object_file(tmp_file, buf.buf))
>> >> +	if (rename(tmp_file, buf.buf))
>> >>  		die(_("cannot store reverse index file"));
>> >
>> > Doesn't your new code die with it if buf.buf names an existing file?
>>
>> Ah, scratch that.  rename() discards the old one atomically, so as
>> long as tmp_file and buf.buf are in the same directory (which I
>> think it is in this case), we wouldn't be affected by the bug that
>> is worked around with "Coda hack" in finalize_object_file(), either.
>
> Exactly. In this case, we really did want to overwrite an existing .rev
> file with the same name. That's because prior to this patch, we didn't
> store the object order in the MIDX itself. That made it possible for us
> to change the object order, but leave the MIDX checksum alone.

The other change in this step is addition of a new chunk type that
records the revindex data.  With that, you are guaranteeing that a
new file with the same checksum as an old one must have the
byte-for-byte identical contents, so at that point, it is OK to use
finalize_object_file() and not use rename() to keep the old file, no?

If that is the case, we may rather want to use f-o-f consistently
for stuff inside .git/ directory whose filename is tied with its
contents.  I do not think we want to chase a bug that comes from
difference between link-then-unlink vs rename, which affects loose
object files in one way and midx file in another way.
