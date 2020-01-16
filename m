Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2D8C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E722206D7
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KEye+rT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733297AbgAPUUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:20:10 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58436 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAPUUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 15:20:09 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B162957A9;
        Thu, 16 Jan 2020 15:20:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8asIYMSDee28XAhtkphqMYEDoXo=; b=KEye+r
        T2PtIdbhZgopSWBcc4XrbjWetqz9HiMzbseSO1k/S6Y7UI1YSp6ejPnvi9HpYDiS
        67HjwtOwuZRDBk3xckgDd5Rj0t/TgokBvhdB0/kFMOw3yYU9Zit/G4WJDCuTNuhO
        hSIDU1BZKMZVKS8a//WHgN4vIVi797D9iEDUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bBEBPCWBXMYzEdkm00sEXDv7P0XQ5l1P
        eqYY4ukDiFudNnSb/ojMN9n4UxSAoXzIc9tBT60DezaN3fnI9iZYZq6NFsObBgEs
        NEb2zNCpQWIgH8x+n7UO8T8bZDdUd247KZzquc1U3Kd39/+0r73h3vuqyd1LhuNB
        dlcYLDlW65A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 81A7E957A8;
        Thu, 16 Jan 2020 15:20:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 89538957A6;
        Thu, 16 Jan 2020 15:20:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] clean: demonstrate a bug with pathspecs
References: <pull.526.git.1579119946211.gitgitgadget@gmail.com>
        <CABPp-BHywo5Js0YGwDykV8G+=Y6-M_Wh3sE5BvC-7zArJd1rLw@mail.gmail.com>
        <e008da66-defe-d2b0-410b-64b7754b9c6e@gmail.com>
        <CABPp-BFX2ER9aqaHi=sbaSppGobCOisR2a8z1mTGqbQ8xS_WCA@mail.gmail.com>
Date:   Thu, 16 Jan 2020 12:20:02 -0800
In-Reply-To: <CABPp-BFX2ER9aqaHi=sbaSppGobCOisR2a8z1mTGqbQ8xS_WCA@mail.gmail.com>
        (Elijah Newren's message of "Thu, 16 Jan 2020 10:01:23 -0800")
Message-ID: <xmqqk15rgnm5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94CE3636-389D-11EA-9DB1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Anyway, I'm going to pull your commit into my series so I can put my
> fix on top, and lump it in with Peff's two patches over at
> https://lore.kernel.org/git/20200115202146.GA4091171@coredump.intra.peff.net/
> since all these patches are basically "more fill_directory() fixes".

Thanks.  Then I'll refrain from applying those two patches we saw
earlier (including the one you have the URL in your message).

