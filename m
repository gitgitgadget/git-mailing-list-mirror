Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B0AECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 16:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiISQ7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 12:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiISQ63 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 12:58:29 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E0831DC1
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:58:28 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EBB8F1BEBC9;
        Mon, 19 Sep 2022 12:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rkkVKzSsz/yd4dBacKYJSOox1W9id6cnmzpUca
        uwyf4=; b=Pd+Jqfk/Mb7xhm7U+oWGpIYDaE9D3CYvUCtsxHyg6P2YphO6UHCvl1
        4tHTc7ftZqrMT8BpbELt5pKx0IXHFXxANFL5P9mWU7ymnv7xel09ZuLzeZdXc5/X
        s0Q8IwjOeCehgV7hzpJ0Y8mwLASx0wF95NxMXPb6I7oC9+oyPchOs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3E811BEBC8;
        Mon, 19 Sep 2022 12:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 59FD71BEBC7;
        Mon, 19 Sep 2022 12:58:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v8 2/5] fsmonitor: relocate socket file if .git
 directory is remote
References: <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
        <pull.1326.v8.git.1663377141.gitgitgadget@gmail.com>
        <b535649722826d7317061da7d8b0cf3d6e2a51ff.1663377141.git.gitgitgadget@gmail.com>
        <CAPig+cTRNfewL01GOVTjFLaFq-vGgdeV2OX6Bn+StGrgb1JVMA@mail.gmail.com>
Date:   Mon, 19 Sep 2022 09:58:23 -0700
In-Reply-To: <CAPig+cTRNfewL01GOVTjFLaFq-vGgdeV2OX6Bn+StGrgb1JVMA@mail.gmail.com>
        (Eric Sunshine's message of "Sat, 17 Sep 2022 02:29:44 -0400")
Message-ID: <xmqqsfknb8sw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 461D520A-383C-11ED-BB94-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> A couple comments...
>
> In my mind, the directory specified by `fsmonitor.socketdir` is likely
> to be dedicated to this purpose (i.e. housing Git administrative
> junk). As such, it feels somewhat odd for the socket file to be
> hidden; I would instead expect the socket name to be non-hidden (say,
> "git-fsmonitor-daemon-{hash}.ipc") rather than hidden
> (".git-fsmonitor-*"). The directory specified by `fsmonitor.socketdir`
> may or may not be hidden (i.e. start with a dot), but that's the
> user's decision. For the $HOME case, it almost feels cleaner to create
> a hidden directory (say, "$HOME/.git-fsmonitor") in which to house the
> socket files ("git-fsmonitor-daemon-{hash}.ipc"). Anyhow, this comment
> is quite subjective; perhaps not actionable.

Yeah, dot-prefixed files are appropriate if they are to be placed at
the top of some tree without the user having any say in how that
tree is chosen (e.g. the working tree or $HOME).  If the user has
the power to specify the location, the equation changes.

> What happens if either $HOME or `fsmonitor.socketdir` are
> network-mounted? Should this code be checking for that case? If they
> are network-mounted, should it error out? At minimum, I would think a
> warning is warranted in order to save users the headache of wondering
> why fsmonitor isn't working correctly.

That's a good point.  If one default position (e.g. repository) is
checked if it is usable and can be rejected if it isn't, the
fallback position should at least satisfy the same "is it usable?"
criteria.

Thanks.
