Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F3ACDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 22:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbjJKWht (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 18:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbjJKWhp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 18:37:45 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BB9E3
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 15:37:41 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AB761CDD4F;
        Wed, 11 Oct 2023 18:37:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=lwUqtTHYzKKxpy6qCdnKcRx0D4Vt7kgzL59hPi
        LxKTw=; b=gJzIpDvdtjJLzeuiTde8AIsGI2B6YkQfnnttjVWB2q8o6+Sd699WxD
        LtAqAFtbIn4EUrj8Lx6Fe2TQZoF5koaDagvN3QmVfOAiFcnDzsiRX1MNm79tWo6n
        CD3WKcAo60/ZfVUR+hZ0kF+tpJXa4jyTlNUJ9l6YzhXWMUy2MK57U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00B711CDD4E;
        Wed, 11 Oct 2023 18:37:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 649FE1CDD4B;
        Wed, 11 Oct 2023 18:37:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Strawbridge <michael.strawbridge@amd.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: move process_address_list earlier to avoid,
 uninitialized address error
In-Reply-To: <20231011221844.GB518221@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 11 Oct 2023 18:18:44 -0400")
References: <ZQ1eGzqfyoeeTBUq@debian.me>
        <20230924033625.GA1492190@coredump.intra.peff.net>
        <ZRE6q8dHPFRIQezX@debian.me>
        <20230925080010.GA1534025@coredump.intra.peff.net>
        <ZRGdvRQuj4zllGnm@pobox.com>
        <20230925161748.GA2149383@coredump.intra.peff.net>
        <ZSal-mQIZAUBaq6g@debian.me>
        <95b9e5d5-ab07-48a6-b972-af5348f653be@amd.com>
        <7e2c92ff-b42c-4b3f-a509-9d0785448262@amd.com>
        <xmqq1qe0lui2.fsf@gitster.g>
        <20231011221844.GB518221@coredump.intra.peff.net>
Date:   Wed, 11 Oct 2023 15:37:39 -0700
Message-ID: <xmqqzg0oiy4s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C91FECBE-6886-11EE-BB4F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Which of course implies that we're not (and cannot) validate what
> they're typing at this step, but I think that's OK because we feed it
> through extract_valid_address_or_die().

OK, let's queue it then.

> IOW, I think there are actually two distinct validation steps
> hidden here:
>
>   1. We want to validate that the patch files we were fed are OK.
>
>   2. We want to validate that the addresses, etc, fed by the user are
>      OK.
>
> And after Michael's original patch, we are accidentally hitting some of
> that validation code for (2) while doing (1).

> This is actually a weird split if you think about it. We are feeding to
> the validate hook in (1), so surely it would want to see the full set of
> inputs from the user, too? Which argues for pushing the "if ($validate)"
> down as you suggest. And then either:
>
>   a. We accept that the user experience is a little worse if validation
>      fails after the user typed.
>
>   b. We split (1) into "early" validation that just checks if the files
>      are OK, but doesn't call the hook. And then later on we do the full
>      validation.
>
> I don't have a strong opinion myself (I don't even use send-email
> myself, and if I did, I'd probably mostly be feeding it with "--to" etc
> on the command line, rather than interactively).

I am not affected, either, and do not have a strong opinion either
way.  As long as the end-user input is validated separately, it
would be OK, but if the end-user supplied validation hook cares
about what addresses the messages are going to be sent to, not
knowing the set of recipients mean the validation hook is not
getting the whole picture, which does smell bad.

On the other hand, I am not sure what is wrong with "after the user
typed", actually.  As you said, anybody sane would be using --to (or
an equivalent configuration variable in the repository) to send
their patches to the project address instead of typing, and to them
it is not a problem.  After getting the recipient address from the
end user, the validation may fail due to a wrong address, in which
case it is a good thing.  If the validation failed due to wrong
contents of the patch (perhaps it included a change to the file with
trade secret that appeared in the context lines), as long as the
reason why the validation hook rejected the patches is clear enough
(e.g., "it's the patches, not the recipients"), such "a rejection
after typing" would be only once per a patch series, so it does not
sound too bad, either.

But perhaps I am not seeing the reason why "fail after the user typed"
is so disliked and being unnecessarily unsympathetic.  I dunno.

