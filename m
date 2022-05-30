Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923A3C433EF
	for <git@archiver.kernel.org>; Mon, 30 May 2022 00:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiE3AQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 May 2022 20:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiE3AQY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 May 2022 20:16:24 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA4430F42
        for <git@vger.kernel.org>; Sun, 29 May 2022 17:16:22 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A567719822B;
        Sun, 29 May 2022 20:16:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gdxla7oKBgOiLEtCSkNSSPguRFt3NEJ1hipiTb
        ntNNQ=; b=Bjm1uVSZYTzJu7hN/UiE/bnJzo9KyDbTy7s/J/CBy1Bd4MU5s6UEut
        8kv8sO+8rAOEJ21UGEYaXsSoqyxqqnBXlQit8l1JjMBkJFkxJXqvqDmn6YHaHMpZ
        XaiYZJkrdDR/Yc3hqDkDqRAyc95N5KY4/guh5K+yBEG1KgRHM37og=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C07A19822A;
        Sun, 29 May 2022 20:16:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 416A8198227;
        Sun, 29 May 2022 20:16:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] urlmatch: create fetch.credentialsInUrl config
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
        <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
Date:   Sun, 29 May 2022 17:16:17 -0700
In-Reply-To: <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Fri, 27 May 2022 13:27:13
        +0000")
Message-ID: <xmqqilpnyiwe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9E68E64-DFAD-11EC-9518-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Create a new "fetch.credentialsInUrl" config option and teach Git to
> warn or die when seeing a URL with this kind of information. The warning
> anonymizes the sensitive information of the URL to be clear about the
> issue.
>
> This change currently defaults the behavior to "allow" which does
> nothing with these URLs. We can consider changing this behavior to
> "warn" by default if we wish. At that time, we may want to add some
> advice about setting fetch.credentialsInUrl=ignore for users who still
> want to follow this pattern (and not receive the warning).

Can we make this die in a bit more controlled way?

e.g. https://github.com/git/git/runs/6646450422 seems to show that
depending on the timing, the call to die() on the "git clone" side
may cause us stop reading early enough to kill the other side with
SIGPIPE.  The nicely prepared warning message seems to be lost.


