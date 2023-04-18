Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115ECC77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 03:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjDRDyO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 23:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjDRDyM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 23:54:12 -0400
X-Greylist: delayed 65946 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Apr 2023 20:54:09 PDT
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57D53C3B
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 20:54:09 -0700 (PDT)
Date:   Tue, 18 Apr 2023 03:53:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1681790046; x=1682049246;
        bh=t0rlsKEtM9XNUExf6PyPhyQyr5V7wzIBT1WskwRuJsM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ca2ve5aL8wZB8CNxzch2JKhjjy5Kc3gihfdhR6t3OSFJd+hyXpLKV2hLkBpjbUoX3
         rVgpI/1wu9vbU2l9PMpYgWM0Pt3MIjOvWER4qW3nu4nmAXEa3FmiK95labegM9BWt6
         q+vghQw0Oj8/jidzHCNzt3DHZ283OLNxySKzdqKtvh2hwvtmpms803NzUzf8Cl7b6H
         v104hZXEgRrFUeVbex7C/yYJQb6EhpT2au7pd7dQGTCH5ALJGfnS1bO4qKzttam9pm
         NwghKdwvwLZrb771kuKSgrG9Ksl8R1NS2pnYAau74D0/cuuKM0kDuabzp424Lb4FMl
         DLhxhTDsOwacQ==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v9 2/8] t2400: print captured git output when finished
Message-ID: <olztmib77r35mx33a655obqpxui6coj74hfxoxfvcudnkpbqns@ixerneqaai45>
In-Reply-To: <xmqq8reqkyfz.fsf@gitster.g>
References: <20230417093255.31079-1-jacobabel@nullpo.dev> <20230417093255.31079-3-jacobabel@nullpo.dev> <xmqq8reqkyfz.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/04/17 02:09PM, Junio C Hamano wrote:
> Jacob Abel <jacobabel@nullpo.dev> writes:
>
> >  test_expect_success 'add --quiet' '
> > +=09test_when_finished "git worktree remove -f -f another-worktree" &&
> > +=09test_when_finished cat actual >&2 &&
>
> I doubt that this redirection does anything you expect it do.
> Doesn't it redirect the standard output that is emitted by the
> test_when_finished shell function when it registers another
> test_cleanup scriptlet to the standard error, and when test_cleanup
> is indeed run, wouldn't "cat actual" send its output to the standard
> output?

Yes that's correct. I figured "grab from stderr, cat to stderr" but yes
this isn't necessarily what we want here. Dropping the `>&2` causes it to
work as expected.

>
> No, I am not suggesting to write the line as:
>
> =09test_when_finished "cat >&2 actual" &&
>
> >  =09git worktree add --quiet another-worktree main 2>actual &&
> >  =09test_must_be_empty actual
>
> The reason why I do not suggest "fixing" the above is because
> test_must_be_empty, when fails, does this:
>
>         test_must_be_empty () {
>                 test "$#" -ne 1 && BUG "1 param"
>                 test_path_is_file "$1" &&
>                 if test -s "$1"
>                 then
>                         echo "'$1' is not empty, it contains:"
>                         cat "$1"
>                         return 1
>                 fi
>         }
>
> i.e. it sends the contents of "actual" to the standard output
> already.  When it succeeds, of course "actual" is empty, and there
> is no point in showing its contents.
>
> So "sh t2400-*.sh -x -i" already shows "cat actual" output.  Try
> the attached patch on top of this one and running it would show
> the above message shown by test_must_be_empty and the contents of
> the file 'actual'.  "git worktree remove" fails and your "cat" in
> the test_cleanup does not even trigger, by the way.

That should not be the case. From what I've seen, the test cleanup is
executed in reverse order from the order they are declared with
`test_when_finished`. So as long as `cat` is the last command added to test
cleanup it should always execute immediately after the first command in the
script fails. And as long as the `cat` is added immediately before the
`git worktree add`, that means it should be the most recently added in the
event that command fails.

>
> There may be cases where having something like this might help, but
> running the test with "-x" is not it---that case is already covered
> by what test_must_be_empty gives us, I think.
>
> [...]

I attached an example below to try to illustrate the issue I was attempting
to solve. If `git worktree add ... 2>actual` fails, redirecting stderr to
actual eats the output that would normally show w/ `-x`. Then because a
command fails, it never reaches the `test_must_be_empty`.

Test results of running `sh t2400-*.sh -x` for this test when
`git worktree add` fails (caused in this case by adding `--bad-arg` to the
command):

    expecting success of 2400.37 'add --quiet':
            test_when_finished "git worktree remove -f -f another-worktree"=
 &&
            test_when_finished cat actual >&2 &&
            git worktree add --quiet --bad-arg another-worktree main 2>actu=
al &&
            test_must_be_empty actual

    ++ test_when_finished 'git worktree remove -f -f another-worktree'
    ++ test 0 =3D 0
    ++ test_cleanup=3D'{ git worktree remove -f -f another-worktree
                    } && (exit "$eval_ret"); eval_ret=3D$?; :'
    ++ test_when_finished cat actual
    ++ test 0 =3D 0
    ++ test_cleanup=3D'{ cat actual
                    } && (exit "$eval_ret"); eval_ret=3D$?; { git worktree =
remove -f -f another-worktree
                    } && (exit "$eval_ret"); eval_ret=3D$?; :'
    ++ git worktree add --quiet --bad-arg another-worktree main
    error: last command exited with $?=3D129
    ++ cat actual
    error: unknown option `bad-arg'
    usage: git worktree add [-f] [--detach] [--checkout] [--lock [--reason =
<string>]]
                            [(-b | -B) <new-branch>] <path> [<commit-ish>]

        -f, --force           checkout <branch> even if already checked out=
 in other worktree
        -b <branch>           create a new branch
        -B <branch>           create or reset a branch
        -d, --detach          detach HEAD at named commit
        --checkout            populate the new working tree
        --lock                keep the new working tree locked
        --reason <string>     reason for locking
        -q, --quiet           suppress progress reporting
        --track               set up tracking mode (see git-branch(1))
        --guess-remote        try to match the new branch name with a remot=
e-tracking branch

    ++ exit 129
    ++ eval_ret=3D129
    ++ git worktree remove -f -f another-worktree
    fatal: 'another-worktree' is not a working tree
    ++ eval_ret=3D128
    ++ :
    not ok 37 - add --quiet

The same test but with the `test_when_finished cat actual` removed:

    expecting success of 2400.37 'add --quiet':
            test_when_finished "git worktree remove -f -f another-worktree"=
 &&
            git worktree add --quiet --bad-arg another-worktree main 2>actu=
al &&
            test_must_be_empty actual

    ++ test_when_finished 'git worktree remove -f -f another-worktree'
    ++ test 0 =3D 0
    ++ test_cleanup=3D'{ git worktree remove -f -f another-worktree
                    } && (exit "$eval_ret"); eval_ret=3D$?; :'
    ++ git worktree add --quiet --bad-arg another-worktree main
    error: last command exited with $?=3D129
    ++ git worktree remove -f -f another-worktree
    fatal: 'another-worktree' is not a working tree
    ++ eval_ret=3D128
    ++ :
    not ok 37 - add --quiet


