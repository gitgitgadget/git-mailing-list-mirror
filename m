Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF89C433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 18:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384838AbiBHSY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 13:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384833AbiBHSYy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 13:24:54 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63CDC061578
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 10:24:53 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 412E016B2D1;
        Tue,  8 Feb 2022 13:24:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=egca7wBiGmtqUxSA1LIeOl4ZLGWsx5cOGp9GEM
        6BrIM=; b=nlQwqDiJAfQkTlwfeXHV8/whg1VS1VFrc0/4KwuSVSVA6dXRsr1esR
        djFK1OvkFFZdtC+X1vtmBe4mFAV4QgZc6MMsn7gjSDSPyJtS0vVBw/YHDRimEbP5
        ywJoSZwR4+xQqpRpkZbriO2qlbpQjpOrsCMzan6Bso/RFpk8CAKjU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 37D8216B2D0;
        Tue,  8 Feb 2022 13:24:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 97A3D16B2CB;
        Tue,  8 Feb 2022 13:24:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 0/5] teach submodules to know they're submodules
References: <20211117005701.371808-1-emilyshaffer@google.com>
        <20220203215914.683922-1-emilyshaffer@google.com>
        <220204.86pmo34d2m.gmgdl@evledraar.gmail.com>
        <YgF5V2Y0Btr8B4cd@google.com> <xmqqk0e6gt5j.fsf@gitster.g>
        <YgHE4iaV8QHRw64U@google.com>
Date:   Tue, 08 Feb 2022 10:24:49 -0800
In-Reply-To: <YgHE4iaV8QHRw64U@google.com> (Jonathan Nieder's message of "Mon,
        7 Feb 2022 17:18:26 -0800")
Message-ID: <xmqqy22lcj2m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 673E38A8-890C-11EC-9006-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> My point with this example is that it's useful to have a definition of
> what is a submodule repository, to make it unambiguous whether this
> repository is a submodule or whether it's just a repository that
> happens to have been cloned inside of a git-managed worktree.

OK, together with the other "no need to let NFS automounter worry
about parent directories", it makes a very successful argument for a
single bit (i.e. this is a free-standing repository and is not a
submodule, so no need to auto-discover if it is one).  I think the
"Alternatively" you later mention to solve ambiguity with just a
single bit, without "this is a submodule of that superproject"
linkage, is essentially the same?

But I do not think it argues for the need to say "a config, not
filesystem layout, must be the single source of truth to say which
superproject this repository belongs as its submodule".

> This would be the first time in git history that we are saying a
> property of a repository depends on having to examine files outside of
> it.

Well, path-based configuration inclusion, with configuration driven
hooks, I do not think the distinction matters much anymore in these
days.

> I guess the main question I'd have is, why _wouldn't_ I want a
> submodule to be able to point to the superproject containing it?

Because with (the absense of) a single "this is freestanding" bit, 
by default the filesystem layout can already "point" at it?
