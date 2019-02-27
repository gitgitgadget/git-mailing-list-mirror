Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F204020248
	for <e@80x24.org>; Wed, 27 Feb 2019 15:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbfB0PDo (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 10:03:44 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:33202 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfB0PDn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 10:03:43 -0500
Received: by mail-wr1-f41.google.com with SMTP id i12so18379037wrw.0
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 07:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QbVBcNUwgYrN+Oz9f682kpVGyrRhuTTVliW95/QZ4Pk=;
        b=M5qNvyjhTVVjOeGxIaMavw+h46mJWMf45OI8KoOc1w4m9iWREflNaYLKk/gQReApnA
         yTJDO63kJrbUwxsMK+HeqslcgDKFZodCO6J0HvaIvLa389b2UVcucEwyVBCMM07K3RUM
         IrU5rutYUuAYIrgiUHlv/wK9q8570Jg5Jcoew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QbVBcNUwgYrN+Oz9f682kpVGyrRhuTTVliW95/QZ4Pk=;
        b=e6qqG8NwACUl2+VAW9eva3sFqQhXx/pt2gV+ikgCEzALa0aEbYKKvqH4mLHzEBeo/A
         GmNzHFur8nVsk7SnImGJk83In+eM7CzMFrB7dmuvOh4VRHKUxhAQr0RNkAk29Vaogk7W
         LPYMu5drwLGoD2+cVK1pzDKFopmWpST6Co663OV1bAv6VrHHPYTH5yWk8rQVdTuX5vGb
         pnE3oelGoGRlsuodfXm3iZNh+RtWYpm2IVafrVTFxC5KxpyhVqvNB+bI5PYB+vyn+Ej4
         CPMfUOwXZlKtjBJRt9lSbYloRqq2fTkgvgkolSiqboNZlXtcAdY0vJJXXQ7Ru9Hw56v8
         7fcA==
X-Gm-Message-State: APjAAAVZF8FmW15HhJGdDeBsUXhwq8Q0h2DNYwSw5e33YNbtUMGORB51
        KAKQF3nH9tvXBmWx7+nBNEbDzg8dOVhmF2XvXrG/d8G095E=
X-Google-Smtp-Source: APXvYqz2AxkFDmTdSWPxUuURzIXO6YSJmJLAqDCXL4+ICY3GBmIWcTuvYazx4qyIebpVO//XX6jq9wiQA2FhnK99km8=
X-Received: by 2002:adf:dd12:: with SMTP id a18mr2607217wrm.4.1551279821152;
 Wed, 27 Feb 2019 07:03:41 -0800 (PST)
MIME-Version: 1.0
References: <20190227094926.GE19739@szeder.dev>
In-Reply-To: <20190227094926.GE19739@szeder.dev>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 27 Feb 2019 15:03:30 +0000
Message-ID: <CAE5ih78MV1qGTHBmCaN5k+VGv8Cy-RnFwOU0yuJBPEyn37C_4w@mail.gmail.com>
Subject: Re: Occasional git p4 test failures because of stray fast-import processes
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Feb 2019 at 09:49, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrot=
e:
>
> Hi Luke,
>
> I saw rare failures in test 6 'git p4 sync uninitialized repo' in
> 't9800-git-p4-basic.sh' on Travis CI, because the 'cleanup_git'
> function failed to do its job.  The (redacted) trace looks like this:

Thanks for the *very* detailed analysis!

I think you are right - git-p4 should wait() for all of its children,
and that ought to fix this.

I think I may have even added the bit of code you mention (about a
decade ago now).

I'll have a look and see what can be done.

Thanks!
Luke



>
>   + cleanup_git
>   + retry_until_success rm -r /home/szeder/src/git/t/trash directory.t980=
0-git-p4-basic/git
>   + time_in_seconds
>   + cd /
>   + /usr/bin/python -c import time; print(int(time.time()))
>   + timeout=3D1551233042
>   + rm -r /home/szeder/src/git/t/trash directory.t9800-git-p4-basic/git
>   + test_must_fail test -d /home/szeder/src/git/t/trash directory.t9800-g=
it-p4-basic/git
>   test_must_fail: command succeeded: test -d /home/szeder/src/git/t/trash=
 directory.t9800-git-p4-basic/git
>   + eval_ret=3D1
>   + :
>   not ok 6 - git p4 sync uninitialized repo
>
> Trying to reproduce this failure with stock Git can be tricky: I've
> seen
>
>   ./t9800-git-p4-basic.sh --stress -r 1,2,6,22
>
> fail within the first 10 tries, but it also run overnight without a
> single failure...  However, the following two-liner patch can reliably
> trigger this failure:
>
> diff --git a/fast-import.c b/fast-import.c
> index b7ba755c2b..54715018b3 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -3296,6 +3296,7 @@ int cmd_main(int argc, const char **argv)
>                 rc_free[i].next =3D &rc_free[i + 1];
>         rc_free[cmd_save - 1].next =3D NULL;
>
> +       sleep(1);
>         start_packfile();
>         set_die_routine(die_nicely);
>         set_checkpoint_signal();
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index b3be3ba011..2d2ef50bfa 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -190,6 +190,7 @@ kill_p4d () {
>
>  cleanup_git () {
>         retry_until_success rm -r "$git"
> +       sleep 2
>         test_must_fail test -d "$git" &&
>         retry_until_success mkdir "$git"
>  }
>
>
> What's going on is this: 'git p4' invokes 'git fast-import' via
> Python's subprocess.Popen(), and then there are two chain of events
> racing with each other:
>
>   - In the foreground:
>
>     - 'git p4' notices that there are no p4 branches and die()s as
>       expected, but leaves its child fast-import behind
>     - 'test_i18ngrep' quickly verifies that 'git p4' died with the
>       expected error message
>     - the cleanup function removes the "$TRASH_DIRECTORY/git"
>       directory, and
>     - checks that the directory is indeed gone.
>
>   - Meanwhile in the background:
>
>     - 'git fast-import' starts up, kicks off the dashed external
>       'git-fast-import' process,
>     - which opens a tmp packfile in "$TRASH_DIRECTORY/git" for writing
>       (the start_packfile() call in the patch context above), creating
>       any leading directories if necessary,
>     - notices that its stdin is closed (because 'git p4' died) and it
>       has nothing left to do, so
>     - it cleans up and exits.  Note that this cleanup only removes the
>       tmp packfile, but leaves any newly created leading directories
>       behind.
>
> While unlikely, it does apparently happen from time to time that the
> test's cleanup function first removes "$TRASH_DIRECTORY/git", but then
> 'git fast-import' re-creates it for its packfile before the cleanup
> function checks the result of the removal.  The two well-placed
> sleep()s in the patch above force such a problematic scheduling.
>
> There are 4 test cases running 'test_must_fail git p4 sync': the above
> patch triggers a failure in 3 of them, and with a bit of extra modding
> I could trigger a failure in the fourth one as well.
>
> We could work this around by waiting for 'git p4' and all its child
> processes in the affected tests themselves, using the same shell
> trickery as in ef09036cf3 (t6500: wait for detached auto gc at the end
> of the test script, 2017-04-13), but this feels like, well, a
> workaround.
>
> I think the proper solution would be to ensure that 'git p4' kills and
> waits for all its child processes when die()ing.  Alternatively (or in
> addition?), it could perform all the necessary sanity-checking (and
> potential die()ing) before starting the 'git fast-import' process in
> the first place.
>
> I've glanced through all subprocess.Popen() callsites in 'git p4' and
> found most of them OK, in the sense that they wait for whatever child
> process they create.  Alas, there was one exception: p4CmdList() can
> invoke an optional callback function before wait()ing on its 'p4'
> child, and the streamP4FilesCb() callback function can die() without
> waiting for the 'p4' process (but it does wait() for 'git
> fast-import'!).
>
> On a related note: this check for the just-removed directory was added
> in 23aee4199a (git-p4: retry kill/cleanup operations in tests with
> timeout, 2015-11-19), which mentions flaky cleanup operations.
> Perhaps this is the same flakiness?!
>
> Anyway, as I mentioned elsewhere before, I have no idea why/how 'git
> p4' works, so I'll leave it up to you how it's best to deal with this
> issue...
>
>
> G=C3=A1bor
>
