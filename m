Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970BCECAAD8
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 01:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiISBXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Sep 2022 21:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiISBXR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2022 21:23:17 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017F114D39
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 18:23:16 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A8E0148FDC;
        Sun, 18 Sep 2022 21:23:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R/Mh7UNuGlGwFmiZin3WOChCc3CWRqun/Adm40
        7WB6E=; b=I+PdyBdmOt2fYY2IvfAugHnQscHFxKqm2lpa6/EPqVntVRpsW2wAsi
        HIoekNfrRA1ZgMpmf8oB9eCrJ78O/bI3MYGwzWCHYaszVojAZ3oho+wxz0YgQWNL
        dIF2NCUk00Z8p2sPaxdFkM52yspuo3pnEC+ltHODC/1RNzPRHNF1o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30677148FDB;
        Sun, 18 Sep 2022 21:23:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C15F148FDA;
        Sun, 18 Sep 2022 21:23:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] builtin/grep.c: add --sparse option
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
        <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
        <20220908001854.206789-2-shaoxuan.yuan02@gmail.com>
        <CABPp-BF-z72=hY_Jf8h3g95s+wwZOsV_S=+dDNs_AVskQxoaTw@mail.gmail.com>
        <xmqqh719pcoo.fsf@gitster.g>
        <CABPp-BEOVGfgmAMGCjP6Q3k-t=C1tL=f27buhiCiL-Wv0eDF_A@mail.gmail.com>
        <cafcedba-96a2-cb85-d593-ef47c8c8397c@github.com>
Date:   Sun, 18 Sep 2022 18:23:14 -0700
In-Reply-To: <cafcedba-96a2-cb85-d593-ef47c8c8397c@github.com> (Victoria Dye's
        message of "Sun, 18 Sep 2022 12:52:38 -0700")
Message-ID: <xmqq8rmgdunx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2B4382C-37B9-11ED-AEBD-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Elijah Newren wrote:
> ...
>> However, for modification commands, I think we want the default to be
>> --restrict, regardless of the default for querying commands.  There
>> are some potentially very negative surprises for users if we don't,
>> and those surprises will be delayed rather than occur at the time the
>> user runs the command.  In fact, those negative surprises are likely
>> why those commands were the first to gain an option controlling
>> whether they operated on paths outside the sparsity specification.
>> (Also, the modification commands print a warning if they could have
>> affected other files but didn't due the the default of restricting, so
>> I think we have their default correct, even if the flag name is
>> suboptimal.)
>
> One of the things I've found myself a bit frustrated with while working on
> these sparse index integrations is that we haven't had a clear set of
> guidelines for times when we need to make UI/UX changes relating to
> 'sparse-checkout' compatibility. I think what you've outlined here is a good
> start to a larger discussion on the topic, but in the middle of this series
> might not be the best place for that discussion (at least in terms of
> preserving for later reference). 

Yup, I think we were a bit too quick to add the "hide outside sparse
cones" feature without first coming up with a reasonable guideline
that is designed to keep things consistent.

It might have been nice if we did this "make X sparse checkout
aware" effort in two separate steps.  The first step will not change
any behaviour, i.e. no optional or default "hide outside sparse
cones" at all, just "we do not upfront expand the index fully;
instead as we discover we need to inspect the contents in a
subdirectory that is compacted to a tree in the index, we lazily
expand it" as performance optimization.  And once we made sure we
taught all commands that used to expand the index fully upfront not
to do so, we do the "guideline" design for UI to "hide outside
sparse cones", and add that feature to the commands in the second
step.

Unfortunately we all get excited too much when we find a new shiny
toy, and we ended up getting ahead of ourselves before designing a
consistent end user experience.  But better late than never ;-)

> As for this series, I think the best way to move the sparse index work along
> is to drop this patch ("builtin/grep.c: add --sparse option") altogether.

Does that roughly correspond to the first step in my "It would have
been nice if we did these in two steps" above?  That would be a
sensible thing to do, as it would be less surprises to the users, I
hope.

Thanks.
