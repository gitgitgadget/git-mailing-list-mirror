Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9268720248
	for <e@80x24.org>; Mon, 25 Mar 2019 21:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbfCYVXi convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 25 Mar 2019 17:23:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36749 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbfCYVXi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 17:23:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so11945293wrd.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 14:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yyrCPyobO7JvdDR1nsfOc8PvZWJFvJekaLwZI7wrkrM=;
        b=II+GT5x9eoEjtin0FqqPc1jiKJS8HSc5pLjfwZcZ+373KlHlCSduQQdpRSeKetC+X0
         IFLdcaM5G369bu6hXbx7E9rXKEeX6bcHtPfQrtf4wPqC2hrRItRskrYTwO7mm8ytpRNu
         3nK0jxG4HvGDvbxJF+Wa3wtUWDTHpBVvuWz/vKorbwIEk350C87dJA+AR5kN6TlNQAIQ
         XTvzPwT5iUGlUcOZGZcp1avS6OvRB2yf7DPhPbIKBITT7hmeGgkBdvWrRoWAP8wrckPf
         lBtxjzLoZLEiiHjiRzMjl6Mz2Y4vpx7pgnBkRbBV6q4WrwYmat5S5oPtPVXy78u7C1HV
         waRA==
X-Gm-Message-State: APjAAAWtCI78uwhsN0e40JJ2VCKKaxHOwamGqXM1dSQMZPyuYdEHQEcl
        blLfJ3oRE5/Y3i7LME2PzVYziVvpAAUNGEWB7kI=
X-Google-Smtp-Source: APXvYqxjXBWngawZwDhF7kH/Jlf+xIglSN2BSt+WVR7uP1ZwGuLRQFm32RkEMw2KDvTVs8C5H3JcdUHj6FRuBl7PjEg=
X-Received: by 2002:adf:ed8a:: with SMTP id c10mr132745wro.40.1553549016211;
 Mon, 25 Mar 2019 14:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.167.git.gitgitgadget@gmail.com> <20190325202329.26033-2-avarab@gmail.com>
In-Reply-To: <20190325202329.26033-2-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 25 Mar 2019 17:23:25 -0400
Message-ID: <CAPig+cR0Ldt3EpQ683ZFNFXggfsTrdeZ3R-V6pDBZNA1N3c+xg@mail.gmail.com>
Subject: Re: [PATCH 1/2] parse-options: allow for configuring option abbreviation
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 4:23 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> @@ -1,3 +1,15 @@
> +core.abbreviatedOptions::
> +       Defaults to `true` which allows options to be abbreviated as
> +       long as they aren't ambiguous, e.g. for linkgit:git-init[1]
> +       the `--bare` option can be abbreviated as `--bar`, `--ba` or
> +       even `--b` since no other option starts with those
> +       prefixes. However, if such an option were added in the future
> +       any use of these abbreviations would break.
> ++
> +By setting this to false (e.g. in scripts) you can defend against such
> +future breakages by enforcing that options must always be fully
> +provided.

I don't get why having a configuration option is better for defending
scripts against this problem than a simple environment variable. It
seems easier for the script prologue to contain:

    GIT_TEST_ABBREVIATED_OPTIONS=false
    export GIT_TEST_ABBREVIATED_OPTIONS

than for it to muck about with git-config or use "git -c
core.abbreviatedOptions=false ..." everywhere. The commit message
doesn't do a good enough job of justifying the configuration option
over the environment variable.

Also, if this is now intended to be more general (aiding script
writers) than just being for our test suite, then dropping "TEST" from
the name seems warranted:

    GIT_ABBREVIATED_OPTIONS
