Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5018C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 18:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbiFBSaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 14:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbiFBSao (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 14:30:44 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8221C2D7C
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 11:30:42 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA443123E60;
        Thu,  2 Jun 2022 14:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lJx9Sj2Gkb/5PGQJfv4hs2F5XUUbYntv2D27my
        mA9cU=; b=p0tKgEUJGd4rUorPVCSF+LasL1vczdqzkiFlPHNArt2qpRatKMXXx1
        gUTw4vk3Dk/ZEvbpCLSLTsU4yD71XFAdoru1+i2kh1nsh46D13yYogatbfONs6Fv
        iNfNXrIotFiWWf+Um9VnaUUiBugsJz/5tRuqOVACwGSmTwl8xDxp8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D32BD123E5E;
        Thu,  2 Jun 2022 14:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 43BD0123E5D;
        Thu,  2 Jun 2022 14:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Subject: Re: Introduce "git stash --continue" and "git stash --abort"?
References: <CAPMMpohvKSgcL=X=Z=Wf7zHRr_Ghex5oZ4iUTgZL7XhHSWFi8g@mail.gmail.com>
Date:   Thu, 02 Jun 2022 11:30:38 -0700
In-Reply-To: <CAPMMpohvKSgcL=X=Z=Wf7zHRr_Ghex5oZ4iUTgZL7XhHSWFi8g@mail.gmail.com>
        (Tao Klerks's message of "Thu, 2 Jun 2022 18:40:09 +0200")
Message-ID: <xmqq5ylior3l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A25DC98-E2A2-11EC-9763-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> I would expect that some sort of merge- or rebase-like "--continue or
> --abort" facility would make this much easier to understand... but of
> course I have no idea how one would go about doing that. I assume the
> closest existing pattern would be "git cherry-pick", but I imagine I'm
> missing lots of subtleties.
> ...
> Is this kind of direction one that's been considered before? Are there
> reasons why it's a bad idea?

I saw a few exchange on the intended use of "stash" on another
thread in the past days, but I think the reason why the current
set of defaults and behaviour are appropriate for "stash" is related
to it.

The intended use of "stash" is to clear the deck as quickly as
possible to deal with "emergencies", and its behaviour comes from
the need to support that use case effectively.  Untracked cruft are
often useful even when you do a "quick context switch" (aka "the
boss suddenly appears and asks you to do something different real
quick"), hence "-u" is not the default, for example.  "stash pop"
was the primary way to go back to where you were before the
interruption, and such going back is expected to be done after the
crisis is over when you can be more relaxed, and was expected to be
done _after_ you "reset --hard" and/or "git switch" out of the
crisis mode.  And the natural way to recover from "eh, I moved back
to a different commit---I wanted to go to the commit I was when I
saved the stash" was "reset --hard" that would not lose anything new
(and "stash branch" was later added to make the last one easier to
do), for another example.

Users are better off doing any large scale "I made a mess in the
working tree with mixed changes, and I want to take time to separate
them out" on separate (possibly temporary) branches, instead of
using "stash save" + "stash pop".  Any change that would make it
more cumbersome for the primary intended purpose of "quick save"
would be very much unwelcome, I would have to say.

Thanks.

