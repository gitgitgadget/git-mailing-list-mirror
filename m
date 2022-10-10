Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C25C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 21:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJJV6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 17:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJJV6d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 17:58:33 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A0E647DE
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 14:58:31 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB76C1BFD83;
        Mon, 10 Oct 2022 17:58:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ndrfwt8Ev26l
        kCcsctXqx2iBI9+rYPdg3g4ViUowZjk=; b=tmIpWDK2wJNKQPJzZr5fwp+MyzEa
        /jyG3xI+ikLO0t2mz+cNgh4IaLaeKm2j1dTXze3/Th7buDRlq0Cz8ON+FW5ePZgY
        jy6PmqkHfZZVp9g8EGwXD3D+Vb+OSf3i6P+sMBVJEpSW6Cypyakfv8+CdfToy3de
        XsdtoAT/TjzyAbI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B408B1BFD82;
        Mon, 10 Oct 2022 17:58:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EE0991BFD81;
        Mon, 10 Oct 2022 17:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, alexander.s.m@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5 1/1] diff.c: When appropriate, use utf8_strwidth()
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
        <20220914151333.3309-1-tboegi@web.de> <xmqqpmfx52qj.fsf@gitster.g>
        <20220926184308.5oaaoopod36igq6i@tb-raspi4>
Date:   Mon, 10 Oct 2022 14:58:26 -0700
In-Reply-To: <20220926184308.5oaaoopod36igq6i@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Mon, 26 Sep 2022 20:43:08
 +0200")
Message-ID: <xmqq35bv1gu5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ABC5B27C-48E6-11ED-ADAF-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On Wed, Sep 14, 2022 at 09:40:04AM -0700, Junio C Hamano wrote:
>
> []
>
>> I think I spotted two remaining "bugs" that are left unfixed with
>> this patch..
>> ...
> How should we proceed here ?
> This patch fixes one, and only one, reported bug,

But then two more were reported in the message you are responding
to, and they stem from the same underlying logic bug where byte
count and display columns are mixed interchangeably.

> "git log --graph" was mentioned.
> Do we have test cases, that test this ?
> How easy are they converted into unicode instead of ASCII ?

The graph stuff pushes your "start of line" to the right, making the
available screen real estate narrower.  I do not think in the
current code we need to worry about unicode vs ascii (IIRC, we stick
to ASCII graphics while drawing lines), but we do need to take into
account the fact that ANSI COLOR escape sequences have non-zero byte
count while occupying zero display columns.

The other bug about the code that finds which / to use to abbreviate
a long pathname on diffstat lines does involve byte vs column that
comes from unicode.  From the bug description in the message you are
responding to, if we have a directory name whose display columns and
byte count are significantly different, the end result by chopping
with the current code would end up wider than it should be, which
sounds like a recipe to cook up a test case to me.

