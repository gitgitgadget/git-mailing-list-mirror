Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF417C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 20:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbiF3UMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 16:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbiF3UMY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 16:12:24 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D16B4507B
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 13:12:23 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3210A135411;
        Thu, 30 Jun 2022 16:12:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=72pYTNJwwsyDk0Qef9GTn2NFsVFeoX56PQ3rTr
        ZkBoQ=; b=FBObFmvtQVrrD6xFkQrBGBXpZ7E7d2vE20XYy7xX2mgsmPfg+4L/IW
        jCIyI/VRlhk764EfoBwBjmab3fyOI76gsGs5/XdzLQjbgBklue5svyIicnw9kEWa
        DJXCi7uRIoUGjARjL3nbJ92xd9j/yrLw3g2+AuhgTn9Svkfm51w4E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2820A135410;
        Thu, 30 Jun 2022 16:12:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8BEBB13540F;
        Thu, 30 Jun 2022 16:12:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Gregory Szorc <gregory.szorc@gmail.com>, git@vger.kernel.org,
        stolee@gmail.com
Subject: Re: Race condition between repack and loose-objects maintenance task
References: <CAKQoGamCrRMqtzziuzi8mL6E7uA3SC1WXiMGT_4rpbk1jcu_OQ@mail.gmail.com>
        <YryF+vkosJOXf+mQ@nand.local>
        <CAKQoGakSFaNm10ZeTKc8XtTcD0JW19CZP1OwA4j7W__iBQaJfg@mail.gmail.com>
        <YryKCl5J1Em89d3e@nand.local>
        <CAKQoGanPBec6wRO6uWrETaoJXdszpjRWytXaJwx6jw0mrrj-gQ@mail.gmail.com>
        <Yr0WLebMfBXZ1K7D@nand.local> <Yr0XMWWyD5C9uhlb@nand.local>
Date:   Thu, 30 Jun 2022 13:12:20 -0700
In-Reply-To: <Yr0XMWWyD5C9uhlb@nand.local> (Taylor Blau's message of "Wed, 29
        Jun 2022 23:23:29 -0400")
Message-ID: <xmqqletdewrf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2F7D4BC-F8B0-11EC-A674-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Jun 29, 2022 at 11:19:09PM -0400, Taylor Blau wrote:
>> > However, I think there is yet another bug at play: running
>> > `incremental-repack` appears to be able to repack the cruft packfile.
>> > In doing so, it deletes its .mtimes file and the metadata inside.
>>
>> That sounds like a bug to me. I'll take a look into it and see what I
>> can find.
>
> I actually think that there are two bugs here.
>
> One is that we run a MIDX repack and expire, which could lead to us
> repacking the entire contents of the cruft pack and then expiring the
> metadata file. This is a bug, and we should exclude cruft packs from
> this computation.
>
> Another bug can happen when the cruft pack gets written into the MIDX
> and is MIDX-expireable (meaning that no objects are selected from the
> cruft pack). In that case, the `git multi-pack-index expire` step would
> remove the cruft pack entirely, which is also incorrect.
>
> I'll take a look at fixing both of these, and thanks for pointing them
> out!

Thanks, both.

The fact that the semantics of the .mtimes file being not equivalent
to the mtime on individual loose objects does not help thinking
about the possible ways the "cruft" pack can break, and both of the
possible issues you discuss above are indeed tricky ones.


