Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1481C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 17:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbiBPR0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 12:26:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiBPR0G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 12:26:06 -0500
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A20C2B04A4
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 09:25:53 -0800 (PST)
Received: by mail-pj1-f46.google.com with SMTP id ki18-20020a17090ae91200b001b8be87e9abso4337877pjb.1
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 09:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RSFhETBISnArTnHCFI9uSrWvKF1epwtrDofWBiNcFqI=;
        b=i+Zfz+LWVwehoUKELrrgq6HKMyxkJLU4lIegBQM3yKmwt2hYw7fOPrwvP1yG4keQhB
         xbHUsBFzQ8qe8NXXtWJIERkn45DT9v8oRWZynjWTTqFoWE9oorq5oSnJM8PrZn7aga2E
         ZXy/FuFMtNhMJoECU0WFfqY2IAROghR2GseNj2qOsypKFH6tMbeOCIgSq+5lO3F8pw9n
         WKGXPxl9FotiKhnomz6glxYx0dfYB97hVWXLl1Ak3ZYR5XUe9+syogo3wg67X4OnkkIu
         hi4Y3bz9zr6nwoPbUMzfr6A/6R+2wbp98jhvSCaFOR9LNjJic2Cfy9iPwN9sPP6Ry/gb
         gvew==
X-Gm-Message-State: AOAM533w9Va7xneoPJjj6RU1W5uApv9b60c6xNtdh39gUEl/DYjo4ooV
        xwGHYyDGLy9PE5GwlhiBiyB7YZ4u4PBu1GEMj+8=
X-Google-Smtp-Source: ABdhPJzk/Jkk2hCeA23cg28Qoeo+8eaoKxu1rKvQSdmnm/4T+NDdeQyfTlKYeNB4LntVMfjpe8YFiFS9Fzc/4WWkcoM=
X-Received: by 2002:a17:902:a713:b0:14d:8f49:84cd with SMTP id
 w19-20020a170902a71300b0014d8f4984cdmr3293981plq.145.1645032352826; Wed, 16
 Feb 2022 09:25:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com>
 <pull.1212.v8.git.git.1645023740.gitgitgadget@gmail.com> <8edf80574b8dd72ca8489df6e480cf6820b98070.1645023740.git.gitgitgadget@gmail.com>
 <xmqqwnhuu410.fsf@gitster.g>
In-Reply-To: <xmqqwnhuu410.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 16 Feb 2022 12:25:41 -0500
Message-ID: <CAPig+cQKRytC0xQBCMss0S6tAoVft8XhcPCws9x4PMx_STfcHA@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] cat-file: add --batch-command mode
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 16, 2022 at 12:15 PM Junio C Hamano <gitster@pobox.com> wrote:
> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
> As it seems that this code structure and division of responsibility
> between the caller and the callee is confusing even to the author of
> this code, it may make sense to make the caller responsible for
> freeing.
>
> Then the caller becomes
>
> > +             if (!strcmp(cmd->name, "flush")) {
> > +                     dispatch_calls(opt, output, data, queued_cmd, nr);
>
>                         for (i = 0; i < nr; i++)
>                                 free(queued_cmd[i].line);
>
> > +                     nr = 0;
> > +                     continue;
> > +             }
>
> which is not too bad.  And then we'd free the array itself at the
> end ...
>
> > ...
> > +             call.line = xstrdup_or_null(p);
> > +             queued_cmd[nr++] = call;
> > +     }
> > +
> > +     if (opt->buffer_output &&
> > +         nr &&
> > +         !git_env_bool("GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT", 0))
> > +             dispatch_calls(opt, output, data, queued_cmd, nr);
> > +
> > +     free(queued_cmd);
>
> ... which may be easier to see what is going on.

I agree that it is easier to see what is going on when the caller is
responsible for freeing `line`. It _may_ make sense to factor out the
free-line-loop to a separate function since the caller will have to do
so after both calls to dispatch_calls(), not just the one inside the
strbuf_getline() loop, but also the one after the loop. A separate
function might be overkill for this two-line loop; on the other hand,
it may clue in future readers that resource management needs to be
taken into account.
