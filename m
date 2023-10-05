Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77493E93712
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 20:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjJEUW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 16:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJEUWz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 16:22:55 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C44993
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 13:22:55 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60D3C1AD811;
        Thu,  5 Oct 2023 16:22:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=CxfywdJQyLQR/p4akFli3DXRcCgsRHwabDWn3m
        cN1jc=; b=FsK77z1JjCABGLLN/iTAHbSnLHnTAqFJ850JRa6hLuFraNH97w9FIY
        Z9yPHkjMX2nDBMQvsaQZ01VDk1IddmYoUgopZW6j1kOuT4JUHIWWs3NO2Dn20cBk
        UMuJuKMe9TCJUJmv9pYVw4ZXw0GXbRLHxcF75aXtSeQyoZlJkfTPk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57EE11AD810;
        Thu,  5 Oct 2023 16:22:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BCEAD1AD80F;
        Thu,  5 Oct 2023 16:22:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/3] builtin/repack.c: parse `--max-pack-size` with
 OPT_MAGNITUDE
In-Reply-To: <ZR7yOgvk3PCtYIR2@nand.local> (Taylor Blau's message of "Thu, 5
        Oct 2023 13:28:26 -0400")
References: <cover.1694123506.git.me@ttaylorr.com>
        <cover.1696293862.git.me@ttaylorr.com>
        <9ec999882d790aa770aba8c0916b9260661af9be.1696293862.git.me@ttaylorr.com>
        <ZR6ednOcuK6qizch@tanuki> <ZR7yOgvk3PCtYIR2@nand.local>
Date:   Thu, 05 Oct 2023 13:22:52 -0700
Message-ID: <xmqq8r8giztv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6A2761C-63BC-11EE-AE7C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Oct 05, 2023 at 01:31:02PM +0200, Patrick Steinhardt wrote:
>> On Mon, Oct 02, 2023 at 08:44:29PM -0400, Taylor Blau wrote:
>> > The repack builtin takes a `--max-pack-size` command-line argument which
>> > it uses to feed into any of the pack-objects children that it may spawn
>> > when generating a new pack.
>> >
>> > This option is parsed with OPT_STRING, meaning that we'll accept
>> > anything as input, punting on more fine-grained validation until we get
>> > down into pack-objects.
>> >
>> > This is fine, but it's wasteful to spend an entire sub-process just to
>> > figure out that one of its option is bogus. Instead, parse the value of
>> > `--max-pack-size` with OPT_MAGNITUDE in 'git repack', and then pass the
>> > knonw-good result down to pack-objects.
>>
>> Tiny nit: s/knonw/known.
>>
>> Other than that this patch looks good to me.
>
> Oops, good eyes. Perhaps Junio can tweak this when queuing, but if he
> doesn't, I don't think it'd be the end of the world...

I cannot do so "when queuing" anymore, but let me see if it is still
outside 'next' and then run "rebase -i" on it.

This is a bit different from what I would have written (I would have
passed the original string to underlying subprocess for it to sanity
check the value to its own liking, after we checked if it makes
sense when interpreted as magnitude, so that the underlying
subprocess, if it has stricter limit than we know of, can complain
with the string the end-user gave it, not the result of us turning
into a large integer string.  But that is minor.

Thanks, both.
