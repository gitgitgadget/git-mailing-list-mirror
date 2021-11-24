Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E02C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 06:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhKXGPd convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 24 Nov 2021 01:15:33 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:34541 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbhKXGPc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 01:15:32 -0500
Received: by mail-ed1-f52.google.com with SMTP id x15so5428385edv.1
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 22:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y1IujGzFcgzwZoUD8oulrr754yHW+M5A7J+EWpPcaiA=;
        b=vp9SfmAojmNTBTb5YAs67zlwREgUVpTQyYGfuhRN497u9S8sDOHbxZ+SIYU8CfIcpW
         eSvVW9nT3hZWL3ESKt73vcUAz3PzMQXrsxXgIbWpNl1AIehnue3Z0nZApL1M2xcmpRZr
         amSxXYX6dryMvQ3L/so+2RD3R4V1/wPQQvL9L8OqTZ1UlXA9KJrx7aNEt0Z81hvkdXC5
         A0Tf+fOoo60iOV99h+fShvM9NuCNOjOTJ9mPAs218EGGCP+v/X3z1ZmMPVQcOEQr4v2K
         FD//ux2IXNgIA2Y/ky4QZ6MiqNMm+fVeMUGYt3gK+mAyGdRDGEdqCXuaAULjsDlI4ua4
         cpxA==
X-Gm-Message-State: AOAM5310bZJWmXFFp+YJ+XJAHYTYvrt1/SA0OprKeoIUXCy7ltostc4e
        KevOGhzr0i4PSieTDY87O3GlH4jTcRZkhZPwcPE=
X-Google-Smtp-Source: ABdhPJy5osVqDj4FkvDanRTcCbZ7JM04gLLweJIuCpQxDgidIzODsDibk4NzFPJdCa0Qsoz7A9ASJRbGVKsMLouHo/w=
X-Received: by 2002:a17:907:a426:: with SMTP id sg38mr16434048ejc.392.1637734342243;
 Tue, 23 Nov 2021 22:12:22 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
 <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
 <patch-v2-1.9-9cc220ce5a3-20211123T115551Z-avarab@gmail.com>
 <CAPig+cStZp=AOPHW8i7AqwDOV6djYzHC6GmcVeb=4PUj5bjvAw@mail.gmail.com>
 <xmqqy25e48u5.fsf@gitster.g> <CAPig+cRMYiCvq7=ESSk7+PM50p4PeoKFat+w9svXMxsCHA6HEw@mail.gmail.com>
In-Reply-To: <CAPig+cRMYiCvq7=ESSk7+PM50p4PeoKFat+w9svXMxsCHA6HEw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 24 Nov 2021 01:12:11 -0500
Message-ID: <CAPig+cTNEQhv=OeZDrXA4k7K1hgpbrBUa91wdfpxo6Se38DBEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] worktree: remove redundant NULL-ing of "cp.argv
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 24, 2021 at 1:00 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Nov 23, 2021 at 8:54 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Thanks for spotting this.  Has this patch ever been tested with
> > sanitizer?  Do we have gap in test coverage?
>
> The question about potential gap in test coverage is a good one.
> Maybe, by chance it reallocated the same memory that it had earlier
> freed, thus did indeed work "by accident". Another possibility is that
> Ævar only ran the tests after applying the full patch series, in which
> case this dangling-pointer bug would be gone, rather than running the
> tests after each patch.

As a follow-up, I just applied this patch alone and ran the tests, and
they do indeed fail as expected (on my macOS). In
t2400-worktree-add.sh, alone, 44 out of 71 tests failed, thus I don't
think there's a gap in test coverage. So, the most likely explanation
of how this problem slipped through is that Ævar only tested after
applying the full series, in which case the dangling pointer bug would
be gone, rather than testing after each patch.
