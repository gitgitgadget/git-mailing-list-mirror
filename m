Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 257831F462
	for <e@80x24.org>; Mon, 27 May 2019 22:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfE0WqC (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 18:46:02 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36611 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfE0WqB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 18:46:01 -0400
Received: by mail-ua1-f68.google.com with SMTP id 94so7083399uam.3
        for <git@vger.kernel.org>; Mon, 27 May 2019 15:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanocritical.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MDpwyvNvKzRX544stGkOuB3YGHIMHt3h9cqLbnpPFVU=;
        b=SQbCLvtKcRhVSNJhFG0NFvydBnReydaQiOy05YeFTC9v8kbKizgEHaFmxlJMfSXoqI
         l0sgHq4O36WFg+ehZtMmRKF5S2i/TntQ6/iNFZGUvlWvmcHkYNqIQvGegz+EZzI2+Y3N
         k3HauZZ5hwbel6mwbPaKJNqThlRQ1oMaYosGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MDpwyvNvKzRX544stGkOuB3YGHIMHt3h9cqLbnpPFVU=;
        b=hBzFaqOzOXtYWxHVk9UA9Lm61tnfBgAGmM8b7j4M/aitRNF6UKZn1QFTWNw68XW0FF
         mfsViRVleOLTUDLoqz7lT78Cd0jnDmSEPwewP+8J2JCTFndUAjvXQ3tSM4KIyv9iQkjb
         Ac4wTfxfNkHz3SeEQZKjoDRVlF16zYaUFkCceHGtur1H+HSCJcfROyhOryEZJauIL+qr
         in9a+kPaTktGL0MV9ipsPKnfJ0HMvsXeukqdClzOjJqbs4VE2xTTL/M3U3owIhUaxBHV
         RpyUSxHF2c4DyGk6asJW8qIAJcSB0pZP96LxvcPGp6Anc6l7WXDG51S0WjCYpMe89ebX
         Yc8w==
X-Gm-Message-State: APjAAAU3QM41NHz121jxYaMbmkqBEn2mDZvsZk8N9D4dMZNiRv7gNFjj
        xqUMAvCIAamn1PwipgxwwGhnqNidJJHJLkLw+6X6GQ==
X-Google-Smtp-Source: APXvYqxsrxNi1/aXqpKMI/Zd9ULzd1giDujiym6xsxuI1dGV94mIQ/556wtr3y3xF2q3Q//uokU1gP2UYrmCrSeRIFM=
X-Received: by 2002:ab0:e08:: with SMTP id g8mr41714057uak.32.1558997160382;
 Mon, 27 May 2019 15:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAH_=xoYQEvXKnhyZsUeZ=VTEMOpOdgbd-57f7-6M+2KQLSAAUQ@mail.gmail.com>
 <20190527211245.12292-1-newren@gmail.com>
In-Reply-To: <20190527211245.12292-1-newren@gmail.com>
From:   Eric Rannaud <e@nanocritical.com>
Date:   Mon, 27 May 2019 15:45:49 -0700
Message-ID: <CAH_=xoZ5Lt2nn50cfDbTA-ZVeshi8HZ91Od4btuUXpBGCanGng@mail.gmail.com>
Subject: Re: [PATCH v4] fast-import: checkpoint: only write out refs and tags
 if we changed them
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeremy Serror <jeremy.serror@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 27, 2019 at 2:12 PM Elijah Newren <newren@gmail.com> wrote:
> On Fri, May 24, 2019 at 4:10 PM Eric Rannaud <e@nanocritical.com> wrote:
> >
> > With this patch, we keep track of whether a particular branch or tag has
> > been changed by this fast-import process since our last checkpoint (or
> > startup). At the next checkpoint, only refs and tags that new commands
> > have changed are written to disk. To be clear, fast-import still does
> > not update its internal view of branches in response to external
> > changes, but now it avoids interfering with external changes unless
> > there was an explicit command to do so since the last checkpoint.
>
> This patch looks reasonable to me; you can view it one of two basic ways:
>   1) an optimization (only update what needs to be updated)
>   2) a way to have early access to a completed branch
>
> In particular, if the fast-import stream is dealing with unrelated (or
> very divergent) branches and it completes one branch before others,
> then your change allows people to have early access to both read &
> update the completed branches while the import continues working on
> other branches.

That's a good way to describe how people with a more standard use case
than mine can benefit from my patch.


