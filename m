Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFF6EB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 15:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjGUPZi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 11:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjGUPZg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 11:25:36 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42906C6
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 08:25:26 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B3E8119706;
        Fri, 21 Jul 2023 11:21:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vqWRspHr1mRz3N90iWSJel8zLbYivFingbNcb0
        U4Hr8=; b=fmTYBV5DhYtc1A7jlBCjtQTD/uKPY5oWYXnmMbu2RXW9MAuGKUREYZ
        glOknkQXoCeS/Jo7u7VxsYjsg20Q0KFfeG6uxEVmC2v1u7LL2g8daNhXHCFMXFFY
        BTfNGGqMKln4eYY2WhgHb3gKsidsPx9wdulT6/HduAJCGXMNAqwB0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ADABE19705;
        Fri, 21 Jul 2023 11:21:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0DAE519704;
        Fri, 21 Jul 2023 11:21:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, alban.gruin@gmail.com
Subject: Re: [PATCH] sequencer: finish parsing the todo list despite an
 invalid first line
References: <20230719144339.447852-1-alexhenrie24@gmail.com>
        <395274b4-37a9-8c95-203f-94178c99772a@gmail.com>
        <CAMMLpeSN_M1HW1D3HyuY+S+GwUrQ_4dP9qoSQ72hbQv3pwK5kg@mail.gmail.com>
        <c7b7f078-6561-5081-9c23-0cec65b71c97@gmail.com>
        <d6e54535-79a3-2d2c-3152-4cabc5bbd9b8@gmail.com>
Date:   Fri, 21 Jul 2023 08:21:00 -0700
In-Reply-To: <d6e54535-79a3-2d2c-3152-4cabc5bbd9b8@gmail.com> (Phillip Wood's
        message of "Fri, 21 Jul 2023 14:08:42 +0100")
Message-ID: <xmqqpm4lwasj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33D0709E-27DA-11EE-AFD6-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 21/07/2023 10:31, Phillip Wood wrote:
>> That's fine but the commit message should explain that decision and
>> clarify why ddb81e5072 caused the regression
>
> Maybe something like
>
> Before the todo list is edited it is rewritten to shorten the OIDs of
> the commits being picked and to append advice about editing the
> list. The exact advice depends on whether the todo list is being
> edited for the first time or not. After the todo list has been edited
> it is rewritten to lengthen the OIDs of the commits being picked and to
> remove the advice. If the edited list cannot be parsed then this last
> step is skipped.
>
> Prior to db81e50724 (rebase-interactive: use todo_list_write_to_file()
> in edit_todo_list(), 2019-03-05) if the existing todo list could not
> be parsed then the initial rewrite was skipped as well. This had the
> unfortunate consequence that if the list could not be parsed after the
> initial edit the advice given to the user was wrong when they
> re-edited the list. This change relied on
> todo_list_parse_insn_buffer() returning the whole todo list even when
> it cannot be parsed. Unfortunately if the list starts with a "fixup"
> command then it will be truncated and the remaining lines are
> lost. Fix this by continuing to parse after an initial "fixup" commit
> as we do when we see any other invalid line.
>
> Best Wishes
>
> Phillip

That does sounds a lot easier to understand as an explanation for
the reason why this change is necessary and sufficient.

Thanks for reviewing.

