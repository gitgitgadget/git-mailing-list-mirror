Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5660C433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 22:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349926AbiARW0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 17:26:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63494 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349010AbiARW0w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 17:26:52 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38F1511AE0C;
        Tue, 18 Jan 2022 17:26:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2h3cuvpCeRKP
        GVU/MOKWKsIGED0nR2zVMnLZ7NFLhUw=; b=cV+xUHE+8PywNAUNK1G0AufBuOYf
        XBAlbN9L8iNMyYlEEXh6BxzV7SGAVBfOZQk+BCO0uZ35LPeBXBziguItsRnpeAXV
        /JIgkRnIKJkTLMoyVsD2C95KptYdDf+QMgfhQmfTTHo/+xe1IxuwNz6Ibc5DNXMe
        JYaquzrDuPz5dUY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 314A211AE0B;
        Tue, 18 Jan 2022 17:26:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 948A311AE0A;
        Tue, 18 Jan 2022 17:26:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] branch,checkout: fix --track usage strings
References: <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
        <3de40324bea6a1dd9bca2654721471e3809e87d8.1642538935.git.steadmon@google.com>
Date:   Tue, 18 Jan 2022 14:26:49 -0800
In-Reply-To: <3de40324bea6a1dd9bca2654721471e3809e87d8.1642538935.git.steadmon@google.com>
        (Josh Steadmon's message of "Tue, 18 Jan 2022 12:49:46 -0800")
Message-ID: <xmqqh7a0r87q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BB278B3C-78AD-11EC-A393-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> As =C3=86var pointed out in [1], the use of PARSE_OPT_LITERAL_ARGHELP w=
ith a
> list of allowed parameters is not recommended. Both git-branch and
> git-checkout were changed in d311566 (branch: add flags and config to
> inherit tracking, 2021-12-20) to use this discouraged combination for
> their --track flags.

(tl;dr) I'll take this as-is and hopefully I can fast-track it in
time before tagging -rc2 tomorrow.

Having said that, here is what parse-options.h describes this flag
bit:

 *   PARSE_OPT_LITERAL_ARGHELP: says that argh shouldn't be enclosed in b=
rackets
 *				(i.e. '<argh>') in the help message.
 *				Useful for options with multiple parameters.

Notice that this bit actually is meant "for options with multiple
parameters"?  The recommendation given to you might not be showing
the right way.

Looking at "git grep -C2 OPT_LITERAL_ARGHELP \*.c" output, I suspect
that a better solution may be to enclose "direct|inherit" in a pair
of parentheses, i.e. "(direct|inherit)".  That mimics the way how
"git am --show-current-patch[=3D(diff|raw)]" does it.

Then we would show

	--track[=3D(direct|inherit)]

instead of

	--track[=3D<mode>]

which means that ...

> Fix this by removing PARSE_OPT_LITERAL_ARGHELP, and changing the arghel=
p
> to simply be "mode". Users may discover allowed values in the manual
> pages.

... users won't have to visit the manual page only to find out what
modes we support.

In any case, the lesson should not be lost in the list archive.  To
help future developers from the same trouble, we should leave a note
to revisit the above description of the flag bit in parse-options.h
later, possibly after the 2.35 final, to see if we can improve it
(both the description and/or the behaviour of the code when it sees
the flag bit).

Thanks.
