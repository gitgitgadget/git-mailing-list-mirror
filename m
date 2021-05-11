Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B65C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 06:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFFC96192B
	for <git@archiver.kernel.org>; Tue, 11 May 2021 06:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhEKGSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 02:18:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64561 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhEKGSY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 02:18:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 43F98137DB7;
        Tue, 11 May 2021 02:17:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YwQmq0wZKpnGPhcMwoz/8vFxVKmmuU/FdLuQog
        Pw0Zo=; b=QC/lJjG9H/WwRdzPBBvzaAe0fVwlKhhl66wGUh9akgtrmbMQ4uO35l
        f8Cuwvu7D4mUoZ826ijjQ0NWni0E/PhBCHj2A7Jf8MJ99oWqpJFhg2ZTqI1waQfV
        1Q8uEE8TKu4HJXzNbU3tek2M09Olvy7elA6kvMAFFyDLLoO2iE9LU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3CC83137DB6;
        Tue, 11 May 2021 02:17:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 78B95137DB5;
        Tue, 11 May 2021 02:17:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v1 1/8] compat/terminal: let prompt accept input from pipe
References: <20210506165102.123739-1-firminmartin24@gmail.com>
        <20210506165102.123739-2-firminmartin24@gmail.com>
        <xmqqr1ijwi0i.fsf@gitster.g>
        <YJTH+sTP/O5Nxtp9@coredump.intra.peff.net>
        <875yzrgr1f.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
        <YJmmXZdwSoR+vxjw@coredump.intra.peff.net>
        <xmqq1raeos7x.fsf@gitster.g>
        <YJof0/Eq18QnLumV@coredump.intra.peff.net>
Date:   Tue, 11 May 2021 15:17:13 +0900
In-Reply-To: <YJof0/Eq18QnLumV@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 11 May 2021 02:10:27 -0400")
Message-ID: <xmqq35utokuu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87FC544E-B220-11EB-84AE-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, May 11, 2021 at 12:38:10PM +0900, Junio C Hamano wrote:
>
>> >> I actually inspired myself from the two occurrences of git_prompt in
>> >> builtin/bisect--helper.c introduced in 09535f056b (bisect--helper:
>> >> reimplement `bisect_autostart` shell function in C, 2020-09-24).
>> >> Not sure if they should also be converted to a simple fgets.
>> >
>> > Yes, I think they should be switched.
>> 
>> OK, that is because in the context of a "bisect" session, we won't
>> be feeding any real data from its standard input, unlike "git am"
>> that may well be eating a patch stream from its standard input
>> stream.  If so, makes sense.
>
> Yes, though even in "git am", we forbid using interactive mode with
> patches on stdin (and did so even when we were reading from the tty;
> presumably the rule dates back to when it was a shell script and was
> using stdin).

As long as the "prompt and accept an single-line answer from the end
user" is restricted to "git am -i", I'll be perfectly OK with that.
I just do not want my regular "type '|' in my MUA to pipe the
current article to a command, and give 'git am -s' as the command"
workflow to get broken in the future when somebody blindly follows a
carelessly written direction to use a helper that reads from the
standard input for confirmation.  The condition under which use of
that helper is appropriate needs to be clearly spelled out.

Thanks.
