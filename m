Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE282C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 17:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354639AbiHSRgh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 13:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351084AbiHSRgP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 13:36:15 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B29162E2A
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:54:59 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 210EF138322;
        Fri, 19 Aug 2022 12:53:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qhYaq0MMafNzgcVua37Sq0M25O6iJ+ngxrc5mk
        Lcjmw=; b=eBxwOuXJmpaBiI3QzGq1gqfZ4mOuf3Omfk9A+utnx/1ilyMnZZRQ8h
        TEx+3BAhoPFpUIdUS/9we8LOuJim0AAhNKL+Ddv9SgHVMgVKYBhhKQorwvsIe45c
        TzfwrR3w06Qx5y1tf/j2pXM8obSI+ZrXpWbo7RfT8BrRMRyzXk5m8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17449138321;
        Fri, 19 Aug 2022 12:53:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 672E013831F;
        Fri, 19 Aug 2022 12:53:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
        entwicklung@pengutronix.de
Subject: Re: Bug in rebase --autosquash
References: <20220817094909.v2ev4rpsmxjnii4x@pengutronix.de>
        <8p78q4p9-9ro4-p5s4-r738-7sno17rqr414@tzk.qr>
Date:   Fri, 19 Aug 2022 09:53:46 -0700
In-Reply-To: <8p78q4p9-9ro4-p5s4-r738-7sno17rqr414@tzk.qr> (Johannes
        Schindelin's message of "Fri, 19 Aug 2022 13:09:00 +0200 (CEST)")
Message-ID: <xmqqpmgwmaxx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E3BFD1E-1FDF-11ED-8B89-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This demonstrates a somewhat obscure feature where the `fixup!` of a
> `fixup!` magically targets the original commit.
>
> I understand that it is somewhat unintuitive that `fixup! fixup! abc` does
> not target `fixup! abc` but instead `abc`, but that's how the tool has
> been behaving forever.

It certainly is handy when the original commit A has a fixup commit
B, which gets later fixed up by another commit C, resulting in a
sequence like this:

    $ git rebase -i A~1 C

    pick A original commit
    fixup B fixup! original commit
    fixup C fixup! fixup! original commit

But if the user for some reason finds it is not quite ready to touch
the original commit by squashing in the fixes, it may be reasonable
to want to squash the two fixes together, so that it can later be
applied to the original commit.  And it would be one natural way to
request that with

    $ git rebase -i A C

that is, leave the history up to A intact, but everything above
tweaked.  Without --autosquash, you would get

    pick B fixup! original commit
    pick C fixup! fixup! original commit

and you would manually do

    pick B fixup! original commit
    fixup C fixup! fixup! original commit

to squash B and C together into a single fix-up to be applied
later.  It does not look all too unreasonable to expect the
"--autosquash" feature to do that automatically for you.

Thanks.

    


