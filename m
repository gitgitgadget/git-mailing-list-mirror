Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9E981F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 01:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfJ3BhT (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 21:37:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56483 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfJ3BhS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 21:37:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4C263D553;
        Tue, 29 Oct 2019 21:37:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+oh73mGvp3U/gl6Kg/1Jy6wOmis=; b=C4QnBW
        cOTw5owYw0ERRtCkRuxw4vzF+amowqaP5JcQ6IgDwDheWloHdDwMuWWArb+9BxX7
        OERZAJ7hHYZzXFdmos1BLGtNZ8MZ0v5sVZklALzvi4EFYU2kmiCB3qZL0XerixQH
        CHc0lELEsZLO6L5NrhQlsT+lBH+E6gPQeiogI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HD22Mt3xDnfhJVT0+SPEjKv6Cz1SPQlM
        9efGDFSYDLvb/C+/1xIw8wb0tTM+k0G/oaQ8G+6GLHFTgdnM1UTmMTy24/LtVbLi
        pDaMNTiMhJCcVq2Ys9DFKGBi4VULPSlooLuEUXvZJF17Nt0N38EYX2ncK+cObH4/
        YtQXziIgzEM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABE113D552;
        Tue, 29 Oct 2019 21:37:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1C9F73D550;
        Tue, 29 Oct 2019 21:37:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 4/9] bugreport: add config values from whitelist
References: <20191025025129.250049-1-emilyshaffer@google.com>
        <20191025025129.250049-5-emilyshaffer@google.com>
        <20191029205823.GC12243@google.com>
Date:   Wed, 30 Oct 2019 10:37:13 +0900
In-Reply-To: <20191029205823.GC12243@google.com> (Josh Steadmon's message of
        "Tue, 29 Oct 2019 13:58:23 -0700")
Message-ID: <xmqqwocn3tfa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD443090-FAB5-11E9-BD72-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> This and git_config_bugreport() below should both be static as well.
> Rather than repeating advice on the later patches, I'll just note that
> any new functions that don't show up in the corresponding .h file should
> be marked static.

Good advice.  

More importantly, given that "git bugreport" itself has no service
of itself to offer other existing parts of Git (it is just a "gather
various pieces of information from different places, and then
produce a text file output" application), I do not see much point in
it having its own header file that others would #include (i.e. the
include file is to define services that are offered by it).  If
there are common enough service routines invented to support the
need of bugreport.c (e.g. perhaps it wants to give more info than
what is currently available via the existing API on the contents of
in-core index), by definition of being them common enough, they
should be added to the header that can be used by both bugreport.c
and other existing users of the same subsystem (e.g. if it is about
in-core index, perhaps cache.h).

It makes perfect sense for bugreport.c to #include header files for
the Git internals to collect pieces of information from inside Git,
though.

