Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62937C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 21:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A66613B5
	for <git@archiver.kernel.org>; Thu,  6 May 2021 21:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhEFVE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 17:04:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57488 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhEFVEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 17:04:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 16BBB12B7DF;
        Thu,  6 May 2021 17:03:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xGgKAOhBSQUQ
        qRB6Go5lcTShCQhwOtBj4pxTfJhjmxo=; b=qoQ/2TQGmMLs2WTzVCnHGuxdzHCF
        YbQwLwrVn5VQB86REVfL6vh/mTUU4SrPr2jO4CtvU2pOQx1rCShK0KjgPJtkh/gh
        QsGtVWjdDKn2RVg6C/3lZiq8pNH+3qwh8lTBM7FWFzuYoXVKXWGB4nMo1D8HdsXC
        kCQPXS8FUfK3PvM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0FAF712B7DE;
        Thu,  6 May 2021 17:03:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E0B5712B7DD;
        Thu,  6 May 2021 17:03:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mark Amery <markrobertamery@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Subject: Re: Bug: Changing folder case with `git mv` crashes on
 case-insensitive file system
References: <CAD8jeghpOQoibk0xM0QgLsOwLNw9GdM=4rhYuzV-NSkw8LinMQ@mail.gmail.com>
        <20210504151954.aczbvml4rh7t2svc@tb-raspi4>
        <xmqqtuni58ra.fsf@gitster.g>
        <20210506043429.zqgzxjrj643avrns@tb-raspi4>
        <CAD8jeghZKDcp=weHtcMZ4z8KaO1jQJqfPqaRtYgtiwrX-1+NNg@mail.gmail.com>
Date:   Fri, 07 May 2021 06:03:21 +0900
In-Reply-To: <CAD8jeghZKDcp=weHtcMZ4z8KaO1jQJqfPqaRtYgtiwrX-1+NNg@mail.gmail.com>
        (Mark Amery's message of "Thu, 6 May 2021 10:12:40 +0100")
Message-ID: <xmqqlf8ry3qe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7E2CEB9C-AEAE-11EB-A5A7-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark Amery <markrobertamery@gmail.com> writes:

>   That is: first check the inode or file ID of the src and dst passed
> to `git mv`. If they are different and the second one is a folder,
> move src inside the existing folder. If either they are the same or
> the second one is not a folder, then do a rename.
>
>   It seems to me that this approach automatically handles stuff like
> `git mv b=C3=A4r.txt b=C3=84r.txt` plus any other rules about names bei=
ng equal
> (like two different sequences of code points that both express "=C3=A0"=
),
> all without Git ever needing to explicitly check whether two names are
> case-insensitively equal. Am I missing something?
>
> Sorry if any of the above is dumb or if I'm reiterating things others
> have already said without realising it.

There is nothing dumb about the idea.  I think that is essentially
what brian and I outlined in the earlier exchange, except that we
need to use something other than inum on Windows to decide if two
pathnames refer to the same filesystem entity, and the approach we
suggested was to use the inum-based check _after_ seeing the current
code fail with EINVAL in the error codepath, instead of doing so
upfront.

Thanks.

