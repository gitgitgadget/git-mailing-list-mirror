Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7571C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348143AbiFCSwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348122AbiFCSwh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:52:37 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB86D2871D
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:52:35 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D25F12D354;
        Fri,  3 Jun 2022 14:52:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l2x9aj9ilVyEym+Ha30ZUmPwZWV+L8/yPrbI1A
        b9fOY=; b=pi2CYpiJbme/xQxFAI7twYN/HXw1lZaBJhwuwuSUdBQ9AIu8nSgPs8
        bgqOf2qQIeUKVWeCoR0Uygw3rjoAEOfYrDwdFyKK7SDrAMG7eCA1EOrpIN10ohmM
        9SZTJdaRgZYcziTDA9TyBiAUnWG+5dTtJvUb5m2l3VI/9rIz5R8sY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 451E112D353;
        Fri,  3 Jun 2022 14:52:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B172512D352;
        Fri,  3 Jun 2022 14:52:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/4] rebase: update branches in multi-part topic
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
        <YppSl4rOvVciLuXE@nand.local>
Date:   Fri, 03 Jun 2022 11:52:33 -0700
In-Reply-To: <YppSl4rOvVciLuXE@nand.local> (Taylor Blau's message of "Fri, 3
        Jun 2022 14:27:35 -0400")
Message-ID: <xmqqr145fuku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54A1CE0A-E36E-11EC-B4F7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> But I wonder if we can or should delay these update-refs as long as
> possible. In particular: what happens if I get past this "exec" line (so
> that I've already updated my bundle-redo/fetch branch to point at the
> new thing), but decide at some later point to abort the rebase?
>
> I think users will expect us to restore bundle-redo/fetch to where it
> was before if we end up in that case. Recovering from it manually sounds
> like kind of a headache.

That is a very good safety and usability concern.  I am glad
somebody thought of it.

> What if instead we created labels here, and then delayed all ref updates
> to the end by replacing this with:
>
>     label bundle-redo/fetch
>
> and then at the end of the todo list we'd add:
>
>     exec git update-ref refs/heads/bundle-redo/fetch refs/rewritten/bundle-redo/fetch
>
> If we do all of those ref updates in a single transaction at the end, it
> should be much easier to roll back from if desired, and we'd avoid the
> aborted-rebase problem entirely.

;-)
