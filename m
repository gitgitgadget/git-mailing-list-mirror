Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A0DC47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 21:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A926561401
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 21:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhFCVz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 17:55:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60522 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhFCVz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 17:55:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E7A43D172F;
        Thu,  3 Jun 2021 17:54:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f7yUXwba/gp8/v5n+jLAyCu/kLDPRTo+c+oksE
        SC2iY=; b=ySwSuYoD+Gs+aoi2bMreCDx35MSsDWzPBd88+W3I4pIVwmAPo6GWpl
        myvJVQYcF0LcN8nc7As8tdnHaGBc+SzYAcAXVBavy49A5NfgrwmLp101dTkHzyNA
        1jhwUe2+vnhlnz7zk81QCLQ/UcrK1ObsQmicWZZ0632egeyWYojiM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF9EFD172E;
        Thu,  3 Jun 2021 17:54:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5CE2BD172D;
        Thu,  3 Jun 2021 17:54:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Ilias Apostolou <ilias.apostolou.zero@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Request feature: =?utf-8?Q?=E2=80=93no-submodule?=
References: <c5709df6-c357-56b4-f0e0-673bc8b4e668@gmail.com>
        <YLfqiLbpPXWXHlBi@nand.local> <xmqq8s3r7oma.fsf@gitster.g>
        <YLg/dLqYFEqHZJUn@nand.local> <xmqq7dja6e46.fsf@gitster.g>
        <YLkr+kLdjmHyPjgl@coredump.intra.peff.net>
Date:   Fri, 04 Jun 2021 06:54:10 +0900
In-Reply-To: <YLkr+kLdjmHyPjgl@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 3 Jun 2021 15:22:34 -0400")
Message-ID: <xmqqo8cm4nst.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AC4D68A-C4B6-11EB-857A-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It doesn't seem outrageous to me for Git to automatically populate
> "pseudo-attributes" that connect properties of paths to the attribute
> system.

Sounds sensible.  The attribute assignment was designed to purely
depend on paths and not contents, so it might be a bit awkwarad to
implement, but it should be doable.

> An alternative view is allowing a pathspec that asks about the mode:
>
>   git ls-files ':(mode=160000)'
>
> That also lets you ask about other things, like:
>
>   git ls-files ':(mode=100755)'
>
> but it is probably unnecessarily arcane (even I had to look up the
> correct mode for a gitlink just now :) ).

The original request, as I understand the clarification posted
upthread, is not "submodules are uninteresting", but is "we want
regular files" (and we postprocess further the output), so such a
"mode" (pseudo-)attribute that is automatically populated would be a
better fit anyway.  With the current system, they can already do:

    git ls-files -s ':(exclude)*.png' ':(exclude)*.ico)' |
    sed -n -e 's/^100[76][54][54] [0-9a-f]* 0       //p' |
    xargs dos2unix

(cf. <9cc98ca3-bdc5-61bf-450a-99bb47673d6c@gmail.com>)

and with such an auto-pseudo-attribute, presumably something along
this line would work, removing the need for the intermediate filter:

    git ls-files \
	':(attr:mode=100755)' ':(attr:mode=100644)' \
	':(exclude)*.png' ':(exclude)*.ico' |
    xargs dos2unix

