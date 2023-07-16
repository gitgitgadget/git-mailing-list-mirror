Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CA5C001B0
	for <git@archiver.kernel.org>; Sun, 16 Jul 2023 01:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjGPBPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jul 2023 21:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGPBPn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2023 21:15:43 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8061E271E
        for <git@vger.kernel.org>; Sat, 15 Jul 2023 18:15:42 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 330D921419;
        Sat, 15 Jul 2023 21:15:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dHIHXH51Y5DlHC2qOTdtTDG1mt0WF6JRPHRZrg
        ywMCI=; b=ig/5wJNfcm/lsablxJ+viw3EoFs5I9kBTo+3eyTwnEcatjxaOl5zRo
        bJHU9RKT52T/I77thXTbyTO1C8VcmrB44Mp0bgFrSRTbxQnnAdINOw58sQ0lnHsV
        5x8e8XQocdF9b5PJvAWAysP+D0GXHHbYq37VfmgkWTbE7g9rFQCmc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D9AB21418;
        Sat, 15 Jul 2023 21:15:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9EFEC21417;
        Sat, 15 Jul 2023 21:15:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Yuri <yuri@rawbw.com>, Git Mailing List <git@vger.kernel.org>
Subject: Re: Pressing Ctrl-C during 'git checkout <branch-name>' messes up
 the repository
References: <fe3c68d5-124e-5a87-881a-21ad8e492f76@tsoft.com>
        <ZLM4sTUjBQt4QMfG@tapette.crustytoothpaste.net>
Date:   Sat, 15 Jul 2023 18:15:37 -0700
In-Reply-To: <ZLM4sTUjBQt4QMfG@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 16 Jul 2023 00:24:17 +0000")
Message-ID: <xmqqedl8lkqu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 463E4066-2376-11EE-B214-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> When the user presses Ctrl-C, the correct action would be to cleanly return
>> to the initial branch.
>
> I would disagree here.  When the user has hit Ctrl-C, they want to
> interrupt the operation.  That's literally why a SIGINT (interrupt)
> signal is sent.  A checkout can take a long time, and the user will not
> want Git to perform an operation which will take even longer than the
> original one (because the original checkout was aborted).
>
> Even if we did that, the user could just hit Ctrl-C again and really
> interrupt the process, and then they'd be stuck again.
>
> If you don't want to interrupt the operation, then don't hit Ctrl-C.

I agree with all of the above, but stopping with "don't" is not very
helpful---people do do things that they are told not to anyway, and
it makes a whole lot of difference if they know how to recover from
the fallout of their actions.  It would help to teach "reset --hard"
or something that lets the user to return to a known state.  It may
not necessarily be the state the user would want to go, but it is
still better to be in a known stable state and be able to complain
"I lost my stashed changes" or "I lost a few commits" than to be in
a state where the user is totally lost and do not know what to do
next.

Of course, that kind of coaching is not something we should do in
our error or advise messages, but in an early part of the tutorial
or somewhere, perhaps?

Thanks.
