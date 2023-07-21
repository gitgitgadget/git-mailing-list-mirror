Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236C1EB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 18:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjGUSCO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 21 Jul 2023 14:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGUSCN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 14:02:13 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1F6186
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 11:02:10 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7680e3910dfso223634785a.0
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 11:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689962529; x=1690567329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJAM1gOvONOC3WEDzXpFWp2KIOD9ScNs/HTvwEO6B6Q=;
        b=Em5azHmcJEpSPpJibLf+1p5GjbG5ZmLI/Zk20Hd3NWdrNJTAJkRCwkLJ2uOhrCi4f1
         lPOe8w4g0oNKNl4+phMb2k4qOhkezbId5qIfwWoUn1LttzBP3syaGf2R26JwrI7tqOSB
         p0Qv77afnnGeGnXBDwVhQppQ7KTCo5DghFJJMHdkb4ov1nOIF9UqZDyeYEd7IVMeg0T/
         jsT9LfdnGObzmMztxDj5gmeRE0HM1Tz9C80vh3xwWjtsA1o8N7SY7hlDtyEuxrlSQ3nq
         ChiiyKpWpo24CectWx9Tw3VmDIZ8xBqoQtbeIQzkc3GBWbkOyX2o4hed4c5ogEPeEGpA
         /d+g==
X-Gm-Message-State: ABy/qLbISw9h3H/3UMDX4aclVy4tnOg3/loz3/chkzEIRzo4gDAW/AYa
        SDd0t7WPDXN8N9ov3JPSwXnwxyC2OKnoTjA2q2c=
X-Google-Smtp-Source: APBJJlHHBqaWboGoAFNkHdJ8U8q88/7d2xw7jcC3hDCpTrtXnv9NnjNg6Pc0OaKa0ncbHg8PTGDqxZX8bNEKDvN9Bs8=
X-Received: by 2002:a05:6214:283:b0:63c:5ffc:c679 with SMTP id
 l3-20020a056214028300b0063c5ffcc679mr818371qvv.27.1689962529557; Fri, 21 Jul
 2023 11:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689960606.git.me@ttaylorr.com> <715a160903be6dc8873a7215c55f90894e62f589.1689960606.git.me@ttaylorr.com>
In-Reply-To: <715a160903be6dc8873a7215c55f90894e62f589.1689960606.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Jul 2023 14:01:58 -0400
Message-ID: <CAPig+cTse-bgpApQR3jVGir0Tur22NEgAoTKpmLek+pTRovxwg@mail.gmail.com>
Subject: Re: [PATCH 2/5] t/lib-commit-graph.sh: avoid directory change in `graph_git_behavior()`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 21, 2023 at 1:32 PM Taylor Blau <me@ttaylorr.com> wrote:
> The `graph_git_behavior()` helper asserts that a number of common Git
> operations (such as `git log --oneline`, `git log --topo-order`, etc.)
> produce identical output regardless of whether or not a commit-graph is
> in use.
>
> This helper takes as its second argument the location (relative to the
> `$TRASH_DIRECTORY`) of the Git repostiory under test. In order to run
> each of its commands within that repository, it first changes into that
> directory, without the use of a sub-shell.
>
> This pollutes future tests which expect to be run in the top-level
> `$TRASH_DIRECTORY` as usual. We could wrap `graph_git_behavior()` in a
> sub-shell, like:
>
>     graph_git_behavior() {
>       # ...
>       (
>         cd "$TRASH_DIRECTORY/$DIR" &&
>         graph_git_two_modesl
>       )
>     }
>
> , but since we're invoking git directly, we can pass along a "-C $DIR"
> when "$DIR" is non-empty.
>
> Note, however, that until the remaining callers are cleaned up to avoid
> changing working directories outside of a sub-shell, that we need to
> ensure that we are operating in the top-level $TRASH_DIRECTORY. The
> inner-subshell will go away in a future commit once it is no longer
> necessary.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/t/lib-commit-graph.sh b/t/lib-commit-graph.sh
> @@ -20,12 +20,14 @@ graph_git_behavior() {
>         test_expect_success "check normal git operations: $MSG" '
> -               cd "$TRASH_DIRECTORY/$DIR" &&
> -               graph_git_two_modes "log --oneline $BRANCH" &&
> -               graph_git_two_modes "log --topo-order $BRANCH" &&
> -               graph_git_two_modes "log --graph $COMPARE..$BRANCH" &&
> -               graph_git_two_modes "branch -vv" &&
> -               graph_git_two_modes "merge-base -a $BRANCH $COMPARE"
> +               (
> +                       cd "$TRASH_DIRECTORY" &&
> +                       graph_git_two_modes "${DIR:+-C $DIR} log --oneline $BRANCH" &&
> +                       graph_git_two_modes "${DIR:+-C $DIR} log --topo-order $BRANCH" &&
> +                       graph_git_two_modes "${DIR:+-C $DIR} log --graph $COMPARE..$BRANCH" &&
> +                       graph_git_two_modes "${DIR:+-C $DIR} branch -vv" &&
> +                       graph_git_two_modes "${DIR:+-C $DIR} merge-base -a $BRANCH $COMPARE"
> +               )
>         '
>  }

As mentioned in my review of patch [1/5], for safety, you'd probably
want to quote the expansion of DIR in case it ever contains whitespace
(or other weird characters). The obvious POSIX-correct way to do this
would be:

    graph_git_two_modes "${DIR:+-C \"$DIR\"} log ..." &&

Unfortunately, however, some older broken shells incorrectly expand
this to a single argument ("-C <dir>") rather than the expected two
arguments (-C and "<dir>")[1,2,3,4]. The workaround is unsightly but
doable:

    graph_git_two_modes "${DIR:+-C} ${DIR:+\"$DIR\"} log ..." &&

[1]: https://lore.kernel.org/git/20160517215214.GA16905@sigill.intra.peff.net/
[2]: https://lore.kernel.org/git/e3bfc53363b14826d828e1adffbbeea@74d39fa044aa309eaea14b9f57fe79c/
[3]: https://lore.kernel.org/git/20160518010609.Horde.sM8QUFek6WMAAwho56DDob8@webmail.informatik.kit.edu/
[4]: https://lore.kernel.org/git/1240044459-57227-1-git-send-email-ben@ben.com/
