Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9111DC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 16:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbiGMQCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 12:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbiGMQCC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 12:02:02 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2D12C64B
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 09:01:59 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 84C461AE50C;
        Wed, 13 Jul 2022 12:01:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=u5LXwN693sSL
        0N45j9qo7Fqi7KzyGsBmQXUa8lyhIw0=; b=sKRVll+40Cpjwj2bDwQCBp4gIS4p
        bRMvmkB3j8yBN1+YQBvQsZYBD1Z0R/F3rFJoRp6lmLZoamAAVdH+HzXqsMBAo/qF
        7DCgSN7yQ7FAnl5kauL3ppNaWlLodAJQbNxjtyyBzX+wCj9sdil7JveHLm0EVfHH
        dRLZUnFSeosiZlc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D2BA1AE50B;
        Wed, 13 Jul 2022 12:01:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2C3E81AE50A;
        Wed, 13 Jul 2022 12:01:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: js/bisect-in-c, was Re: What's cooking in git.git (Jul 2022,
 #03; Mon, 11)
References: <xmqqo7xufee7.fsf@gitster.g>
        <s3726r9p-r96o-7793-0qrq-o54rs4npr972@tzk.qr>
        <220713.865yk1456z.gmgdl@evledraar.gmail.com>
Date:   Wed, 13 Jul 2022 09:01:52 -0700
In-Reply-To: <220713.865yk1456z.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 13 Jul 2022 13:18:39 +0200")
Message-ID: <xmqqtu7ldmrz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1D5061DE-02C5-11ED-A1CC-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I'm not claiming that we always use 129 when we're fed bad options etc.=
,
> but rather that that's what parse_options() does, so at this point most
> commands do that consistently.
> =09
> 	./git --blah >/dev/null 2>&1; echo $?
> 	129
> 	./git status --blah >/dev/null 2>&1; echo $?
> 	129
>
> But yes, you can find exceptions still, e.g. try that with "git log" an=
d
> it'll return 128.

Yup, that was my understanding as well.  We may have existing
breakage that we shouldn't be actively imitating when we do not have
to.

> Which, I'm not saying should hold this series up, but just that having
> reviewed it for a few iterations I'm not comfortable saying we haven't
> missed something else, and given the nature of the past whack-a-mole
> fixes it looks like you haven't really looked it either.

"We haven't missed" is not something we can comfortably say, ever,
aobut a series with any meaningful size.  I am not so worried about
it, if it is your only worries.  Would it make it less likely to
have introduced unintended bugs if we find a way to keep using
parse-options?

> I'm referring to e.g. the thread ending at [3], where I pointed out tha=
t
> "git <subcommand> -h" was broken, you apparently tested one of the
> subcommands and concluded it wasn't broken, but clearly not all of them=
.
>
> Which, I'd be less concerned about if as pointed out in [1] we don't
> have entirte bisect sub-commands that don't have any test coverage at
> all, so whatever coverage we have probably has major gaps.
>
> 1. https://lore.kernel.org/git/220627.86mtdxhnwk.gmgdl@evledraar.gmail.=
com/
> 2. https://lore.kernel.org/git/220523.865ylwzgji.gmgdl@evledraar.gmail.=
com/
> 3. https://lore.kernel.org/git/220225.86ilt27uln.gmgdl@evledraar.gmail.=
com/
