From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC] Pinning of submodules
Date: Fri, 4 Sep 2015 01:02:41 -0400
Message-ID: <CAPig+cQ6Ls1iasVsTwbpqGWt9=7gBuWjWAPmSMJCStsdPUwCgg@mail.gmail.com>
References: <55E78522.1030107@gmail.com>
	<55E78780.2040801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Anders Ro <anders.ronnbrant@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 07:02:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXj9D-0000Bb-Fw
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 07:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063AbbIDFCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 01:02:43 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:36022 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbbIDFCm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 01:02:42 -0400
Received: by ykcf206 with SMTP id f206so10625973ykc.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 22:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=hBba1QjjeFLHM3f+st77v3Wgc8ZyCv0B9dOwGPlV6SE=;
        b=JJaaloJ7/pJksg8kc4s4VoOZLGHhE2aI9km7QOKy8zlC7NvkG1woGXK/c0F862T9ML
         eiMe9hZRXyQLJte9L1NIbyuOYQ9OYSTnxLDFbH0zoCn1W4RtwVM9dsws1kQmEPm9ggSl
         PCmyJq3SA30jDqKdbUALEobsxfkC3536H9dFFa0osSHIzDzUDvGbVZIDXM19CQwMK+SI
         HO7g+TbkHiNCqbwQmihVQRatGlQg0bbAUSyXYdPh5o4bAF61bwYBX2UgiBREo8I7+svu
         wmiITYMdJzDr6A2LNnWg33b8u09owk12cdcQ1fLqx0bcy9HCylqvYE8s1YXl0gjGHa+J
         rWqA==
X-Received: by 10.170.114.18 with SMTP id g18mr1960720ykb.90.1441342961618;
 Thu, 03 Sep 2015 22:02:41 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Thu, 3 Sep 2015 22:02:41 -0700 (PDT)
In-Reply-To: <55E78780.2040801@gmail.com>
X-Google-Sender-Auth: fqpcqL1VqVF2PAt65y1TsBnBSaI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277287>

On Wed, Sep 2, 2015 at 7:34 PM, Anders Ro <anders.ronnbrant@gmail.com> wrote:
> Patch to make it possible to pin submodules so that they are not
> affected by the --remote option in "git submodule".

Thanks for the patches. I don't use submodules, so I can't comment
specifically on this change, however, I can offer some general
comments on the patches. But first, a piece of advice...

Use git-send-email to post the patches as proper emails, one email
per patch, rather than as attachments. Reviewers are going to want to
write inline comments on the patches, and they can't do so when the
patches are attachments, so attaching patches discourages reviewers
from responding.

> git-submodule.sh: pin submodule when branch name is '@'
>
> Setting branch name to '@' for a submodule will disable 'git submodule
> update --remote' calls for that specific submodule. I.e. instead of
> follow the unspecified default choice of master, nothing is being
> updated. This is useful when multiple submodules exist but not all
> should follow the remote branch head.

With the disclaimer that I'm not a submodule user (to which the
answer might be obvious): What benefit is there in using a magic
value like this ("@") over, say, an explicit configuration setting?

> Signed-off-by: Anders Ro <anders.ronnbrant@gmail.com>
> ---
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 25b1ddf..1bb2bb1 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -843,7 +843,8 @@ Maybe you want to use 'update --init'?")"
>   die "$(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
>   fi
>
> - if test -n "$remote"
> + # Fetch latest in remote unless branch name in config is '@'
> + if test -n "$remote" -a "$branch" != "@"

The -a option to 'test' is not portable[1] and is considered obsolete
by POSIX[2]. Use "test foo && test bar" instead.

[1]: http://www.gnu.org/software/autoconf/manual/autoconf.html#index-g_t_0040command_007btest_007d-1793
[2]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html

>   then
>   if test -z "$nofetch"
>   then
> @@ -857,6 +858,12 @@ Maybe you want to use 'update --init'?")"
>   die "$(eval_gettext "Unable to find current ${remote_name}/${branch} revision in submodule path '\$sm_path'")"
>   fi
>
> + # Inform that the current sm is pinned and use of '--remote' ignored
> + if test -n "$remote" -a "$branch" = "@"

Ditto.

> + then
> + say "$(eval_gettext "Submodule path '\$displaypath' pinned, remote update ignored")"
> + fi
> +

> Subject: [PATCH 2/2] t7412: add test case for pinned submodules
>
> Signed-off-by: Anders Ro <anders.ronnbrant@gmail.com>
> ---
> diff --git a/t/t7412-submodule-pinning.sh b/t/t7412-submodule-pinning.sh
> new file mode 100755
> index 0000000..2844b1e
> --- /dev/null
> +++ b/t/t7412-submodule-pinning.sh
> @@ -0,0 +1,73 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2015 Anders Ronnbrant
> +#
> +
> +test_description="Branch name '@' disables submodule update --remote calls"
> +
> +. ./test-lib.sh
> +
> +get_sha() {
> +  cd $1 && git rev-list --max-count=1 HEAD
> +}

A few issues:

Indent with tabs (width 8), not spaces. (This comment applies to the
entire patch).

