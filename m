Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEE6C28B2B
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 15:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbiHPPCz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 11:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbiHPPCg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 11:02:36 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F24E640A
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 08:00:47 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 87B68130ABE;
        Tue, 16 Aug 2022 11:00:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YUIydcExIQu4PrTQne6v2j1OF5lul5Zu51UEgI
        1HcEA=; b=Q89Vry/whLer/7zFNJZk9wFCAouRU4/uF1mZyVQ+imQOFLLF6ZHq7J
        zZmn/o6Fn3xcNkcef+dD0a1UQFWSCY+kEixYX9CtZzMwZiHcGVRAWmArEuEBJUB6
        MgtBB0afXiB8y+kI3jvwh1xsGOzYg53R3RvdQS8mbhAIlf0FBR/Ts=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C992130ABD;
        Tue, 16 Aug 2022 11:00:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE4A0130ABB;
        Tue, 16 Aug 2022 11:00:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/5] rebase: factor out merge_base calculation
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
        <019158db9d2dbb371705ba79a96a907e4a17cdb1.1660576283.git.gitgitgadget@gmail.com>
        <xmqqczd12zhv.fsf@gitster.g>
        <77899422-7o79-s730-p529-72022r6o7442@tzk.qr>
Date:   Tue, 16 Aug 2022 08:00:44 -0700
In-Reply-To: <77899422-7o79-s730-p529-72022r6o7442@tzk.qr> (Johannes
        Schindelin's message of "Tue, 16 Aug 2022 11:15:22 +0200 (CEST)")
Message-ID: <xmqq1qtgz10j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34D2D91C-1D74-11ED-B26C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 15 Aug 2022, Junio C Hamano wrote:
>
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
>> >
>> > Separate out calculating the merge base between onto and head from the
>> > check for whether we can fast-forward or not. This means we can skip
>> > the fast-forward checks when the rebase is forced and avoid
>> > calculating the merge-base twice when --keep-base is given.
>> >
>> > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> > ---
>> > Note the unnecessary braces around "if (keep_base)" are added here
>> > reduce the churn on the next commit.
>
> This note...
>
>> > @@ -1668,7 +1678,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>> >  			die(_("Does not point to a valid commit '%s'"),
>> >  				options.onto_name);
>> >  	}
>> > -
>> > +	if (keep_base) {
>> > +		oidcpy(&merge_base, &options.onto->object.oid);
>> > +	} else {
>> > +		fill_merge_base(&options, &merge_base);
>> > +	}
>>
>> No need for braces around single-statement block on either side.
>
> ... already addresses this feedback.

Yeah, but the point is instead of wasting readers' bandwidth with an
additional note, the series can add braces in the step where they
become necessary, i.e. the later step where there is a new statement
in the body of the "if-true" side.
