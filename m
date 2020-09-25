Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED35C4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED9920838
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgIYUdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 16:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgIYUUy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 16:20:54 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EC4C0613AF
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 12:41:56 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e23so203449eja.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 12:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kmt7WizBtO1fi5RQgj/qwqegBjfw337bt9ofhVIztUo=;
        b=bykJr1QwC6GjKuxCqVRgOWRirSO59RANmMHHkQQAnlMyEqHyDdOgQztU9IKYwlnnBC
         asWoAVjKAkwu6rxbGxKBSqfq5rWDT67aV9ukFyv8IcpqAD6bOVxDmInyksy3W8prLJ9h
         N4x98nLlBLHL3kKBwhhJC7omhjw445q3O7Yu70XjLw3B/BGWKOjcDujajk155efIC6DS
         NcaNn+TaEVZ/E3c57UCraKTdH2TaYQyZUi4/Z61d1VVg/Y2s5NjvisGw9E9I6vNICLL2
         PHQAROzIi9io7vGpnojFR46018oSFsOnDUnTVpVHpdeZy1gg21NWeA+zr/+feZad+ztU
         nTjg==
X-Gm-Message-State: AOAM5324frl9rNoOc7iKZ9dAwJaJ/XWS1p4E+RdS9LyjqVsqr2f/wyVC
        i9QjiOPj8wWXSRI+80NenlG4wco8ONUWT8kf5ERMqvmt1P0=
X-Google-Smtp-Source: ABdhPJw8dcH8pe0jyZAiQ6OlohHSRYJMjMI/UfZridM0ru68iqVkAzrrAPhR+h+/XVAI/ld1cqSZ9+0fIXh8SxhOlOY=
X-Received: by 2002:a17:906:c045:: with SMTP id bm5mr4116017ejb.311.1601062614443;
 Fri, 25 Sep 2020 12:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200925170256.11490-1-shubhunic@gmail.com> <20200925170256.11490-12-shubhunic@gmail.com>
In-Reply-To: <20200925170256.11490-12-shubhunic@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 25 Sep 2020 15:36:43 -0400
Message-ID: <CAPig+cS+Hp3c96LjBezvhDg0WuBeFvPNVH9_V0iviEkFWfvjEQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] t7001: move cleanup code from outside the tests
 into them
To:     shubham verma <shubhunic@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 1:03 PM shubham verma <shubhunic@gmail.com> wrote:
> Let's use test_when_finished() to include cleanup code inside the tests,
> as it's cleaner and safer to not have any code outside the tests.
>
> Signed-off-by: shubham verma <shubhunic@gmail.com>
> ---
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> @@ -32,6 +32,7 @@ test_expect_success 'commiting the change' '
>  test_expect_success 'checking the commit' '
> +       test_when_finished "rmdir path1" &&
>         git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
>         grep "^R100..*path1/COPYING..*path0/COPYING" actual
>  '

This one doesn't really pass the smell test. `path1` was created by
the "prepare reference tree" test; it is not created by this test, so
it's not really this test's responsibility to clean it up. But it also
can't be cleaned up by "prepare reference tree" since that is just a
"setup" test, and `path` is used by subsequent tests.

Does anything actually fail if directory `path1` is not removed? I ask
because slightly below the point at which `path1` is removed (outside
of any tests) a different test goes ahead and re-creates `path1`. If
it turns out that removal of `path1` isn't actually necessary, then a
better option might be simply to drop the global `rmdir path1`
altogether, along with the subsequent `mkdir path1` which comes a bit
later.

> @@ -43,6 +44,7 @@ test_expect_success 'mv --dry-run does not move file' '
>  test_expect_success 'checking -k on non-existing file' '
> +       test_when_finished "rm -f idontexist path0/idontexist" &&
>         git mv -k idontexist path0
>  '

The paths being removed here shouldn't actually be created by this
test, but if Git is somehow buggy and they do get created, then this
is the appropriate place to clean them up. Good.

> @@ -55,6 +57,7 @@ test_expect_success 'checking -k on untracked file' '
>  test_expect_success 'checking -k on multiple untracked files' '
>         : > untracked2 &&
> +       test_when_finished "rm -f untracked2 path0/untracked2" &&
>         git mv -k untracked1 untracked2 path0 &&
>         test -f untracked1 &&
>         test -f untracked2 &&
> @@ -64,18 +67,14 @@ test_expect_success 'checking -k on multiple untracked files' '
>  test_expect_success 'checking -f on untracked file with existing target' '
>         : > path0/untracked1 &&
> +       test_when_finished "rm -f untracked1 path0/untracked1" &&
> +       test_when_finished "rm -f .git/index.lock" &&
>         test_must_fail git mv -f untracked1 path0 &&
>         test ! -f .git/index.lock &&
>         test -f untracked1 &&
>         test -f path0/untracked1
>  '

