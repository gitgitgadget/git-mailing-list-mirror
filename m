Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95325C433EF
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 06:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379515AbiBEGwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Feb 2022 01:52:39 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:40613 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiBEGwh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Feb 2022 01:52:37 -0500
Received: by mail-pg1-f172.google.com with SMTP id q132so6872061pgq.7
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 22:52:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0CcBn/lY7ZbluEwg1pGrgpjSZybxX814WZ5k1sfiJ8=;
        b=zK2HXhi+5YWZ0/Cfbt0bP/ZGccqnHnQ8c7ENRUMaBKnqzGQPqwcRv/pUHQz2QrncgH
         QpbBweZYjvH1HjWg2ERcIJe++0FruqYBR0VnFwzvN8t8CxhUHmmTmI9+tV43pv7gJKIQ
         cVQA0ZJrmOYW1/zt4hy64onKwTkozLk6tqH3hOR4s3p7wxndn871pW5wocqsJYXGNSkQ
         6q5V3tiSWWCRtSMA+PNMNC/l/R6rgElJ1grefcqXCJCBKKFLFz593quAAWBHxxMvGMDL
         hRyQ05fBDQaY2jtLJV+2F6XKd5RWTtzl+y0UL0okPCAYZcD1qL0kYkWdWh77XD/erkHu
         q1pg==
X-Gm-Message-State: AOAM530NsW9pjom+Ye8mnyHx0nQ6GUgfWkwZdo5tndbYis9M4bwpg0oz
        oBz7Z7a29L4GmfEzILbMoDaxmubmk9nW+XH3Yyc=
X-Google-Smtp-Source: ABdhPJyxGQL2cLFI5KVj6PF3HXK9J3Q4VUBZxu6sUc5u3gdQI7vo9kYvyjQVipfzTpDNaFCZ6TY0ONOG0jH4Pjbil1k=
X-Received: by 2002:a63:2c07:: with SMTP id s7mr2021390pgs.181.1644043957299;
 Fri, 04 Feb 2022 22:52:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
 <ebd2a1356017905245744babf32c5b78a0af1639.1643915286.git.gitgitgadget@gmail.com>
 <CAPig+cQHcstj28F-==oCakp3iMLHtd1SVQV+snzewYihHxNG6g@mail.gmail.com> <3F83E252-D99C-47CB-B47F-11B8EA554A4F@gmail.com>
In-Reply-To: <3F83E252-D99C-47CB-B47F-11B8EA554A4F@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 5 Feb 2022 01:52:26 -0500
Message-ID: <CAPig+cTeqhOYTu9WBiY=LnZtt35hAp3Qa5RduC2yLut6p01_1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] catfile.c: add --batch-command mode
To:     John Cai <johncai86@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 4, 2022 at 4:42 PM John Cai <johncai86@gmail.com> wrote:
> On 4 Feb 2022, at 1:45, Eric Sunshine wrote:
> > The `info` and `contents` commands neglect to do any sort of
> > validation of their arguments, thus any and all bogus invocations are
> > accepted. Thus:
> >
> >     info
> >     info <arg1> <arg2>
> >     info <non-oid>
> >
> > are all accepted as valid invocations, misleadingly producing "<foo>
> > missing" messages, rather than erroring out as they should. The "<oid>
> > missing" message should be reserved for the case when the lone
> > argument to `info` or `contents` is something which looks like a
> > legitimate OID.
>
> So actually the argument to info and contents doesn't have to be an OID but an object name that
> eventually gets passed to get_oid_with_context() to resolve to an actual oid. This is the
> same behavior as git cat-file --batch and --batch-check, neither of which throws an error. My
> goal was to maintain this behavior in --batch-command.

Okay, that makes sense. I was misled by the commit message talking
about "<sha1>" in its examples, and didn't do my due diligence by
digging more deeply into the existing documentation and code.
