Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D279C433F5
	for <git@archiver.kernel.org>; Fri, 13 May 2022 12:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380477AbiEMM5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 08:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380456AbiEMM5G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 08:57:06 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527089B186
        for <git@vger.kernel.org>; Fri, 13 May 2022 05:57:03 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 22CCE1A49D2;
        Fri, 13 May 2022 08:57:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=m06ObQ8j+UICxj+6qHPBNWTZK470Ml5yvPDeu5HqsIM=; b=bfOV
        vy6seMJ881dhVJczQe+G2C8YAh2QLtcXlLK5785XoBWlHjF4zcCkwmG1RldtXV8j
        N0zVIo/+PsOo1i0m7rCuE3IHViF6a8LA594pmSXQpzsO4SPqe8UHBP7GmUlySi1t
        NZLkT5cH4L6DSKIxGPfHjdxPauXCo/VfBZ+lAaE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B5771A49D1;
        Fri, 13 May 2022 08:57:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B94641A49CE;
        Fri, 13 May 2022 08:56:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>, vascomalmeida@sapo.pt
Subject: Re: Question about pre-merge and git merge octopus strategy
References: <CAOLTT8S8rh+VYcuaqBeNtmphiRqw7HropLFpkxfnTJq6BngGXw@mail.gmail.com>
        <CAP8UFD2p+Evqv_MBAgv23zooppsNWjOw6ZU2GLqAq_skZoJPOw@mail.gmail.com>
        <CABPp-BGD3AZvXwmSHfQQ_xh_UqevH23kdBYijAWUk8GHu1q0Qw@mail.gmail.com>
        <CAOLTT8STRfqq4bfobCK8Q5uvtXzgNYY0x0wNh4HNyAhv0Mc07A@mail.gmail.com>
        <CABPp-BEFYjTvK4ZNSg+yiahRAzXW=KU11a-b+QRdcBDGb-movQ@mail.gmail.com>
        <CAOLTT8R7QmpvaFPTRs3xTpxr7eiuxF-ZWtvUUSC0-JOo9Y+SqA@mail.gmail.com>
        <CABPp-BHmNBMypVDrE=gPMXoHT9uH-u4HJG1dAuY0tjSGrK0yPg@mail.gmail.com>
        <xmqqk0aqhia1.fsf@gitster.g>
        <CABPp-BGOGLUPOn20yWzCrBYCykiet0=5UfbkuGC78f-QoWVvYg@mail.gmail.com>
Date:   Fri, 13 May 2022 05:56:58 -0700
Message-ID: <xmqq35hdd205.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D530E12-D2BC-11EC-806A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> If merge-recursive or merge-resolve is asked to merge a single
>> commit to the current branch without any other strategies to use as
>> a fallback, they leave the working tree and index into a state where
>> the end-user can conclude the conflict resolution and commit the
>> result.  In spirit, we are in the same situation, aren't we?
>
> I don't think it's quite the same....
> ...
> Or are you saying that if all merge strategies return a 2, we just
> treat the last one as good enough and consider the merge to be in
> progress?

No, I was just confusing the difference between the special return
value 2 and a normal failure value 1.

I have a feeling that it would be nice if we can restore to pristine
on the calling "git merge" side, rather than forcing individual
strategy backends to implement the restore-to-pristine correctly,
but in any case, as you said, we should behave as if a merge
strategy backend never run after it failed with exit value 2 by
restoring to pristine state.
