Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE3111F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 03:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392892AbfJXD3e (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 23:29:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57887 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390450AbfJXD3e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 23:29:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 288229635F;
        Wed, 23 Oct 2019 23:29:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Vj6MqwgcY5Qq
        3taWBUTs8M/QNdA=; b=ev8wXn9sSjfoUTHPP0Tm8Fnu8BdypCkSBryyPZmdBj0u
        TUwcVEpuhsuTTqOmMjib8Knmzz5TZgV68VXETWdSLrv1FV79C+gJh55xRfRoW8rn
        UgJb7ru4mZg3yXE2Z92YCoM8hodD2TFDUcF2Mx72RmOHuTU0Qrc2a6XCyxKWgFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eJSmbA
        qHut4+6bUfQp/PPIQbzAFfxqXGtavql5wIugv52P6UlFb8pwYzEUFwMkiZA4hLUQ
        dDlza9GacBAWtm2fsU3V4XfhZjdUhKptAUNg8EX+NrfL3xoDA7o9wWHzoONITfNh
        DQFow+sDRms282DVP9D4xRQIOCyuf2l4bi4DI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 212F09635E;
        Wed, 23 Oct 2019 23:29:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 55D379635C;
        Wed, 23 Oct 2019 23:29:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     David Turner <novalis@novalis.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/5] path.c: don't call the match function without value in trie_find()
References: <20191021160043.701-1-szeder.dev@gmail.com>
        <20191021160043.701-6-szeder.dev@gmail.com>
        <20191021205703.GB4348@szeder.dev>
        <xmqqa79si003.fsf@gitster-ct.c.googlers.com>
        <20191023162048.GI4348@szeder.dev>
Date:   Thu, 24 Oct 2019 12:29:28 +0900
In-Reply-To: <20191023162048.GI4348@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Wed, 23 Oct 2019 18:20:48 +0200")
Message-ID: <xmqq5zkehld3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7DE56BA0-F60E-11E9-930E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> I'm not sure what you mean by "consistency check".  The resulting trie
> looked as expected both before and after b9317d55a3, i.e. each trie
> node had the right contents, value, and children, as far as I could
> tell.  The issue was in the lookup function.

I saw the change to the code as a band-aid, which wouldn't have been
necessary if we had the missing refs/ entry.  Fully populating the
leading levels explicitly may give the application more flexibility
by yielding results different from hardcoded -1 like the patched
code gives. =20

But perhaps treating a path that matches a missing intermediate
level just like a path that did not match anything in the trie is
what we want anyway, so I guess the code change was the right thing
(as opposed to a band-aid).

Thanks.

