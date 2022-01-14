Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C9FC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 21:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiANVn7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 16:43:59 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56717 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiANVn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 16:43:59 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0007D167BDB;
        Fri, 14 Jan 2022 16:43:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v/dHzLVyFdSFCoy7cgsCubMWNbDzQRX+JOYL0K
        8I0gc=; b=gFhul+s/BFtjMAFLE5yYKzde8svqWtmviF3AEbV5Q/SzWJxCUKXz9Z
        80+0U6bbwcqMgxtJClsfyCzZScipdRC7fgk/kLPJg/5pBPrKOWov2xl+PIJJtD7C
        miT9s+7fPpFB5f+ZZ/dpra4jld5cV9gOjwemv2yD0Q2lISeuPT/Z8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ED935167BDA;
        Fri, 14 Jan 2022 16:43:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 55973167BD9;
        Fri, 14 Jan 2022 16:43:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH v3 2/9] midx.c: make changing the preferred pack safe
References: <cover.1638991570.git.me@ttaylorr.com>
        <cover.1641320129.git.me@ttaylorr.com>
        <7d20c13f8b48d2aef45c2c8c40efb6ecdb865aa8.1641320129.git.me@ttaylorr.com>
        <xmqqwnj29f1v.fsf@gitster.g>
Date:   Fri, 14 Jan 2022 13:43:55 -0800
In-Reply-To: <xmqqwnj29f1v.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        14 Jan 2022 13:35:08 -0800")
Message-ID: <xmqqsftq9en8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 131FF8AC-7583-11EC-9FE3-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> ... It's likely we were using
>> finalize_object_file() instead of a pure rename() because the former
>> also adjusts shared permissions.
>
> I thought the primary reason why we use finalize was because we
> ignore EEXIST (and the assumption is that the files with the same
> contents get the same name computed from their contents).
>
>>  	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
>>  					midx_hash, WRITE_REV);
>>  
>> -	if (finalize_object_file(tmp_file, buf.buf))
>> +	if (rename(tmp_file, buf.buf))
>>  		die(_("cannot store reverse index file"));
>
> Doesn't your new code die with it if buf.buf names an existing file?

Ah, scratch that.  rename() discards the old one atomically, so as
long as tmp_file and buf.buf are in the same directory (which I
think it is in this case), we wouldn't be affected by the bug that
is worked around with "Coda hack" in finalize_object_file(), either.

