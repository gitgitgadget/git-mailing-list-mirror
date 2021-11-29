Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F85EC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhK2X1Q convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 29 Nov 2021 18:27:16 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:43557 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhK2X1M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:27:12 -0500
Received: by mail-pg1-f169.google.com with SMTP id q16so17667329pgq.10
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 15:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2LStq+UYIfzjjBXOFtuAjuggIcNGIJMKlYqUP+kNSoI=;
        b=jGEPNNYveBmR8eHSDtEa+n5CPKwDY/HzO42eYRaPhPXmJaTdUbURD/VFFerKWM1OTS
         Jzpwagx2c8J6HGK/PueKzHJa+6ec+d14kwMft5DVt4uf8bmkQAczGfYHLnsOsSAAtcy7
         Xj0u8Hiz7Q++rF6N5saaqWktYKDiSOlTnGNfPS3If7T2Z/AelJkSsdJYqV24cEIMZOMo
         qk9s027rs1HH68J8ZWfo3rpLury5HE5m0roUHJL59HuzzvxJrn52nk0lPnlAvsDLE0Rv
         Vo9WfRqprfdt1jNkXn0lvAC+eC70z9atF9PIyOErfNotyL3gYNqvSFKZU+gksbWrWb3N
         8O8w==
X-Gm-Message-State: AOAM533c4/7OIZBVrUr5Y4fOxGbUF2Xtuyjolbw08JvUrb23pFFEDOfS
        2fVcibhzlDtFyYBYBEO5oJA0zfrI3AZOntD9wds=
X-Google-Smtp-Source: ABdhPJwDMJMqxFF0+M2Om21NeGvbnY7Xss1O51DtA6odDN+rMnrurRuNXcNKo5nWisQ4z222ipRtdX7vFJ/ZwnIKxtM=
X-Received: by 2002:a05:6a00:2349:b0:4a8:d87:e8ad with SMTP id
 j9-20020a056a00234900b004a80d87e8admr22031834pfj.15.1638228234100; Mon, 29
 Nov 2021 15:23:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.1085.git.1638193666.gitgitgadget@gmail.com> <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 29 Nov 2021 18:23:43 -0500
Message-ID: <CAPig+cQ-WsuLLfUiseEithhGXWRgS=nB95BNe+k8iSPCCxJ2xw@mail.gmail.com>
Subject: Re: [PATCH] test-lib.sh: have all tests pass under "-x", remove BASH_XTRACEFD
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 5:20 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Change the "t1510-repo-setup.sh" test to use a new
> "test_must_be_empty_trace" wrapper, instead of turning on
> "test_untraceable=UnfortunatelyYes".
>
> The only reason the test was incompatible with "-x" was because of
> these "test_must_be_empty" checks, which we can instead instead skip
> if we're running under "set -x".

s/instead instead/instead/

> Skipping the tests is preferable to not having the "-x" output at all,
> as it's much easier to debug the test. The result loss of test
> coverage is minimal. If someone is adjusting a "test_must_be_empty"
> test a failure might go away under "-x", but the new "say" we emit
> here should highlight that appropriately.
>
> Since the only user of "test_untraceable" is gone, we can remove that,
> not only isn't it used now, but I think the rationale for using it in
> the future no longer applies.
>
> We'll be better off by using a simple wrapper like the new
> "test_must_be_empty_trace". See 58275069288 (t1510-repo-setup: mark as
> untraceable with '-x', 2018-02-24) and 5fc98e79fc0 (t: add means to
> disable '-x' tracing for individual test scripts, 2018-02-24) for the
> addition of "test_untraceable".
>
> Once that's been removed we can dig deeper and see that we only have
> "BASH_XTRACEFD" due to an earlier attempt to work around the same
> issue. See d88785e424a (test-lib: set BASH_XTRACEFD automatically,
> 2016-05-11) and the 90c8a1db9d6 (test-lib: silence "-x" cleanup under
> bash, 2017-12-08) follow-up.
>
> I.e. we had redirection in "test_eval_" to get more relevant trace
> output under bash, which in turn was only needed because
> BASH_XTRACEFD=1 was set, which in turn was trying to work around test
> failures under "set -x".
>
> It's better if our test suite works the same way on all shells, rather
> than getting a passing run under "bash", only to have it fail with
> "-x" under say "dash". As the deleted code shows this is much simpler
> to implement across our supported POSIX shells.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
