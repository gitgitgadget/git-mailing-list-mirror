Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81894C433EF
	for <git@archiver.kernel.org>; Sat,  7 May 2022 18:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351646AbiEGSlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 14:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiEGSlG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 14:41:06 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BD919C0D
        for <git@vger.kernel.org>; Sat,  7 May 2022 11:37:18 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 357EB187BB9;
        Sat,  7 May 2022 14:37:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VemsxHVAXIY2LJjm2xWCIQeYEX4EOlhYEACMr0
        FM4fI=; b=RdWfwMR11S+5b7VVHltIXD7ddXkyjKPiREd9lwRQUhXAkXsBOzA/lI
        jKrUlWLWyK0Vjdr0GXrikf1sP/+hvWDmZ2VJbdxOhEkXdU8FLecF/4AW+ZCH1Qz/
        89WyVb+D9SFkx4rfOc++jx4W4LECjFHIefCf22+vo2kf9cBesCGbU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2DE46187BB8;
        Sat,  7 May 2022 14:37:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C563F187BB5;
        Sat,  7 May 2022 14:37:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>, vascomalmeida@sapo.pt
Subject: Re: Question about pre-merge and git merge octopus strategy
References: <CAOLTT8S8rh+VYcuaqBeNtmphiRqw7HropLFpkxfnTJq6BngGXw@mail.gmail.com>
        <CAP8UFD2p+Evqv_MBAgv23zooppsNWjOw6ZU2GLqAq_skZoJPOw@mail.gmail.com>
        <CABPp-BGD3AZvXwmSHfQQ_xh_UqevH23kdBYijAWUk8GHu1q0Qw@mail.gmail.com>
Date:   Sat, 07 May 2022 11:37:13 -0700
In-Reply-To: <CABPp-BGD3AZvXwmSHfQQ_xh_UqevH23kdBYijAWUk8GHu1q0Qw@mail.gmail.com>
        (Elijah Newren's message of "Fri, 6 May 2022 21:09:45 -0700")
Message-ID: <xmqq8rrdgpeu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B729B3C0-CE34-11EC-9533-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> However, I think Junio said that octopus merge only handles trivial
> cases anyway,...

"git merge -s octopus A B C" deliberately made a design decision to
strongly discourage the users from creating an octopus that requires
non-trivial merges.  One of the reasons is because octopus merges
make the history less efficient to bisect, and they are meant as a
way to bind totally unrelated changes, whose order of merging into
the resulting history does not matter.

Yes, it is an opinionated design choice, but "git merge" is a
Porcelain that can afford to be opinionated.  It also means that
tools other than the git-merge--octopus backend does not have to
follow the design philosophy.

> ... in which case an iterated "git merge --write-tree" would
> actually be a sufficient solution here and we could sidestep the more
> convoluted cases.  But, sadly for ZheNing, that option doesn't exist
> yet -- It's still under development.
