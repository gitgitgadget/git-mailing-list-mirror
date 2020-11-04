Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B99CC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E471620684
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgKDUQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:16:18 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:44353 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgKDUQS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:16:18 -0500
Received: by mail-ej1-f66.google.com with SMTP id j24so31559112ejc.11
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRDC/itBVGVcVoipSduHSPJXkBpoNPy81usqv71mi5o=;
        b=AMW4dKOUiuSNDDRdhhLI7ZQ9YutCv573iYP5W13Qt2YBS4mcKfcvbRw9yM0cxR6eGN
         XvoUMIjZECDqb4EcqWoXBlmfkAIC4yOBWQgwouC1TgOijLfX+aVFpjIkMeOe3YylssFj
         7fhhYH3SDULLDcCxxkhE5lq7DIP9Lhw/px/ssGUs5VSOdeCl/QIdmMjcEVEHwSZm4LgY
         YRVb4zYWPwqxzWnNv6KEDow9o9e87fFVSggiIBVUANjTHwCtcs1Czw0uMA6wwlcniUPo
         pdS8LKpcmfGagf/QeeBW/jKrNf0K0LLNJnXm5ruqkQDrFia1uxgDV2iU43nYPsXVl0k/
         bcfQ==
X-Gm-Message-State: AOAM5338+jOUOmomcQINangFAnUsCxNTLl0Xh223vWQGa7Yprg8NoCFB
        NpYf7KnPsHJxWR2MT7FUAWZ1tESJjq34fDvr7zM=
X-Google-Smtp-Source: ABdhPJwkXpyNL5Z7e4fyWs2YlmFQ7OEJN9XMNd+5XsNducNACI15h+Z3oZ9JG9G++lq/1Ae8tAMepZ8MFbM9iwSqnZI=
X-Received: by 2002:a17:906:6949:: with SMTP id c9mr14468474ejs.482.1604520975865;
 Wed, 04 Nov 2020 12:16:15 -0800 (PST)
MIME-Version: 1.0
References: <20201104132428.GA2491189@coredump.intra.peff.net>
 <20201104132907.GC3030146@coredump.intra.peff.net> <CAPig+cQ7t1by2X0xwddyo40sQdb9BPBKmERpqKR6oMD82kUwgg@mail.gmail.com>
 <20201104191559.GA3053889@coredump.intra.peff.net>
In-Reply-To: <20201104191559.GA3053889@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 4 Nov 2020 15:16:04 -0500
Message-ID: <CAPig+cSOB+raZHEpSeqnZZ-VHNqLqVyrfVUA8fCr97mv8oSBFw@mail.gmail.com>
Subject: Re: [PATCH 3/3] format-patch: support --output option
To:     Jeff King <peff@peff.net>
Cc:     Johannes Postler <johannes.postler@txture.io>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 4, 2020 at 2:16 PM Jeff King <peff@peff.net> wrote:
> On Wed, Nov 04, 2020 at 12:27:30PM -0500, Eric Sunshine wrote:
> > The commit message's justification for supporting --output seems
> > reasonable. However, my knee-jerk reaction to the implementation was
> > that it feels overly magical and a bit too hacky. I can see the logic
> > in it but it also leaves a bad taste when the implementation has to
> > "undo" a side-effect of some other piece of code, which makes it feel
> > unplanned and fragile. [...]
>
> FWIW, that unsetting of rev.diffopt.close_file is exactly how git-log
> does it. So while I agree it's a bit ugly, this is the intended way for
> --output to be used across multiple diffs, and with log_tree_commit().
> I'd prefer to go this way for now, and if somebody wants to make it less
> ugly, they can clean up all of the callers in one go.

If you intend to re-roll, it might make sense to include this
explanation in the commit message since existing precedent helps sell
the ugliness (bad taste), making for a less negative knee-jerk
reaction.
