Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EF6C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 05:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62CA061DC3
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 05:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhF2FHc convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 29 Jun 2021 01:07:32 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:36371 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhF2FHb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 01:07:31 -0400
Received: by mail-ed1-f41.google.com with SMTP id h2so29467960edt.3
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 22:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j+ghGziP2uL6bwLhkHL/U3rRov6LZ0kq9veG6K97rUA=;
        b=t3Xb/PB4MARUVfP0C9eAwnHsZjItPsEyNBtUxt5a/x/EZHA8KsV9e/1612F2s0KQY5
         qWM0pEHo+jlVNzFB5/EklFBP+sx0iXr+6RkCmAkHQx28JqvG+/pJYCxA7F+X/YhOkKpQ
         muFNV4bGLsZf+StvY9nO1TbE8MquxHb/bXhAJq39P6g4hKLDnO3yLResPXirlbWPDk8V
         2f9IV6uABIjy59UXWtYzmP8MGJ1iQd0QhRMpJ/gGPpYGOvzTRrBD8ZkQans+EJTIgLv+
         ohZJCcCUGhi1VH/8TTTu0EDTrw0Ihh7T4NtGDdT9wj+pA/tJrUkmOK9dZMMTY6/cC+WB
         DZww==
X-Gm-Message-State: AOAM533uyEZDO/P8BLHmwxQBB6fmTDkGgeWTd45ENfvIm2ZoAg4IdzbY
        m4R2erNF2IbpXbUNkxGeHtsH9qzTWjW8grkAVmA=
X-Google-Smtp-Source: ABdhPJyFfWYZxcUHF0iOBprccDGAvAtm2uzKhbD09XbbQhZodIGXr0HUdQmpPqLJpcmuj8zIjhWMgP+AK36N/g5LC9I=
X-Received: by 2002:a05:6402:152:: with SMTP id s18mr37144686edu.221.1624943103904;
 Mon, 28 Jun 2021 22:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <874kdn1j6i.fsf@evledraar.gmail.com> <YNSh0CskelTwuZq0@coredump.intra.peff.net>
In-Reply-To: <YNSh0CskelTwuZq0@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 29 Jun 2021 01:04:53 -0400
Message-ID: <CAPig+cSzKoOzU-zPOZqfNpPYBFpcWqvDP3mwLvAn5WkiNW0UMw@mail.gmail.com>
Subject: Re: Why the Makefile is so eager to re-build & re-link
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 24, 2021 at 11:16 AM Jeff King <peff@peff.net> wrote:
> On Thu, Jun 24, 2021 at 03:16:48PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >    I think the best solution here is to make the generate-*.sh
> >    shellscripts faster (just one takes ~300ms of nested shellscripting,
> >    just to grep out the first few lines of every git-*.txt, in e.g. Perl
> >    or a smarter awk script this would be <5ms).
>
> Yeah, I think Eric mentioned he had looked into doing this in perl, but
> we weren't entirely happy with the dependency. [...]

For what it's worth, the original `generate-cmdlist` was a shell
script which I rewrote[1] in `awk` to extend the functionality, but
Junio felt uncomfortable[2] about making `awk` a build dependency, so
I rewrote[3] it again in `perl`. However, the `perl` version didn't
last long since we got a report[4] that Git would no longer build in
the FreeBSD ports tree, so I rewrote[5] it a final time in shell, thus
coming full circle (but with extended functionality).

[1]: https://lore.kernel.org/git/1431976697-26288-4-git-send-email-sebastien.guimmara@gmail.com/
[2]: https://lore.kernel.org/git/xmqqr3qda7kx.fsf@gitster.dls.corp.google.com/
[3]: https://lore.kernel.org/git/1432149781-24596-4-git-send-email-sebastien.guimmara@gmail.com/
[4]: https://lore.kernel.org/git/loom.20150814T171757-901@post.gmane.org/
[5]: https://lore.kernel.org/git/1440365469-9928-1-git-send-email-sunshine@sunshineco.com/
