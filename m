Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63B381F454
	for <e@80x24.org>; Sat,  2 Nov 2019 09:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfKBJSv (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 05:18:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58183 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfKBJSv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 05:18:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 68A18813E6;
        Sat,  2 Nov 2019 05:18:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WzaT4TLHKgzieJin1q+yoH1LBl8=; b=aREDvQ
        5DXtz+sk7VgxpSMkjvC5caTS4BfpDfJVa/dkGl7CD185+RsFM/t6kDaRAaxyONZF
        JgcVpH0NrvXMUAoiyvokfMm+MPZH+fno1qsEa3VjnOlck0QvFHkuuGkHFqYEb5MU
        AKWorv00W5Jk2t89C1jHsgz1K9ED+e7pBmdzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HWpEZ0L0RbI92Z2ogej+B3ml0HHNsb4Y
        g/rs/GzhZ2DA0ghcwy38XW+zb1NZKgYNUouJIaYKhKoXT9EeL7HKpHjP/v2TAcBw
        in09kOjLPAu4KxWamfJx9k3tU3kBpjSCM78STDDanVs2nu08Xltbur4EJKUEktfw
        q0eBU9b0aYU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 62135813E5;
        Sat,  2 Nov 2019 05:18:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8C118813E2;
        Sat,  2 Nov 2019 05:18:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Davide Berardi <berardi.dav@gmail.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH] Segmentation Fault on non-commit --branch clone
References: <20191101002432.GA49846@carpenter.lan>
        <nycvar.QRO.7.76.6.1911012000160.46@tvgsbejvaqbjf.bet>
Date:   Sat, 02 Nov 2019 18:18:44 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1911012000160.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 1 Nov 2019 20:08:10 +0100 (CET)")
Message-ID: <xmqqtv7m1vrf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5E62EAE-FD51-11E9-A60B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Davide,
>
> I wonder whether you might want to reword the Subject: such that it
> reflects what the patch does instead of what the problem is that
> motivated you to work on the patch (the patch does not cause the
> segmentation fault, after all, but it fixes it).

Good point.

    Subject: clone: do not segfault on "clone -b B" where B is a non-commit

    The code in "git clone -b B" to decide what branch to check out
    assumed that B points at a commit object without checking,
    leading to dereferencing a NULL pointer and causing a segfault.

    Just aborting the operation when it happens is not a very
    attractive option because we would be left with a directory
    without .git/HEAD that cannot be used as a valid repository the
    user can attempt to recover from the situation by checking out
    something.

    Fall back to use the 'master' branch, which is what we use when
    the command without the "-b" option cannot figure out what
    branch the remote side points with its HEAD.

or something like that, perhaps?

I am not sure if the existing code is careful enough setting up the
resulting local 'master' branch, or needs more changes associated
with this patch, though.  For example, does it want to be set to
integrate with the 'master' branch on the remote side by setting
"branch.master.remote" and "branch.master.merge" configuration, or
do we want to turn them off?  I _think_ the answer is that we want
to behave as if the user said "-b master" instead of "-b B" (with B
that does not point at a commit), but I am not sure.  Also, don't we
try to be a bit noisier when the fallback fails?  For example, if
the user said "clone -b master" and the 'master' points at an object
that is not a commit, falling back and writing refs/heads/master in
the HEAD would leave us in the same position as we did not have any
fallback.

I skimmed your review and I think I agree with most (if not all) of
them.  Thanks.
