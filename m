Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D074FC433DB
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 00:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92EB3619D7
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 00:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhCaAFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 20:05:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59779 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbhCaAFB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 20:05:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5923212EF10;
        Tue, 30 Mar 2021 20:05:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Vlt8RQ1eGejr
        wni0G+z5TvWy6S8=; b=mNztKb1NaXWrikFDjcebbSKsTg3pv2UD8ZCA97EnZOKI
        lcxUGwzGaB3juFtQfNteSJb7p88GwGBzycMxGTY9/RyIuoeETEKXO1813026KQdm
        5KxkaHry6EUsUhBLwUtASPT6d41m7Ob9corXYCwHnB84wbd7z0qYlqbP4hchoKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YgeVxN
        0eo8HsXXcTGDX+p8C34cGHq1aUIfmpfmZJ8Ude9NFTh0oZsPjUdjDDi4MaRwTEuk
        1twxNFe5WL8j/cm3Pv8zy2Zxtex7qMOhxgfHUW+9S9qJK2rjBN6jykinwH9c75lP
        kFBSBZvohO8ohYav0m0PQ4h/j3v9sVvfs4Jd8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5155F12EF0F;
        Tue, 30 Mar 2021 20:05:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 865AC12EEDA;
        Tue, 30 Mar 2021 20:04:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 19/22] xdiff-interface: allow early return from
 xdiff_emit_{line,hunk}_fn
References: <20210203032811.14979-1-avarab@gmail.com>
        <20210216115801.4773-20-avarab@gmail.com>
Date:   Tue, 30 Mar 2021 17:04:56 -0700
In-Reply-To: <20210216115801.4773-20-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Feb 2021 12:57:58 +0100")
Message-ID: <xmqqa6qk9oif.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BB314A40-91B4-11EB-BF53-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the function prototype of xdiff_emit_{line,hunk}_fn to return
> an int instead of void. This will allow for returning early from hunk
> & diff consumers that want some of the data, but not all of it.
>
> No behavior is being changed here, just replacing the equivalent of
> "return" with "return 0", nothing acts on the changed return values
> yet.

So, is this "allowing" early return yet?  I am looking at the patch
title and then reading the above paragraph and wondering.

Or is this step "preparation for allowing" and the real fun is left
for later steps?
