Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1644CC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 08:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8A764E4B
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 08:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhBWIJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 03:09:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55811 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhBWIIg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 03:08:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C96BBB8A62;
        Tue, 23 Feb 2021 03:07:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=17/V5eg0MU7psr8Wv95rwRIgchk=; b=chyvTl
        T15jCIABhssRAaCcsVj7XzMLNLgiss80xizGFY7UGz4hpQdrWd71qQvoj+XuJ25p
        YIP/v2V00pvgS5PzIouV3Sy1IXOnyQoHO4umn7/STpDN+89IkvqKszXfZDLIPgaN
        2DrQbHIXqreGRjmmXrHH3FukTYEz+O36mCe2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Th2idJ/mz3tbjBNCi4UHTle4r5djHrC1
        Ar8GX+fpyKsO2FWMShWzS8UML8gDMDofpDEYiLv6Sx2iTZza/kU/HALtsio3qzIR
        OnEFl1cs6iyiN9bIvNXf01H4KA8x+xtBaimNBJkwib/URMc7CjIP45UZnHZvgFbY
        D7ULZhAIgxg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AEEC4B8A61;
        Tue, 23 Feb 2021 03:07:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2BBF0B8A60;
        Tue, 23 Feb 2021 03:07:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH v4 3/8] builtin/pack-objects.c: add '--stdin-packs' option
References: <cover.1611098616.git.me@ttaylorr.com>
        <cover.1614047097.git.me@ttaylorr.com>
        <649cf9020bfdae9f48e3efbfbc52429cefd31432.1614047097.git.me@ttaylorr.com>
Date:   Tue, 23 Feb 2021 00:07:52 -0800
In-Reply-To: <649cf9020bfdae9f48e3efbfbc52429cefd31432.1614047097.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 22 Feb 2021 21:25:10 -0500")
Message-ID: <xmqqsg5n436v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A8C2E86-75AE-11EB-A3B6-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> (I found it convenient while developing this patch to have 'git
> pack-objects' report the number of objects which were visited and got
> their namehash fields filled in during traversal. This is also included
> in the below patch via trace2 data lines).

It does sound like a well thought out strategy to give name-hash to
entries that we may have to find good delta bases afresh, while
stopping upon hitting parts of the history we won't have to (either
because they are in "excluded" packs, which you did here, or because
they can take advantage of the "reuse existing delta base" logic [*],
which we may want to look further into in future follow-on topics).


[Footnote]

* I presume that such a logic may, instead of stopping at an object
  that is in an excluded pack, stop at an object that is stored in
  the current pack as a delta and its base is also going to be
  packed (and the latter by definition is always true, I presume, as
  everything in the included pack would be packed)


