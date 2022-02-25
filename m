Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A85C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 18:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiBYSkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 13:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiBYSkx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 13:40:53 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461595C64F
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 10:40:21 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9687101F00;
        Fri, 25 Feb 2022 13:40:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=INv7JXBfZe6lhKvwIzEnM00ZGW9+ja7Gic0/j7
        PRc8A=; b=pOYzB/V2j1p6dKRJamydn7ewRGzsxtg9lTb0eNsUDmAvQrXoiV1a4P
        iDdiqNw59/4zmU9GxDKN/aTXdSQYbfnIPNm1ACERec7iL68AuYeMLsnaFrqjABNk
        YlxgA5gHhDBjVTEK5W5vckKsjdA3Exj3o1cBHXt5McP6VUZ3Iyr08=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B16BA101EFF;
        Fri, 25 Feb 2022 13:40:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2CB61101EFE;
        Fri, 25 Feb 2022 13:40:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet>
        <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
        <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org>
        <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com>
        <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet>
        <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
        <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet>
        <CABPp-BFG_05RyVVyiHzOkuoT8=9NftJGp_W+DXd7ktqC5UfvwQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.2202251726500.11118@tvgsbejvaqbjf.bet>
Date:   Fri, 25 Feb 2022 10:40:18 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2202251726500.11118@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 25 Feb 2022 17:31:19 +0100
        (CET)")
Message-ID: <xmqqh78mdc31.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6253AACE-966A-11EC-B549-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I tend to call things either content-based conflicts or path-based
>> conflicts, where content-based usually means textual-based but also
>> includes merges of binaries.
>
> I like "content-based conflicts".

Yup, even before ort existed, we had clear distinction between tree
level merges (i.e. which path corresponds to which other path, which
is done in unpack_trees() and "read-tree O A B") and content level
merges (which is done with ll_merge()).

>> Switching to single quoting paths as a matter of style might make
>> sense, but only if we go through and change every caller to do so so
>> that we can make sure it applies to all paths.  And only paths and not
>> OIDs.
>
> Yes, that sounds unappealing.
>
>> But I'm going to reserve the right in merge-ort to modify, add, or
>> delete any of those messages passed to path_msg(), which might wreak
>> havoc on your attempts to parse those strings.  I think they're a bad
>> form for communicating information to a script or program, and trying
>> to transform them into such risks making them suboptimal at
>> communicating info to humans.  These messages should optimize the
>> latter, and if we want something for the former, it should probably be
>> a new independent bit of info.
>
> Makes sense.

As long as it is made clear that the path_msg() is not for machine
consumption (perhaps we can sprinkle <RED><RESET> at random places
to make it impossible for machines to handle), I think the direction
makes sense, too ;-)
