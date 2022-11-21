Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B000C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 18:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiKUSsG convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 21 Nov 2022 13:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiKUSr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 13:47:56 -0500
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DD212098
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 10:47:54 -0800 (PST)
Received: by mail-pl1-f171.google.com with SMTP id w23so11367874ply.12
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 10:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/p8rIr/YaMzTxM83CYW0pWHGUTCj47WgvM0VdCOH4dc=;
        b=MI1iLO23Mlc/KNOJ3sgsvx588NUnVljIJSMZ5lICpg+ss+pcGopoo+aaAmVIstS6wE
         JFumH/QDhj3mRLbM5mK42QpuC/6onH3o71z33pcOkQzmKsI06NpS8HMUgdK1UDCasc/8
         FHmT5uYMWENh5FA3ggstRWtfDGvBnyPiS1Z39j73hLp7YMoc6tcVUIN+4LKah8jj7p02
         A/ZTqeuJt/AJJCAZC4gbZealqAG8SoFNNpGn9u8j1LjQRHEHYZICik6CW7CrqBw6mJii
         deAD9XZQkrLSbeZlwk6E1FXhN5d1yIr5Vnw3P9tabOB8H+LPmlrlTrWQgNmUeJ/8M1xu
         DE3A==
X-Gm-Message-State: ANoB5pm7eLocBTwKd7QGgWIny5HexIccmryAXC8ts96xGhWRXlaCFEXh
        3PFmxwbrhfDidhC2qZePtjUYLJWV0cisHrV+JVs=
X-Google-Smtp-Source: AA0mqf7JHCOHsSmS8rshu8Va6S6rJ63wKXDpzWwfiQRVCKEbGxMPUWry3QPw/mECSAKAbYT1ugPf32VyZqV/FuNYB80=
X-Received: by 2002:a17:902:ef94:b0:186:aad0:6b32 with SMTP id
 iz20-20020a170902ef9400b00186aad06b32mr13260490plb.77.1669056473560; Mon, 21
 Nov 2022 10:47:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <62fc652eb47a4df83d88a197e376f28dbbab3b52.1661992197.git.gitgitgadget@gmail.com>
 <20220906223537.M956576@dcvr> <CAPig+cSx661-HEr3JcAD5MuYfgHviGQ1cSAftkgw6gj2FgTQVg@mail.gmail.com>
 <YxfXQ0IJjq/FT2Uh@coredump.intra.peff.net> <CAPig+cTge7kp9bH+Xd8wpqmEZuuEFE0xQdgqaFP1WAQ-F+xyHA@mail.gmail.com>
 <Y3u9ul1cu+L5d5IZ@coredump.intra.peff.net>
In-Reply-To: <Y3u9ul1cu+L5d5IZ@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 21 Nov 2022 13:47:42 -0500
Message-ID: <CAPig+cQfkkY2Eh=QD47QoUGuAiCEpxSsX24x_8ts2GTKVnV1aw@mail.gmail.com>
Subject: Re: [PATCH 06/18] chainlint.pl: validate test scripts in parallel
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 1:04 PM Jeff King <peff@peff.net> wrote:
> On Sun, Nov 20, 2022 at 11:02:54PM -0500, Eric Sunshine wrote:
> > Overall, I think Ævar's plan to parallelize linting via "make" is
> > probably the way to go.
>
> TBH, I think just running the linter once per test script when the
> script is run would be sufficient. That is one extra process per script,
> but they are already shell scripts running a bunch of processes. You get
> parallelism for free because you're already running the tests in
> parallel. You lose out on "don't bother linting because the file hasn't
> changed", but I'm not sure that's really worth the extra complexity
> overall.

Hmm, yes, that's appealing (especially since I've essentially given up
on making linting fast on Windows), and it wouldn't be hard to
implement. In fact, it's already implemented by 23a14f3016 (test-lib:
replace chainlint.sed with chainlint.pl, 2022-09-01); making it work
the way you describe would just involve dropping 69b9924b87
(t/Makefile: teach `make test` and `make prove` to run chainlint.pl,
2022-09-01) and 29fb2ec384 (chainlint.pl: validate test scripts in
parallel, 2022-09-01).

I think Ævar's use-case for `make` parallelization was to speed up
git-bisect runs. But thinking about it now, the likelihood of "lint"
problems cropping up during a git-bisect run is effectively nil, in
which case setting GIT_TEST_CHAIN_LINT=1 should be a perfectly
appropriate way to take linting out of the equation when bisecting.
