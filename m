Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3283C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 18:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbiGVSkm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 14:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbiGVSkj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 14:40:39 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A1613F23
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 11:40:38 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8774D19AB73;
        Fri, 22 Jul 2022 14:40:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=n+UPzX6r+skhEyqEFTDDyuYpDqXqWrLLKY+p/Q
        FnA1U=; b=PeK1+yo1SQJxkbWYEcuAvotihniv1rvdLSqYngwYn5fOzeCmpM4gEP
        Po9lh++OUS1vEnATK8WXIii/DkoBHNazaP7KizptLT6IAFDT+PNfkXvyMWHUCWlU
        CB7MW+n0orOAMkWigSVbL++lKvppF+2JOdl8CNfspQyocaBqM4qKo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7EEEF19AB72;
        Fri, 22 Jul 2022 14:40:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 33C5319AB6A;
        Fri, 22 Jul 2022 14:40:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, vdye@github.com,
        git@vger.kernel.org
Subject: Re: [PATCH v1 4/7] mv: check if <destination> is a SKIP_WORKTREE_DIR
In-Reply-To: <25ca0c62-e3b4-e96a-4c44-285bcfef2143@github.com> (Derrick
        Stolee's message of "Fri, 22 Jul 2022 08:48:08 -0400")
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
        <20220719132809.409247-5-shaoxuan.yuan02@gmail.com>
        <95263c88-6894-87bb-4d52-84d8d1cc5671@github.com>
        <ab96cbe0-f256-ea5e-8356-db11d2b773f4@gmail.com>
        <25ca0c62-e3b4-e96a-4c44-285bcfef2143@github.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Fri, 22 Jul 2022 11:40:32 -0700
Message-ID: <xmqqczdxc7of.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4D0796A-09ED-11ED-9295-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>>> Good that you are freeing this here. You might also want to set it to NULL
>>> just in case.
>> 
>> I was using the `FREE_AND_NULL()` macro, but I wasn't sure since other
>> places in 'git-mv' only use `free()`. Though I think it is better to
>> `FREE_AND_NULL()`.
>
> free() is generally the way to go if it is clear that the variable
> is about to go out-of-scope and could not possibly be referenced
> again. Since there is a lot more of the current code block to go,
> nulling the variable is good defensive programming.

NULLing it out is better when a potential misuse of the pointer
after it got freed will be caught by dereferencing NULL.

There however are pointer members of structures wher they represent
optional data.  Access to such a member goes like so:

	if (structure->optinal_member)
		do_things(structure->optional_member);

When you are done using such a structure and clearing it, after
releasing the resource held by the member, it is better to leave it
dangling than assigning NULL to it.  If somebody reuses that
structure and the control enters a codepath like the above one to
use the "optional" pointer, uncleared dangling pointer will likely
be caught at runtime; setting it to NULL will paper over it.  We've
seen many bugs caused by a premature releasing of a member that was
hidden exactly by such a use of FREE_AND_NULL() few relases ago.

Thanks.
