Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A125EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 16:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjFUQIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 12:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFUQIh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 12:08:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27618E68
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 09:08:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A1488275BA;
        Wed, 21 Jun 2023 12:08:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1K8tLF79nX4WSfbYRxseskaxOSVQguByt47T7E
        DcLOg=; b=FHy0gOnVGvTrGCTQuxtdMEDU7HBla4YZuWFp3TohYfm0besodr0WPu
        TqvXYjLBYsCDZwm88b4mCvLJHgWmtlvshp6fJ8Ni+eb7l1rmy+tlxWaSUsV22JWU
        dFxysb2TjWZtrrWP4KWZH9gvOPQ6YZ6c4o7iE72He/BWmjKSRQR50=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 98E21275B9;
        Wed, 21 Jun 2023 12:08:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9DF63275B8;
        Wed, 21 Jun 2023 12:08:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Guido =?utf-8?Q?Mart=C3=ADnez?= via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Guido =?utf-8?Q?Mart=C3=ADnez?= <mtzguido@gmail.com>
Subject: Re: [PATCH] ls-files: add an --exclude-links option
References: <pull.1549.git.1687327684909.gitgitgadget@gmail.com>
        <20230621081754.GA803861@coredump.intra.peff.net>
Date:   Wed, 21 Jun 2023 09:08:21 -0700
In-Reply-To: <20230621081754.GA803861@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 21 Jun 2023 04:17:54 -0400")
Message-ID: <xmqqzg4siyru.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D88B9748-104D-11EE-9AA5-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> This option enables a straightforward implementation of a `git sed`:
>> 
>>     #!/bin/bash
>>     git ls-files --exclude-links -z | xargs -0 -P $(nproc) -- sed -i -e "$@"

Unrelated nit.  

I think -i -e above is iffy, as it does not distribute -e across
"$@" and your users may not always want to edit the files.  It is
better to leave them to the callers.

"sed" is also something the caller can easily pass from their
command line, for that matter ;-).  Passing the entire command
part run under xargs from the command line of the wrapper,

    $ git for-all-paths grep -e pattern

would also work just fine, for example.

> ... A mild application of perl works, though:
>
>   git ls-files -s -z |
>   perl -0ne 'print if s/^100(644|755).*?\t//' |
>   xargs -0 ...
>
> So I dunno. That is not exactly pretty, but if you were hiding it in a
> "git sed" alias or script, it's not so bad.

Yes, the above would be a perfectly reasonable implementation of
"git for-all-paths", especially if you do not hardcode anything in
the ... part and instead use something like xargs -0 "$@" there.

What is somewhat unsatisfactory is that we cannot pass pathspec to
the "ls-files" so that the command does not have to be for-all-paths
but can be usable as "git do-for-paths -c '<command>' <pathspec>".
