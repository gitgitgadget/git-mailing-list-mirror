Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5190BC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183DF64EAA
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBBCCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 21:02:23 -0500
Received: from mail-ej1-f41.google.com ([209.85.218.41]:37721 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhBBCCT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 21:02:19 -0500
Received: by mail-ej1-f41.google.com with SMTP id kg20so27503039ejc.4
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 18:02:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLLoJJtLtaIBudud5kvqAc57Qed5Mm/k6nSlxJz0OMI=;
        b=aEs2UnVEHzfmtSrk5pSzB4qrFTR7N3/aaJNrCYRIXkt7IK3eyxIjALwrnmIixDPBwy
         v31JDSWO+0HL15jco4LfgWvo0fvVzVa0rC8X0j580bSi5LCj1Ifl3d8F6P8K2spHEJpA
         eJdY5lI1siHK520j1XIKYGINtNe+dKBztiZT4gthFv7wUOMz/TS2GATsoYf7n21yIx/0
         gkw1sDHg0+410+5YoNehYzJNlJVnkc9J7ilFKP2OeSRX4APeDSbIIRz4bY3d6QP9/4uM
         px8sbfMJqBDatpJOkcjG6gd/MGWCAOo0TMCbNx9iZi9cUGdWd6WiDaonrhz3VuzahknP
         4esg==
X-Gm-Message-State: AOAM532LAVhJfBfWn7eRvUuc6ZxL2+ryuXMmSIh8s782z2PWJrdp7frz
        S0KWbbzgU7t3iugb9dgPJ8rQpuRM+OpsVWp9LNE=
X-Google-Smtp-Source: ABdhPJwhWILoLFyZObZwjcGPv7wMrdKgsvHwu8McXkmmBqbxSD6luV+E6Cvl+BZEV2Xra2J/H/Unxg/BCARy8yL7RnA=
X-Received: by 2002:a17:907:1b10:: with SMTP id mp16mr20440546ejc.482.1612231295922;
 Mon, 01 Feb 2021 18:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20210124170405.30583-1-charvi077@gmail.com> <20210129182050.26143-1-charvi077@gmail.com>
 <20210129182050.26143-8-charvi077@gmail.com>
In-Reply-To: <20210129182050.26143-8-charvi077@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 1 Feb 2021 21:01:24 -0500
Message-ID: <CAPig+cQO_uHurPn3N-k-UwBFgvx2x8Bx2Uy+=sQxhmj3E6rt7Q@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] t3437: test script for fixup [-C|-c] options in
 interactive rebase
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 1:25 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> @@ -51,6 +53,8 @@ set_fake_editor () {
>                 exec_*|x_*|break|b)
>                         echo "$line" | sed 's/_/ /g' >> "$1";;
> +               merge_*|fixup_*)
> +                       action=$(echo "$line" | sed 's/_/ /g');;

What is "merge_" doing here? It doesn't seem to be used by this patch.

The function comment above this code may also need to be updated to
reflect this change.

> diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
> @@ -0,0 +1,213 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2018 Phillip Wood

Did Phillip write this script? Is this patch based upon an old patch from him?

> +test_commit_message () {
> +       rev="$1" && # commit or tag we want to test
> +       file="$2" && # test against the content of a file
> +       git show --no-patch --pretty=format:%B "$rev" >actual-message &&
> +       if test "$2" = -m
> +       then
> +               str="$3" && # test against a string
> +               printf "%s\n" "$str" >tmp-expected-message &&
> +               file="tmp-expected-message"
> +       fi
> +       test_cmp "$file" actual-message
> +}

By embedding comments in the function itself explaining $1, $2, and
$3, anyone who adds tests to this script in the future is forced to
read the function implementation to understand how to call it. Adding
function documentation can remove that burden. For instance:

    # test_commit_message <rev> -m <msg>
    # test_commit_message <rev> <path>
    #    Verify that the commit message of <rev> matches
    #    <msg> or the content of <path>.
    test_commit_message ()  {
        ...
    }

The implementation of test_commit_message() is a bit hard to follow.
It might be simpler to write it more concisely and directly like this:

    git show --no-patch --pretty=format:%B "$1" >actual &&
    case "$2" in
    -m) echo "$3" >expect && test_cmp expect actual ;;
    *) test_cmp "$2" actual ;;
    esac

> +test_expect_success 'setup' '
> +       cat >message <<-EOF &&
> +               amend! B
> +               ${EMPTY}
> +               new subject
> +               ${EMPTY}
> +               new
> +               body
> +               EOF

Style nit: In Git test scripts, the here-doc body and EOF are indented
the same amount as the command which opened the here-doc:

    cat >message <<-EOF &&
    amend! B
    ...
    body
    EOF

Also, `$EMPTY` is perfectly fine; no need to write it as `${EMPTY}`.

> +       ORIG_AUTHOR_NAME="$GIT_AUTHOR_NAME" &&
> +       ORIG_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" &&
> +       GIT_AUTHOR_NAME="Amend Author" &&
> +       GIT_AUTHOR_EMAIL="amend@example.com" &&
> +       test_commit "$(cat message)" A A1 A1 &&
> +       test_commit A2 A &&
> +       test_commit A3 A &&
> +       GIT_AUTHOR_NAME="$ORIG_AUTHOR_NAME" &&
> +       GIT_AUTHOR_EMAIL="$ORIG_AUTHOR_EMAIL" &&

