Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC933C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 04:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E4720678
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 04:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgHKEtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 00:49:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37936 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgHKEtG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 00:49:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id t14so1542574wmi.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 21:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwwMD12Fd047gF1zdq1Tm0Il4rrTPCVcFlbJ3GyeLYY=;
        b=D9KlaNWlnvJyP7/KNIPmcpdJXI3bKjiLOKl2gZyH+oyo6GPTTN+pA/YJ6/fTM0buh9
         aYN2AVdHCJl8jzyixGEggn2QMT8V+OqqvtGI8Btfbtd5L9iYiJS5yFu3GKc4CgT+lEIX
         BzUhict/0OEePf3LxW47ODcZb/SjX92ZqrWXVrdeIhgGMZOzsZJ0KTRovoTOKrSG9VCa
         4QWd5PNVK1tzFNxLd4+Kb9AOTMrYHdrdM9R5LTqnT4utfN4f/msMHLXVaSo5NNat8uvJ
         mebOkuEWBvv7+aEtZeMIicYbV73U4nfWuOD/wNUMSGjQRqb6bhfNH1nGlZtMngLSOvXm
         ejZA==
X-Gm-Message-State: AOAM532AIKvwscR6XOh1SvjxEx9ZONKJfkyhASDKfAF+GJ/yEss3Rn0j
        XnHyD6Hi+HfYo40SFUFk27lOteAMQxDz7jnmvDI=
X-Google-Smtp-Source: ABdhPJyQK6oHWyxRCrsU0sNPqsv+ktQZI9sHB/aOnBZjlokIsRY8Ll8cfBqwk72idIxEQxksWQLlU//8ACBNPjwkSq4=
X-Received: by 2002:a1c:7405:: with SMTP id p5mr2138870wmc.130.1597121344778;
 Mon, 10 Aug 2020 21:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200808213457.13116-1-me@pluvano.com> <20200809230436.2152-1-me@pluvano.com>
 <20200810100249.GC37030@coredump.intra.peff.net> <20200811041728.GA1748@pluvano.com>
In-Reply-To: <20200811041728.GA1748@pluvano.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 11 Aug 2020 00:48:53 -0400
Message-ID: <CAPig+cREqPM-hpbvRUxrZwiYRQ+k6Ca=FtY6vufy_Mb45jU9Og@mail.gmail.com>
Subject: Re: [PATCH v2] gitweb: map names/emails with mailmap
To:     Emma Brooks <me@pluvano.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 12:17 AM Emma Brooks <me@pluvano.com> wrote:
> On 2020-08-10 06:02:49-0400, Jeff King wrote:
> > There was a little discussion in response to v1 on whether we could
> > reuse the existing C mailmap code:
>
> I think it's probably not worth the effort to make the necessary changes
> to "rev-list --header" Junio mentioned, just for gitweb.
>
> I agree it's a bit worrisome to have a second parser that could
> potentially behave slightly differently than the main implementation.
> What if we added tests for gitweb's mailmap parsing based on the same
> cases used for Git itself?

Another option which people probably won't like is to have gitweb
start "git check-mailmap --stdin" in the background, leave it running,
and just feed it author/commit info as needed and read back its
replies. The benefit is that you get the .mailmap parsing and
resolution built into Git itself without needing any extra
parsing/resolution Perl code or tests. The downside is that people
might balk at an extra process hanging around for the duration of
gitweb itself. (You could also start up "git check-mailmap" repeatedly
on-demand, but that would probably be too slow and resource intensive
for real-world use.)
