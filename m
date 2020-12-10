Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C09BC4167B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 15:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 552F123CD4
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 15:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391278AbgLJOkN convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 10 Dec 2020 09:40:13 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35378 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387578AbgLJOkB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 09:40:01 -0500
Received: by mail-ed1-f67.google.com with SMTP id u19so5745816edx.2
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 06:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UcGR5tLNzyb6xRhJtNBWQMYbu/pj7DcEzY0Y/SAX6Gc=;
        b=C6KWFMfjhG4NDe4pfiyhW4EaKpX5IryMu83F0H6fMg/XEXYKmzjSwkRhgQiFfo7o1l
         0XL0pdZfA/oC2IhBIAbDI6crQNvdnIVM3mIHr0/fxNZoPVCJwgkMjFK+ZSzK52XD/kze
         tau5e/OeVDCbpvi+ChYh1++sbKX0Z4y3lk4pHs++xw8ozlam9FVMSeNIC5/VSJjDw3pC
         34R70QI0Of90RFkYVxebDmwfN+2CplV0wD3OWkbef1VpJZdkMYjTs469CAYFSv6HQtw6
         noTFVEWYVHYESbhgR+YvqMNzxE4CpO9NHe5Efjl8ylDJanJeoRqSYRZs9OvKxFrTy5u4
         hljA==
X-Gm-Message-State: AOAM530gyyirFpJDgYqfMQSZ46zMUzID00Moc4gl8cS3uizjmYryLL/b
        uwN62tiboMll6CHdxcfwQybWvNzVEPQPi6SOJ7k=
X-Google-Smtp-Source: ABdhPJydi6A8y+JgAmRxxqiLNeyI2cWDOerV9BNuf/GJdgmito2WqKOUgU+o8HGcWY9mUpI+FUAp4xxznUYgMgry6bA=
X-Received: by 2002:a05:6402:1592:: with SMTP id c18mr6977903edv.181.1607611159044;
 Thu, 10 Dec 2020 06:39:19 -0800 (PST)
MIME-Version: 1.0
References: <20201210125321.19456-1-avarab@gmail.com> <20201210125321.19456-2-avarab@gmail.com>
In-Reply-To: <20201210125321.19456-2-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 10 Dec 2020 09:39:07 -0500
Message-ID: <CAPig+cQpB3B+Ywc1aFd7QMrqVKy29VmNKJfzcFeSCYz=mwO0Hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] refs: warn on non-pseudoref looking .git/<file> refs
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 7:55 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> [...]
> Let's help the user in this case by doing a very loose check for
> whether the ref name looks like a pseudoref such as "HEAD" (i.e. only
> has upper case, dashes, underbars), and if not issue a warning:
> [...]
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> @@ -355,6 +355,17 @@ core.warnAmbiguousRefs::
> +core.warnNonPseudoRefs::
> +       If true, Git will warn you if the `<ref>` you passed
> +       unexpectedly resolves to a top-level ref stored in
> +       `.git/<file>` but doesn't look like a pseudoref such as
> +       `HEAD`, `MERGE_HEAD` etc. True by default.
> ++
> +These references are ignored by linkgit:for-each-ref[1], but resolved
> +by linkgit:git-show[1], linkgit:git-rev-parse[1] etc. So it can be
> +confusing to have e.g. an errant `.git/master` being confused with
> +`.git/refs/heads/master`.

Dscho has been submitting patches lately to eradicate the word
"master" from the project source.

> diff --git a/refs.c b/refs.c
> @@ -669,6 +676,19 @@ int expand_ref(struct repository *repo, const char *str, int len,
>                 if (r) {
> +                       if (warn_non_pseudo_refs &&
> +                           !starts_with(fullref.buf, "refs/") &&
> +                           !starts_with(r, "refs/") &&
> +                           !strchr(r, '/') &&
> +                           !is_any_pseudoref_syntax(r) &&
> +                           !warned_on_non_pseudo_ref++) {
> +                               /*
> +                                * TRANSLATORS: The 1st argument is
> +                                * e.g. "master", and the 2nd can be
> +                                * e.g. "master~10".
> +                                */
> +                               warning(_("matched ref name .git/%s doesn't look like a pseudoref"), r);

The TRANSLATORS comment talks about two arguments, but I see only one.

Does the "matched ref name" part add any value? I would find the
warning just as helpful without it:

    .git/blork doesn't look like a pseudoref

> diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
> @@ -374,4 +374,45 @@ test_expect_success 'branch -m can rename refs/heads/-dash' '
> +test_expect_success 'warn on non-pseudoref syntax refs in .git/' '
> +       test_when_finished "
> +               rm -f .git/mybranch &&
> +               rm -rf .git/a-dir &&
> +               rm -rf .git/MY-BRANCH_NAME &&
> +               rm -rf .git/MY-branch_NAME
> +       " &&

Nit: These could all be removed with a single `rm -rf`:

    rm -rf .git/mybranch .git/a-dir ...

> +       # We do not ignore lower-case
> +       cp expect .git/mybranch &&
> +       git rev-parse mybranch >hash 2>err &&
> +       test_cmp expect hash &&
> +       GIT_TEST_GETTEXT_POISON=false grep "like a pseudoref" err &&

What is the purpose of assigning GIT_TEST_GETTEXT_POISON here?

> +       git -c core.warnNonPseudoRefs=false rev-parse mybranch >hash 2>err &&
> +       test_cmp expect hash &&
> +       test_must_be_empty err &&
> +       rm .git/mybranch
> +'
