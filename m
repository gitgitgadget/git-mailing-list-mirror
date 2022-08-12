Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E59C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 17:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiHLRVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 13:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiHLRVW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 13:21:22 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C85DA9241
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 10:21:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6154313B67D;
        Fri, 12 Aug 2022 13:21:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hebb3nKUjSc3NPqfw9j3qJ73FmK7x4qeo1ofmC
        BG458=; b=BX5izkBtA0kiFnepfKbdUIYuQO3Ab749dJJMOl/aqDc0wxg0c7rTzp
        MtJr1lHKGZrE55EMLkbXxUlo4MjC0L+VEaQcvGQQGP5iOEmdNOOJWHx+waiEtigW
        WGJME45UUiibaGU1X7vhVxOfIN2AHc0/zrg+n32+Liq17qhCDex78=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 56F8613B67B;
        Fri, 12 Aug 2022 13:21:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B455513B679;
        Fri, 12 Aug 2022 13:21:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] sequencer: do not translate reflog messages
References: <b8ab40b2b0e3e5d762b414329ad2f4552f935d28.1660318162.git.git@grubix.eu>
Date:   Fri, 12 Aug 2022 10:21:18 -0700
In-Reply-To: <b8ab40b2b0e3e5d762b414329ad2f4552f935d28.1660318162.git.git@grubix.eu>
        (Michael J. Gruber's message of "Fri, 12 Aug 2022 17:38:40 +0200")
Message-ID: <xmqq8rntcr8x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E332B5C-1A63-11ED-B68D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> Traditionally, reflog messages were never translated, in particular not
> on storage.

True, and it must (unfortunately) stay to be the way, because tools
(like @{-<n>} syntax) expect to be able to parse out what we write.

> Due to the switch of more parts of git to the sequencer, old changes in
> the sequencer code may lead to recent changes in git's behaviour. E.g.:
> c28cbc5ea6 ("sequencer: mark action_name() for translation", 2016-10-21)
> marked several uses of `action_name()` for translation. Recently, this
> lead to a partially translated reflog:
>
> `rebase: fast-forward` is translated (e.g. in de to `Rebase: Vorspulen`)
> whereas other reflog entries such as `rebase (pick):` remain
> untranslated as they should be.
>
> Change the relevant line in the sequencer so that this reflog entry
> remains untranslated, as well.

Good move, I would have to say X-<.

In the longer term, we need to transition to a new version of reflog
message, where "git reflog" output can (meaning: with an option) or
does (meaning: by default) show localized message, but the internal
machinery as well as scripts can ask to see an untranslated message.

We would need to teach the reflog machinery to understand a reflog
message specially formatted (e.g. with an unusual prefix like
"::v2::"), from which both untranslated and translated messages can
be parsed out or generated.  Codepaths that write reflog messages
may need to be adjusted to send both versions to the ref machinery.

Looking at recent reflog entries I happen to have in "git reflog
--format="%gs" HEAD@{now}"

    checkout: moving from 219fe53025fdf5c3fb79d289a36eb2cad3f38a04 to master
    checkout: moving from master to next^0
    commit (amend): fsmonitor: option to allow fsmonitor to run against network-mounted repos
    checkout: moving from d5eaf969c17c196268d9db7af50f6767ec3a3d0a to ed/fsmonitor-on-network-disk
    am: fsmonitor: option to allow fsmonitor to run against network-mounted repos
    merge @{-1}: Merge made by the 'ort' strategy.
    checkout: moving from ll/disk-usage-humanise to seen
    am: rev-list: support human-readable output for `--disk-usage`
    checkout: moving from master to ll/disk-usage-humanise

one relatively easy way to do so may be to store the printf-like
format string, possibly limiting to %s and nothing else, e.g.

    "checkout: moving from %s to %s"
    "am: %s"
    "merge %s: Merge made by the '%s' strategy"

together with the parameters to fill in these %s blanks, as a
N-tuple of strings, i.e.

    ("checkout: moving from %s to %s",
     "219fe53025fdf5c3fb79d289a36eb2cad3f38a04", "master")

and then serialize them into a single long string (with that special
prefix to allow us notice the format).

But I'll leave the details of how the new format can be made to
allow storing raw and translated messages.  The review thread of
this patch is not a good place or time to discuss it.

Thanks.
