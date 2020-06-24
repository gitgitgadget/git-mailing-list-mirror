Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3205C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 18:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF69D2081A
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 18:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CSUabfMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406015AbgFXSlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:41:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53914 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405581AbgFXSlx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 14:41:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4302462FA0;
        Wed, 24 Jun 2020 14:41:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ML1k7Xglxg9fyWkQA2gsRJzwEmk=; b=CSUabf
        MHqs/ow+gxcqmoYGgwvQ4Sn/yy8ADcor9mMqqDIsAMvGeKGPby/OiFOk4PxPzMjG
        9vnHIsQ03vZ7FDeDvQaa0+/VjQkUAKVdpRaOFudSdAC/wsU5DrIMFfydsV5wWVdm
        mWNJLu7jiX0jcfy9W+dA2f7SGSTqsOZCcWF3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FpwmcRAuyF5vppgWr2eZ0RaHofXmWb9t
        QBq92cr4L8qMX7XYuMeI1BG8Y7l6FkVd7d/2fJxOkFVGjBotBD+5/wePJLt+fhEY
        XP6GxSidXkZa0/NGQpROJdGEAf9eVWrAGzLQ0J6Ne62194u/idlzI/b8zs8n/y8Z
        dtBV6kJPV44=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A7D562F9F;
        Wed, 24 Jun 2020 14:41:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C4FB762F9E;
        Wed, 24 Jun 2020 14:41:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: Re: [PATCH v2 1/3] diff-files --raw: handle intent-to-add files correctly
References: <pull.654.git.1591879139.gitgitgadget@gmail.com>
        <pull.654.v2.git.1592916485.gitgitgadget@gmail.com>
        <640e225550886727594ca9dfaee6c9e6ea4b1014.1592916485.git.gitgitgadget@gmail.com>
        <xmqqzh8t9vf5.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006241517320.54@tvgsbejvaqbjf.bet>
        <xmqqy2oc8oye.fsf@gitster.c.googlers.com>
Date:   Wed, 24 Jun 2020 11:41:50 -0700
In-Reply-To: <xmqqy2oc8oye.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 24 Jun 2020 08:26:33 -0700")
Message-ID: <xmqq4kr071ch.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DF26B34-B64A-11EA-B3BC-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Sure, but my intention was to synchronize the `--raw` vs the `--patch`
>> output: the latter _already_ shows the correct hash. This here patch makes
>> the hash in the former's output match the latter's.
>
> That is shooting for a wrong uniformity and breaking consistency
> among the `--raw` modes.
> ...
>
> [Footnote]
>
> *1* This division of labor to free "--raw" mode of anything remotely
>     unnecessary stems from the original diff plumbing design in May
>     2005 where the "--raw" mode was the only output mode, and there
>     was a separate "git-diff-helper" (look for it in the mailing
>     list archive if you want to learn more) that reads a "--raw"
>     output and transforms it into the patch form.  That "once we
>     have the raw diff, we can pipe it to post-processing and do more
>     interesting things" eventually led to the design of the diffcore
>     pipeline where we match up (A)dded and (D)eleted entries to
>     detect renames, etc.

Having said all that.

If somebody wants to shift the burden of computing object names from
the consumers of "diff --raw" output to generators like diff-files
and diff-index, I do not mind if it is done under a new command line
option and done consistently for not just I-T-A additions, but
"modified but not added yet" and "not modified but stat information
is dirty" paths.  As I said, I would not recommend it, though.

