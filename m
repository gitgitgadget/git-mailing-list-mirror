Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9BEC433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 03:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFCEF61076
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 03:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbhILDCC convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 11 Sep 2021 23:02:02 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:36559 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbhILDCB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 23:02:01 -0400
Received: by mail-ed1-f49.google.com with SMTP id v24so2438924eda.3
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 20:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w7LTP/ZiX5FdsbQj6tt1Br/y/kB92PkIuaoNsA8GcSM=;
        b=nTgAwGxedE2m2SM5mTWwKu+72plPgpX+ot0tF+f2/7v+FOITEzw0ONwZPPMYzFbQ0Z
         APrgJYov8TjRCGmSB6usnVA8mwRC6Mei8W87RrWIfJLPUxsYS6qKaToRMCy7Ub3kAonm
         pJ4vVZ9AZ6u0G+R66fYeHM+f/Is+yahUrxj2rQ1gIU1x7wzdgm1u1swWmkmMX051fPoX
         EEiNwsRf/CFcKao5xN9Mtyw1pQYnOzYRrHuuEesA7oNYzyKZMZyW/4D3M/v6nn4AEJgl
         PxZDy0uFqBrmsjJDKYKsW/OL+RHPfDsuUK7zZoe/RDQCWtRkaGEt1Cxz+os/eIamLYWP
         RFOQ==
X-Gm-Message-State: AOAM530NRph4s4+0US3+4TEnPHJTg4u1cZxC/yUf+toxv99XPYlC9tZf
        qeWALKr5fQoKxw6sucEmODexrdPHWvVGnnYQwEQ=
X-Google-Smtp-Source: ABdhPJxJyIzFiijsULXfxoqLnDeHjOtNRvZuGEK4esIpsSVBZ16Zp7fLlziCW8GyACGpEZVg7Jw8BEbW+pOXrDajUlY=
X-Received: by 2002:a05:6402:2686:: with SMTP id w6mr5951270edd.231.1631415646924;
 Sat, 11 Sep 2021 20:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email>
 <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com> <patch-v2-7.7-2edd9708888-20210912T001420Z-avarab@gmail.com>
In-Reply-To: <patch-v2-7.7-2edd9708888-20210912T001420Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 11 Sep 2021 23:00:36 -0400
Message-ID: <CAPig+cTdisiKU-8i3kRuDqtwy6eQOA+jNbz8WGm627ojUwkgbA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] strvec API users: change some "int" tracking "nr"
 to "size_t"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 8:16 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Now that the strvec.h "int nr" has been changed to "size_t nr" in the
> preceding commit change various users of the API so that their local
> tracking (usually for-loop iteration) of the number of items in the
> array uses "size_t" as well.

s/change/changed/

> These were found by changing the "nr" member to a pointer temporarily,
> and manually looking at the codepaths that the compiler complained
> about.
>
> As argued in <YTIBnT8Ue1HZXs82@coredump.intra.peff.net>[1] these
> changes are not strictly necessary as a follow-up, but let's do them
> anyway so we don't need to wonder about the "size_t" v.s. "int"
> inconsistency going forward.
>
> As noted in <87v93i8svd.fsf@evledraar.gmail.com> in that thread we

s/>/>[2]/

> have various things that interact with the "int argc" passed from
> main() (e.g. setup_revisions()) and "struct strvec". Those things
> could consistently use "int" before, but will now use some mixture of
> "int" and "size_t". That's OK, but is the reason we're not converting
> all API users to use "size_t" here for their own copies of "nr", or
> when they pass that "nr" to other functions.
>
> 1. https://lore.kernel.org/git/YTIBnT8Ue1HZXs82@coredump.intra.peff.net/
> 2. https://lore.kernel.org/git/87v93i8svd.fsf@evledraar.gmail.com/
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
