Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0FBC11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC1661429
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhF2BZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:25:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63632 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhF2BZI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:25:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 882F21327A2;
        Mon, 28 Jun 2021 21:22:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=7qJGimZxyCjl1PI3JhtV+5jaV9MSjxGlPPNhoaBOrmA=; b=ujBd
        xslQpV65uDOD05+1dBwIJf4N4mMKpxtRYXedQm213MEergdjFhncTkUwcVhMAbZQ
        ge0TquvO7ZeKXVl0fHM3H5ZBGGe3Va9AApTBHqFCFGOxGu9+ym+Dz/xWWud3ExWJ
        45BQ6rcHTKJZB7+bbvLg3uJcHEbFsqswZAfCwyA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 814771327A0;
        Mon, 28 Jun 2021 21:22:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B139E13279F;
        Mon, 28 Jun 2021 21:22:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Roland Hieber <rhi@pengutronix.de>, git@vger.kernel.org,
        Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH] bisect: allow to run from subdirectories
References: <20210620213836.10771-1-rhi@pengutronix.de>
        <xmqqy2b3j317.fsf@gitster.g>
        <YNPGb5gvygs++jlv@coredump.intra.peff.net>
Date:   Mon, 28 Jun 2021 18:22:37 -0700
Message-ID: <xmqqtulh31nm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7EA605BA-D878-11EB-8B05-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> This does not depend on "do we have T as a directory?" being the
>> bisection criteria.  The important thing is that the current
>> directory would appear and disappear as the bisection process makes
>> you jump around in the history.
>
> I think that is a good explanation. But I remain somewhat unconvinced
> that it is that big a problem in practice.

It's just the difference in attitude, I would think.  Things like
"rebase" take a more liberal attitude and most of the time things
work out OK because removal of a directory is a rare event and
replacement of a directory with a non-directory is even rarer, but
when things break there is no provision to help users to know how it
broke by diagnosing why the revision cannot be checked out, or why
the directory D the user's shell session is sitting in is now
orphaned and different from the directory D the user thinks he is in
because it was removed (while the user's process is in there) and
then recreated under the same name, or any of the tricky things.

The ideal endgame would be to allow operating from subdirectory
*AND* have provisions for helping users when things go wrong because
the starting subdirectory goes away.  "bisect" works under the more
conservative philosophy (start strict and forbid operation that we
know we didn't spend any effort to avoid taking the user into
dangerous waters---we can allow it later once we make it safer but
not until then).

It would involve a bit of chicken-and-egg, I would guess.  If we
think improving Git is more important than avoiding even occasional
failures imposed on end-users, then the more liberal approach would
be easier to work with---we can allow the command to start from
subdirectory even if we do not do anything to help avoid problems,
let the users hit a snag and have them report it, which would give
us some concrete failure mode to work on.



