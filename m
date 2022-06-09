Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB61C43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 18:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbiFISYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 14:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiFISYB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 14:24:01 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C675015242C
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 11:24:00 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BCA79146E11;
        Thu,  9 Jun 2022 14:23:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=90Jnn/iSmWd3Pt98kU2+FnMEbhkqGIfn8LVY4E
        Rb31Y=; b=MMWVxHrET8Rbp1wcPC5pl8uHwF5dRB0foH9IugYxwNmuWc9qyxg3Ng
        w0qeubc+NIH6X+EDQqtRJbRApKLJl2oCVswmafzaReSWBBlZ4+Zee6LAKjgPW0mG
        pHzgo9JZgsw0zpR/W0jpxApZCQGj+EvVNKjYbq8PuT3dLhalABAVs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B409C146E10;
        Thu,  9 Jun 2022 14:23:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 269B6146E03;
        Thu,  9 Jun 2022 14:23:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, Tassilo Horn <tsdh@gnu.org>,
        Tao Klerks <tao@klerks.biz>, git@vger.kernel.org
Subject: Re: [BUG?] Major performance issue with some commands on our repo's
 master branch
References: <87h750q1b9.fsf@gnu.org>
        <CAPMMpohzqKo-+q-tOcXymmzGxuOY-mf2NPRviHURm8-+3MPjZg@mail.gmail.com>
        <87y1yb2xc8.fsf@gnu.org> <YqEyh5opAaJxph2+@coredump.intra.peff.net>
        <87sfoe7hio.fsf@kyleam.com> <YqILyX97zKg5ViUS@coredump.intra.peff.net>
Date:   Thu, 09 Jun 2022 11:23:58 -0700
In-Reply-To: <YqILyX97zKg5ViUS@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 9 Jun 2022 11:03:37 -0400")
Message-ID: <xmqqedzxlmpt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 548D0D64-E821-11EC-B3E1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   git show --diff-filter=D -s a6434bc6f7a1
>
> Without the patch above, it always shows the commit. With it, it shows
> nothing. That's a bit far-fetched, but it is a regression, and I'm also
> not sure if it's just the tip of the iceberg.

Here "-s" is merely "do not give patch output like we do by
default", so the behaviour is quite understandable and is not a
regression we would want to see happen.  -S/-G are also likely to be
affected, not just the --diff-filter.

> It also doesn't solve problem completely. Regular commits can have
> expensive diffs, too.

That's a good point.

> I think you'd do better to have a mode specific to git-show that skips
> the diff if we're not showing it, but makes sure to always show the
> commit anyway.

Meaning an explicit option "git show --log-only"?  We'd need to
careful to make it either (1) be incompatible with certain features
of "git show" (like giving a pathspec) and error out, or (2) ignore
these features of "git show" silently and document that.  But it
would work as a new option.

Thanks.
