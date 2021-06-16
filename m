Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B9DC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 03:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9AF61246
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 03:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFPDMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 23:12:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62495 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhFPDMh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 23:12:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EBBA81442EA;
        Tue, 15 Jun 2021 23:10:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YBugDNltnqTUVwaLirXUWx+LESZT8AO6SuklFW
        Q14EQ=; b=xRges7cKxY35lXMKK8jEA2IpSwRGeckbz4oktV9vHFsI+ICU5TocuB
        yf82A+0rHMTec9c4K/BCN4gXX59VSAUzWp5nfic1WnWOdjROdNAxgxDJ8ge0zX9P
        P9KrDvAdJjrEZGrCa0gJ4O6dOUgCfFmU5BvBTKuC0WK+Qx7b0/QjQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D602C1442E9;
        Tue, 15 Jun 2021 23:10:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4153B1442E8;
        Tue, 15 Jun 2021 23:10:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Rose Kunkel <rose@rosekunkel.me>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [BUG] `git reset --hard` fails with `update = none` submodules
References: <CAKjYmsELpf9r3bAJj_JUHgVegw_7z2KzyuR_6FYYngpC1XmNeg@mail.gmail.com>
        <YMlLGwScowX8eXeJ@camp.crustytoothpaste.net>
        <CAKjYmsHD2MuTE+drebKichz_0wquPN8ZTLbiPkUCZJyLsSFh8Q@mail.gmail.com>
        <CAKjYmsEHWShuKEOFWnCyU1x5rM7kFrcaN78D7KhhUay8kCvA2g@mail.gmail.com>
        <YMlS+1F9IND7vxNI@camp.crustytoothpaste.net>
Date:   Wed, 16 Jun 2021 12:10:27 +0900
In-Reply-To: <YMlS+1F9IND7vxNI@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Wed, 16 Jun 2021 01:25:15 +0000")
Message-ID: <xmqqeed2sdwc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 676CDAA4-CE50-11EB-8192-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2021-06-16 at 01:03:40, Rose Kunkel wrote:
>> Potentially relevant: `git config --global --list` shows
>> ```
>> status.showstash=true
>> status.submodulesummary=true
>> submodule.recurse=true
>
> Thanks for this additional information.  This line is the critical
> piece.  Now I get this:
>
>   $ git reset --hard
>   fatal: not a git repository: ../../.git/modules/repos/agda
>   fatal: could not reset submodule index
>
> Predictably, "git -c submodules.recurse=true reset --hard" also results
> in the same thing.
>
> The --recurse-submodules option for git reset says this (emphasis mine):
>
>   When the working tree is updated, using --recurse-submodules will also
>   recursively reset the working tree of all *active* submodules
>   according to the commit recorded in the superproject, also setting the
>   submodules' HEAD to be detached at that commit.
>
> On my system, .git/config has this:
>
>   [submodule]
>           active = .
>
> So these submodules are active, but they probably should not be, since
> we haven't checked anything out (or, for that matter, cloned any data)
> and it wouldn't make sense to try to operate on them automatically with
> submodules.recurse or --recurse-submodules.
>
> My gut tells me that we should probably mark submodules with update=none
> set on a clone as inactive.  Of course, this is a tricky area that I'm
> not super familiar with, so opinions or thoughts are welcome.
>
> If folks think this is a good way forward, I'll look into writing a
> patch, probably tomorrow evening since it's starting to get late here.

Cc'ing some folks who recently mumbled the word "submodule" in their
recent topics for input.

Thanks.
