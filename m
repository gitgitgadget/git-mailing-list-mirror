Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414BDC10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 17:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B6C21927
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 17:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="TFYX6xGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCJRaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:30:11 -0400
Received: from forward501o.mail.yandex.net ([37.140.190.203]:46837 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbgCJRaK (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Mar 2020 13:30:10 -0400
Received: from mxback7q.mail.yandex.net (mxback7q.mail.yandex.net [IPv6:2a02:6b8:c0e:41:0:640:cbbf:d618])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id 04C2D1E80177;
        Tue, 10 Mar 2020 20:30:06 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback7q.mail.yandex.net (mxback/Yandex) with ESMTP id tanIq8KrIg-U54G03Bv;
        Tue, 10 Mar 2020 20:30:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1583861405;
        bh=ShV3pvf5Ws4yvVbn3Vdlqq6W8AObJX/r+3p81kaRh2Y=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=TFYX6xGsGZh9qTpU34FDtRLASYCdL8dHNPtZibrv8tn8jCGZ7WEJ2ow+QYwEQSnQp
         8fcytV+OJw+sXwmXH1iy+WwgL2hAkUF3JV+qljr2ezxccXo6P4fobLqAz/IL7FYSKK
         Ibi1JxgZb6kyTOJnRRxTjD5UihHjTHfsXTsZr0WU=
Authentication-Results: mxback7q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla5-c5051da8689e.qloud-c.yandex.net with HTTP;
        Tue, 10 Mar 2020 20:30:05 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     =?utf-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     Ondrej Pohorelsky <opohorel@redhat.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <20200310165723.GB3122@szeder.dev>
References: <CA+B51BFFvn9puia8+kheeWkDfOQ7RYHTcGa74M5aeiTd8-QJXA@mail.gmail.com>
         <3c722d21-ee57-7d20-81fb-0399f02f1bc7@syntevo.com> <20200310165723.GB3122@szeder.dev>
Subject: Re: git-core: try_to_follow_renames(): git killed by SIGSEGV
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 10 Mar 2020 20:30:05 +0300
Message-Id: <347951583861239@vla5-dcf36e533bf7.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



10.03.2020, 19:57, "SZEDER Gábor" <szeder.dev@gmail.com>:
> On Fri, Mar 06, 2020 at 03:44:34PM +0100, Alexandr Miloslavskiy wrote:
>>  Since I like studying crashes and noone else replied, I decided to have a
>>  look.
>>
>>  The problem is easy to reproduce with this (replace 1.c with any file):
>>    git log --follow -L 1,1:1.c -- 1.c
>
> Don't do this. In particular:
>
>   - Don't use line-level log with a pathspec, because the
>     documentation of 'git log -L' explicitly told you not to do so
>     ("You may not give any pathspec limiters."). This should have
>     errored out since the beginning, but, unfortunately, has never
>     been enforced.
>
>   - Don't use '-L' with '--follow'. On one hand, line-level log on
>     its own already follows file renames, even multiple files at once,
>     there is no need for an additional '--follow' (which can only
>     follow one file). OTOH, you shouldn't be able to use '-L' and
>     '--follow' together, because the former forbids a pathspec, while
>     the latter requires one.
>
> In any case, '--follow' has always been an ugly hack on top of the
> revision walking machinery, while line-level log is a rather poorly
> integrated bolt-on. They simply weren't designed to work together, as
> evidenced by their contradicting requirements about the pathspec.

This kind of explains issue with --follow and --full-diff which I've reported
recently and got completely ignored.

Are there any plans to integrate --follow better with other tools?


>
>>  It occurs because `opt->pathspec.items` gets cleaned here:
>>      clear_pathspec
>>      queue_diffs
>>          /* must look at the full tree diff to detect renames */
>>          clear_pathspec(&opt->pathspec);
>>          DIFF_QUEUE_CLEAR(&diff_queued_diff);
>>      process_ranges_ordinary_commit
>>      process_ranges_arbitrary_commit
>>      line_log_filter
>>      prepare_revision_walk
>>      cmd_log_walk
>>      cmd_log
>>
>>  And on next iteration it crashes in 'try_to_follow_renames' on this line:
>>      diff_opts.single_follow = opt->pathspec.items[0].match;
>>
>>  I think that bug comes from commit:
>>      a2bb801f by SZEDER Gábor, 2019-08-21 13:04:24
>>      line-log: avoid unnecessary full tree diffs
>>
>>  @szeder could you please look into that?
>>
>>  On 27.02.2020 13:56, Ondrej Pohorelsky wrote:
>>  >Hi,
>>  >
>>  >there is a SIGSEGV appearing in Fedora[0] with Git 2.24.1
>>  >
>>  >This bug started to appear after update to Git 2.24.1.
>>  >Bug reporter said that Git crashed on him while running VS Code with
>>  >Git Lens extension[1]
>>  >I have tried to reproduce this bug with my own compiled Git with debug
>>  >flags, but sadly SIGSEGV never appeared.
>>  >
>>  >To me it seems like there is a problem in commit a2bb801f6a[2] which
>>  >changes move_diff_queue() function. This function calls
>>  >diff_tree_oid() that calls try_to_follow_renames(). In the last two
>>  >functions there are no arguments checks.
>>  >
>>  >Best regards,
>>  >Ondřej Pohořelský
>>  >
>>  >[0] https://retrace.fedoraproject.org/faf/problems/bthash/?bth=25aa7d7267ab5de548ffca337115cb68f7b65105
>>  >[1] https://bugzilla.redhat.com/show_bug.cgi?id=1791810
>>  >[2] https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2bb801f6a430f6049e5c9729a8f3bf9097d9b34
>>  >

-- 
Regards,
Konstantin

