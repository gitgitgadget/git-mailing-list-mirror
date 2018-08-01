Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 421EB1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 06:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbeHAIGX (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 04:06:23 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41720 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733310AbeHAIGX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 04:06:23 -0400
Received: by mail-yb0-f193.google.com with SMTP id s8-v6so7123422ybe.8
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 23:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ldlpzDRczR6KyzAmRqV58t3XUSUFbJOKopAi+pNBZw8=;
        b=lkZ2HYKMMuDVLtKjuO83qJOcndp6XlYPMmk4tnqWwlCnmv3qVWXCERlfy0KKreTpDO
         bE4USfgIayyfdFU5t/1n4zjeNjW1g46hXn9q6HV/X0SKNlgCGlN5hY59o3/T8iFW1OHa
         Gertq7SV5vTFUSBvh0Vk2pfb5YRimRvQPh5JaX/pCRNCqXH6Er16o9X9uWuval3izDh6
         wUfqzivSdXIwyMYJp5zPEFFYvPSi98dZRMzavNURlVHPI5a/BM8Qvse7y03qdxOh1JPR
         0DQszo2fTJHQxSHD/0VIjlx5txks/AeuE92E0xVrfV/sT7jJhZquMABatOKbRMEhAWus
         0stA==
X-Gm-Message-State: AOUpUlFvL9VdRT6yPESmcWcmOBvnewW1SkmsQUys59ydpqwVBI1RLxua
        ztryrASWQFk1rjLPuOR9HyT0EaxIa6+c5jvIiBM=
X-Google-Smtp-Source: AAOMgpcgzB5OEo20O766zr8qqWy42SJLAIdMLhVdyijYJ8MdA1b4rpTsJdyNJEKeiiMg8PPnoYwgCLpdRfMmFloQD58=
X-Received: by 2002:a25:d38f:: with SMTP id e137-v6mr12626081ybf.287.1533104542201;
 Tue, 31 Jul 2018 23:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180731073331.40007-1-sunshine@sunshineco.com> <CAE1pOi3oeBEyD8skwfLAd7JviGYOUZaZwj3u9pznM4eLAR7fDQ@mail.gmail.com>
In-Reply-To: <CAE1pOi3oeBEyD8skwfLAd7JviGYOUZaZwj3u9pznM4eLAR7fDQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Aug 2018 02:22:11 -0400
Message-ID: <CAPig+cRe1R1YWpLaXVtTmwhaJiz2dONU83qtn_+XhaRevjn2fQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] fix "rebase -i --root" corrupting root commit
To:     Hilco Wijbenga <hilco.wijbenga@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Akinori MUSHA <knu@idaemons.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 9:30 PM Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
> On Tue, Jul 31, 2018 at 12:33 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > This is a re-roll of [1] which fixes sequencer bugs resulting in commit
> > object corruption when "rebase -i --root" swaps in a new commit as root.
> > Unfortunately, those bugs made it into v2.18.0 and have already
> > corrupted at least one repository (a local project of mine). Patches 3/4
> > and 4/4 are new.
>
> Does this also fix losing the initial commit if it is empty?
>
> git init ; git commit -m 'Initial commit' --allow-empty ; touch
> file.txt ; git add file.txt ; git commit -m 'Add file.txt' ; git
> rebase --root
>
> I would expect there to be 2 commits but the first one has
> disappeared. (This usually happens with "git rebase -i --root" early
> on in a new project.)

This series should have no impact on that issue; it is fixing root
commit object corruption, and does not touch or change how the commit
graph is maintained or how the rebasing machinery itself works (and
the --allow-empty stuff is part of that machinery).

As Dscho is cc:'d already, perhaps he can chime in as a resident expert.

By the way, what happens if you use --keep-empty while rebasing?
