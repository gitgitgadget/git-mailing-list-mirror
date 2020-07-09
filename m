Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3D9C433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 14:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598E52073A
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 14:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bin1VFVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgGIOId (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:08:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57637 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgGIOId (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 10:08:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5EA9FEE6CC;
        Thu,  9 Jul 2020 10:08:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=opr5pW57xANuIp5ChhGJbX2Y4vk=; b=Bin1VF
        Vf76kIQedv0mwzEdJNThDCyMzKpCIUtlg1uNYcP0YwbLlaKck6PQ3Rv4EnSITCOL
        otqfNzOLp2B6BspIPKpUKOv5YGZmpavkBw4zZcW8J2LKqnUmxtJUFEvhhC5+mUcA
        DuESVZVSlauc70SRwMbfxArlXspfl1M7+KxaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AgeLshVTK0StYyLtaaA5+1zFPmVpWQ0W
        0HdKQim0DYbwRJY2uGUkGAglIcQTheLY0pRHdBW5vS/CVVwc7RzRM3/6Dt0caVOp
        /tuWxgPL/j+hJ0+0epS2X8qzzUvhmTcaHgRBdIEja/JeeWSn9TbUmN+gi3SYTsKe
        5igg54BiPrM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 57279EE6CB;
        Thu,  9 Jul 2020 10:08:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9423CEE6C7;
        Thu,  9 Jul 2020 10:08:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Subject: Re: [PATCH] entry: check for fstat() errors after checkout
References: <fbde5e1c9042ea06b448bc759cea9d45e300961f.1594260597.git.matheus.bernardino@usp.br>
        <882592a4-ffb7-924c-b52a-3287b11318b8@gmail.com>
Date:   Thu, 09 Jul 2020 07:08:27 -0700
In-Reply-To: <882592a4-ffb7-924c-b52a-3287b11318b8@gmail.com> (Derrick
        Stolee's message of "Thu, 9 Jul 2020 07:41:30 -0400")
Message-ID: <xmqqr1tkye5g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9AB50AA-C1ED-11EA-AE7F-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 7/8/2020 10:10 PM, Matheus Tavares wrote:
>> In 11179eb311 ("entry.c: check if file exists after checkout",
>> 2017-10-05) we started checking the result of the lstat() call done
>> after writing a file, to avoid writing garbage to the corresponding
>> cache entry. However, the code skips calling lstat() if it's possible
>> to use fstat() when it still has the file descriptor open. And when
>> calling fstat() we don't do the same error checking. To fix that, let
>> the callers of fstat_output() know when fstat() fails. In this case,
>> write_entry() will try to use lstat() and properly report an error if
>> that fails as well.
>
> Looking at this for the first time, I was confused because 11179eb311
> doesn't touch these lines. But that's the point: it should have.
>
> Thanks for finding this! I wonder if there is a way to expose this
> behavior in a test... it definitely seems like this is only something
> that happens if there is a failure in the filesystem, so I'm not sure
> such a thing is possible.

If another process removed the path from the filesystem after this
process created it and before this codepath used fstat() on it,
fstat() may succeed while lstat() would definitely fail.  There is
no "failure in the filesystem", but it would be harder to arrange.

> It would just be nice to know the ramifications of this change in
> behavior, keeping in mind that this behavior started way back in
> e4c7292353 (write_entry(): use fstat() instead of lstat() when file is
> open, 2009-02-09), over 11 years ago!

Yup.  I am curious how this was found ;-)

Thanks.
