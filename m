Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9A3C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87AD560FC1
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhINRr1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:47:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53731 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhINRr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 13:47:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6444B147D53;
        Tue, 14 Sep 2021 13:46:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DTeJWpI/q/Ix9+xAR+p7bX/2cvi7RxHEiMkCHL
        Hb1Es=; b=vJyEtj4dSC5IEz4medbOe5RgTlV865srsA8LEdrWw1uztmnccD0TxZ
        hA7nyRsCO5nOKKsuDVsK2Bn1hurkWDfUJEAPhf/8XMaKKzW+LI4ItCzwhVd53SyI
        7aJ/azCcoYCYCwrXMliUwOpjMJde0wLbhw8yB3d01SVFxrvTrP56Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5CA43147D51;
        Tue, 14 Sep 2021 13:46:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D1FD4147D4F;
        Tue, 14 Sep 2021 13:46:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v1] git-clone.txt: add the --recursive option
References: <20210913185941.6247-1-alban.gruin@gmail.com>
        <CAPig+cR=HUDgFctXzcigZ062c=QWYfGWUPuT7scc-xU_w3NT1w@mail.gmail.com>
        <26422bc7-f1d4-4959-ce30-b26d8fe61888@gmail.com>
        <CAPig+cRGzmN6tH-5DmtnbW2cMHSSQ2RS_6d=B0xJ7QWKtG6yug@mail.gmail.com>
        <d02c7f3b-221d-fbab-827a-a950bf28856c@gmail.com>
Date:   Tue, 14 Sep 2021 10:46:05 -0700
In-Reply-To: <d02c7f3b-221d-fbab-827a-a950bf28856c@gmail.com> (Alban Gruin's
        message of "Tue, 14 Sep 2021 12:27:44 +0200")
Message-ID: <xmqqbl4v2gpu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A372CC28-1583-11EC-92ED-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> Junio did mention[0] that --recursive was no longer in the manual, but
> not that it was once hidden from the option list.

Please allow me to summarize the discussion so far.

We want our subcommands to take "--recurse-submodules=<arg>"
uniformly, while accepting any unique prefix, e.g. --recurs=<arg>,
as its short-hand.

For "git clone", we kept "--recurse=<it>" in the options[] table as
a HIDDEN entry as part of our deprecation plan.  This nicely hid the
deprecated "--recurse=<it>" from "git clone -h".

But it backfired because "git cmd --recur=<it>" was not a "unique
prefix" (as it matched both) and triggered a disambiguation error.
To solve it, we introduced OPT_ALIAS() to tell the machinery that
allows unique prefix that these two are the same thing.  As a side
effect, because the use of OPT_ALIAS() did not have HIDDEN bit, we
started showing the deprecated "--recurse" in "git clone -h" output.

Is that where we are?

I am wondering if it is just a matter of either

 * removing the "recursive" alias from the options table.  Because
   we accept unique prefix, --recurse=<arg> the user types will be
   taken as --recurse-submodules=<arg> anyway (until "git clone"
   learns another option --recurse-xyzzy=<arg>, at which time it
   will become ambiguous and error out, that is).

or

 * adding the PARSE_OPT_HIDDEN bit to the OPT_ALIAS() element for
   the deprecated "recurse" option.

and all would be fine?

Between adding "--recursive" to the manual and describing it as a
deprecated synonym for "--recurse-submodules", and not doing so, I
do not have a strong preference.

Thanks.