Are the timestamps of these commits meaningful in this context? If
not, another way to do this would be to assign the new author
name/email values in a subshell so that the values do not need to be
restored manually. For instance:

    (
        GIT_AUTHOR_NAME="Amend Author" &&
        GIT_AUTHOR_EMAIL="amend@example.com" &&
        test_commit "$(cat message)" A A1 A1 &&
        test_commit A2 A &&
        test_commit A3 A
    ) &&

It's a matter of taste whether or not that is preferable, though.

> +       echo B1 >B &&
> +       test_tick &&
> +       git commit --fixup=HEAD -a &&
> +       test_tick &&

Same question about whether the commit timestamps have any
significance in these tests. If not, then these test_tick() calls
mislead the reader into thinking that the timestamps are significant,
thus it would make sense to drop them.

> +test_expect_success 'simple fixup -C works' '
> +       test_when_finished "test_might_fail git rebase --abort" &&
> +       git checkout --detach A2 &&
> +       FAKE_LINES="1 fixup_-C 2" git rebase -i B &&

I see that you mirrored the implementation of FAKE_LINES handling of
"exec" here for "fixup", but the cases are quite different. The
argument to "exec" is arbitrary and can have any number of spaces
embedded in it, which conflicts with the meaning of spaces in
FAKE_LINES, which separate the individual commands in FAKE_LINES.
Consequently, "_" was chosen as a placeholder in "exec" to mean
"space".

However, "fixup" is a very different beast. Its arguments are not
arbitrary at all, so there isn't a good reason to mirror the choice of
"_" to represent a space, which leads to rather unsightly tokens such
as "fixup_-C". It would work just as well to use simpler tokens such
as "fixup-C" and "fixup-c", in which case t/lib-rebase.sh might parse
them like this (note that I also dropped `g` from the `sed` action):

    fixup-*)
        action=$(echo "$line" | sed 's/-/ -/');;

In fact, the recognized set of options following "fixup" is so small,
that you could even get by with simpler tokens "fixupC" and "fixupc":

    fixupC)
        action="fixup -C";;
    fixupc)
        actions="fixup -c";;

Though it's subjective whether or not "fixupC" and "fixupc" are nicer
than "fixup-C" and "fixup-c", respectively.

> +test_expect_success 'fixup -C removes amend! from message' '
> +       test_when_finished "test_might_fail git rebase --abort" &&
> +       git checkout --detach A1 &&
> +       FAKE_LINES="1 fixup_-C 2" git rebase -i A &&
> +       test_cmp_rev HEAD^ A &&
> +       test_cmp_rev HEAD^{tree} A1^{tree} &&
> +       test_commit_message HEAD expected-message &&
> +       get_author HEAD >actual-author &&
> +       test_cmp expected-author actual-author
> +'

This test seems out of place. I would expect to see it added in the
patch which adds "amend!" functionality.

Alternatively, if the intention really is to support "amend!" this
early in the series in [6/9], then the commit message of [6/9] should
talk about it.

> +test_expect_success 'fixup -C with conflicts gives correct message' '
> +       test_when_finished "test_might_fail git rebase --abort" &&

Is there a reason this isn't written as:

    test_when_finished "reset_rebase" &&

which is more common? Is there something non-obvious which makes
reset_rebase() inappropriate in these tests?

> +       git checkout --detach A1 &&
> +       test_must_fail env FAKE_LINES="1 fixup_-C 2" git rebase -i conflicts &&
> +       git checkout --theirs -- A &&
> +       git add A &&
> +       FAKE_COMMIT_AMEND=edited git rebase --continue &&
> +       test_cmp_rev HEAD^ conflicts &&
> +       test_cmp_rev HEAD^{tree} A1^{tree} &&
> +       test_write_lines "" edited >>expected-message &&

It feels clunky and fragile for this test to be changing
"expected-message" which was created in the "setup" test and used
unaltered up to this point. If the content of "expected-message" is
really going to change from test to test (as I see it changes again in
a later test), then it would be easier to reason about the behavior if
each test gives "expected-message" the precise content it should have
in that local context. As it is currently implemented, it's too
difficult to follow along and remember the value of "expected-message"
from test to test. It also makes it difficult to extend tests or add
new tests in between existing tests without negatively impacting other
tests. If each test sets up "expected-message" to the precise content
needed by the test, then both those problems go away.

> +test_expect_success 'multiple fixup -c opens editor once' '
> +       test_when_finished "test_might_fail git rebase --abort" &&
> +       git checkout --detach A3 &&
> +       base=$(git rev-parse HEAD~4) &&
> +       FAKE_COMMIT_MESSAGE="Modified-A3" \
> +               FAKE_LINES="1 fixup_-C 2 fixup_-c 3 fixup_-c 4" \
> +               EXPECT_HEADER_COUNT=4 \
> +               git rebase -i $base &&
> +       test_cmp_rev $base HEAD^ &&
> +       test 1 = $(git show | grep Modified-A3 | wc -l)
> +'

These days, we would phrase the last part of the test as:

    git show > raw &&
    grep Modified-A3 raw >out &&
    test_line_count = 1 out
