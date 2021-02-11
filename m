Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C75C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 00:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB5464E31
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 00:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhBKALB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 19:11:01 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55068 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhBKALA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 19:11:00 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 54AEB107AAC;
        Wed, 10 Feb 2021 19:10:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gD1RPei7rENdvbyJBRC68NbUlEI=; b=lIc7J8
        D2h9a2zy8WInsTAL3MvQRK0M0+xBwYRLnJpbK87fGGXM1qLvDS6tH9gBl0Huk06M
        MdQbYv5YE7tWMlHW9mcAYG1YFijNlCCjQK6EgBzQimlQvtXlSNmPrZUOrJmzZVxx
        oXEbtNPpDqHmhI+aKqaw+v6303TU3FjAxisaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HHuaV0c2UWs9qVKIXwIdkwXE0wfn2ol2
        R+KYPyl+jfcMsDjA1n4XNsy5la1u6c4OOTPzxLgMaHtwE0DJT35J4hMuHZ0whzKq
        nIka5jA6lfEbKZGy5ZrQiaAhJXJZgxF+PYqc4OcUx0F3lyVc6rcEvZeFtJhZT+Hp
        aZ+CBbC8XYQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4DC67107AAB;
        Wed, 10 Feb 2021 19:10:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AD115107AA9;
        Wed, 10 Feb 2021 19:10:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t1450: robustify `remove_object()`
References: <pull.874.git.1612980090.gitgitgadget@gmail.com>
        <24d43d121162a9052f31c760a5fc929fdaad76b5.1612980090.git.gitgitgadget@gmail.com>
        <xmqqtuqj1wzg.fsf@gitster.c.googlers.com>
        <YCRqOVS/iXp/d6Rc@nand.local>
Date:   Wed, 10 Feb 2021 16:10:14 -0800
In-Reply-To: <YCRqOVS/iXp/d6Rc@nand.local> (Taylor Blau's message of "Wed, 10
        Feb 2021 18:20:25 -0500")
Message-ID: <xmqqsg63zcpl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8467A1D0-6BFD-11EB-935C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Feb 10, 2021 at 12:36:19PM -0800, Junio C Hamano wrote:
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>>
>> > -test_expect_success 'setup: helpers for corruption tests' '
>> > -	sha1_file() {
>> > -		remainder=${1#??} &&
>> > -		firsttwo=${1%$remainder} &&
>> > -		echo ".git/objects/$firsttwo/$remainder"
>> > -	} &&
>> > +sha1_file () {
>> > +	git rev-parse --git-path objects/$(test_oid_to_path "$1")
>> > +}
>>
>> Yeah, back when 90cf590f (fsck: optionally show more helpful info
>> for broken links, 2016-07-17) originally introduced this pattern,
>> we didn't have nicely abstracted helper, but now we do, and there
>> is no reason not to use it.  Nice.
>
> This has nothing to do with this series, but I do notice a number of
> other uses of test_oid_to_path that are doing this exact thing. In fact,
> many of them don't use "git rev-parse --git-path", which would be
> better.
>
> I wonder if it's worth a clean-up on top to consolidate all of those
> "combine the loose object path of the object with xyz OID and the
> $GIT_DIR/objects directory".
>
> In either case -- and I think I'm pretty clearly being pedantic at this
> point -- do you suppose it's worthwhile to rename sha1_file to something
> that doesn't have sha1 in it?

Possibly.  That is probably outside the scope of this topic, but we
see such SHA -> HASH clean-up patches in different places, and this
certainly is a fair game for such a clean-up, I would think.

Thanks.
