Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868D6C71134
	for <git@archiver.kernel.org>; Fri, 25 Aug 2023 17:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbjHYRVt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Aug 2023 13:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbjHYRVm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2023 13:21:42 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE300211B
        for <git@vger.kernel.org>; Fri, 25 Aug 2023 10:21:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88B0B19BE1D;
        Fri, 25 Aug 2023 13:21:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0N1Te4gpnKH4PpM9cDWBLWs/KzLM22O3HtC5nd
        G4Sn4=; b=gkRW/vs14H754tnaY1kUoDc57TezBsFHVFulCLKntiZbCIlV9NT0RZ
        6nZ+dNw03ih78zWj3Ho8wcg9X2eil1VZeuxxB8YFLj3MHPJeK7h1jcbyMJ6Iui3k
        cHE4wdRcBA73VK3vf+spwjM2P6lMxLxKSWedcBM5lOADo7CiDh3CU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8151A19BE1C;
        Fri, 25 Aug 2023 13:21:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EDB7E19BE1B;
        Fri, 25 Aug 2023 13:21:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Alexei Podtelezhnikov <apodtele@gmail.com>, git@vger.kernel.org
Subject: Re: confused git diff -G
References: <CAJU=AjWatV6A5Vx-yqRfG=yeUWxMvKocc4nTsdq58WHjaYFEzw@mail.gmail.com>
        <ZOfgKQfqvef9FXZ6@nand.local>
Date:   Fri, 25 Aug 2023 10:21:34 -0700
In-Reply-To: <ZOfgKQfqvef9FXZ6@nand.local> (Taylor Blau's message of "Thu, 24
        Aug 2023 18:56:41 -0400")
Message-ID: <xmqqfs479gwx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8060564-436B-11EE-8E49-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Then you can see `-G` has the effect of limiting the output of 'git
> diff' to just those file(s) whose diff matches the regular expression
> given to `-G`, like so:
>
>     $ git -C repo diff --stat HEAD^
>      a | 1 +
>      b | 1 +
>      2 files changed, 2 insertions(+)
>     $ git -C repo diff --stat HEAD^ -G a
>      a | 1 +
>      1 file changed, 1 insertion(+)
>     $ git -C repo diff --stat HEAD^ -G b
>      b | 1 +
>      1 file changed, 1 insertion(+)

All true.

As this feature is primarily designed to help "git log" to choose
which commit to show and which commit to omit in its output, readers
would not appreciate the usefulness of the feature, when shown in
the context of "git diff".

Even more puzzling is how the "--full-diff" option works in
combination with "-G" or "-S" (or --diff-filter=... for that
matter)..

They make perfect sense as ingredients of a mechanism to choose
which commit to show in the context of "git log", but their value is
not immediately apparent in the context of "git diff".  Continuing
with your example [*1*], comparing what these two do would be
illuminating:

    $ git -C repo diff --full-diff --stat -G b HEAD^
    $ git -C repo diff --full-diff --stat -G c HEAD^

The former should show changes to both a and b, and the latter
should show nothing.

While the way how each of these behaves makes perfect sense at the
logical level, it would be very puzzling why anybody may even want
to use such a feature in the first place.  Until you realize that
comparing the previous commit and the current state (which happens
to be identical to the current commit) is more or less a degenerated
form of running "log -n <n> HEAD" with <n> set to 1, that is.


[Footnote]

*1* By the way, as an experienced mentor, avoid giving a command
    line example that has dashed options after revs and paths.  It
    may happen to do what you intended, but is confusing to readers.
