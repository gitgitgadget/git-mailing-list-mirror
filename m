Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D83CCA47B
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 17:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346990AbiFJR2P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 13:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349541AbiFJR2N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 13:28:13 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354A62A7AB5
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 10:28:09 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DA10C1A107D;
        Fri, 10 Jun 2022 13:28:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TuhJpAjI81MT
        Cl5axFCpVs2jL3AmSbEeCjgH/24gwiI=; b=UvMOf8V5YH1N+9h9t6Nw/1ppkOPU
        dtQHZLTo/2WiYIRd0AoXyyNqnJzcwx+dC1akqYy3vMDJQX5eJodGxbhXxBBvx56G
        +fcvaC5UM5hEAo1TkFI+E9x66mJ95UrUq0FylwcT5CmQ3U+RwG8InemwNpuHPuox
        YZnsooRpWuUJSOI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D247F1A107C;
        Fri, 10 Jun 2022 13:28:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 768E61A1078;
        Fri, 10 Jun 2022 13:28:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Volker =?utf-8?Q?Wei=C3=9Fmann?= <volker.weissmann@gmx.de>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git bisect outputs list of commits in the wrong order
References: <3352fbbd-d555-fc51-1eac-692fdb5e4ae0@gmx.de>
Date:   Fri, 10 Jun 2022 10:28:04 -0700
In-Reply-To: <3352fbbd-d555-fc51-1eac-692fdb5e4ae0@gmx.de> ("Volker
        =?utf-8?Q?Wei=C3=9Fmann=22's?= message of "Fri, 10 Jun 2022 18:01:21
 +0200")
Message-ID: <xmqqsfoce8d7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B0052E94-E8E2-11EC-9324-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Volker Wei=C3=9Fmann <volker.weissmann@gmx.de> writes:

> If you use `git bisect` and `git bisect skip`, you might get an output
> like this:
>
> There are only 'skip'ped commits left to test.
> The first bad commit could be any of:
> 01f793267a9af328f0f1af2cdb88301a08f007b2
> a87784e29411e8b08059fdc79629e64de3002c99
> af0df663440796a0580644493c15290405e60ecd
> 4f34b8cd48e2a814263efb319fe5dbab91215aed
> f3d91e38a45f0a2ec5affb884d536c9c4e5bb290
> 13526e1b0e1b11a2e30e44ccf35fbf92ffb61372
> abee97622db5301d593265ff6e2009777b09221e
> b63700f09a422f01d954967b84c5e662881352eb
> We cannot bisect more!
>
> While the output is correct, I don't like the fact that the commits are
> not in chronological order. Is there a reason for this? Chronological
> order makes sense and would make it easier to find the first known bad
> and the last known good commit.

Thanks for a report.

I looked at an "scripted" version in the ancient past and it seems
to have computed by iterating over

	git rev-list bisect/bad --not $good_revs

which would have given these intermediate ones roughly in the
reverse chronological order.  It could be that the behaviour
regressed when the scripted version was rewritten in C, but I dunno.

Christian (as an "area" expert for bisect), do you have any
comments?

Thanks.



