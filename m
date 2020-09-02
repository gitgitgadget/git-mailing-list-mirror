Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509EEC43461
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 06:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38562207EA
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 06:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIBG5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:57:37 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:38126 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgIBG5a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 02:57:30 -0400
Received: by mail-ej1-f65.google.com with SMTP id i22so5095944eja.5
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 23:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jNnFrpTOg1R+XX6ZReouJlSWveFt1ExuVD7NwU35c5M=;
        b=fUIyaW4UovRUFZ081KdYWsD/+n578lAHVHfCqLTpf0EzQ+wyErO17lHaW3Y2FIY2ij
         mHMdbgVN6OSsVTtpkfqfZguZSuld6KQhf+SR5y5rv4RCKfSUWUfJgBEIS0qYYWo2rl06
         +fMlI1nGhN+mOloTcyvr5rQ8M3DDQYITYxxPgV9ugC20u6G4SzzpyNRqsd7jhZWfP1p1
         BYtKIOjc1F7ryYwwJap3iGr6xU6PzCJYwVFbwxSfizkQ6u68Sm1PIauUidcoL/8Ne7+7
         s7HDQliA9ZMrJV5n4xct94yWQ9rbymk94ddtdYGJeQRGGoUfTQiF2DywTMDZtzrE2GYr
         +lbQ==
X-Gm-Message-State: AOAM5327bJDfJaQk/xgRe/tikFfoTouqcRM7lscSCh9rf3g0tZXwcnt/
        0vqT9bMtgq560pX8AUhJQ0fHTGfsFHJ+yogB4b0=
X-Google-Smtp-Source: ABdhPJzFctSaARiCDYEk2ll213QuXD4/MrCjd0eVMOW8AJOwAlU/SbvspiqRs1aEBiXJQApeFUNvC7TbCo06LA+uOa4=
X-Received: by 2002:a17:906:4f11:: with SMTP id t17mr5179569eju.371.1599029848531;
 Tue, 01 Sep 2020 23:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599026986.git.matheus.bernardino@usp.br> <f53782f14c5f53da5d5537b369a810a94f9ce184.1599026986.git.matheus.bernardino@usp.br>
In-Reply-To: <f53782f14c5f53da5d5537b369a810a94f9ce184.1599026986.git.matheus.bernardino@usp.br>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 2 Sep 2020 02:57:17 -0400
Message-ID: <CAPig+cSLjMabeLgkg9N7+ZJ1jotbpJx0FAnjkpNSt0Lf+Q0wNQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] t1308-config-set: avoid false positives when using test-config
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 2, 2020 at 2:18 AM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
> One test in t1308 expects test-config to fail with exit code 128 due to
> a parsing error in the config machinery. But test-config might also exit
> with 128 for any other reason that leads it to call die(). Therefore the
> test can potentially succeed for the wrong reason. To avoid false
> positives, let's check test-config's output, in addition to the exit
> code, and make sure that the cause of the error is the one we expect in
> this test.
>
> Moreover, the test was using the auxiliary function check_config which
> optionally takes a string to compare the test-config stdout against.
> Because this string is optional, there is a risk that future callers may
> also check only the exit code and not the output. To avoid that, make
> the string parameter of this function mandatory.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> @@ -14,10 +14,7 @@ check_config () {
>                 expect_code=0
>         fi &&
>         op=$1 key=$2 && shift && shift &&
> -       if test $# != 0
> -       then
> -               printf "%s\n" "$@"
> -       fi >expect &&
> +       printf "%s\n" "$@" >expect &&

This change in behavior is quite subtle. With the original code,
"expect" will be entirely empty if no argument is provided, whereas
with the revised code, "expect" will contain a single newline. This
could be improved by making the argument genuinely mandatory as stated
in the commit message. Perhaps something like this:

    if test $# -eq 0
    then
        BUG "check_config 'value' argument missing"
    fi &&
    printf "%s\n" "$@" >expect &&

> @@ -130,7 +127,8 @@ test_expect_success 'check line error when NULL string is queried' '
>  test_expect_success 'find integer if value is non parse-able' '
> -       check_config expect_code 128 get_int lamb.head
> +       test_expect_code 128 test-tool config get_int lamb.head 2>result &&
> +       test_i18ngrep "fatal: bad numeric config value '\'none\'' for '\'lamb.head\''" result
>  '

The complex '\'quoting\'' magic leaves and re-enters the single-quote
context of the test body and makes it difficult to reason about. Since
this is a pattern argument to grep, a simpler alternative would be:

    test_i18ngrep "fatal: bad numeric config value .none. for
.lamb.head." result

Aside from that, do I understand correctly that all other callers
which expect a non-zero exit code will find the error message on
stdout, but this case will find it on stderr? That makes one wonder
if, rather than dropping use of check_config() here, instead
check_config() should be enhanced to accept an additional option, such
as 'stderr' which causes it to check stderr rather than stdout
(similar to how 'expect_code' allows the caller to override the
expected exit code). But perhaps that would be overengineered if this
case is not expected to come up again as more callers are added in the
future?
