Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D08CC001DF
	for <git@archiver.kernel.org>; Wed,  2 Aug 2023 22:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjHBWDD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 18:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjHBWDB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 18:03:01 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2481FD9
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 15:02:59 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A12572348A;
        Wed,  2 Aug 2023 18:02:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JzDffw4WRbZr2fraUUDrtXp5Qs2jtQ771ELjYn
        IQqFA=; b=SgtEa0WFU5mvSwbROniB/uuXfg1ZaeQE0sRBZldKP+c65Py0SftQPV
        rByUzE/Tdf5acgYHA0+/Rrx7VhpYuwisf9ikklzYt8LzseYOcSf17U001TDD3hky
        j3/Jxf+3qFNQbAOxs7vNpYyUhvYpBaK+8E7xwaZIxTiZ0H94HqEkY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9961B23489;
        Wed,  2 Aug 2023 18:02:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 461EB23486;
        Wed,  2 Aug 2023 18:02:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 3/7] sequencer: use rebase_path_message()
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
        <8f6c0e4056742951ce84acbdb07b0518f7607b2a.1690903412.git.gitgitgadget@gmail.com>
        <xmqq4jlid6cx.fsf@gitster.g>
        <619e458b-218b-a790-dfb4-9200e201b513@gmail.com>
Date:   Wed, 02 Aug 2023 15:02:54 -0700
In-Reply-To: <619e458b-218b-a790-dfb4-9200e201b513@gmail.com> (Phillip Wood's
        message of "Tue, 1 Aug 2023 19:49:34 +0100")
Message-ID: <xmqqedkl6r1t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5560E9C8-3180-11EE-AEA5-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 01/08/2023 18:23, Junio C Hamano wrote:
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> Rather than constructing the path in a struct strbuf use the ready
>>> made function to get the path name instead. This was the last
>>> remaining use of the strbuf so remove it as well.
>> The same comment about "get_dir() vs hardcoded rebase-merge" applies
>> here, I think.  And the same (1) assertion to ensure that we are in
>> "rebase -i" when make_patch() is called should give us a sufficient
>> safety valve,
>
> Agreed
>
>> or (2) instead of hardcoding rebase_path_message(),
>> call it sequencer_path_message() and switch at runtime behaving the
>> same way as get_dir(opts) based version, would also work.
>
> I think that would me misleading because cherry-pick/revert do not
> create that file - they rely on "git commit" reading .git/MERGE_MSG

Fair enough.  

Abusing the MERGE_MSG this way probably came from the "if 'commit'
picks up whatever is left inside MERGE_MSG when it is run, reusing
it for this operation (even though it clearly is not a 'merge')
would be a way to do with the least effort, even if it does not make
sense for those who will be reading the code 3 years from now on"
kind of hackery.  The file probably outgrew its name and we might
want to rename it to a more appropriate name (it is "we gave control
back to the user to help us resolve a mess in the working tree, and
here is the message to be used when the user is done"; the "mess" no
longer is limited to conflicts created during a "merge").

But it would be a major headache if end-user tools are relying on
it, so it is not likely to happen anytime soon.

So, moving to hardcoded "rebase-merge", as long as we make sure
make_patch() will only callable by "rebase -i" (and not something
like "cherry-pick -i" people will wish to add in the future), I am
fine with such a design.

Thanks.
