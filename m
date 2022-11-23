Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AD0C4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 19:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbiKWTLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 14:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239825AbiKWTLL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 14:11:11 -0500
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1211E710
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 11:11:08 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id k7so17478081pll.6
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 11:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZ4Xxv7MQd4JOyfHj4dy5eogIjFonW5Yi6168ebePBk=;
        b=UaEuB071xgchV8Oq1/XQCK2LKACd4V7SH2HsoJe5KCFfh4UKrQHaB2K/RT3ku2S0w8
         uYkh2tYjk1+NPW68GnLQBYVLUcD+d/WPC1/Eg2pC4CbTjltPeZmG4NMNxain6b2ox7Vo
         NkJDmmLZgF9JRh6HNQq5dig8rvNyJQEKTtIsG8Z6lozjDmLcqGPpGvam4TtySTymJfo0
         psufjZ7caSQgSyWUx2UmxLVYlwWXAcvabNujhdr+MzGhJpFyHMGwxRRNEIdxk/mNogn0
         lazilW/EE0hmZ2pBAVnYy3UxPIDnSz+6aD6c5CENkoBOvPyiHjS8f97G6TqKYxOsPNSd
         4Yng==
X-Gm-Message-State: ANoB5pnwfCeqsCk59Gvm4UgmJ6seXnkKfztBBmOeWwEXhXx/35RZ8MfU
        P1OgtoVkX547iFVVdQOXTmYCxEaldmLao6zFUG0=
X-Google-Smtp-Source: AA0mqf7x1xk3JpyPInvinXk+tgwxJqdz0Pk+y0G3Sd8Rxj3hW12BE8AhBT1uV07PS6bnt998p5k9SRmzffiqD66YFoQ=
X-Received: by 2002:a17:902:8f96:b0:189:3803:23e6 with SMTP id
 z22-20020a1709028f9600b00189380323e6mr7555771plo.77.1669230667591; Wed, 23
 Nov 2022 11:11:07 -0800 (PST)
MIME-Version: 1.0
References: <CANYNYEHXU8ivgAOa8EO5e9kOcbu6XF7rj+9EcSrbDQE+Rvyw_Q@mail.gmail.com>
 <87v8n6o9du.fsf@igel.home> <CAPig+cRchF_6t-B-cZHLHAH_E6qNmapTezSfCj9AZ8cfWNzivw@mail.gmail.com>
 <mvm1qpu9g2e.fsf@linux-m68k.org>
In-Reply-To: <mvm1qpu9g2e.fsf@linux-m68k.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 23 Nov 2022 14:10:56 -0500
Message-ID: <CAPig+cT5dxrS2-xUSYfot7k6v0qV0TXh=xSMe7Y-oMGLMhbjVA@mail.gmail.com>
Subject: Re: chainlink.pl /proc/cpuinfo regexp fails on s390x
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Andreas Hasenack <andreas@canonical.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2022 at 4:27 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Nov 22 2022, Eric Sunshine wrote:
> > On Tue, Nov 22, 2022 at 6:37 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> >> On Nov 22 2022, Andreas Hasenack wrote:
> >> > /^processor[\s\d]*:/
> >> > or something else.
> >>
> >> Something else.
> >> $ getconf _NPROCESSORS_ONLN
> >
> > Yes, that works too and was (I'm pretty sure) considered during
> > development. The reason /proc/cpu was chosen over `getconf` was that
> > opening & reading /proc/cpu should be faster since it doesn't involve
> > spawning a process. If we did use `getconf`, we'd have to be careful
> > to degrade gracefully if `getconf` isn't available or if the
> > configuration parameter (i.e. "_NPROCESSORS_ONLN") isn't known on the
> > platform.
>
> getconf is surely more portable than poking in /proc, especially
> /proc/cpuinfo is the antipode of portability.

No doubt, but for the immediate issue, this tightly-focused fix is
more appropriate and less likely to lead to unexpected additional
problems. I'm not arguing against `getconf`, but saying only that
_this_ patch is fine as-is.

It may very well be a good idea to replace the /proc/cpuinfo probe by
`getconf` in the future (or remove it altogether as mentioned
upstream), but that's outside the scope of this patch and the
immediate problem.
