Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2DCC433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 23:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJVXRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 19:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJVXRO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 19:17:14 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A412978223
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 16:17:13 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1D9616344A;
        Sat, 22 Oct 2022 19:17:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ICfimwybhDYDaaN1sBG6QMjSeiY97F4L9nYwzL
        jZcmM=; b=G9FwXXMsXPixbxPt6oWl86MBkACoQPnmRQ0h63+u+vj5xCeHXZq0ut
        f4ooYHIHBKIQlDKo20a0j9fjPK4aDzrkqTi46ACc4f6pC4MlQVfOwXsb1KNQQuw2
        54uqT2jToLSGAFyOOcro83LDjcdmIQ/iOlvMGNJGoXTjoDKMHfyls=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA87F163449;
        Sat, 22 Oct 2022 19:17:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 25BE1163448;
        Sat, 22 Oct 2022 19:17:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael McClimon <michael@mcclimon.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] setup: allow Git.pm to do unsafe repo checking
References: <20221016212236.12453-1-michael@mcclimon.org>
        <20221022011931.43992-1-michael@mcclimon.org>
        <20221022011931.43992-3-michael@mcclimon.org>
        <xmqq1qr0ifya.fsf@gitster.g>
        <Y1ReKB701QXRv64A@coredump.intra.peff.net>
Date:   Sat, 22 Oct 2022 16:17:11 -0700
In-Reply-To: <Y1ReKB701QXRv64A@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 22 Oct 2022 17:18:32 -0400")
Message-ID: <xmqqy1t7fnyg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A88FBE22-525F-11ED-B172-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think it has to in order to avoid surprises. If I do this:
>
>   perl -MGit -e '
>     my $r = Git->repository;
>     chdir("/somewhere/else");
>     $r->git_command(...);
>   '
>
> that command ought to run in the repository I opened earlier. So I think
> to keep the illusion of a lib-ified object, creating that object has to
> lock in the path.
>
> But it really seems like we should be asking rev-parse what that path
> is, not trying to do any magic ourselves.

Yeah, whichever caller doing the chdir() needs to take the
responsibility of adjusting the future use of git, e.g. going back
to the original before spawning git or whatever.

Or having the original Git->repository call bail out by having "git"
figure out where it is, while honoring safe.directory or any future
protection underlying "git" offers.

Thanks.

