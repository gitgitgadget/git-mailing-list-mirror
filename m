Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9376CC77B7F
	for <git@archiver.kernel.org>; Wed, 17 May 2023 16:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjEQQB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 12:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjEQQBI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 12:01:08 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947BFD2C3
        for <git@vger.kernel.org>; Wed, 17 May 2023 09:00:38 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0BEA3204B6D;
        Wed, 17 May 2023 12:00:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t0gxOXe+bOtsB8Q2iZeHdBRG0xUoSrSxGif66c
        kT8g0=; b=pNN2W3bWrcjlPQaH3nC9GBCuu81yAHmaqA8NCauAYosqDkeTRX7ZEN
        Sq6ZIioXHTuXb102OWonet/tXTBHup5y9qO2HMcFgGlq9RUxuY63BojQojGU/aSS
        KDeOgSb95jKX5NoWAghBOzuo32FohGvVJpKQhQ4IsKViEBOsRUTO0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 046DA204B6C;
        Wed, 17 May 2023 12:00:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ACD1D204B6B;
        Wed, 17 May 2023 12:00:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] tag: keep the message file in case ref transaction
 fails
References: <cover.1684067644.git.code@khaugsbakk.name>
        <20230517093214.GA527234@coredump.intra.peff.net>
Date:   Wed, 17 May 2023 09:00:10 -0700
In-Reply-To: <20230517093214.GA527234@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 17 May 2023 05:32:14 -0400")
Message-ID: <xmqqo7mjq779.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7775212-F4CB-11ED-94C9-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That said, I'm willing to believe that most users wouldn't figure this
> out on their own, and saving TAG_EDITMSG might be more friendly. But one
> other alternative might be to mention the hash of that tag object, and
> possibly give advice on recovering it.

Hmph, then the advice message would suggest "update-ref"?

Ah, no.  Because the message may be reused to create a tag with
different tagname, which is very likely because one reason for the
refusal to update the ref could be that the name was already taken,
and that would create a mismatch between tagname and refname.

OK, so ...

> It's too bad we do not have "git tag -c" to match "git commit -c", which
> would allow us to say something like:
>
>       A tag object was created, but we failed to update the ref.
>       After correcting any errors, you can recover the original tag
>       message with:
>
>         git tag -c $oid [other options]
>
> (where we'd replace $oid with the hash of the created tag object). The
> best alternatives I could come up with were:
>
>       # this is kind of obscure advice to give somebody, plus
>       # it makes a weird tag if you originally tried to tag "foo/bar"
>       # but then later switch to some other name. The "tag" field
>       # in the object won't match the ref.
>       git update-ref $ref $oid

... I agree that this is not a very good advice to give, and ...

>       # this saves just the message but is horribly complicated
>       git cat-file tag $oid | sed '1,/^$/d' |
>       git tag -F -

... this is a reasonable thing to have in a more user-friendly
feature, like your -c above.

> I dunno. There is a certain elegance to telling the user about what
> progress we _did_ make, but if there isn't an easy way to turn that into
> a retry of their command, it may not be all that useful.

Yeah, I am OK with "leaving TAG_EDITMSG behind" and a future "tag
-c/-C $another" to coexist.