This is a big ugly. `untracked1` gets created by an earlier test but
is then cleaned up by this subsequent test. That goes against the idea
of test_when_finished(), which is that tests should clean up after
themselves. Doing it this way also creates a smelly dependency between
the tests. What I would recommend instead is having each test
independently create and cleanup the "untracked" files it needs. This
makes the tests a tiny bit more verbose but makes it much clearer to
the reader that the tests are independent.

> -# clean up the mess in case bad things happen
> -rm -f idontexist untracked1 untracked2 \
> -     path0/idontexist path0/untracked1 path0/untracked2 \
> -     .git/index.lock
> -rmdir path1
> @@ -149,10 +148,12 @@ test_expect_success 'do not move directory over existing directory' '
>  test_expect_success 'move into "."' '
> +       test_when_finished "rm -fr path?" &&
>         git mv path1/path2/ .
>  '

This is another of those cases which doesn't really pass the smell
test. This may indeed be the final test in which the various `path?`
subdirectories are used, but it isn't the test which created them,
thus it isn't "cleaning up after itself".

If the test which might get tripped up by these `path?` directories is
the "Sergey Vlasov's test case" test, then it probably would make more
sense for _that_ test to do `rm -fr path?` as its very first step (not
as a test_when_finished()) in order to prepare things the way it needs
them (just as it already does `rm -fr .git`).

>  test_expect_success "Michael Cassar's test case" '
> +       test_when_finished "rm -fr papers partA" &&
>         rm -fr .git papers partA &&
>         git init &&
>         mkdir -p papers/unsorted papers/all-papers partA &&

Cleaning these paths here makes sense since they are created and only
used by this test.

> @@ -168,8 +169,6 @@ test_expect_success "Michael Cassar's test case" '
> -rm -fr papers partA path?
> -
>  test_expect_success "Sergey Vlasov's test case" '
>         rm -fr .git &&
>         git init &&

So, given what I said above, the first line of this test might become:

    rm -fr .git path? &&

> @@ -230,6 +229,7 @@ test_expect_success 'git mv to move multiple sources into a directory' '
>  test_expect_success 'git mv should not change sha1 of moved cache entry' '
> +       test_when_finished "rm -f dirty dirty2" &&
>         rm -fr .git &&
>         git init &&
>         echo 1 >dirty &&
> @@ -242,8 +242,6 @@ test_expect_success 'git mv should not change sha1 of moved cache entry' '
>         test "$entry" = "$(git ls-files --stage dirty | cut -f 1)"
>  '
>
> -rm -f dirty dirty2

Makes perfect sense.

> @@ -262,6 +260,7 @@ test_expect_success 'git mv error on conflicted file' '
>  test_expect_success 'git mv should overwrite symlink to a file' '
> +       test_when_finished "rm -f moved symlink" &&
>         rm -fr .git &&
>         git init &&
>         echo 1 >moved &&
> @@ -276,9 +275,8 @@ test_expect_success 'git mv should overwrite symlink to a file' '
>         git diff-files --quiet
>  '
>
> -rm -f moved symlink

Okay.

>  test_expect_success 'git mv should overwrite file with a symlink' '
> +       test_when_finished "rm -f symlink" &&
>         rm -fr .git &&
>         git init &&
>         echo 1 >moved &&

This makes sense, but...

> @@ -292,11 +290,10 @@ test_expect_success 'git mv should overwrite file with a symlink' '
>  test_expect_success SYMLINKS 'check moved symlink' '
> +       test_when_finished "rm -f moved" &&
>         test -h moved
>  '

... this test only gets run on platforms which support symlinks (see
the SYMLINKS predicate in the test definition), so the `moved` file
won't get cleaned up on platforms which don't support symlinks.

> -rm -f moved symlink

If the `moved` file actually causes subsequent tests to fail, then
this might be one of those rare instances in which you'd introduce a
test merely to clean up state from earlier tests. Perhaps something
like this:

    test_expect_success 'cleanup symlink detritus' '
        rm -r moved
    '

However, if `moved` doesn't cause subsequent tests to fail, then it
might also make sense instead just to leave it alone and not bother
cleaning it up.
