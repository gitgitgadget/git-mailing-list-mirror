Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C271C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 573EE60F4A
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbhIPVxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 17:53:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55746 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbhIPVxo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 17:53:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE7ECF05A0;
        Thu, 16 Sep 2021 17:52:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+kRPmPcO00lmceGSIpG68EbMQoUqD2xnxd9Hli
        LqJtM=; b=kyzRbLI020dvfndbKypb+Y44c6j6I2PD0x6Gu4s49byU2lez7sTFGy
        T6s2liiEye8MDdnx8wTL3i8sOCZgrbWVpwF7CdLVmfawJQBmyiOily+34Ke9sJTr
        UDqK16UHODW2QeXo+EN9yN5b2kJAZI9liQ0kDeC1j1o2FV0DyvTaQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B57AAF059F;
        Thu, 16 Sep 2021 17:52:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 38DB9F059D;
        Thu, 16 Sep 2021 17:52:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wesley Schwengle <wesley@schwengle.net>
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: Possible git bug
References: <c7949156-a7e5-085f-4779-82d0538a4d72@schwengle.net>
        <20210916124709.2824551-1-wesley@schwengle.net>
        <xmqqzgsctu10.fsf@gitster.g>
        <3b4270f9-6139-7007-301b-8a084f4336cf@schwengle.net>
Date:   Thu, 16 Sep 2021 14:52:21 -0700
In-Reply-To: <3b4270f9-6139-7007-301b-8a084f4336cf@schwengle.net> (Wesley
        Schwengle's message of "Thu, 16 Sep 2021 15:39:04 -0400")
Message-ID: <xmqqmtocrxwq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F15783A-1738-11EC-917D-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wesley Schwengle <wesley@schwengle.net> writes:

> I feel like it is a bad default, it caught me by surprise.

I tend to agree.  It seems that d44e7126 (pull: support rebased
upstream + fetch + pull --rebase, 2009-07-19) started it, probably
by mistake, which was partially corrected by ad8261d2 (rebase: use
reflog to find common base with upstream, 2013-12-09).

The thread that contains

  https://lore.kernel.org/git/xmqq7gbdzsvt.fsf@gitster.dls.corp.google.com/

seems to have resulted in the design of the current behaviour, where 
the discussion refers to an even older discussion thread:

https://lore.kernel.org/git/d8e9f102609ee4502f579cb4ce872e0a40756204.1381949622.git.john@keeping.me.uk/

	Side note: I am kind-of surprised that I contributed the
	core computation of the fork-point logic, even though I
	wasn't buying it is a good feature back then.

In any case, updating the documentation to refer to the configuraion
variable that tweaks the default for --fork-point would be a good
near-term thing to do, but in the longer term, I think it may make
sense to fix this "surprise" and transition the default over time,
i.e.

 (1) when "git rebase" is run without --[no-]fork-point from the
     command line, and without rebase.forkpoint configuration
     variable in effect, give a warning that says we'll change the
     default to 'false' and the users who want to can use the
     configuration variable to force it to 'true'.  Update the
     documentation to say the special casing of "If <upstream> is
     not specified, --fork-point option is assumed" will be changed
     in the future.

     Ship such a version of Git and wait for several development
     cycles.


 (2) flip the default and remove the warning.  Update the
     documentation.

> As for the patch. The reason why --fork-point is default I do not
> know, but how to disable it isn't documented and I think it should. It
> is hidden in the source code and the release notes of 2.31.0. It
> should be more visible. Which is the reason I submitted the patch.

Certainly.

"git config --help" is the only end-user facing place the reference
from the configuration variable to the command line option is found.
We should also have a backreference from the command line option to
the configuration variable.


