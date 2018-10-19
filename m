Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B7321F453
	for <e@80x24.org>; Fri, 19 Oct 2018 05:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeJSN64 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 09:58:56 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34588 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbeJSN64 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 09:58:56 -0400
Received: by mail-qk1-f196.google.com with SMTP id p6-v6so20366757qkg.1
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 22:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XEIQai5jShDCGnq66Ne5FPNJoSs+mJjCHMS2CQ0oBpM=;
        b=Mwg5kwSiK6dri28R5fGAORW0rFxtx78wD1p8KWviKvkuZ1HMp90D9+cnZwHJkFyDwZ
         WGrASDA4gkgveFITqxOR1racWwXwfDliPh57vNL4RHcnYo64bm1jN3c1ux2QYATLIxVH
         Obnrntz/NxyeYsJ7OAszRijlyw93RJEzBm8S1AFHerrH4UgJVst1tmGgGr3X2o1p4Fql
         TAUwXgZl9nGlWz1S3xWjnBZZBBTk0vD0kYsjVLCdQGTqFiS87XeT8OW+lUBaiMGe+02D
         4m995HSbgriRKv+7Hxa2uVqeBNeavoXhEkIN/Hk80tmcw5+47oxjrxRSbONsGC/mYbUi
         81RA==
X-Gm-Message-State: ABuFfogFMZoad6LNXphapsahCy70W4J9m34+ts0cdfhrBTFLueF3ALcH
        MtWEcXWsvKDZ399wx1Bu+cQ3DG/+SqAwxirIi3I=
X-Google-Smtp-Source: ACcGV62fGkXjdf2PNWxkPCEKJP0DmRRPwnigqQcACUc0CFy3cNMhQ9EPbQipTTaRN/Ta3N+novRn8o+li3AIqmLx8OM=
X-Received: by 2002:a37:7641:: with SMTP id r62-v6mr31559638qkc.314.1539928462446;
 Thu, 18 Oct 2018 22:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <CANahLXm7O6scvLdaL6bm14d5oGM5Zp+S-rpQDo554ssagRFNoQ@mail.gmail.com>
 <xmqqsh124wqb.fsf@gitster-ct.c.googlers.com> <xmqq4ldi38u7.fsf@gitster-ct.c.googlers.com>
 <xmqqpnw61qkg.fsf_-_@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnw61qkg.fsf_-_@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Oct 2018 01:54:11 -0400
Message-ID: <CAPig+cT9vKDr2uYVS0XdM=KxN5JY4yrONni5iZnVL5GdE1taLw@mail.gmail.com>
Subject: Re: [PATCH] receive: denyCurrentBranch=updateinstead should not
 blindly update
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, rmadamanchi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 12:57 AM Junio C Hamano <gitster@pobox.com> wrote:
> The handling of receive.denyCurrentBranch=updateInstead was added to
> a switch statement that handles other values of the variable, but
> all the other case arms only checked a condition to reject the
> attempted push, or let later logic in the same function to still
> intervene, so that a push that does not fast-forward (which is
> checked after the switch statement in question) is still rejected.
>
> But the handling of updateInstead incorrectly took immediate effect,
> without giving other checks a chance to intervene.
>
> Instead of calling update_worktree() that causes the side effect
> immediately, just note the fact that we will need to call the
> funciton later, and first give other checks chance to reject the

s/funciton/function
s/chance/a &/

> request.  After the update-hook gets a chance to reject the push
> (which happens as the last step in a series of checks), call
> update_worktree() when we earlier detected the need to.
>
> Reported-by: Rajesh Madamanchi
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
