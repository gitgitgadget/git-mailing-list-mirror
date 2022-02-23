Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B6CC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 23:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244796AbiBWX13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 18:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235909AbiBWX12 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 18:27:28 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BA665F5
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:26:58 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BAD8B18C020;
        Wed, 23 Feb 2022 18:26:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ICVkDrlbdILW5fI2QPPPtbnSe75TgrOTpFGhwu
        aIT9A=; b=CWlzS3ZyG7gwJUgAPBsWSG/npzsmDB43kV5DntL0ur789B43NyRDtz
        kLGd9pVkuCdhDQn+nilkJGKWKA2t6iOYho3hCFBBy2HVhcmOYEYTrNRS6PGW8dLV
        RBUpONJSsUAICeZr2EWUP+99xLMGLOCLTYUOOqx+nXoCq2Zl7c5zk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B3D9218C01F;
        Wed, 23 Feb 2022 18:26:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2740718C01E;
        Wed, 23 Feb 2022 18:26:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Matt Cooper via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com,
        Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH 2/2] t5302: confirm that large packs mention limit
References: <pull.1158.git.1645632193.gitgitgadget@gmail.com>
        <43990408a10d65058d872f13ea9619e85de7081d.1645632193.git.gitgitgadget@gmail.com>
        <YhZtcEqczAFES+hQ@nand.local>
Date:   Wed, 23 Feb 2022 15:26:54 -0800
In-Reply-To: <YhZtcEqczAFES+hQ@nand.local> (Taylor Blau's message of "Wed, 23
        Feb 2022 12:22:56 -0500")
Message-ID: <xmqqh78pp3k1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 168152E2-9500-11EC-B5C1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Feb 23, 2022 at 04:03:13PM +0000, Matt Cooper via GitGitGadget wrote:
>> From: Matt Cooper <vtbassmatt@gmail.com>
>>
>> When a pack can't be processed because it's too large, we report the
>> exact nature of the breach. This test ensures that the error message has
>> a human-readable size included.
>>
>> Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
>> Helped-by: Taylor Blau <me@ttaylorr.com>
>> Helped-by: Derrick Stolee <derrickstolee@github.com>
>
> Ah, one small note here: typically we try to keep commit trailers in
> reverse-chronological order, with the most recent thing at the bottom.
> That doesn't really matter for the Helped-by's, but keeping your s-o-b
> at the bottom indicates that you signed off on the result of your patch
> after Stolee and I gave some suggestions.

It is very much appreciated to point these things out.

> It's not a huge deal, and I'm sure we have plenty of examples of
> slightly out-of-order commit trailers throughout our history. Personally
> I don't consider it worth rerolling, but perhaps something to keep in
> mind for future contributions :-).

People need to understand that each such contributor robs maintainer
bandwidth by not rerolling.

>> +test_expect_success 'too-large packs report the breach' '
>> +	pack=$(git pack-objects --all pack </dev/null) &&
>> +	sz="$(test_file_size pack-$pack.pack)" &&
>> +	test "$sz" -gt 20 &&
>> +	test_must_fail git index-pack --max-input-size=20 pack-$pack.pack 2>err &&
>> +	grep "maximum allowed size (20 bytes)" err
>> +'

This test looks OK to me.

Shouldn't it be squashed into the previous patch?  After all, it is
a test for the new behaviour introduced by the previous step, right?

Thanks.