> If you changed your description to sell it this way, it'd be fine
> as-is.  But you use --force and make multiple mentions of concurrent
> updates to branches in external processes during the fast-import
> process.  That kind of description makes it really clear we need to
> tighten up what happens with the checkpoint command when it hits a
> failure (as mentioned in the commentary on V3).  Below is a patch that
> does this.
>
> I think we should either:
>
>   1) update your commit message to sell it without mentioning the
>      concurrent rewrites, and then I'll update my patch to not
>      conflict (we both add new tests at the same location to the same
>      file causing a simple conflict) by building on yours, OR
>
>   2) update your patch to come after mine and add a comment to your
>      commit message about how checkpoint will abort if it hits an
>      error, suggesting that people should only update branches
>      fast-import will not be updating further or they should use
>      --force and deal with their changes being overwritten by
>      fast-import.  Then you can submit our two patches as a series.
>
> Thoughts?

(2) is probably the most logical order to do things. I have a few
comments on your patch, below.



> -- 8< --
> Subject: [PATCH] fast-import: remember to check failure flag when
>  checkpointing
>
> fast-import, when finished, will flush out the current packfile and
> update branches, tags, and marks, returning whether it was successful.
> The point of the 'checkpoint' command was to do all the same things, but
> continue processing the stream of input commands if it was successful.
> Unfortunately, the checkpoint code forgot to check the 'failure' flag to
> see if there was an error in e.g. updating the branches, which meant it
> would also continue if there was a failure.  Fix this oversight.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  fast-import.c          |  2 ++
>  t/t9300-fast-import.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/fast-import.c b/fast-import.c
> index f38d04fa58..d0e12b03a0 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -3033,6 +3033,8 @@ static void checkpoint(void)
>         dump_branches();
>         dump_tags();
>         dump_marks();
> +       if (failure)
> +               exit(1);
>  }
>
>  static void parse_checkpoint(void)
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 3668263c40..788a543b82 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -3262,6 +3262,48 @@ test_expect_success PIPE 'V: checkpoint updates tags after tag' '
>         background_import_still_running
>  '
>
> +background_fast_import_race () {
> +       options=$1
> +       input_file=$2
> +       exit_status=$3
> +       extra_cmd="$4"
> +
> +       mkfifo V.input
> +       exec 8<>V.input
> +       rm V.input
> +
> +       git fast-import $options <&8 &
> +       echo $! >V.pid &&
> +       $extra_cmd &&
> +
> +       cat $input_file >&8
> +       wait $(cat V.pid)
> +       test $? -eq $exit_status
> +}

I think the test will not fail without the patch (and therefore won't
catch a regression): while checkpoint doesn't currently check the
failure flag, it will be checked when cmd_main() returns so
exit_status will be 1.

You either want to:
- (a) add more independent commands after the checkpoint and check
that they were not run,
- or (b) run with --done, do not include a done command, and check
that fast-import does exit (but it's racy),
- or (c) you can reuse background_import to have a more explicit
sequence of events (in which case improvements to background_import
from my patch would have to be committed first).

Something like: (I did not try the following code)

cat >input <<-INPUT_END &&
commit refs/heads/V4
mark :1
committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
data 0
from refs/heads/U

commit refs/heads/V4_child
mark :1
committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
data 0
from refs/heads/V4^0

checkpoint

reset refs/heads/V5
from refs/heads/U

progress do: shell
progress git branch V5 V4

checkpoint

reset refs/heads/V5
from refs/heads/V4_child

progress do: checkpoint and stop

INPUT_END

background_import "" input &&

# V5 remains equal to V4 as set by the external "git branch" command:
#
# V5 is not updated by the second checkpoint (as resetting V5 to U isn't a
# fast-forward with respect to V4), and V5 is not updated by the reset to
# V4_child after the second checkpoint (which would be a fast-forward with
# respect to V4) as fast-import immediately exits on a failed checkpoint.
test "$(git rev-parse --verify V5)" = "$(git rev-parse --verify V4)" &&

# fast-import is not running anymore (but do kill it if it is):
! kill -9 $(cat V.pid) &> /dev/null &&
# fast-import exited with an error:
test $(wait $(cat V.pid)) -eq 1



> +test_expect_success PIPE 'V: checkpoint fails if refs updated beforehand' '
> +       git checkout --orphan V3 &&
> +       git commit --allow-empty -m initial &&
> +       INITIAL=$(git rev-parse HEAD) &&
> +
> +       cat >input <<-INPUT_END &&
> +       feature done
> +       commit refs/heads/V3
> +       mark :3
> +       committer Me My <self@and.eye> 1234567890 +0123

You likely want to use:
committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE


> +       data 10
> +       generated
> +       from $INITIAL
> +
> +       checkpoint
> +       done
> +       INPUT_END
> +
> +       background_fast_import_race "" input 1 "git commit --allow-empty -m conflicting" &&
> +       background_fast_import_race "--force" input 0 "git commit --allow-empty -m conflicting"
> +'
> +
> +
>  ###
>  ### series W (get-mark and empty orphan commits)
>  ###
> --
> 2.22.0.rc1.dirty
>