Style for shell scripts on this project is to have a space before
"()".

Taking a hint from t/test-lib-functions.sh:test_cmp_rev(), use "git
rev-parse --verify" instead.

It's a bit ugly that this does "cd $1" without ever balancing it with
a return to the original directory. If someone later comes along and
writes:

    get_sha1 fiddle >fiddle-id

in a new test, then that person will be surprised to find that the
current working directory changed out from under him. The current
patch doesn't experience this problem since it always invokes it as
$(get_sha1 fiddle), but it could be made more robust by either
wrapping it in a subshell so that the 'cd' is undone when the
subshell exits, or by using "-C $1".

Taking the above comments into account:

    get_sha () {
        git -C "$1" rev-parse --verify HEAD
    }

> +equal_sha() {
> +  test "$(get_sha $1)" = "$(get_sha $2)"
> +}
> +
> +not_equal_sha() {
> +  test "$(get_sha $1)" != "$(get_sha $2)"
> +}

Style: space before "()" on these two function declarations

> +test_expect_success 'setup submodule tree structure' '
> +for i in 1 2 3; do echo file$i > file$i; git add file$i; git commit -m file$i; done &&

Style: write each command of the 'for' loop on its own line,
including 'do', don't use semi-colons

Style: no space after redirection operator: >file$i

Keep the &&-chain intact, and end the chain with "|| return $?" so
that the 'for' loop correctly exits if any contained command fails.

    for i in 1 2 3
    do
        echo file$i >file$i &&
        git add file$i &&
        git commit -m file$i || return $?
    done

> +test_tick &&

Why is this needed? There doesn't seem to be any obvious reason for
its presence, and the test still passes without it.

> +git clone . super &&
> +git clone . follow &&
> +git clone . pinned &&
> +(cd super && git submodule add -b master ../follow follow) &&
> +(cd super && git submodule add           ../pinned pinned)

Style: it's probably better to avoid aligning columns like this since
it can end up being a maintenance headache, and because the line with
the extensive blank span can be difficult to read in isolation.

Since both of these execute in directory 'super', this could be
stated more concisely as:

    (
    cd super &&
    git submodule add ... &&
    git submodule add ...
    ) &&

Placement of the subshell parentheses is intentional.

> +'
> +
> +test_expect_success 'verify submodules have the same SHA' '
> +equal_sha super/follow super/pinned
> +'

Style: indent the test body (using tab); this comment applies to the
entire patch

> +
> +

Style: one blank line between tests, not two

> +test_expect_success 'switch submodule pinned to HEAD~1 and commit super' '
> +(cd super/pinned && git checkout master && git reset --hard HEAD~1) &&
> +(cd super && git add pinned && git commit -m "Submodule pinned @ HEAD~1") &&
> +(cd super && git submodule status)
> +'

Style: one command per line; format subshell as shown in above
example

You can combine the two 'cd super' bits into a single subshell.

> +
> +
> +test_expect_success 'verify submodules not have the same SHA anymore' '
> +not_equal_sha super/follow super/pinned
> +'

Each test should be a logical unit. In prose, you might describe a
test as "set condition A, make change B, and verify that A and B
resulted in some expected state".

This test is the "verify A and B" part, and the preceding test is the
"set condition A, make change B" part, however, splitting them up
like this makes it difficult for the reader to understand how they
are related. Worse, someone may come along and insert a new test
between the two, not realizing that these two tests are logically
one, possibly breaking them.

Consequently, this test should be combined with the one preceding it.

> +
> +
> +test_expect_success 'set branch name to "@" for submodule pinned' '
> +(cd super && git config --replace-all submodule.pinned.branch "@") &&
> +test "$(cd super && git config --get submodule.pinned.branch)" = "@"

What is the last line testing? It appears to be testing the behavior
of git-config, which is outside the scope of this test script.

> +'
> +
> +
> +test_expect_success 'run submodule update --remote and expect no change' '
> +(cd super && git submodule update --remote) &&
> +not_equal_sha super/follow super/pinned
> +'

All the above comments apply here too. These two tests are logically
one, thus should be combined.

Once combined, you can use test_config rather than git-config, since
test_config will ensure that the config setting is undone when the
test exits.

> +
> +
> +test_expect_success 'remove branch name "@" for submodule pinned (unpin)' '
> +(cd super && git config --unset-all submodule.pinned.branch) &&

If you take the above advice and use test_config in the previous
test, then this won't be needed.

> +(cd super && git config --list)

This isn't testing anything at all, but is instead merely cluttering
the output (when --verbose is enabled). It looks like debugging code
which should have been removed before committing.

> +'
> +
> +
> +test_expect_success 'run submodule update --remote and expect same SHA1 again' '
> +(cd super && git submodule update --remote) &&

For these one-line subshells, "-C super" is easier and reads
better. (This comment also applies to the rest of the patch.)

> +equal_sha super/follow super/pinned
> +'

This test should be combined with the previous one (although, if you
follow the advice regarding the previous test, then that test will
collapse to nothing...).

> +
> +
> +test_done
> --
> 2.1.4
