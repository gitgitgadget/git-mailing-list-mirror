Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1324AC04A68
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 06:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiG3Goo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 02:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiG3Gom (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 02:44:42 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B924D83E
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 23:44:41 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-31e7ca45091so69226767b3.3
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 23:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3Sa02xck8QsvQ/W7PrEk/D+NyURVdVSmjcdMb1Et1x4=;
        b=c5KdNu5luzbFDIMmN8jyWE1q26SaNcY4GKvUj0L0WClClbEGfL3p2bgafYqr+ev2jk
         Puvjef3fs6w/2D6c6V4Vrev6ikZjxOEa/ayjzw2q/N9YBwF3nxFGcjV/e0DMvo96Nvak
         MEImZZZRpgzQcodI5+3TwiiUcbACqArRhgD84uJNgALjfhDrc+VhKVJD0SLXf/sQ4lnY
         cYZkKVJQ49suFRUXAwJGHL0r4NGLCK+HMSO0DAm6DuygPbQBfzIYXLloKMSpYeeNsyxg
         aeu2AoECi1akHn0fZWTsIksDCAZywnePZ2LSrErtCVu8Dk1toLn3kC4u5I0ssTOST0dx
         HXFg==
X-Gm-Message-State: ACgBeo2Qgm8HSG7WguwTydagBehOXPJlrC8qOwSDoDlP1tiVBCJJwCnr
        w6L8xnJiWZDkol1coLqpBAtzY4RHDwdqAUbXB83ml0rT5hsRHBTV
X-Google-Smtp-Source: AA6agR5cJOAMo7qShkXEeax6OirOt+7s8LHpiia9TSCs1YhHJloHe0gJg7MviAxS6BreGrPknIGmmix1s6VsY62Bw4U=
X-Received: by 2002:a81:e82:0:b0:31f:435e:b432 with SMTP id
 124-20020a810e82000000b0031f435eb432mr5763080ywo.13.1659163480580; Fri, 29
 Jul 2022 23:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220729101245.6469-1-worldhello.net@gmail.com> <20220729101245.6469-2-worldhello.net@gmail.com>
In-Reply-To: <20220729101245.6469-2-worldhello.net@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 30 Jul 2022 02:44:29 -0400
Message-ID: <CAPig+cQyW4Bz1kL5MriXeU6Zd93oYQU8ZuA-1gaEmAERpbTaDA@mail.gmail.com>
Subject: Re: [PATCH 1/9] t1416: more testcases for reference-transaction hook
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 6:21 AM Jiang Xin <worldhello.net@gmail.com> wrote:
> Append more testcases in t1416 for various git commands that may trigger
> the "reference-transaction" hook.
> [...]
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
> @@ -133,4 +133,1072 @@ test_expect_success 'interleaving hook calls succeed' '
> +# Create commits in <repo> and assign each commit's oid to shell variables
> +# given in the arguments (A, B, and C). E.g.:
> +#
> +#     create_commits_in <repo> A B C
> +#
> +# NOTE: Never calling this function from a subshell since variable
> +# assignments will disappear when subshell exits.
> +create_commits_in () {
> +       repo="$1" && test -d "$repo" ||
> +       error "Repository $repo does not exist."
> +       shift &&
> +       while test $# -gt 0
> +       do
> +               name=$1 &&
> +               shift &&
> +               test_commit -C "$repo" --no-tag "$name" &&
> +               eval $name=$(git -C "$repo" rev-parse HEAD)
> +       done
> +}

Since tests call this function within an &&-chain, we should make sure
that &&-chain inside the function itself does the right thing. There
are a couple important and one (somewhat optional) minor fix needed
for this function. First, the function should manually break from the
loop and indicate failure (using `|| return 1`) if any command inside
the loop fails. Second, the `eval` is always going to return success
even if the embedded `git rev-parse` command fails. Finally, the minor
fix is that the `test ... || error ...` could be difficult for an
&&-chain linter to grok if we ever start linting function bodies. To
fix all these problems, you could perhaps write the function like
this:

    create_commits_in () {
        local repo="$1" &&
        if ! test -d "$repo"
        then
            error "Repository $repo does not exist."
        fi &&
        shift &&
        while test $# -gt 0
        do
            local name=$1 &&
            shift &&
            test_commit -C "$repo" --no-tag "$name" &&
            local rev=$(git -C "$repo" rev-parse HEAD) &&
            eval "$name=$rev" || return 1
        done
    }

Now that the function breaks out of the loop properly with `|| return
1` upon failure, it's no longer necessary to perform the directory
check at the top of the function since the call to test_commit() will
correctly fail if the directory does not exist. So, the function can
be shortened to:

    create_commits_in () {
        local repo="$1" &&
        shift &&
        while test $# -gt 0
        do
            local name=$1 &&
            shift &&
            test_commit -C "$repo" --no-tag "$name" &&
            local rev=$(git -C "$repo" rev-parse HEAD) &&
            eval $name=$rev || return 1
        done
    }

Having said all that, it almost seems overkill to build the loop into
this function considering that it sets only four shell variables in
the entire test script, so it might be simpler to drop the loop
altogether:

    create_commits_in () {
        local repo="$1" name="$2" &&
        test_commit -C "$repo" --no-tag "$name" &&
        local rev=$(git -C "$repo" rev-parse HEAD) &&
        echo $rev
    }

and change the callers to invoke it individually for each variable:

    A=$(create_commits_in base A) &&
    B=$(create_commits_in base B) &&
    C=$(create_commits_in base C) &&

or even drop the function entirely:

    test_commit -C base --no-tag A &&
    A=$(git -C base rev-parse HEAD) &&
    test_commit -C base --no-tag B &&
    B=$(git -C base rev-parse HEAD) &&
    test_commit -C base --no-tag C &&
    C=$(git -C base rev-parse HEAD) &&

though, it's a matter of taste whether that's better.

> +test_cmp_heads_and_tags () {
> +       indir= &&
> +       while test $# != 0
> +       do
> +               case "$1" in
> +               -C)
> +                       indir="$2"
> +                       shift
> +                       ;;

It wouldn't hurt to keep the &&-chain intact here in case the &&-chain
linter is some day updated to check function bodies, so:

    indir="$2" &&
    shift

> +               *)
> +                       break
> +                       ;;
> +               esac
> +               shift

