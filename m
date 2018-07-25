Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4944E1F597
	for <e@80x24.org>; Wed, 25 Jul 2018 20:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbeGYVNr (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 17:13:47 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34365 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729456AbeGYVNr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 17:13:47 -0400
Received: by mail-yw0-f193.google.com with SMTP id j68-v6so3319787ywg.1
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 13:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7uQq1zmOSrmcJty9Iwmx9eXpP+A2hi68qFwHN4A/nA=;
        b=dgKFHF8/O4xjSX/k7W+y/93aky2uxeqXW9MME3xflbxJmwZpIO8te5CKkggs1ibZLw
         v2gtZRIDOnWq2cVawF+YFuQT9CZBOooDJpV1nhrGAlQCnNb0SHSvfCEXTev6+aFxTbEF
         BYo4kd9JLOMD0BYVNZH8hUGmrNPpBDyCv/RxYY0LtUJz47CQqRXQ1CvSZd/hj4LJ8y0I
         WailQ8oONiDrF9Dcg9OJ3/nIgIBj71a1NPiQTRYoumz8y0wGwlV1xL9DGqu0c6pa5VdE
         ftVFeW3Ia3kCK+95nhEjPHAobXjdWygFNRIzVAAsOr3B5kGr/NoafZNJAF7UM+ALV/ED
         ns4g==
X-Gm-Message-State: AOUpUlFu+UxTnu8FfCHoW24Nub6O9gRJL47rMCSideUq6QOD9temQjXC
        pAfT8Ndkg9GVND67p1rUF8grq+cZekj18EOD4gU=
X-Google-Smtp-Source: AAOMgpcvWbWOOJRSpxo+TpmZlJEvuKir5G+a4O73m+V62bT1d1LmGh42q1FNIABVHq9H01BM1z/TFRy8fD6jr7GJSqU=
X-Received: by 2002:a81:7bd4:: with SMTP id w203-v6mr11983203ywc.70.1532548834730;
 Wed, 25 Jul 2018 13:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAE5ih79ndEbnEeV_muQyZwG+01_8Kg0J74rZtOoK1_V40E0z7g@mail.gmail.com>
 <20180725134345.8631-1-chenbin.sh@gmail.com>
In-Reply-To: <20180725134345.8631-1-chenbin.sh@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Jul 2018 16:00:23 -0400
Message-ID: <CAPig+cR2gYEwOTVBMRde35rn9oVsixeerbm5iJV+FmnOiBWxqQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] add hook pre-p4-submit
To:     chenbin.sh@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 25, 2018 at 9:45 AM Chen Bin <chenbin.sh@gmail.com> wrote:
> Hook pre-p4-submit is executed before git-p4 actually submits code.
> If the hook exits with non-zero value, submit process will abort.

Bikeshedding: Should this be named 'p4-pre-submit'? That way, if
git-p4 ever grows additional hooks, they can all be grouped under the
"p4-" prefix.

More below...

> Signed-off-by: Chen Bin <chenbin.sh@gmail.com>
> ---
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> @@ -374,6 +374,13 @@ These options can be used to modify 'git p4 submit' behavior.
> +Hook for submit
> +~~~~~~~~~~~~~~~
> +Hook `pre-p4-submit` is executed if it exists and is executable.
> +Exiting with non-zero status from this script cause `git-p4 submit` to abort.
> +By default the hooks directory is `$GIT_DIR/hooks`, but that can be changed.

Does the hook receive any arguments? Does it receive anything on its
standard input? Those questions ought to be answered by the
documentation.

Also, how is the hook supposed to determine whether the "submit"
should proceed? How does it know what is being submitted? Perhaps the
documentation could provide some explanation of how the hook should
glean such information (especially if the hook does not itself receive
any input).

> diff --git a/git-p4.py b/git-p4.py
> +        # locate hook
> +        hooks_path = gitConfig("core.hooksPath")
> +        if len(hooks_path) > 0:
> +            hook_file = os.path.join(hooks_path, "pre-p4-submit")
> +        else:
> +            hook_file = os.path.join(read_pipe("git rev-parse --git-dir").strip(), "hooks", "pre-p4-submit")
> +
> +        # Execute hook. If it exits with non-zero value, do NOT continue.
> +        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
> +            sys.exit(1)

Nit: The two #comments merely repeat what the code itself already says
clearly enough, thus don't add value (so can be dropped).

Should this be emitting some sort of message letting the user know
that the operation was aborted due to the hook's "rejection"? That
could be especially important if the hook itself is silent (or buggy).

> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
> @@ -261,6 +261,28 @@ test_expect_success 'unresolvable host in P4PORT should display error' '
> +# Test following scenarios:
> +#   - Without hook ".git/hooks/pre-p4-submit", submit should continue
> +#   - With hook returning 0, submit should continue
> +#   - With hook returning 1, submit should abort

Testing three separate cases would normally be done with three
separate tests, making it easier to figure out which case failed. But,
perhaps it doesn't matter here.

> +test_expect_success 'run hook pre-p4-submit before submit' '
> +       test_when_finished cleanup_git &&
> +       git p4 clone --dest="$git" //depot &&
> +       (
> +               cd "$git" &&
> +               echo "hello world" >hello.txt &&
> +               git add hello.txt &&
> +               git commit -m "add hello.txt" &&
> +               git config git-p4.skipSubmitEdit true &&

The wholesale removal of the $git directory by cleanup_git() when the
test finishes is undoing this config setting. Ditto regarding the
hooks created below. Okay.

> +               git p4 submit --dry-run | grep "Would apply" &&

We normally don't use a git command upstream in a pipe since the exit
code of that command gets lost (so, if it crashes, we don't know about
it). Instead:

    git p4 submit --dry-run >out &&
    grep "Would apply" out &&

Also, if "Would apply" is localized, we'd use test_i18ngrep (but you
don't need it in this case).

> +               mkdir -p .git/hooks &&
> +               : >.git/hooks/pre-p4-submit && chmod +x .git/hooks/pre-p4-submit &&

It might be clearer to readers of this test to use an explicit "exit
0" here (complementing the "exit 1" below). The current asymmetry
required extra cognitive effort to realize that this is the "returning
0" case mentioned in the comment above the test.

> +               git p4 submit --dry-run | grep "Would apply" &&
> +               echo #!/bin/sh && echo exit 1 >.git/hooks/pre-p4-submit &&

Use write_script() for this, which takes care of the #!/bin/sh line
and doing chmod:

    write_script >.git/hooks/pre-p4-submit <<-\EOF &&
    exit 1
    EOF

> +               git p4 submit --dry-run | grep "Would apply" || echo "Abort submit"

More idiomatic in this test suite:

    git p4 submit --dry-run >out &&
    ! grep "Would apply" out

> +       )
> +'
