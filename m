Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9673C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 17:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbiFURfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 13:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiFURfR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 13:35:17 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C542101DC
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 10:35:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5AD4C192671;
        Tue, 21 Jun 2022 13:35:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Kod9+v4al5GrWD5dI8bZucCJXlMjndUKi/+lUrYZF6A=; b=ya/A
        0AqtpIUsZcCb3JGr4ORXCpYqse8bxCm6KrSLixH4tazWhFTFGffmSlOiRNZT92rr
        tKRd6KONmLqolqgWHC5WBNEjl2of8RTo7ShTXrY0c7GGmukNrfysNePqwg7pw3/6
        KL14ksNZVvF8vBAXPKNrM+EpeuwfeaIKqYRghtE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 536E519266F;
        Tue, 21 Jun 2022 13:35:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E049119266C;
        Tue, 21 Jun 2022 13:35:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brad Forschinger <bnjf@bnjf.id.au>,
        Brad Forschinger via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-prompt: use builtin test
References: <pull.1260.git.1655197751403.gitgitgadget@gmail.com>
        <YquwpxEoAVWen8tZ@coredump.intra.peff.net>
        <Yq57MP47M5fAzkFC@bnjf.id.au>
        <YrFrsZj8w0i6PPiz@coredump.intra.peff.net>
Date:   Tue, 21 Jun 2022 10:35:10 -0700
Message-ID: <xmqqmte5hqcx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80BCCBFC-F188-11EC-B3FA-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> That's possible, but I suspect the burden is minimal.  As you said, this
>> is bash and zsh specific, and for those shell coders who only write
>> Bourne dialect it's to be read as a "strong" left square bracket.  For
>> example, to minimize any shock to the eyeballs I've intentionally not
>> re-written string operations `[ a = b ] && [ c = d ]` to `[[ a == b && c
>> == d ]]`.  I promise it wasn't mere laziness!
>
> I guess my concern was less about doing it once, and more about: is this
> something we want to continue enforcing as time goes on? That is, would
> we want to catch it in review and complain about people using "test"?

Yes, if this is just a mental exercise burning off excess calories
and too much spare time and nothing else, I'm hesitant to burden our
reviewers and casual contributors, who do not have excess calories
or too much spare time to burn off just to play nice with the result
of this patch, with an issue that is apparently only theoretical
like this one, with which nobody actually is hurt in practice.

It's not like local variables used in prompt and completion leaking
out, which can hurt real users (as it is quite normal to use throw
away variables in your interactive sessions).  It's not even like
these scripts being "set -u" clean, that may hurt those who use "set
-u" in their interactive sessions (what for?) but nobody else.  

If you write your own shell function "test" that is grossly
incompatible with everybody else's "test", where do you do that?
Not in your .bashrc, or you would break more than just prompt and
completion.

If this came with additions to t9903 that redefines "test" and tries
to make sure we consistently use bashism [[...]] and such a change
to "test" would not break it, I might have been more sympathetic,
but I dunno.  I sort-of like the purity of mind when we say "this is
a #!/bin/bash script and we maximally write in a way a bash-script
expert would", but many of our shell scripts outside these two
contrib/ scripts HAVE to be portable and free of bashisms, so...

> That's a subtle thing to remember to look for, though I guess we could
> automate it via the tests. Or would we rely on people who cared to
> notice new instances and submit patches? That's how we deal with some
> other portability issues (if nobody is screaming, how broken could it
> be?). But it sounds from your description like this was a one-off even
> for you.
>
> So I dunno. I'm not really opposed, but I'm not convinced it's really
> accomplishing much here.

I guess I am mostly on the same page here.

Thanks.