Same here:

    esac &&
    shift

> +       done &&
> +       expect=${1:-expect} &&
> +       actual=${2:-actual-heads-and-tags} &&
> +       indir=${indir:+"$indir"/} &&
> +       test_path_is_file "$expect" &&
> +       test_when_finished "rm -f \"$actual\"" &&
> +       git ${indir:+ -C "$indir"} show-ref --heads --tags | \
> +               make_user_friendly_and_stable_output >"$actual" &&

The exit code from `git show-ref` is being lost down the pipe. You
also don't need the `\` after `|`.

> +       test_cmp "$expect" "$actual"
> +}
> +
> +test_expect_success 'setup git config and common reference-transaction hook' '
> +       git config --global \
> +               core.hooksPath "$HOME/test-hooks" &&

Nit: This would fit nicely on a single line; no need for the line splicing.

> +       git config --global core.abbrev 7 &&
> +       mkdir "test-hooks" &&
> +       write_script "test-hooks/reference-transaction" <<-EOF
> +               exec >>"$HOME/$HOOK_OUTPUT"
> +               printf "## Call hook: reference-transaction %9s ##\n" "\$@"
> +               while read -r line
> +               do
> +                   printf "%s\n" "\$line"

Nit This is the same as:

    echo "\$line"

> +               done
> +       EOF
> +'
> +
> +test_expect_success "update-ref: create new refs" '
> +       test_when_finished "rm -f $HOOK_OUTPUT" &&
> +
> +       cat >expect <<-EOF &&
> +               ## Call hook: reference-transaction  prepared ##

This and a bunch of other here-doc tags in subsequent tests are
missing the backslash:

    cat >expect <<-\EOF &&
