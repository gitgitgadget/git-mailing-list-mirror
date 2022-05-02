Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1500EC433EF
	for <git@archiver.kernel.org>; Mon,  2 May 2022 06:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbiEBGZi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 02:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiEBGZg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 02:25:36 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52C52723
        for <git@vger.kernel.org>; Sun,  1 May 2022 23:22:07 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7271318D90C;
        Mon,  2 May 2022 02:22:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fuiXDF7ZSynxgbFqT3BoljAG0ihjkoy9JTPek8
        pmmzI=; b=VG22ZL2t3uKeJDnqct4f/vyISJ7QDr/ckFYFZNoJwD35GPOXM/c9aT
        RTkLg4zEbfLsW97UtCg9LMDsylJ2jcktLRJyEGSHhDSzu4pmh4/UbpMA3XWcZTHp
        6Dj2MjeYhly4BMp2Z2dAerXsr3SCk6HSXz1U37MTnTi3BI/wL7iDI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B84118D90B;
        Mon,  2 May 2022 02:22:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C088C18D907;
        Mon,  2 May 2022 02:22:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Chris Down <chris@chrisdown.name>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] bisect--helper: warn if we are assuming an unlikely
 pathspec
References: <Ym59GmfWpCSV9Bqr@chrisdown.name>
        <48cd2ce4-feac-b028-daad-2df6aa71e363@gmail.com>
Date:   Sun, 01 May 2022 23:22:01 -0700
In-Reply-To: <48cd2ce4-feac-b028-daad-2df6aa71e363@gmail.com> (Bagas Sanjaya's
        message of "Mon, 2 May 2022 12:50:57 +0700")
Message-ID: <xmqqv8uo1mk6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E495072-C9E0-11EC-A913-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 5/1/22 19:29, Chris Down wrote:
>> In order to avoid this, emit a warning when we are assuming an argument
>> is a pathspec, but no such path exists in the checkout and this doesn't
>> look like a pathspec according to looks_like_pathspec:
>> 
>>     $ git bisect start d93ff48803f0 v6.3
>>     warning: assuming 'v6.3' is a path
>>     $
>> 
>
> For completeness, we can say 'If this is incorrect, abort the current
> bisection with "git bisect reset" and rerun with correct commit-ish.'.

We certainly can, but I am not sure how much it helps.

Even though I understand that the original end-user confusion
happened to come from taking what the user thought was a revision as
pathspec, I think it is a mistake to build the "warning" UI around
it.

Stepping back a bit, there are "git bisect" invocations that compute
and check out the commit to be tested, and there are "git bisect"
invocations that only advance the internal state a bit but not yet
become ready to offer the first commit to be tested.  The problem in
the current UI is that we are fairly chatty once we start bisecting,
but until we receive enough information to start bisecting, we are
fairly silent.

Even if the user did not use the lazy short-hand form of "bisect
start" with bad and good commits at all, after saying "git bisect
good <X>" (read: it is a state that made a bit of progress but still
not ready, because the command wants to see at least one bad commit,
too), wouldn't it be nice if the user is told what state the command
is in?  Perhaps we can give some feedback _before_ we are ready to
compute bisection?

A model dialogue may go like this.

    $ git bisect start -- bin/
    info: bisect waiting for good and bad commits.
    $ git bisect good master
    info: bisect waiting for a bad commit, one good commit known.
    $ git bisect good maint
    info: bisect waiting for a bad commit, two good commits known.
    $ git bisect bad next
    Bisecting: ...

Then the exchange for the lazy short-hand form of "bisect start"
would fall out quite naturally.

    $ git bisect start d93ff48803f0 -- v6.3
    info: bisect waiting for a good commit, one bad commit known.

For a bonus point, we may want to also say something on these
"info:" lines that we were given a pathspec.

It would also be a good idea to add a new subcommand "git bisect status"
to recompute the state (i.e. what it is waiting for and what it
already knows) when the user forgets, which can happen quite often.

With such a bonus feature, the exchange might go like this:

    $ git bisect start seen
    info: bisect waiting for a good commit, a bad commit known.
    $ git reset --hard maint ;# choose an older point, hoping it is good.
    $ make test
    ... pages of output scrolls the "info:" out of window ...
    $ git bisect status
    info: bisect waiting for a good commit, a bad commit known.
    $ git bisect bad maint
    info: bisect waiting for a good commit, a bad commit known.
    $ git reset --hard v1.0 ;# an even older point, hoping it is good.
    $ make test
    ... again pages of output ...
    $ git bisect good v1.0
    Bisecting ...

Hmm?
