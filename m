Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726C4C433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 19:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiFXTrL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 15:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiFXTrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 15:47:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19DD8268B
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 12:47:07 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3466314C34A;
        Fri, 24 Jun 2022 15:47:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bJXVv1Br7JQg
        twrDU7XumSm9LQId7Gmo5NKVQpLaAbU=; b=WyhgQyLtW4V6rEMeWqdQI3pRrpVD
        DrKUCXh3hOKiGW/Cx4cvFfRb/PSKdiJZwv6jIPrrjufytDKXqbOvO4dxhk3iCnt+
        6zpJhrTD6wp6OxyvEZQ+wGH/wNG37wtCb1GVqDRLJPTTvFiaNJsBYrZ8/OEpjrSK
        gSQWWd0/aP7cUsQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1518214C349;
        Fri, 24 Jun 2022 15:47:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7DA7914C347;
        Fri, 24 Jun 2022 15:47:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Erik Cervin Edin <erik@cervined.in>,
        Tim Chase <git@tim.thechases.com>, git@vger.kernel.org,
        Daryl Van Den Brink <daryl.vandenbrink@maptek.com.au>
Subject: Re: stashing only unstaged changes?
References: <20220621142618.239b02cd@bigbox.attlocal.net>
        <220624.86tu8ai4mr.gmgdl@evledraar.gmail.com>
        <CA+JQ7M8gaEWHHdx2or2kQfYpp=XBxQS=pXtEOS4x5SBdpPWdkQ@mail.gmail.com>
        <220624.86czeyhy8x.gmgdl@evledraar.gmail.com>
Date:   Fri, 24 Jun 2022 12:47:01 -0700
In-Reply-To: <220624.86czeyhy8x.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 24 Jun 2022 17:32:23 +0200")
Message-ID: <xmqqk095vo7e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6B102CCA-F3F6-11EC-BCB0-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> No, it does work when you stage chunks in the same file, I tested this
> by modifying the top & bottom of our README.md.

This is primarily because of the three-way merge magic.  If you
consider what "git stash pop" does after "git stash push -k"
followed by a "git commit", you can compare the difference between
recorded HEAD and recorded working tree (which is replayed on top of
the result of the "git commit" step) and what is in the working tree
after "git commit".  We do replay both the changes already committed
(and is already in the working tree) and leftover ones (removed from
the working tree when "push -k" was run), and the former is *often*
resolved cleanly as "both sides (meaning: the "stash" and the human
user who did "git commit") made the same change", while the latter
is resolved cleanly because only the "stash" side.

Here, *often* is a key phrase.  If you did a tricky "add -p" that
edited the patch, such a three-way merge may not resolve itself
cleanly.

In addition, if you did something after the "git commit", the former
may get conflicts because what the "working tree" side did may not
match what was in "stash", hence "both sides made the same change"
no longer applies.

The story is very similar when the testing after "git stash push -k"
turned out to be unsuccessful and the user decides not to commit.
"git reset --hard HEAD && git stash pop" is how you would go back to
the state before "git stash push -k" in such a case, but if you edit
between these two operations, you can make "both sides did the same
change" rule not to apply any more.
